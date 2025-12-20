Advanced Structure (With Projects):**

```
Seller
  ↓
Workspace
  ↓
TaskGroups (E-commerce, Mobile App, Marketing)
  ↓
Categories (Frontend, Backend)
  ↓
Tasks (organized by both project AND category)
```

**APIs:**
```javascript
// 1. Create workspace
POST /sellers/:sellerid/workspace

// 2. Create projects (task groups)
POST /workspaces/:workspaceid/task-groups
{ "title": "E-commerce Website", "type": "PROJECT" }

// 3. Create categories
POST /workspaces/:workspaceid/categories
{ "name": "Frontend Development" }

// 4. Create tasks with BOTH project and category
POST /workspaces/:workspaceid/tasks
{
  "title": "Build homepage",
  "group_id": "grp_111",     // E-commerce project
  "category_id": "cat_aaa"   // Frontend category
}
```

---

## ✅ **BONUS FEATURES Already in Your Schema:**

1. **✅ Sub-tasks** - `parent_task_id` (tasks can have child tasks)
2. **✅ Task Repeat** - `TaskRepeat` model (recurring tasks)
3. **✅ Checklists** - `ChecklistItem` (subtasks within a task)
4. **✅ Comments** - `TaskComment` (team discussions)
5. **✅ Attachments** - `TaskAttachment` (file uploads)
6. **✅ Reminders** - `TaskReminder` (notifications)
7. **✅ History** - `TaskHistory` (audit log)
8. **✅ Assignments** - `TaskAssignment` (assign to staff)
9. **✅ Task Loops** - `TaskLoop` (keep people in the loop)
10. **✅ Idea Boards** - `IdeaBoard` (brainstorming)
11. **✅ Links** - `WorkspaceLink` (save important URLs)
12. **✅ Task Templates** - `TaskTemplate` (reusable task templates)

---

## 🎯 **DECISION TIME:**

### **Option A: Simple (Category-only)**
```javascript
// Just use categories, ignore TaskGroup
const task = {
  workspace_id: "ws_123",
  category_id: "cat_frontend",
  group_id: null  // Don't use projects
}
```

### **Option B: Advanced (Projects + Categories)**
```javascript
// Use both projects and categories
const task = {
  workspace_id: "ws_123",
  group_id: "grp_ecommerce",      // Project
  category_id: "cat_frontend"      // Category
}
```

