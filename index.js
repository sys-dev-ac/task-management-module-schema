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

app.get('/user/get_staffs' , async(req , res) =>{
    const staffs = await prisma.seller_staffs.findMany();
    
    res.json(staffs);
})

app.get("/user/:id", async (req, res) => {
    const { id } = req.params;
    const user = await prisma.user.findUnique({
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
