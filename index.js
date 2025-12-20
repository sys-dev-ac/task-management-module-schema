require("dotenv").config();
const express = require("express");
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

// Fix BigInt serialization for JSON
BigInt.prototype.toJSON = function () {
    return this.toString();
};

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;

// Test database connection
app.get("/health", async (req, res) => {
    try {
        await prisma.$connect();
        res.json({ status: "ok", database: "connected" });
    } catch (error) {
        res.status(500).json({ status: "error", message: error.message });
    }
});

// // Get all users
app.get("/users1", async (req, res) => {
    const users = await prisma.user.findMany();
    res.json(users);
});

// Get staffs with details and task history
// app.get("/user/get_staffs/:userid/:agencyid", async (req, res) => {
//     try {
//         console.log("Getting the staffs for user with id", req.params.userid, "and agency with id", req.params.agencyid);
        
//         // Step 1: Get all sellers for this agency
//         const sellers = await prisma.sellers.findMany({
//             where: {
//                 agency_id: BigInt(req.params.agencyid),
//             },
//         });

//         const sellerIds = sellers.map((s) => s.id);

//         // Step 2: Get all staffs for those sellers
//         const staffs = await prisma.seller_staffs.findMany({
//             where: {
//                 seller_id: { in: sellerIds },
//             },
//         });

//         // Step 3: Get detailed info for each staff including task history
//         const staffsWithDetails = await Promise.all(
//             staffs.map(async (staff) => {
//                 // Get user details
//                 const user = await prisma.users.findUnique({
//                     where: { id: staff.user_id },
//                     select: {
//                         id: true,
//                         email: true,
//                         phone: true,
//                         first_name: true,
//                         last_name: true,
//                         user_type: true,
//                         status: true,
//                     }
//                 });

//                 // Get task assignments for this user
//                 const taskAssignments = await prisma.taskAssignment.findMany({
//                     where: { user_id: staff.user_id },
//                     include: {
//                         task: {
//                             select: {
//                                 id: true,
//                                 title: true,
//                                 status: true,
//                                 priority: true,
//                                 dueDate: true,
//                                 completedAt: true,
//                             }
//                         }
//                     }
//                 });

//                 // Get task history for this user
//                 const taskHistory = await prisma.taskHistory.findMany({
//                     where: { user_id: staff.user_id },
//                     orderBy: { created_at: 'desc' },
//                     take: 20, // Limit to last 20 history entries
//                     select: {
//                         id: true,
//                         action: true,
//                         field: true,
//                         oldValue: true,
//                         newValue: true,
//                         created_at: true,
//                         task: {
//                             select: {
//                                 title: true,
//                                 task_number: true,
//                             }
//                         }
//                     }
//                 });

//                 return {
//                     ...staff,
//                     user: user,
//                     taskAssignments: taskAssignments,
//                     taskHistory: taskHistory,
//                 };
//             })
//         );

//         res.json(staffsWithDetails);
//     } catch (error) {
//         res.status(500).json({ error: error.message });
//     }
// });
// 
// Get staffs with details and task history (OPTIMIZED)
app.get("/user/get_staffs/:userid/:agencyid", async (req, res) => {
    try {
        console.log("Getting the staffs for user with id", req.params.userid, "and agency with id", req.params.agencyid);
        
        // Step 1: Get all sellers for this agency
        const sellers = await prisma.sellers.findMany({
            where: {
                agency_id: BigInt(req.params.agencyid),
            },
            select: { id: true }
        });

        console.log("Sellers ", sellers.length);
        const sellerIds = sellers.map((s) => s.id);

        // Step 2: Get all staffs with their user IDs
        const staffs = await prisma.seller_staffs.findMany({
            where: {
                seller_id: { in: sellerIds },
            }
        });

        console.log(staffs.length);
        // console.log("The staffs ", staffs);
        const userIds = staffs.map(s => s.user_id);

        // Step 3: Batch fetch all users (1 query instead of N)
        const users = await prisma.users.findMany({
            where: { id: { in: userIds } },
            select: {
                id: true,
                email: true,
                phone: true,
                first_name: true,
                last_name: true,
                user_type: true,
                status: true,
            }
        });
        
        console.log(users.length);

        // Step 4: Batch fetch all task assignments (1 query instead of N)
        const taskAssignments = await prisma.taskAssignment.findMany({
            where: { user_id: { in: userIds } },
            include: {
                task: {
                    select: {
                        id: true,
                        title: true,
                        status: true,
                        priority: true,
                        dueDate: true,
                        completedAt: true,
                    }
                }
            }
        });

        // Step 5: Batch fetch all task history (1 query instead of N)
        const taskHistory = await prisma.taskHistory.findMany({
            where: { user_id: { in: userIds } },
            orderBy: { created_at: 'desc' },
            select: {
                id: true,
                user_id: true,
                action: true,
                field: true,
                oldValue: true,
                newValue: true,
                created_at: true,
                task: {
                    select: {
                        title: true,
                        task_number: true,
                    }
                }
            }
        });

        // Step 6: Map data together in memory (fast!)
        const staffsWithDetails = staffs.map(staff => {
            const user = users.find(u => u.id === staff.user_id);
            const assignments = taskAssignments.filter(ta => ta.user_id === staff.user_id);
            const history = taskHistory
                .filter(th => th.user_id === staff.user_id)
                .slice(0, 20); // Limit to 20 per user

            return {
                ...staff,
                user: user || null,
                taskAssignments: assignments,
                taskHistory: history,
            };
        });

        res.json(staffsWithDetails);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


app.get("/agencies", async (req, res) => {
    const agencies = await prisma.agencies.findMany();
    res.json(agencies);
});

// Get all staffs for a specific agency (similar to agencies endpoint)
app.get("/agency/:agencyid/:userid/staffs", async (req, res) => {
    try {
        const staffs = await prisma.seller_staffs.findMany({
            where: {
                agency_id: BigInt(req.params.agencyid),
                user_id: BigInt(req.params.userid),
            },
        });

        // Manually fetch seller details for each staff
        const staffsWithDetails = await Promise.all(
            staffs.map(async (staff) => {
                const seller = await prisma.sellers.findUnique({
                    where: { id: staff.seller_id },
                });

                return {
                    ...staff,
                    seller: seller,
                };
            }),
        );

        res.json(staffsWithDetails);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// DEBUG: Get all staffs with their agency_id to see what's in the database
app.get("/debug/staffs", async (req, res) => {
    const staffs = await prisma.seller_staffs.findMany({
        select: {
            id: true,
            seller_id: true,
            user_id: true,
            agency_id: true,
            type: true,
        },
        take: 10, // Limit to first 10 records
    });
    res.json(staffs);
});

// DEBUG: Get count of staffs grouped by agency_id
app.get("/debug/staffs/by-agency", async (req, res) => {
    const staffs = await prisma.seller_staffs.groupBy({
        by: ["agency_id"],
        _count: {
            agency_id: true,
        },
    });
    res.json(staffs);
});

app.get("/user/:id", async (req, res) => {
    const { id } = req.params;
    const user = await prisma.users.findUnique({
        where: {
            id: BigInt(id),
        },
    });

    res.json(user);
});

// app.post('/users1', async (req, res) => {
//   const { email, name } = req.body;
//   const user = await prisma.user.create({
//     data: {
//       email,
//       name,
//       createdAt: new Date(),
//       updatedAt: new Date()
//     } });
//   res.json(user);
// });

// // Get all users
app.get("/users", async (req, res) => {
    const users = await prisma.testUser.findMany();
    res.json(users);
});

app.post("/users", async (req, res) => {
    const { email, name } = req.body;
    const user = await prisma.testUser.create({
        data: {
            email,
            name,
            createdAt: new Date(),
            updatedAt: new Date(),
        },
    });
    res.json(user);
});

// Get all products
// app.get('/products', async (req, res) => {
//   try {
//     const products = await prisma.product.findMany({
//       orderBy: { createdAt: 'desc' }
//     });
//     res.json(products);
//   } catch (error) {
//     res.status(500).json({ error: error.message });
//   }
// })

// Create a new product
// app.post('/products', async (req, res) => {
//   try {
//     const { name, description, price, stock, category, isActive } = req.body;

//     const product = await prisma.product.create({
//       data: {
//         name,
//         description,
//         price,
//         stock: stock || 0,
//         category,
//         isActive: isActive !== undefined ? isActive : true
//       }
//     });

//     res.status(201).json(product);
//   } catch (error) {
//     res.status(500).json({ error: error.message });
//   }
// });

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
