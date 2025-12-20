# Task Management API Documentation

Complete API reference for Task Management System with Prisma queries.

## Table of Contents

1. [Workspace Operations](#workspace-operations)
2. [Task Operations](#task-operations)
3. [Task Assignment Operations](#task-assignment-operations)
4. [User-Based Task Queries](#user-based-task-queries)
5. [Task Statistics](#task-statistics)
6. [Task Categories](#task-categories)
7. [Task Groups](#task-groups)
8. [Checklist Operations](#checklist-operations)
9. [Task Comments](#task-comments)
10. [Task Attachments](#task-attachments)
11. [Task Reminders](#task-reminders)
12. [Recurring Tasks](#recurring-tasks)
13. [Task Templates](#task-templates)
14. [Idea Boards](#idea-boards)
15. [Task History & Audit](#task-history--audit)
16. [Advanced Queries](#advanced-queries)

---

## Workspace Operations

### 1. Create Workspace

```javascript
app.post('/api/workspaces', async (req, res) => {
    try {
        const { agency_id, name, description, color, created_by } = req.body;

        const workspace = await prisma.workspace.create({
            data: {
                agency_id: BigInt(agency_id),
                name,
                description,
                color,
                created_by: BigInt(created_by)
            },
            include: {
                agency: {
                    select: {
                        id: true,
                        admin_email: true
                    }
                },
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true
                    }
                }
            }
        });

        res.status(201).json(workspace);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get All Workspaces for Agency

```javascript
app.get('/api/agencies/:agencyId/workspaces', async (req, res) => {
    try {
        const { agencyId } = req.params;

        const workspaces = await prisma.workspace.findMany({
            where: {
                agency_id: BigInt(agencyId)
            },
            include: {
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true
                    }
                },
                _count: {
                    select: {
                        tasks: true,
                        members: true,
                        categories: true
                    }
                }
            },
            orderBy: {
                created_at: 'desc'
            }
        });

        res.json({
            total: workspaces.length,
            workspaces
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Add Member to Workspace

```javascript
app.post('/api/workspaces/:workspaceId/members', async (req, res) => {
    try {
        const { workspaceId } = req.params;
        const { user_id, role } = req.body;

        const member = await prisma.workspaceMember.create({
            data: {
                workspace_id: workspaceId,
                user_id: BigInt(user_id),
                role: role || 'member'
            },
            include: {
                user: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true
                    }
                }
            }
        });

        res.status(201).json(member);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 4. Get Workspace Members

```javascript
app.get('/api/workspaces/:workspaceId/members', async (req, res) => {
    try {
        const { workspaceId } = req.params;

        const members = await prisma.workspaceMember.findMany({
            where: {
                workspace_id: workspaceId
            },
            include: {
                user: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true,
                        images: true
                    }
                }
            },
            orderBy: {
                joined_at: 'asc'
            }
        });

        res.json({
            total: members.length,
            members
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Task Operations

### 1. Create Task

```javascript
app.post('/api/tasks', async (req, res) => {
    try {
        const {
            workspace_id,
            title,
            description,
            status,
            priority,
            dueDate,
            category_id,
            parent_task_id,
            group_id,
            created_by,
            assignees // Array of user_ids
        } = req.body;

        const task = await prisma.taskManagement.create({
            data: {
                workspace_id,
                title,
                description,
                status: status || 'TODO',
                priority: priority || 'MEDIUM',
                dueDate: dueDate ? new Date(dueDate) : null,
                category_id,
                parent_task_id,
                group_id,
                created_by: BigInt(created_by),
                assignments: assignees ? {
                    create: assignees.map(user_id => ({
                        user_id: BigInt(user_id)
                    }))
                } : undefined
            },
            include: {
                workspace: {
                    select: {
                        id: true,
                        name: true
                    }
                },
                category: true,
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true
                    }
                },
                assignments: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                email: true
                            }
                        }
                    }
                }
            }
        });

        // Create history entry
        await prisma.taskHistory.create({
            data: {
                task_id: task.id,
                user_id: BigInt(created_by),
                action: 'created',
                newValue: 'Task created'
            }
        });

        res.status(201).json(task);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get Task by ID (Full Details)

```javascript
app.get('/api/tasks/:taskId', async (req, res) => {
    try {
        const { taskId } = req.params;

        const task = await prisma.taskManagement.findUnique({
            where: {
                id: taskId
            },
            include: {
                workspace: {
                    select: {
                        id: true,
                        name: true,
                        agency_id: true
                    }
                },
                category: true,
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true
                    }
                },
                updater: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true
                    }
                },
                parentTask: {
                    select: {
                        id: true,
                        title: true,
                        status: true
                    }
                },
                subTasks: {
                    select: {
                        id: true,
                        title: true,
                        status: true,
                        priority: true,
                        dueDate: true
                    }
                },
                group: true,
                assignments: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                email: true,
                                images: true
                            }
                        }
                    }
                },
                checklist: {
                    orderBy: {
                        order: 'asc'
                    }
                },
                comments: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                images: true
                            }
                        }
                    },
                    orderBy: {
                        created_at: 'desc'
                    }
                },
                attachments: true,
                reminders: {
                    include: {
                        recipients: {
                            include: {
                                user: {
                                    select: {
                                        id: true,
                                        first_name: true,
                                        last_name: true,
                                        email: true
                                    }
                                }
                            }
                        }
                    }
                },
                repeat: {
                    include: {
                        daysOfWeek: true
                    }
                },
                _count: {
                    select: {
                        comments: true,
                        attachments: true,
                        checklist: true,
                        subTasks: true
                    }
                }
            }
        });

        if (!task) {
            return res.status(404).json({ error: 'Task not found' });
        }

        res.json(task);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Update Task

```javascript
app.patch('/api/tasks/:taskId', async (req, res) => {
    try {
        const { taskId } = req.params;
        const {
            title,
            description,
            status,
            priority,
            dueDate,
            category_id,
            updated_by
        } = req.body;

        // Get old task for history
        const oldTask = await prisma.taskManagement.findUnique({
            where: { id: taskId }
        });

        const task = await prisma.taskManagement.update({
            where: {
                id: taskId
            },
            data: {
                title,
                description,
                status,
                priority,
                dueDate: dueDate ? new Date(dueDate) : undefined,
                category_id,
                updated_by: updated_by ? BigInt(updated_by) : undefined,
                completedAt: status === 'DONE' ? new Date() : null
            },
            include: {
                workspace: true,
                category: true,
                assignments: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                email: true
                            }
                        }
                    }
                }
            }
        });

        // Create history entries for each changed field
        const changes = [];
        if (title && title !== oldTask.title) {
            changes.push({ field: 'title', oldValue: oldTask.title, newValue: title });
        }
        if (status && status !== oldTask.status) {
            changes.push({ field: 'status', oldValue: oldTask.status, newValue: status });
        }
        if (priority && priority !== oldTask.priority) {
            changes.push({ field: 'priority', oldValue: oldTask.priority, newValue: priority });
        }

        if (changes.length > 0 && updated_by) {
            await prisma.taskHistory.createMany({
                data: changes.map(change => ({
                    task_id: taskId,
                    user_id: BigInt(updated_by),
                    action: 'updated',
                    field: change.field,
                    oldValue: change.oldValue,
                    newValue: change.newValue
                }))
            });
        }

        res.json(task);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 4. Delete Task

```javascript
app.delete('/api/tasks/:taskId', async (req, res) => {
    try {
        const { taskId } = req.params;
        const { deleted_by } = req.body;

        // Check if task has subtasks
        const subtasksCount = await prisma.taskManagement.count({
            where: {
                parent_task_id: taskId
            }
        });

        if (subtasksCount > 0) {
            return res.status(400).json({
                error: 'Cannot delete task with subtasks',
                subtasks_count: subtasksCount
            });
        }

        // Create history entry before deletion
        if (deleted_by) {
            await prisma.taskHistory.create({
                data: {
                    task_id: taskId,
                    user_id: BigInt(deleted_by),
                    action: 'deleted',
                    newValue: 'Task deleted'
                }
            });
        }

        await prisma.taskManagement.delete({
            where: {
                id: taskId
            }
        });

        res.json({ message: 'Task deleted successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 5. Get Tasks by Workspace

```javascript
app.get('/api/workspaces/:workspaceId/tasks', async (req, res) => {
    try {
        const { workspaceId } = req.params;
        const {
            status,
            priority,
            category_id,
            group_id,
            assigned_to,
            search,
            page = 1,
            limit = 50
        } = req.query;

        const skip = (parseInt(page) - 1) * parseInt(limit);

        const where = {
            workspace_id: workspaceId,
            parent_task_id: null, // Only top-level tasks
            ...(status && { status }),
            ...(priority && { priority }),
            ...(category_id && { category_id }),
            ...(group_id && { group_id }),
            ...(assigned_to && {
                assignments: {
                    some: {
                        user_id: BigInt(assigned_to)
                    }
                }
            }),
            ...(search && {
                OR: [
                    { title: { contains: search } },
                    { description: { contains: search } }
                ]
            })
        };

        const [tasks, total] = await Promise.all([
            prisma.taskManagement.findMany({
                where,
                include: {
                    category: true,
                    creator: {
                        select: {
                            id: true,
                            first_name: true,
                            last_name: true
                        }
                    },
                    assignments: {
                        include: {
                            user: {
                                select: {
                                    id: true,
                                    first_name: true,
                                    last_name: true,
                                    images: true
                                }
                            }
                        }
                    },
                    _count: {
                        select: {
                            subTasks: true,
                            comments: true,
                            attachments: true,
                            checklist: true
                        }
                    }
                },
                orderBy: [
                    { priority: 'desc' },
                    { dueDate: 'asc' },
                    { created_at: 'desc' }
                ],
                skip,
                take: parseInt(limit)
            }),
            prisma.taskManagement.count({ where })
        ]);

        res.json({
            tasks,
            pagination: {
                total,
                page: parseInt(page),
                limit: parseInt(limit),
                total_pages: Math.ceil(total / parseInt(limit))
            }
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Task Assignment Operations

### 1. Assign User to Task

```javascript
app.post('/api/tasks/:taskId/assign', async (req, res) => {
    try {
        const { taskId } = req.params;
        const { user_id, assigned_by } = req.body;

        const assignment = await prisma.taskAssignment.create({
            data: {
                task_id: taskId,
                user_id: BigInt(user_id)
            },
            include: {
                user: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true
                    }
                },
                task: {
                    select: {
                        id: true,
                        title: true,
                        workspace_id: true
                    }
                }
            }
        });

        // Create history entry
        if (assigned_by) {
            await prisma.taskHistory.create({
                data: {
                    task_id: taskId,
                    user_id: BigInt(assigned_by),
                    action: 'assigned',
                    newValue: `Assigned to user ${user_id}`
                }
            });
        }

        res.status(201).json(assignment);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Unassign User from Task

```javascript
app.delete('/api/tasks/:taskId/assign/:userId', async (req, res) => {
    try {
        const { taskId, userId } = req.params;
        const { unassigned_by } = req.body;

        await prisma.taskAssignment.delete({
            where: {
                task_id_user_id: {
                    task_id: taskId,
                    user_id: BigInt(userId)
                }
            }
        });

        // Create history entry
        if (unassigned_by) {
            await prisma.taskHistory.create({
                data: {
                    task_id: taskId,
                    user_id: BigInt(unassigned_by),
                    action: 'unassigned',
                    newValue: `Unassigned user ${userId}`
                }
            });
        }

        res.json({ message: 'User unassigned successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Get Task Assignees

```javascript
app.get('/api/tasks/:taskId/assignees', async (req, res) => {
    try {
        const { taskId } = req.params;

        const assignees = await prisma.taskAssignment.findMany({
            where: {
                task_id: taskId
            },
            include: {
                user: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true,
                        images: true
                    }
                }
            }
        });

        res.json({
            total: assignees.length,
            assignees: assignees.map(a => a.user)
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## User-Based Task Queries

### 1. Get Tasks Assigned to User (Staff View)

```javascript
app.get('/api/users/:userId/tasks', async (req, res) => {
    try {
        const { userId } = req.params;
        const { status, priority, workspace_id, overdue } = req.query;

        const where = {
            assignments: {
                some: {
                    user_id: BigInt(userId)
                }
            },
            ...(status && { status }),
            ...(priority && { priority }),
            ...(workspace_id && { workspace_id }),
            ...(overdue === 'true' && {
                dueDate: {
                    lt: new Date()
                },
                status: {
                    not: 'DONE'
                }
            })
        };

        const tasks = await prisma.taskManagement.findMany({
            where,
            include: {
                workspace: {
                    select: {
                        id: true,
                        name: true,
                        agency_id: true
                    }
                },
                category: true,
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true
                    }
                },
                assignments: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        }
                    }
                },
                _count: {
                    select: {
                        comments: true,
                        attachments: true,
                        checklist: true
                    }
                }
            },
            orderBy: [
                { priority: 'desc' },
                { dueDate: 'asc' }
            ]
        });

        res.json({
            user_id: userId,
            total_tasks: tasks.length,
            tasks
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get Tasks Created by User (Admin View)

```javascript
app.get('/api/users/:userId/created-tasks', async (req, res) => {
    try {
        const { userId } = req.params;
        const { workspace_id, status } = req.query;

        const tasks = await prisma.taskManagement.findMany({
            where: {
                created_by: BigInt(userId),
                ...(workspace_id && { workspace_id }),
                ...(status && { status })
            },
            include: {
                workspace: {
                    select: {
                        id: true,
                        name: true
                    }
                },
                category: true,
                assignments: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        }
                    }
                },
                _count: {
                    select: {
                        subTasks: true,
                        comments: true
                    }
                }
            },
            orderBy: {
                created_at: 'desc'
            }
        });

        res.json({
            user_id: userId,
            total_created: tasks.length,
            tasks
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Get User's Task Dashboard (Combined View)

```javascript
app.get('/api/users/:userId/dashboard', async (req, res) => {
    try {
        const { userId } = req.params;
        const uid = BigInt(userId);

        // Get tasks assigned to user
        const assignedTasks = await prisma.taskManagement.findMany({
            where: {
                assignments: {
                    some: {
                        user_id: uid
                    }
                }
            },
            include: {
                workspace: {
                    select: {
                        id: true,
                        name: true
                    }
                },
                category: true,
                _count: {
                    select: {
                        comments: true
                    }
                }
            }
        });

        // Group by status
        const tasksByStatus = {
            TODO: assignedTasks.filter(t => t.status === 'TODO'),
            IN_PROGRESS: assignedTasks.filter(t => t.status === 'IN_PROGRESS'),
            DONE: assignedTasks.filter(t => t.status === 'DONE'),
            BLOCKED: assignedTasks.filter(t => t.status === 'BLOCKED')
        };

        // Get overdue tasks
        const now = new Date();
        const overdueTasks = assignedTasks.filter(
            t => t.dueDate && t.dueDate < now && t.status !== 'DONE'
        );

        // Get tasks due today
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1);

        const dueTodayTasks = assignedTasks.filter(
            t => t.dueDate && t.dueDate >= today && t.dueDate < tomorrow
        );

        // Get tasks created by user
        const createdTasks = await prisma.taskManagement.count({
            where: {
                created_by: uid
            }
        });

        // Get workspaces user has access to
        const workspaces = await prisma.workspaceMember.findMany({
            where: {
                user_id: uid
            },
            include: {
                workspace: {
                    select: {
                        id: true,
                        name: true,
                        agency_id: true
                    }
                }
            }
        });

        res.json({
            user_id: userId,
            summary: {
                total_assigned: assignedTasks.length,
                todo: tasksByStatus.TODO.length,
                in_progress: tasksByStatus.IN_PROGRESS.length,
                done: tasksByStatus.DONE.length,
                blocked: tasksByStatus.BLOCKED.length,
                overdue: overdueTasks.length,
                due_today: dueTodayTasks.length,
                created: createdTasks
            },
            overdue_tasks: overdueTasks,
            due_today_tasks: dueTodayTasks,
            tasks_by_status: tasksByStatus,
            workspaces: workspaces.map(w => w.workspace)
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 4. Get Agency Staff with Task Counts

```javascript
app.get('/api/agencies/:agencyId/staff-tasks', async (req, res) => {
    try {
        const { agencyId } = req.params;

        // Get all workspaces in the agency
        const workspaces = await prisma.workspace.findMany({
            where: {
                agency_id: BigInt(agencyId)
            },
            select: {
                id: true
            }
        });

        const workspaceIds = workspaces.map(w => w.id);

        // Get all tasks in these workspaces with assignments
        const tasks = await prisma.taskManagement.findMany({
            where: {
                workspace_id: {
                    in: workspaceIds
                }
            },
            include: {
                assignments: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                email: true
                            }
                        }
                    }
                }
            }
        });

        // Count tasks per user
        const userTaskCounts = {};
        tasks.forEach(task => {
            task.assignments.forEach(assignment => {
                const userId = assignment.user_id.toString();
                if (!userTaskCounts[userId]) {
                    userTaskCounts[userId] = {
                        user: assignment.user,
                        total: 0,
                        todo: 0,
                        in_progress: 0,
                        done: 0,
                        blocked: 0
                    };
                }
                userTaskCounts[userId].total++;
                userTaskCounts[userId][task.status.toLowerCase()]++;
            });
        });

        const staffList = Object.values(userTaskCounts);

        res.json({
            agency_id: agencyId,
            total_staff: staffList.length,
            staff: staffList.sort((a, b) => b.total - a.total)
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Task Statistics

### 1. Get Workspace Statistics

```javascript
app.get('/api/workspaces/:workspaceId/stats', async (req, res) => {
    try {
        const { workspaceId } = req.params;

        const [
            totalTasks,
            tasksByStatus,
            tasksByPriority,
            overdueTasks,
            completedThisWeek,
            totalMembers,
            totalCategories
        ] = await Promise.all([
            // Total tasks
            prisma.taskManagement.count({
                where: { workspace_id: workspaceId }
            }),

            // Tasks by status
            prisma.taskManagement.groupBy({
                by: ['status'],
                where: { workspace_id: workspaceId },
                _count: { id: true }
            }),

            // Tasks by priority
            prisma.taskManagement.groupBy({
                by: ['priority'],
                where: { workspace_id: workspaceId },
                _count: { id: true }
            }),

            // Overdue tasks
            prisma.taskManagement.count({
                where: {
                    workspace_id: workspaceId,
                    dueDate: { lt: new Date() },
                    status: { not: 'DONE' }
                }
            }),

            // Completed this week
            prisma.taskManagement.count({
                where: {
                    workspace_id: workspaceId,
                    status: 'DONE',
                    completedAt: {
                        gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000)
                    }
                }
            }),

            // Members count
            prisma.workspaceMember.count({
                where: { workspace_id: workspaceId }
            }),

            // Categories count
            prisma.taskCategory.count({
                where: { workspace_id: workspaceId }
            })
        ]);

        // Format status counts
        const statusCounts = tasksByStatus.reduce((acc, item) => {
            acc[item.status] = item._count.id;
            return acc;
        }, {});

        // Format priority counts
        const priorityCounts = tasksByPriority.reduce((acc, item) => {
            acc[item.priority] = item._count.id;
            return acc;
        }, {});

        // Completion rate
        const completedTasks = statusCounts.DONE || 0;
        const completionRate = totalTasks > 0
            ? ((completedTasks / totalTasks) * 100).toFixed(2)
            : 0;

        res.json({
            workspace_id: workspaceId,
            overview: {
                total_tasks: totalTasks,
                total_members: totalMembers,
                total_categories: totalCategories,
                overdue_tasks: overdueTasks,
                completed_this_week: completedThisWeek,
                completion_rate: parseFloat(completionRate)
            },
            tasks_by_status: statusCounts,
            tasks_by_priority: priorityCounts
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get Agency-Wide Statistics

```javascript
app.get('/api/agencies/:agencyId/stats', async (req, res) => {
    try {
        const { agencyId } = req.params;

        // Get all workspaces
        const workspaces = await prisma.workspace.findMany({
            where: { agency_id: BigInt(agencyId) },
            select: { id: true }
        });

        const workspaceIds = workspaces.map(w => w.id);

        const [
            totalTasks,
            tasksByStatus,
            totalWorkspaces,
            totalMembers,
            overdueTasks,
            completedToday,
            activeTasks
        ] = await Promise.all([
            // Total tasks
            prisma.taskManagement.count({
                where: { workspace_id: { in: workspaceIds } }
            }),

            // Tasks by status
            prisma.taskManagement.groupBy({
                by: ['status'],
                where: { workspace_id: { in: workspaceIds } },
                _count: { id: true }
            }),

            // Total workspaces
            prisma.workspace.count({
                where: { agency_id: BigInt(agencyId) }
            }),

            // Total unique members across all workspaces
            prisma.workspaceMember.findMany({
                where: { workspace_id: { in: workspaceIds } },
                select: { user_id: true },
                distinct: ['user_id']
            }),

            // Overdue tasks
            prisma.taskManagement.count({
                where: {
                    workspace_id: { in: workspaceIds },
                    dueDate: { lt: new Date() },
                    status: { not: 'DONE' }
                }
            }),

            // Completed today
            prisma.taskManagement.count({
                where: {
                    workspace_id: { in: workspaceIds },
                    status: 'DONE',
                    completedAt: {
                        gte: new Date(new Date().setHours(0, 0, 0, 0))
                    }
                }
            }),

            // Active tasks (TODO or IN_PROGRESS)
            prisma.taskManagement.count({
                where: {
                    workspace_id: { in: workspaceIds },
                    status: { in: ['TODO', 'IN_PROGRESS'] }
                }
            })
        ]);

        const statusCounts = tasksByStatus.reduce((acc, item) => {
            acc[item.status] = item._count.id;
            return acc;
        }, {});

        res.json({
            agency_id: agencyId,
            overview: {
                total_workspaces: totalWorkspaces,
                total_tasks: totalTasks,
                active_tasks: activeTasks,
                overdue_tasks: overdueTasks,
                completed_today: completedToday,
                total_members: totalMembers.length
            },
            tasks_by_status: statusCounts
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Get Task Analytics by Date Range

```javascript
app.get('/api/workspaces/:workspaceId/analytics', async (req, res) => {
    try {
        const { workspaceId } = req.params;
        const { start_date, end_date } = req.query;

        const startDate = start_date ? new Date(start_date) : new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
        const endDate = end_date ? new Date(end_date) : new Date();

        const tasks = await prisma.taskManagement.findMany({
            where: {
                workspace_id: workspaceId,
                created_at: {
                    gte: startDate,
                    lte: endDate
                }
            },
            select: {
                id: true,
                status: true,
                priority: true,
                created_at: true,
                completedAt: true,
                dueDate: true
            }
        });

        // Group by date
        const tasksByDate = {};
        tasks.forEach(task => {
            const date = task.created_at.toISOString().split('T')[0];
            if (!tasksByDate[date]) {
                tasksByDate[date] = { created: 0, completed: 0 };
            }
            tasksByDate[date].created++;

            if (task.completedAt) {
                const completedDate = task.completedAt.toISOString().split('T')[0];
                if (!tasksByDate[completedDate]) {
                    tasksByDate[completedDate] = { created: 0, completed: 0 };
                }
                tasksByDate[completedDate].completed++;
            }
        });

        // Calculate average completion time
        const completedTasks = tasks.filter(t => t.completedAt);
        const avgCompletionTime = completedTasks.length > 0
            ? completedTasks.reduce((sum, task) => {
                return sum + (task.completedAt - task.created_at);
            }, 0) / completedTasks.length / (1000 * 60 * 60 * 24) // Convert to days
            : 0;

        res.json({
            workspace_id: workspaceId,
            date_range: {
                start: startDate,
                end: endDate
            },
            summary: {
                total_created: tasks.length,
                total_completed: completedTasks.length,
                avg_completion_days: avgCompletionTime.toFixed(2)
            },
            tasks_by_date: tasksByDate
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Task Categories

### 1. Create Category

```javascript
app.post('/api/workspaces/:workspaceId/categories', async (req, res) => {
    try {
        const { workspaceId } = req.params;
        const { name, description, color, icon } = req.body;

        const category = await prisma.taskCategory.create({
            data: {
                workspace_id: workspaceId,
                name,
                description,
                color,
                icon
            }
        });

        res.status(201).json(category);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get All Categories in Workspace

```javascript
app.get('/api/workspaces/:workspaceId/categories', async (req, res) => {
    try {
        const { workspaceId } = req.params;

        const categories = await prisma.taskCategory.findMany({
            where: {
                workspace_id: workspaceId
            },
            include: {
                _count: {
                    select: {
                        tasks: true
                    }
                }
            },
            orderBy: {
                created_at: 'asc'
            }
        });

        res.json({
            total: categories.length,
            categories
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Get Tasks by Category

```javascript
app.get('/api/categories/:categoryId/tasks', async (req, res) => {
    try {
        const { categoryId } = req.params;
        const { status } = req.query;

        const tasks = await prisma.taskManagement.findMany({
            where: {
                category_id: categoryId,
                ...(status && { status })
            },
            include: {
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true
                    }
                },
                assignments: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        }
                    }
                }
            },
            orderBy: {
                created_at: 'desc'
            }
        });

        res.json({
            category_id: categoryId,
            total: tasks.length,
            tasks
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Task Groups

### 1. Create Task Group

```javascript
app.post('/api/workspaces/:workspaceId/groups', async (req, res) => {
    try {
        const { workspaceId } = req.params;
        const {
            title,
            description,
            type,
            groupImage,
            color,
            icon,
            created_by,
            member_ids
        } = req.body;

        const group = await prisma.taskGroup.create({
            data: {
                workspace_id: workspaceId,
                title,
                description,
                type: type || 'PUBLIC',
                groupImage,
                color,
                icon,
                created_by: BigInt(created_by),
                members: member_ids ? {
                    create: member_ids.map(user_id => ({
                        user_id: BigInt(user_id)
                    }))
                } : undefined
            },
            include: {
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true
                    }
                },
                members: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                email: true
                            }
                        }
                    }
                }
            }
        });

        res.status(201).json(group);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get Group with Tasks

```javascript
app.get('/api/groups/:groupId', async (req, res) => {
    try {
        const { groupId } = req.params;

        const group = await prisma.taskGroup.findUnique({
            where: {
                id: groupId
            },
            include: {
                workspace: {
                    select: {
                        id: true,
                        name: true
                    }
                },
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true
                    }
                },
                members: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                email: true,
                                images: true
                            }
                        }
                    }
                },
                tasks: {
                    include: {
                        category: true,
                        assignments: {
                            include: {
                                user: {
                                    select: {
                                        id: true,
                                        first_name: true,
                                        last_name: true
                                    }
                                }
                            }
                        },
                        _count: {
                            select: {
                                comments: true,
                                attachments: true
                            }
                        }
                    },
                    orderBy: {
                        created_at: 'desc'
                    }
                },
                _count: {
                    select: {
                        tasks: true,
                        members: true
                    }
                }
            }
        });

        if (!group) {
            return res.status(404).json({ error: 'Group not found' });
        }

        res.json(group);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Add Member to Group

```javascript
app.post('/api/groups/:groupId/members', async (req, res) => {
    try {
        const { groupId } = req.params;
        const { user_id } = req.body;

        const member = await prisma.groupMembership.create({
            data: {
                group_id: groupId,
                user_id: BigInt(user_id)
            },
            include: {
                user: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true
                    }
                }
            }
        });

        res.status(201).json(member);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Checklist Operations

### 1. Add Checklist Item

```javascript
app.post('/api/tasks/:taskId/checklist', async (req, res) => {
    try {
        const { taskId } = req.params;
        const { title, order } = req.body;

        const item = await prisma.checklistItem.create({
            data: {
                task_id: taskId,
                title,
                order: order || 0
            }
        });

        res.status(201).json(item);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Toggle Checklist Item

```javascript
app.patch('/api/checklist/:itemId', async (req, res) => {
    try {
        const { itemId } = req.params;
        const { isCompleted } = req.body;

        const item = await prisma.checklistItem.update({
            where: {
                id: itemId
            },
            data: {
                isCompleted
            }
        });

        res.json(item);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Get Checklist Progress

```javascript
app.get('/api/tasks/:taskId/checklist/progress', async (req, res) => {
    try {
        const { taskId } = req.params;

        const [total, completed] = await Promise.all([
            prisma.checklistItem.count({
                where: { task_id: taskId }
            }),
            prisma.checklistItem.count({
                where: {
                    task_id: taskId,
                    isCompleted: true
                }
            })
        ]);

        const progress = total > 0 ? ((completed / total) * 100).toFixed(2) : 0;

        res.json({
            task_id: taskId,
            total_items: total,
            completed_items: completed,
            progress_percentage: parseFloat(progress)
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Task Comments

### 1. Add Comment

```javascript
app.post('/api/tasks/:taskId/comments', async (req, res) => {
    try {
        const { taskId } = req.params;
        const { user_id, content } = req.body;

        const comment = await prisma.taskComment.create({
            data: {
                task_id: taskId,
                user_id: BigInt(user_id),
                content
            },
            include: {
                user: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        images: true
                    }
                }
            }
        });

        // Create history entry
        await prisma.taskHistory.create({
            data: {
                task_id: taskId,
                user_id: BigInt(user_id),
                action: 'commented',
                newValue: content
            }
        });

        res.status(201).json(comment);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get Task Comments

```javascript
app.get('/api/tasks/:taskId/comments', async (req, res) => {
    try {
        const { taskId } = req.params;

        const comments = await prisma.taskComment.findMany({
            where: {
                task_id: taskId
            },
            include: {
                user: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        images: true
                    }
                }
            },
            orderBy: {
                created_at: 'desc'
            }
        });

        res.json({
            total: comments.length,
            comments
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Update Comment

```javascript
app.patch('/api/comments/:commentId', async (req, res) => {
    try {
        const { commentId } = req.params;
        const { content } = req.body;

        const comment = await prisma.taskComment.update({
            where: {
                id: commentId
            },
            data: {
                content
            },
            include: {
                user: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true
                    }
                }
            }
        });

        res.json(comment);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Task Attachments

### 1. Add Attachment

```javascript
app.post('/api/tasks/:taskId/attachments', async (req, res) => {
    try {
        const { taskId } = req.params;
        const { fileUrl, fileName, fileSize, mimeType } = req.body;

        const attachment = await prisma.taskAttachment.create({
            data: {
                task_id: taskId,
                fileUrl,
                fileName,
                fileSize: fileSize ? BigInt(fileSize) : null,
                mimeType
            }
        });

        res.status(201).json(attachment);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get Task Attachments

```javascript
app.get('/api/tasks/:taskId/attachments', async (req, res) => {
    try {
        const { taskId } = req.params;

        const attachments = await prisma.taskAttachment.findMany({
            where: {
                task_id: taskId
            },
            orderBy: {
                created_at: 'desc'
            }
        });

        res.json({
            total: attachments.length,
            attachments
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Delete Attachment

```javascript
app.delete('/api/attachments/:attachmentId', async (req, res) => {
    try {
        const { attachmentId } = req.params;

        await prisma.taskAttachment.delete({
            where: {
                id: attachmentId
            }
        });

        res.json({ message: 'Attachment deleted successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Task Reminders

### 1. Create Reminder

```javascript
app.post('/api/tasks/:taskId/reminders', async (req, res) => {
    try {
        const { taskId } = req.params;
        const {
            channel,
            triggerType,
            triggerAt,
            reminderMessage,
            recipient_ids
        } = req.body;

        const reminder = await prisma.taskReminder.create({
            data: {
                task_id: taskId,
                channel: channel || 'EMAIL',
                triggerType: triggerType || 'SPECIFIC_TIME',
                triggerAt: new Date(triggerAt),
                reminderMessage,
                recipients: recipient_ids ? {
                    create: recipient_ids.map(user_id => ({
                        user_id: BigInt(user_id)
                    }))
                } : undefined
            },
            include: {
                recipients: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                email: true
                            }
                        }
                    }
                }
            }
        });

        res.status(201).json(reminder);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get Pending Reminders

```javascript
app.get('/api/reminders/pending', async (req, res) => {
    try {
        const now = new Date();

        const reminders = await prisma.taskReminder.findMany({
            where: {
                status: 'PENDING',
                triggerAt: {
                    lte: now
                }
            },
            include: {
                task: {
                    select: {
                        id: true,
                        title: true,
                        workspace_id: true
                    }
                },
                recipients: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                email: true,
                                phone: true
                            }
                        }
                    }
                }
            },
            orderBy: {
                triggerAt: 'asc'
            }
        });

        res.json({
            total: reminders.length,
            reminders
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Mark Reminder as Sent

```javascript
app.patch('/api/reminders/:reminderId/sent', async (req, res) => {
    try {
        const { reminderId } = req.params;

        const reminder = await prisma.taskReminder.update({
            where: {
                id: reminderId
            },
            data: {
                status: 'SENT',
                sentAt: new Date()
            }
        });

        res.json(reminder);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Recurring Tasks

### 1. Create Recurring Task

```javascript
app.post('/api/tasks/recurring', async (req, res) => {
    try {
        const {
            workspace_id,
            title,
            description,
            priority,
            category_id,
            created_by,
            repeat_config
        } = req.body;

        const task = await prisma.taskManagement.create({
            data: {
                workspace_id,
                title,
                description,
                priority: priority || 'MEDIUM',
                category_id,
                created_by: BigInt(created_by),
                repeat: {
                    create: {
                        interval: repeat_config.interval,
                        startDate: new Date(repeat_config.startDate),
                        endDate: repeat_config.endDate ? new Date(repeat_config.endDate) : null,
                        dayOfMonth: repeat_config.dayOfMonth,
                        skipWeekends: repeat_config.skipWeekends || false,
                        occurrenceCount: repeat_config.occurrenceCount,
                        daysOfWeek: repeat_config.daysOfWeek ? {
                            create: repeat_config.daysOfWeek.map(day => ({
                                dayOfWeek: day
                            }))
                        } : undefined
                    }
                }
            },
            include: {
                repeat: {
                    include: {
                        daysOfWeek: true
                    }
                }
            }
        });

        res.status(201).json(task);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Get All Recurring Tasks

```javascript
app.get('/api/workspaces/:workspaceId/recurring-tasks', async (req, res) => {
    try {
        const { workspaceId } = req.params;

        const tasks = await prisma.taskManagement.findMany({
            where: {
                workspace_id: workspaceId,
                repeat: {
                    isNot: null
                }
            },
            include: {
                category: true,
                repeat: {
                    include: {
                        daysOfWeek: true
                    }
                },
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true
                    }
                }
            }
        });

        res.json({
            total: tasks.length,
            tasks
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Task Templates

### 1. Create Task Template

```javascript
app.post('/api/templates', async (req, res) => {
    try {
        const {
            title,
            description,
            status,
            priority,
            category_id,
            created_by,
            checklist_items,
            attachments
        } = req.body;

        const template = await prisma.taskTemplate.create({
            data: {
                title,
                description,
                status: status || 'TODO',
                priority: priority || 'MEDIUM',
                category_id,
                created_by: BigInt(created_by),
                checklistItems: checklist_items ? {
                    create: checklist_items.map((item, index) => ({
                        title: item.title,
                        order: index
                    }))
                } : undefined,
                attachments: attachments ? {
                    create: attachments.map(att => ({
                        fileUrl: att.fileUrl,
                        fileName: att.fileName
                    }))
                } : undefined
            },
            include: {
                category: true,
                checklistItems: {
                    orderBy: {
                        order: 'asc'
                    }
                },
                attachments: true
            }
        });

        res.status(201).json(template);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 2. Create Task from Template

```javascript
app.post('/api/templates/:templateId/create-task', async (req, res) => {
    try {
        const { templateId } = req.params;
        const { workspace_id, dueDate, assignees, created_by } = req.body;

        // Get template
        const template = await prisma.taskTemplate.findUnique({
            where: { id: templateId },
            include: {
                checklistItems: true,
                attachments: true
            }
        });

        if (!template) {
            return res.status(404).json({ error: 'Template not found' });
        }

        // Create task from template
        const task = await prisma.taskManagement.create({
            data: {
                workspace_id,
                title: template.title,
                description: template.description,
                status: template.status,
                priority: template.priority,
                category_id: template.category_id,
                dueDate: dueDate ? new Date(dueDate) : null,
                created_by: BigInt(created_by),
                assignments: assignees ? {
                    create: assignees.map(user_id => ({
                        user_id: BigInt(user_id)
                    }))
                } : undefined,
                checklist: {
                    create: template.checklistItems.map(item => ({
                        title: item.title,
                        order: item.order
                    }))
                },
                attachments: {
                    create: template.attachments.map(att => ({
                        fileUrl: att.fileUrl,
                        fileName: att.fileName
                    }))
                }
            },
            include: {
                checklist: true,
                attachments: true,
                assignments: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        }
                    }
                }
            }
        });

        res.status(201).json(task);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### 3. Get All Templates

```javascript
app.get('/api/templates', async (req, res) => {
    try {
        const { category_id } = req.query;

        const templates = await prisma.taskTemplate.findMany({
            where: {
                ...(category_id && { category_id })
            },
            include: {
                category: true,
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true
                    }
                },
                _count: {
                    select: {
                        checklistItems: true,
                        attachments: true
                    }
                }
            },
            orderBy: {
                created_at: 'desc'
            }
        });

        res.json({
            total: templates.length,
            templates
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

---

## Idea Boards

### 1. Create Idea Board

```javascript
app.post('/api/workspaces/:workspaceId/idea-boards', async (req, res) => {
    try {
        const { workspaceId } = req.params;
        const {
            title,
            description,
            coverImage,
            isPublic,
            category_id,
            created_by,
            tags,
            access_members
        } = req.body;

        const board = await prisma.ideaBoard.create({
            data: {
                workspace_id: workspaceId,
                title,
                description,
                coverImage,
                isPublic: isPublic || false,
                category_id,
                created_by: BigInt(created_by),
                tags: tags ? {
                    create: tags.map(tag => ({ tag }))
                } : undefined,
                accessMembers: access_members ? {
                    create: access_members.map(user_id => ({
                        user_id: BigInt(user_id)
                    }))
                } : undefined
            },
            include: {
                workspace: {
                    select: {
                        id: true,
                        name: true,
                        agency_id: true
                    }
                },
                category: true,
                creator: {
                    select: {
                        id: true,
                        first_name: true,
                        last_name: true,
                        email: true
                    }
                },
                tags: true,
                accessMembers: {
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        }
                    }
                }
            }
        });

        res.status(201).json(board);
        } catch (error) {
        res.status(500).json({ error: error.message });
        }
        });
        ```

        ### 2. Get Idea Boards by Workspace

        ```javascript
        app.get('/api/workspaces/:workspaceId/idea-boards', async (req, res) => {
            try {
                const { workspaceId } = req.params;
                const { isPublic, category_id } = req.query;

                const boards = await prisma.ideaBoard.findMany({
                    where: {
                        workspace_id: workspaceId,
                        ...(isPublic !== undefined && { isPublic: isPublic === 'true' }),
                        ...(category_id && { category_id })
                    },
                    include: {
                        category: true,
                        creator: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        },
                        tags: true,
                        _count: {
                            select: {
                                ideas: true,
                                accessMembers: true
                            }
                        }
                    },
                    orderBy: {
                        created_at: 'desc'
                    }
                });

                res.json({
                    total: boards.length,
                    boards
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 3. Get Idea Boards by Agency

        ```javascript
        app.get('/api/agencies/:agencyId/idea-boards', async (req, res) => {
            try {
                const { agencyId } = req.params;

                // Get all workspaces for the agency
                const workspaces = await prisma.workspace.findMany({
                    where: {
                        agency_id: BigInt(agencyId)
                    },
                    select: {
                        id: true
                    }
                });

                const workspaceIds = workspaces.map(w => w.id);

                const boards = await prisma.ideaBoard.findMany({
                    where: {
                        workspace_id: {
                            in: workspaceIds
                        }
                    },
                    include: {
                        workspace: {
                            select: {
                                id: true,
                                name: true
                            }
                        },
                        category: true,
                        creator: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        },
                        _count: {
                            select: {
                                ideas: true
                            }
                        }
                    },
                    orderBy: {
                        created_at: 'desc'
                    }
                });

                res.json({
                    agency_id: agencyId,
                    total_boards: boards.length,
                    boards
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 4. Get Idea Board with Ideas

        ```javascript
        app.get('/api/idea-boards/:boardId', async (req, res) => {
            try {
                const { boardId } = req.params;

                const board = await prisma.ideaBoard.findUnique({
                    where: {
                        id: boardId
                    },
                    include: {
                        workspace: {
                            select: {
                                id: true,
                                name: true
                            }
                        },
                        category: true,
                        creator: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        },
                        tags: true,
                        accessMembers: {
                            include: {
                                user: {
                                    select: {
                                        id: true,
                                        first_name: true,
                                        last_name: true,
                                        email: true
                                    }
                                }
                            }
                        },
                        ideas: {
                            include: {
                                creator: {
                                    select: {
                                        id: true,
                                        first_name: true,
                                        last_name: true
                                    }
                                },
                                tags: true,
                                _count: {
                                    select: {
                                        comments: true,
                                        attachments: true
                                    }
                                }
                            },
                            orderBy: [
                                { upvotes: 'desc' },
                                { created_at: 'desc' }
                            ]
                        }
                    }
                });

                if (!board) {
                    return res.status(404).json({ error: 'Idea board not found' });
                }

                res.json(board);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 5. Create Idea in Board

        ```javascript
        app.post('/api/idea-boards/:boardId/ideas', async (req, res) => {
            try {
                const { boardId } = req.params;
                const { title, description, status, created_by, tags } = req.body;

                const idea = await prisma.idea.create({
                    data: {
                        board_id: boardId,
                        title,
                        description,
                        status: status || 'DRAFT',
                        created_by: BigInt(created_by),
                        tags: tags ? {
                            create: tags.map(tag => ({ tag }))
                        } : undefined
                    },
                    include: {
                        creator: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        },
                        tags: true
                    }
                });

                res.status(201).json(idea);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 6. Upvote Idea

        ```javascript
        app.patch('/api/ideas/:ideaId/upvote', async (req, res) => {
            try {
                const { ideaId } = req.params;

                const idea = await prisma.idea.update({
                    where: {
                        id: ideaId
                    },
                    data: {
                        upvotes: {
                            increment: 1
                        }
                    }
                });

                res.json(idea);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 7. Add Comment to Idea

        ```javascript
        app.post('/api/ideas/:ideaId/comments', async (req, res) => {
            try {
                const { ideaId } = req.params;
                const { user_id, content, parent_id } = req.body;

                const comment = await prisma.ideaComment.create({
                    data: {
                        idea_id: ideaId,
                        user_id: BigInt(user_id),
                        content,
                        parent_id
                    },
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                images: true
                            }
                        }
                    }
                });

                res.status(201).json(comment);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ---

        ## Task History & Audit

        ### 1. Get Task History

        ```javascript
        app.get('/api/tasks/:taskId/history', async (req, res) => {
            try {
                const { taskId } = req.params;

                const history = await prisma.taskHistory.findMany({
                    where: {
                        task_id: taskId
                    },
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                images: true
                            }
                        }
                    },
                    orderBy: {
                        created_at: 'desc'
                    }
                });

                res.json({
                    task_id: taskId,
                    total_events: history.length,
                    history
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 2. Get User Activity Log

        ```javascript
        app.get('/api/users/:userId/activity', async (req, res) => {
            try {
                const { userId } = req.params;
                const { start_date, end_date, action } = req.query;

                const where = {
                    user_id: BigInt(userId),
                    ...(action && { action }),
                    ...(start_date && end_date && {
                        created_at: {
                            gte: new Date(start_date),
                            lte: new Date(end_date)
                        }
                    })
                };

                const activities = await prisma.taskHistory.findMany({
                    where,
                    include: {
                        task: {
                            select: {
                                id: true,
                                title: true,
                                workspace_id: true
                            }
                        }
                    },
                    orderBy: {
                        created_at: 'desc'
                    },
                    take: 100
                });

                res.json({
                    user_id: userId,
                    total_activities: activities.length,
                    activities
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 3. Get Workspace Activity Feed

        ```javascript
        app.get('/api/workspaces/:workspaceId/activity', async (req, res) => {
            try {
                const { workspaceId } = req.params;
                const { limit = 50 } = req.query;

                // Get all tasks in workspace
                const tasks = await prisma.taskManagement.findMany({
                    where: {
                        workspace_id: workspaceId
                    },
                    select: {
                        id: true
                    }
                });

                const taskIds = tasks.map(t => t.id);

                const activities = await prisma.taskHistory.findMany({
                    where: {
                        task_id: {
                            in: taskIds
                        }
                    },
                    include: {
                        user: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true,
                                images: true
                            }
                        },
                        task: {
                            select: {
                                id: true,
                                title: true
                            }
                        }
                    },
                    orderBy: {
                        created_at: 'desc'
                    },
                    take: parseInt(limit)
                });

                res.json({
                    workspace_id: workspaceId,
                    total_activities: activities.length,
                    activities
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ---

        ## Advanced Queries

        ### 1. Search Tasks

        ```javascript
        app.get('/api/search/tasks', async (req, res) => {
            try {
                const {
                    query,
                    workspace_id,
                    agency_id,
                    status,
                    priority,
                    assigned_to,
                    created_by,
                    category_id,
                    has_due_date,
                    overdue,
                    limit = 50
                } = req.query;

                let workspaceIds = [];

                if (agency_id) {
                    const workspaces = await prisma.workspace.findMany({
                        where: { agency_id: BigInt(agency_id) },
                        select: { id: true }
                    });
                    workspaceIds = workspaces.map(w => w.id);
                } else if (workspace_id) {
                    workspaceIds = [workspace_id];
                }

                const where = {
                    ...(workspaceIds.length > 0 && {
                        workspace_id: { in: workspaceIds }
                    }),
                    ...(query && {
                        OR: [
                            { title: { contains: query } },
                            { description: { contains: query } }
                        ]
                    }),
                    ...(status && { status }),
                    ...(priority && { priority }),
                    ...(category_id && { category_id }),
                    ...(assigned_to && {
                        assignments: {
                            some: {
                                user_id: BigInt(assigned_to)
                            }
                        }
                    }),
                    ...(created_by && { created_by: BigInt(created_by) }),
                    ...(has_due_date === 'true' && {
                        dueDate: { not: null }
                    }),
                    ...(overdue === 'true' && {
                        dueDate: { lt: new Date() },
                        status: { not: 'DONE' }
                    })
                };

                const tasks = await prisma.taskManagement.findMany({
                    where,
                    include: {
                        workspace: {
                            select: {
                                id: true,
                                name: true
                            }
                        },
                        category: true,
                        creator: {
                            select: {
                                id: true,
                                first_name: true,
                                last_name: true
                            }
                        },
                        assignments: {
                            include: {
                                user: {
                                    select: {
                                        id: true,
                                        first_name: true,
                                        last_name: true
                                    }
                                }
                            }
                        }
                    },
                    orderBy: [
                        { priority: 'desc' },
                        { created_at: 'desc' }
                    ],
                    take: parseInt(limit)
                });

                res.json({
                    query,
                    total_results: tasks.length,
                    tasks
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 2. Get Task Dependencies (Parent/Subtasks)

        ```javascript
        app.get('/api/tasks/:taskId/dependencies', async (req, res) => {
            try {
                const { taskId } = req.params;

                const task = await prisma.taskManagement.findUnique({
                    where: { id: taskId },
                    include: {
                        parentTask: {
                            select: {
                                id: true,
                                title: true,
                                status: true,
                                priority: true
                            }
                        },
                        subTasks: {
                            include: {
                                assignments: {
                                    include: {
                                        user: {
                                            select: {
                                                id: true,
                                                first_name: true,
                                                last_name: true
                                            }
                                        }
                                    }
                                },
                                _count: {
                                    select: {
                                        subTasks: true
                                    }
                                }
                            }
                        }
                    }
                });

                if (!task) {
                    return res.status(404).json({ error: 'Task not found' });
                }

                res.json({
                    task_id: taskId,
                    parent_task: task.parentTask,
                    sub_tasks: task.subTasks,
                    total_subtasks: task.subTasks.length
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 3. Get Tasks Due This Week

        ```javascript
        app.get('/api/workspaces/:workspaceId/tasks/due-this-week', async (req, res) => {
            try {
                const { workspaceId } = req.params;

                const today = new Date();
                today.setHours(0, 0, 0, 0);
        
                const nextWeek = new Date(today);
                nextWeek.setDate(nextWeek.getDate() + 7);

                const tasks = await prisma.taskManagement.findMany({
                    where: {
                        workspace_id: workspaceId,
                        dueDate: {
                            gte: today,
                            lt: nextWeek
                        },
                        status: {
                            not: 'DONE'
                        }
                    },
                    include: {
                        category: true,
                        assignments: {
                            include: {
                                user: {
                                    select: {
                                        id: true,
                                        first_name: true,
                                        last_name: true,
                                        email: true
                                    }
                                }
                            }
                        }
                    },
                    orderBy: {
                        dueDate: 'asc'
                    }
                });

                // Group by day
                const tasksByDay = {};
                tasks.forEach(task => {
                    const day = task.dueDate.toISOString().split('T')[0];
                    if (!tasksByDay[day]) {
                        tasksByDay[day] = [];
                    }
                    tasksByDay[day].push(task);
                });

                res.json({
                    workspace_id: workspaceId,
                    week_start: today,
                    week_end: nextWeek,
                    total_tasks: tasks.length,
                    tasks_by_day: tasksByDay,
                    all_tasks: tasks
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 4. Get User Workload

        ```javascript
        app.get('/api/users/:userId/workload', async (req, res) => {
            try {
                const { userId } = req.params;

                const tasks = await prisma.taskManagement.findMany({
                    where: {
                        assignments: {
                            some: {
                                user_id: BigInt(userId)
                            }
                        }
                    },
                    include: {
                        workspace: {
                            select: {
                                id: true,
                                name: true
                            }
                        }
                    }
                });

                // Calculate workload metrics
                const totalTasks = tasks.length;
                const activeTasks = tasks.filter(t => 
                    t.status === 'TODO' || t.status === 'IN_PROGRESS'
                ).length;
        
                const overdueTasks = tasks.filter(t => 
                    t.dueDate && t.dueDate < new Date() && t.status !== 'DONE'
                ).length;

                // Tasks by priority
                const highPriorityTasks = tasks.filter(t => 
                    (t.priority === 'HIGH' || t.priority === 'URGENT') && 
                    t.status !== 'DONE'
                ).length;

                // Tasks by workspace
                const tasksByWorkspace = {};
                tasks.forEach(task => {
                    const wsId = task.workspace_id;
                    if (!tasksByWorkspace[wsId]) {
                        tasksByWorkspace[wsId] = {
                            workspace_id: wsId,
                            workspace_name: task.workspace.name,
                            count: 0
                        };
                    }
                    if (task.status !== 'DONE') {
                        tasksByWorkspace[wsId].count++;
                    }
                });

                res.json({
                    user_id: userId,
                    workload_summary: {
                        total_tasks: totalTasks,
                        active_tasks: activeTasks,
                        overdue_tasks: overdueTasks,
                        high_priority_tasks: highPriorityTasks,
                        workload_level: activeTasks > 10 ? 'high' : activeTasks > 5 ? 'medium' : 'low'
                    },
                    tasks_by_workspace: Object.values(tasksByWorkspace)
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ### 5. Bulk Update Tasks

        ```javascript
        app.patch('/api/tasks/bulk-update', async (req, res) => {
            try {
                const { task_ids, updates, updated_by } = req.body;

                const updateData = {};
                if (updates.status) updateData.status = updates.status;
                if (updates.priority) updateData.priority = updates.priority;
                if (updates.category_id) updateData.category_id = updates.category_id;
                if (updates.updated_by) updateData.updated_by = BigInt(updates.updated_by);

                const result = await prisma.taskManagement.updateMany({
                    where: {
                        id: {
                            in: task_ids
                        }
                    },
                    data: updateData
                });

                // Create history entries
                if (updated_by) {
                    await prisma.taskHistory.createMany({
                        data: task_ids.map(task_id => ({
                            task_id,
                            user_id: BigInt(updated_by),
                            action: 'bulk_updated',
                            newValue: JSON.stringify(updates)
                        }))
                    });
                }

                res.json({
                    updated_count: result.count,
                    updates_applied: updates
                });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
        ```

        ---

        ## Complete Example Integration

        Here's a complete example of how to set up the Task Management API in your Express app:

        ```javascript
        // index.js - Complete Integration Example

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

        // Health check
        app.get("/health", async (req, res) => {
            try {
                await prisma.$connect();
                res.json({ status: "ok", database: "connected" });
            } catch (error) {
                res.status(500).json({ status: "error", message: error.message });
            }
        });

        // Add all the API endpoints from the sections above...
        // (Workspace Operations, Task Operations, etc.)

        // Error handling middleware
        app.use((error, req, res, next) => {
            console.error('Error:', error);
            res.status(500).json({ 
                error: 'Internal server error',
                message: error.message 
            });
        });

        app.listen(PORT, () => {
            console.log(`Task Management API running on port ${PORT}`);
        });

        // Graceful shutdown
        process.on('SIGINT', async () => {
            await prisma.$disconnect();
            process.exit(0);
        });
        ```

        ---

        ## Query Performance Tips

        1. Always use indexes for frequently queried fields
        2. Use `select` to limit returned fields when you don't need all data
        3. Use `include` with `select` to fetch only needed related data
        4. Implement pagination for large result sets
        5. Use `_count` instead of fetching all related records when you only need the count
        6. Consider using raw queries for complex aggregations
        7. Use connection pooling for production environments
        8. Implement caching for frequently accessed data

        ---

        ## Error Handling Best Practices

        1. Always wrap database operations in try-catch blocks
        2. Return appropriate HTTP status codes
        3. Log errors for debugging but don't expose sensitive info to clients
        4. Validate input data before database operations
        5. Handle unique constraint violations gracefully
        6. Check for null/undefined before accessing nested properties
        7. Implement request validation middleware
        8. Use transactions for operations that modify multiple tables

        ---

        ## Security Considerations

        1. Always validate and sanitize user input
        2. Implement authentication middleware for all endpoints
        3. Check user permissions before allowing operations
        4. Use parameterized queries (Prisma handles this)
        5. Implement rate limiting
        6. Validate BigInt conversions
        7. Use HTTPS in production
        8. Implement CORS properly
        9. Never expose sensitive data in error messages
        10. Validate file uploads for attachments

        ---

        ## End of Documentation

        This documentation covers all major task management operations including workspaces, tasks, assignments, statistics, categories, groups, checklists, comments, attachments, reminders, recurring tasks, templates, idea boards, history tracking, and advanced queries.