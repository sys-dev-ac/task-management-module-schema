# Task Management API Summary

Complete API documentation for Task Management System with sample queries for all operations.

## Documentation Location

The complete API documentation with all endpoints and sample code is available in:
**TASK_MANAGEMENT_API.md**

## Quick Reference Guide

### Core Features Covered

1. **Workspace Operations**
   - Create workspace
   - Get workspaces by agency
   - Add/remove members
   - Get workspace statistics

2. **Task Operations**
   - Create task with assignments
   - Get task details (full)
   - Update task
   - Delete task
   - Get tasks by workspace (with filters)
   - Bulk update tasks

3. **Task Assignments**
   - Assign user to task
   - Unassign user from task
   - Get task assignees

4. **User-Based Queries**
   - Get tasks assigned to user (staff view)
   - Get tasks created by user (admin view)
   - Get user's task dashboard
   - Get agency staff with task counts
   - Get user workload analysis

5. **Task Statistics**
   - Workspace statistics
   - Agency-wide statistics
   - Task analytics by date range

6. **Task Categories**
   - Create category
   - Get all categories
   - Get tasks by category

7. **Task Groups**
   - Create task group
   - Get group with tasks
   - Add members to group

8. **Checklist Operations**
   - Add checklist item
   - Toggle checklist item
   - Get checklist progress

9. **Task Comments**
   - Add comment
   - Get task comments
   - Update comment

10. **Task Attachments**
    - Add attachment
    - Get task attachments
    - Delete attachment

11. **Task Reminders**
    - Create reminder
    - Get pending reminders
    - Mark reminder as sent

12. **Recurring Tasks**
    - Create recurring task
    - Get all recurring tasks

13. **Task Templates**
    - Create task template
    - Create task from template
    - Get all templates

14. **Idea Boards**
    - Create idea board
    - Get idea boards by workspace
    - Get idea boards by agency
    - Create idea in board
    - Upvote idea
    - Add comment to idea

15. **Task History & Audit**
    - Get task history
    - Get user activity log
    - Get workspace activity feed

16. **Advanced Queries**
    - Search tasks (multi-filter)
    - Get task dependencies
    - Get tasks due this week
    - Get user workload

## Key API Patterns

### User Role Queries

#### Admin View
```
GET /api/users/:userId/created-tasks
GET /api/agencies/:agencyId/staff-tasks
GET /api/agencies/:agencyId/stats
```

#### Staff View
```
GET /api/users/:userId/tasks
GET /api/users/:userId/dashboard
GET /api/users/:userId/workload
```

### Agency-Based Queries

#### Get All Workspaces for Agency
```
GET /api/agencies/:agencyId/workspaces
```

#### Get Agency Staff with Task Counts
```
GET /api/agencies/:agencyId/staff-tasks

Response:
{
  "agency_id": "123",
  "total_staff": 5,
  "staff": [
    {
      "user": {
        "id": "1",
        "first_name": "John",
        "last_name": "Doe",
        "email": "john@example.com"
      },
      "total": 15,
      "todo": 5,
      "in_progress": 7,
      "done": 3,
      "blocked": 0
    }
  ]
}
```

#### Get Agency-Wide Statistics
```
GET /api/agencies/:agencyId/stats

Response:
{
  "agency_id": "123",
  "overview": {
    "total_workspaces": 3,
    "total_tasks": 150,
    "active_tasks": 80,
    "overdue_tasks": 10,
    "completed_today": 5,
    "total_members": 20
  },
  "tasks_by_status": {
    "TODO": 40,
    "IN_PROGRESS": 40,
    "DONE": 60,
    "BLOCKED": 10
  }
}
```

#### Get Idea Boards by Agency
```
GET /api/agencies/:agencyId/idea-boards
```

### Workspace-Based Queries

#### Get All Tasks in Workspace
```
GET /api/workspaces/:workspaceId/tasks?status=TODO&priority=HIGH&page=1&limit=50
```

#### Get Workspace Statistics
```
GET /api/workspaces/:workspaceId/stats

Response:
{
  "workspace_id": "ws_123",
  "overview": {
    "total_tasks": 45,
    "total_members": 8,
    "total_categories": 5,
    "overdue_tasks": 3,
    "completed_this_week": 12,
    "completion_rate": 68.50
  },
  "tasks_by_status": {
    "TODO": 15,
    "IN_PROGRESS": 10,
    "DONE": 18,
    "BLOCKED": 2
  },
  "tasks_by_priority": {
    "LOW": 10,
    "MEDIUM": 20,
    "HIGH": 12,
    "URGENT": 3
  }
}
```

#### Get Workspace Activity Feed
```
GET /api/workspaces/:workspaceId/activity?limit=50
```

#### Get Tasks Due This Week
```
GET /api/workspaces/:workspaceId/tasks/due-this-week
```

### User Dashboard Query

```
GET /api/users/:userId/dashboard

Response:
{
  "user_id": "123",
  "summary": {
    "total_assigned": 15,
    "todo": 5,
    "in_progress": 7,
    "done": 3,
    "blocked": 0,
    "overdue": 2,
    "due_today": 1,
    "created": 25
  },
  "overdue_tasks": [...],
  "due_today_tasks": [...],
  "tasks_by_status": {
    "TODO": [...],
    "IN_PROGRESS": [...],
    "DONE": [...],
    "BLOCKED": [...]
  },
  "workspaces": [...]
}
```

## Common Query Patterns

### Filter Tasks by Multiple Criteria
```javascript
const where = {
  workspace_id: workspaceId,
  status: 'IN_PROGRESS',
  priority: { in: ['HIGH', 'URGENT'] },
  dueDate: { lt: new Date() },
  assignments: {
    some: {
      user_id: BigInt(userId)
    }
  }
};
```

### Include Related Data
```javascript
include: {
  workspace: { select: { id: true, name: true } },
  category: true,
  assignments: {
    include: {
      user: {
        select: { id: true, first_name: true, last_name: true }
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
}
```

### Count Tasks by Status
```javascript
const tasksByStatus = await prisma.taskManagement.groupBy({
  by: ['status'],
  where: { workspace_id: workspaceId },
  _count: { id: true }
});
```

## Important BigInt Handling

All IDs in the schema use BigInt. Always convert string IDs to BigInt:

```javascript
// Correct
user_id: BigInt(userId)
agency_id: BigInt(agencyId)

// For JSON serialization (add to index.js)
BigInt.prototype.toJSON = function () {
  return this.toString();
};
```

## Relationship Structure

```
Agency
  -> Workspaces
    -> Tasks
      -> Assignments (TaskAssignment)
      -> Comments (TaskComment)
      -> Attachments (TaskAttachment)
      -> Checklist Items (ChecklistItem)
      -> History (TaskHistory)
      -> Reminders (TaskReminder)
    -> Categories (TaskCategory)
    -> Groups (TaskGroup)
    -> Idea Boards (IdeaBoard)
      -> Ideas
        -> Comments
```

## Performance Tips

1. Use pagination for large datasets
2. Use `_count` instead of loading all relations
3. Add indexes on frequently queried fields
4. Use `select` to limit returned fields
5. Implement caching for statistics
6. Use connection pooling in production

## Security Checklist

- [ ] Validate user permissions before operations
- [ ] Sanitize all user input
- [ ] Implement rate limiting
- [ ] Use HTTPS in production
- [ ] Validate BigInt conversions
- [ ] Implement authentication middleware
- [ ] Check workspace/agency access rights
- [ ] Validate file uploads

## Schema Validation

The task management schema is production-ready with:
- All foreign key relations properly defined
- Comprehensive indexing
- Proper cascade behaviors
- Audit trail system (TaskHistory)
- Flexible recurring tasks
- Multi-level hierarchy support
- Automatic timestamp management

## Next Steps

1. Implement authentication middleware
2. Add permission checking for each endpoint
3. Set up proper error handling
4. Implement request validation
5. Add API rate limiting
6. Set up monitoring and logging
7. Implement caching layer
8. Write integration tests

For detailed implementation of each endpoint with complete code examples, refer to **TASK_MANAGEMENT_API.md**.