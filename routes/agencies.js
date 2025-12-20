const { Router } = require('express');
const router = Router();

router.post("/sellers/:sellerid/workspace", async (req, res) => {
    try {
        const { name, description, color, created_by } = req.body;

        // Check if workspace already exists
        const existing = await prisma.workspace.findUnique({
            where: { seller_id: BigInt(req.params.sellerid) }
        });

        if (existing) {
            return res.status(400).json({ 
                error: "Workspace already exists for this seller" 
            });
        }

        const workspace = await prisma.workspace.create({
            data: {
                seller_id: BigInt(req.params.sellerid),
                name,
                description,
                color,
                created_by: BigInt(created_by),
            },
        });

        res.status(201).json(workspace);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/sellers/:sellerid/workspace", async (req, res) => {
    try {
        const workspace = await prisma.workspace.findUnique({
            where: { seller_id: BigInt(req.params.sellerid) },
            include: {
                taskGroups: {
                    include: {
                        _count: {
                            select: { tasks: true, members: true }
                        }
                    }
                },
                categories: true,
                members: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                email: true,
                            }
                        }
                    }
                },
                _count: {
                    select: {
                        tasks: true,
                        taskGroups: true,
                        categories: true,
                    }
                }
            },
        });

        if (!workspace) {
            return res.status(404).json({ error: "Workspace not found" });
        }

        res.json(workspace);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


module.exports = {
  router
}