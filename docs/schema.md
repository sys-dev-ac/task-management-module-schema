# Task Management Schema Documentation

##  Workspace Table (Top Level Entity)
**Purpose**: Multi-tenant workspace container for all organizational data

- **id**: Unique identifier for the workspace (UUID)
- **name**: Name of the workspace (e.g., "Acme Corp", "Marketing Team")
- **description**: Detailed description of the workspace
- **color**: Color code for the workspace (hex color)
- **created_at**: Date and time when the workspace was created
- **updated_at**: Date and time when the workspace was last updated
- **created_by**: User ID of the person who created the workspace
- **updated_by**: User ID of the person who last updated the workspace

### Relations (All data belongs to a workspace)
- **members**: Array of WorkspaceMember records (users with roles)
- **categories**: Array of Category records
- **tasks**: Array of Task records
- **taskGroups**: Array of TaskGroup records
- **ideaBoards**: Array of IdeaBoard records
- **links**: Array of Link records
---

##  Workspace Member Table (Join Table)
**Purpose**: Manages user membership and roles within workspaces

- **workspace_id**: Reference to workspace table (foreign key)
- **user_id**: Reference to user table (foreign key)
- **role**: Role of the user in workspace (e.g., "owner", "admin", "member")
- **joined_at**: Date and time when the user joined the workspace

---

##  User Table
**Purpose**: User accounts that can belong to multiple workspaces

- **id**: Unique identifier for the user (UUID)
- **email**: Email address of the user (unique)
- **name**: Name of the user
- **password**: Hashed password of the user
- **phone**: Phone number (optional)
- **avatar**: Avatar URL (optional)
- **role**: Global role of the user (e.g., "admin", "user")
- **created_at**: Date and time when the user was created
- **updated_at**: Date and time when the user was last updated

### Relations
#### Direct Relations
- **workspaces**: WorkspaceMember records (workspaces user belongs to)
- **createdTasks**: Tasks created by the user
- **taskComments**: TaskComment records
- **taskHistory**: TaskHistory records
- **createdTaskGroups**: TaskGroups created by the user
- **createdIdeaBoards**: IdeaBoards created by the user
- **createdIdeas**: Ideas created by the user
- **ideaComments**: IdeaComment records

## Many-to-Many Relations (through join tables)
- **taskAssignments**: TaskAssignment records (tasks assigned to user)
- **taskLoops**: TaskLoop records (tasks user is in-loop on)
- **groupMemberships**: GroupMembership records (groups user belongs to)
- **boardAccess**: BoardAccess records (idea boards user can access)
- **reminderRecipients**: ReminderRecipient records (reminders for user)

---

##  Category Table
**Purpose**: Organize tasks, templates, and idea boards by category within a workspace

- **id**: Unique identifier for the category (UUID)
- **workspace_id**: Reference to workspace table (foreign key) 
- **name**: Name of the category (e.g."Marketing", "Development")
- **description**: Detailed description of the category (optional)
- **color**: Color code for the category (hex color, optional)
- **icon**: Icon name or emoji (optional)
- **created_at**: Date and time when the category was created
- **updated_at**: Date and time when the category was last updated

### Relations
- **workspace**: Parent workspace
- **tasks**: Tasks in this category
- **taskTemplates**: Task templates in this category
- **ideaBoards**: Idea boards in this category
- **links**: Links in this category

---

##  Task Table
**Purpose**: Individual tasks with assignments, status tracking, and collaboration features

- **id**: Unique identifier for the task (UUID)
- **workspace_id**: Reference to workspace table (foreign key) 
- **title**: Title of the task
- **description**: Detailed description of the task
- **status**: Status of the task (ENUM: "TODO", "IN_PROGRESS", "COMPLETED", "CANCELLED")
- **priority**: Priority of the task (ENUM: "LOW", "MEDIUM", "HIGH", "URGENT")
- **dueDate**: Date and time when the task is due (optional)
- **completedAt**: Date and time when the task was completed (optional)
- **category_id**: Reference to category table (foreign key, optional)
- **parent_task_id**: Reference to parent task for subtasks (foreign key, optional)
- **group_id**: Reference to task group table (foreign key, optional)
- **created_at**: Date and time when the task was created
- **updated_at**: Date and time when the task was last updated
- **created_by**: User ID of the person who created the task
- **updated_by**: User ID of the person who last updated the task (optional)

### Relations
- **workspace**: Parent workspace
- **category**: Category the task belongs to (optional)
- **creator**: User who created the task
- **parentTask**: Parent task (for subtasks)
- **subTasks**: Child tasks (subtasks)
- **group**: TaskGroup the task belongs to (optional)
- **repeat**: TaskRepeat configuration (one-to-one)
- **reminders**: TaskReminder records
- **checklist**: ChecklistItem records
- **comments**: TaskComment records
- **history**: TaskHistory records (audit trail)

#### Many-to-Many Relations
- **assignments**: TaskAssignment records (assigned users)
- **loops**: TaskLoop records (in-loop users)
- **attachments**: TaskAttachment records (files)

---

##  Task Repeat Table
**Purpose**: Configure recurring task schedules

- **id**: Unique identifier for the repeat record (UUID)
- **task_id**: Reference to task table (foreign key, unique, optional)
- **interval**: Interval for repeating (ENUM: "DAILY", "WEEKLY", "MONTHLY", "YEARLY")
- **startDate**: Start date for repeating the task
- **endDate**: End date for repeating the task (optional)
- **dayOfMonth**: Day of month for monthly repeats (1-31, optional)
- **skipWeekends**: Whether to skip weekends (boolean)
- **occurrenceCount**: Limit number of repetitions (optional)
- **created_at**: Date and time when the repeat record was created
- **updated_at**: Date and time when the repeat record was last updated

### Relations
- **task**: Task this repeat belongs to (optional)
- **taskTemplates**: Task templates using this repeat
- **daysOfWeek**: RepeatDayOfWeek records (for weekly repeats)

---

##  Repeat Day of Week Table (Join Table)
**Purpose**: Specify which days of the week a task repeats

- **id**: Unique identifier (UUID)
- **repeat_id**: Reference to TaskRepeat table (foreign key)
- **dayOfWeek**: Day of week (0-6, where 0=Sunday, 6=Saturday)

### Relations
- **repeat**: Parent TaskRepeat

---

##  Task Reminder Table
**Purpose**: Configure reminders for tasks across multiple channels

- **id**: Unique identifier for the reminder (UUID)
- **task_id**: Reference to task table (foreign key)
- **channel**: Reminder channel (ENUM: "WHATSAPP", "EMAIL", "PUSH_NOTIFICATION", "SMS")
- **triggerType**: When to trigger (ENUM: "BEFORE", "AFTER")
- **triggerAt**: Date and time when the reminder should be sent
- **status**: Status of reminder (ENUM: "PENDING", "SENT", "FAILED")
- **reminderMessage**: Custom message for the reminder (optional)
- **retryCount**: Number of retries for failed reminders (default: 0)
- **sentAt**: Date and time when reminder was actually sent (optional)
- **created_at**: Date and time when the reminder was created
- **updated_at**: Date and time when the reminder was last updated

### Relations
- **task**: Task this reminder belongs to
- **recipients**: ReminderRecipient records (users to notify)

---

##  Reminder Recipient Table (Join Table)
**Purpose**: Specify which users receive a reminder

- **reminder_id**: Reference to TaskReminder table (foreign key)
- **user_id**: Reference to User table (foreign key)

### Relations
- **reminder**: Parent TaskReminder
- **user**: User receiving the reminder

---

##  Task Attachment Table
**Purpose**: Store file attachments for tasks

- **id**: Unique identifier (UUID)
- **task_id**: Reference to task table (foreign key)
- **fileUrl**: URL or path to the file
- **fileName**: Original name of the file
- **fileSize**: Size of file in bytes (optional)
- **mimeType**: MIME type of the file (optional)
- **created_at**: Date and time when attachment was added

### Relations
- **task**: Task this attachment belongs to

---

##  Task Assignment Table (Join Table)
**Purpose**: Assign tasks to users

- **task_id**: Reference to task table (foreign key)
- **user_id**: Reference to user table (foreign key)

### Relations
- **task**: Task being assigned
- **user**: User assigned to the task

---

## Task Loop Table (Join Table)
**Purpose**: Keep users in the loop (CC'd) on task updates

- **task_id**: Reference to task table (foreign key)
- **user_id**: Reference to user table (foreign key)

### Relations
- **task**: Task being tracked
- **user**: User in the loop

---

## Checklist Item Table
**Purpose**: Sub-items within a task that can be checked off

- **id**: Unique identifier (UUID)
- **task_id**: Reference to task table (foreign key)
- **title**: Title of the checklist item
- **isCompleted**: Whether the item is completed (boolean, default: false)
- **order**: Display order of the item (integer, default: 0)
- **created_at**: Date and time when created
- **updated_at**: Date and time when last updated

### Relations
- **task**: Parent task

---

## Task Comment Table
**Purpose**: Discussion and collaboration on tasks

- **id**: Unique identifier (UUID)
- **task_id**: Reference to task table (foreign key)
- **user_id**: Reference to user table (foreign key)
- **content**: Content of the comment (text)
- **created_at**: Date and time when created
- **updated_at**: Date and time when last updated

### Relations
- **task**: Task being commented on
- **user**: User who made the comment

---

## Task History Table
**Purpose**: Audit trail of all task changes

- **id**: Unique identifier (UUID)
- **task_id**: Reference to task table (foreign key)
- **user_id**: Reference to user table (foreign key)
- **action**: Action performed (e.g., "created", "updated", "status_changed", "assigned", "checklist_update")
- **field**: Which field changed (optional)
- **oldValue**: Previous value (optional, text)
- **newValue**: New value (optional, text)
- **created_at**: Date and time of the change

### Relations
- **task**: Task being tracked
- **user**: User who made the change

---

## Task Template Table
**Purpose**: Reusable task templates for common workflows

- **id**: Unique identifier (UUID)
- **title**: Title of the template
- **description**: Description of the template (optional)
- **status**: Default status (ENUM: "TODO", "IN_PROGRESS", "COMPLETED", "CANCELLED")
- **priority**: Default priority (ENUM: "LOW", "MEDIUM", "HIGH", "URGENT")
- **category_id**: Reference to category table (foreign key, optional)
- **repeat_id**: Reference to TaskRepeat table (foreign key, optional)
- **created_at**: Date and time when created
- **updated_at**: Date and time when last updated
- **created_by**: User ID who created the template
- **updated_by**: User ID who last updated the template

### Relations
- **category**: Category for tasks created from this template
- **repeat**: Repeat configuration for tasks created from this template
- **checklistItems**: TemplateChecklistItem records
- **attachments**: TemplateAttachment records

---

##  Template Checklist Item Table
**Purpose**: Default checklist items for task templates

- **id**: Unique identifier (UUID)
- **template_id**: Reference to TaskTemplate table (foreign key)
- **title**: Title of the checklist item
- **order**: Display order (integer, default: 0)

### Relations
- **template**: Parent task template

---

##  Template Attachment Table
**Purpose**: Default attachments for task templates

- **id**: Unique identifier (UUID)
- **template_id**: Reference to TaskTemplate table (foreign key)
- **fileUrl**: URL or path to the file
- **fileName**: Original name of the file

### Relations
- **template**: Parent task template

---

##  Task Group Table
**Purpose**: Group related tasks together for team collaboration

- **id**: Unique identifier (UUID)
- **workspace_id**: Reference to workspace table (foreign key) 
- **title**: Title of the task group
- **description**: Description of the task group (optional)
- **status**: Status (ENUM: "ACTIVE", "INACTIVE", "ARCHIVED")
- **type**: Type (ENUM: "PRIVATE", "PUBLIC")
- **groupImage**: Image URL for the group (optional)
- **color**: Color code for visual identification (optional)
- **icon**: Icon name or emoji (optional)
- **created_at**: Date and time when created
- **updated_at**: Date and time when last updated
- **created_by**: User ID who created the group
- **updated_by**: User ID who last updated the group (optional)

### Relations
- **workspace**: Parent workspace
- **creator**: User who created the group
- **tasks**: Tasks in this group
- **members**: GroupMembership records

---

##  Group Membership Table (Join Table)
**Purpose**: Manage members of task groups

- **group_id**: Reference to TaskGroup table (foreign key)
- **user_id**: Reference to User table (foreign key)

### Relations
- **group**: Task group
- **user**: User who is a member

---

## Idea Board Table
**Purpose**: Organize and manage ideas within a workspace

- **id**: Unique identifier (UUID)
- **workspace_id**: Reference to workspace table (foreign key) 
- **title**: Title of the idea board
- **description**: Description of the board (optional)
- **coverImage**: Cover image URL (optional)
- **status**: Status (e.g., "active", "inactive")
- **isPublic**: Whether the board is public (boolean, default: false)
- **category_id**: Reference to category table (foreign key, optional)
- **created_at**: Date and time when created
- **updated_at**: Date and time when last updated
- **created_by**: User ID who created the board
- **updated_by**: User ID who last updated the board (optional)

### Relations
- **workspace**: Parent workspace
- **category**: Category for organization
- **creator**: User who created the board
- **ideas**: Idea records
- **accessMembers**: BoardAccess records (users with access)
- **tags**: BoardTag records

---

## Board Access Table (Join Table)
**Purpose**: Control which users can access idea boards

- **board_id**: Reference to IdeaBoard table (foreign key)
- **user_id**: Reference to User table (foreign key)

### Relations
- **board**: Idea board
- **user**: User with access

---

##  Board Tag Table
**Purpose**: Tag idea boards for categorization

- **id**: Unique identifier (UUID)
- **board_id**: Reference to IdeaBoard table (foreign key)
- **tag**: Tag name (string)

### Relations
- **board**: Parent idea board

---

##  Idea Table
**Purpose**: Individual ideas within idea boards

- **id**: Unique identifier (UUID)
- **title**: Title of the idea
- **description**: Description of the idea (optional)
- **board_id**: Reference to IdeaBoard table (foreign key)
- **status**: Status (ENUM: "DRAFT", "ACTIVE", "UNDER_REVIEW", "APPROVED", "IMPLEMENTED", "REJECTED", "ARCHIVED")
- **upvotes**: Number of upvotes (integer, default: 0)
- **created_at**: Date and time when created
- **updated_at**: Date and time when last updated
- **created_by**: User ID who created the idea
- **updated_by**: User ID who last updated the idea (optional)
- **assigned_to** : Assign this idea to the developer
- **proposals** : Proposed solutions array from the team members and the users 

### Relations
- **board**: Parent idea board
- **creator**: User who created the idea
- **comments**: IdeaComment records
- **attachments**: IdeaAttachment records
- **tags**: IdeaTag records

---

## Idea Attachment Table
**Purpose**: Store file attachments for ideas

- **id**: Unique identifier (UUID)
- **idea_id**: Reference to Idea table (foreign key)
- **fileUrl**: URL or path to the file
- **fileName**: Original name of the file
- **fileSize**: Size of file in bytes (optional)
- **mimeType**: MIME type of the file (optional)
- **created_at**: Date and time when attachment was added

### Relations
- **idea**: Parent idea

---

##  Idea Tag Table
**Purpose**: Tag ideas for organization

- **id**: Unique identifier (UUID)
- **idea_id**: Reference to Idea table (foreign key)
- **tag**: Tag name (string)

### Relations
- **idea**: Parent idea

---

##  Idea Comment Table
**Purpose**: Discussion and feedback on ideas

- **id**: Unique identifier (UUID)
- **idea_id**: Reference to Idea table (foreign key)
- **user_id**: Reference to User table (foreign key)
- **content**: Content of the comment (text)
- **parent_id**: Reference to parent comment for threaded discussions (foreign key, optional)
- **created_at**: Date and time when created
- **updated_at**: Date and time when last updated

### Relations
- **idea**: Idea being commented on
- **user**: User who made the comment
- **parent**: Parent comment (for threaded replies, optional)
- **replies**: Child comments (threaded replies)

---

---

##  Proposed solutions Table
**Purpose**: The user can propose  an the solution on this (only used in the internal workspace problems)

- **id**: Unique identifier (UUID)
- **idea_id**: Reference to Idea table (foreign key)
- **submitted_by**: Submitted By 
- **content**: Content of the comment (text)
- **created_at**: Date and time when created
- **updated_at**: Date and time when last updated

**Relations**
- Relaation with the idea record
---

## Link Table
**Purpose**: Store useful links organized by category within a workspace

- **id**: Unique identifier (UUID)
- **workspace_id**: Reference to workspace table (foreign key) 
- **title**: Title of the link
- **description**: Description of the link (optional)
- **url**: URL of the link
- **category_id**: Reference to category table (foreign key, optional)
- **created_at**: Date and time when created
- **updated_at**: Date and time when last updated
- **created_by**: User ID who created the link
- **updated_by**: User ID who last updated the link (optional)

### Relations
- **workspace**: Parent workspace
- **category**: Category for organization (optional)

---

##  Data Hierarchy Summary

```
Workspace (Top Level - Multi-tenant Container)
├── WorkspaceMembers (Users with roles: owner, admin, member)
├── Categories
│   ├── Tasks
│   ├── TaskTemplates
│   ├── IdeaBoards
│   └── Links
├── Tasks
│   ├── TaskRepeat (with RepeatDayOfWeek)
│   ├── TaskReminders (with ReminderRecipients)
│   ├── ChecklistItems
│   ├── TaskComments
│   ├── TaskHistory
│   ├── TaskAssignments (users)
│   ├── TaskLoops (users)
│   └── TaskAttachments
├── TaskGroups
│   ├── GroupMemberships (users)
│   └── Tasks
├── IdeaBoards
│   ├── BoardAccess (users)
│   ├── BoardTags
│   └── Ideas
│       ├── IdeaAttachments
│       ├── IdeaTags
│       └── IdeaComments (threaded)
└── Links
```

---

## 🔑 Key Design Patterns

### 1. Multi-Tenancy via Workspace
- All primary entities (Tasks, Categories, TaskGroups, IdeaBoards, Links) belong to a Workspace
- Ensures complete data isolation between organizations
- Users can belong to multiple workspaces with different roles

### 2. Join Tables for Many-to-Many Relationships
- **WorkspaceMember**: Users ↔ Workspaces (with roles)
- **TaskAssignment**: Tasks ↔ Users (assigned)
- **TaskLoop**: Tasks ↔ Users (in-loop)
- **GroupMembership**: TaskGroups ↔ Users
- **BoardAccess**: IdeaBoards ↔ Users
- **ReminderRecipient**: TaskReminders ↔ Users

### 3. Hierarchical Structures
- **Tasks**: Support parent-child relationships (subtasks)
- **Comments**: Support threaded discussions (parent-child)

### 4. Audit Trail
- **TaskHistory**: Complete audit log of all task changes
- **created_at/updated_at**: Timestamps on all entities
- **created_by/updated_by**: User tracking on all entities

### 5. Flexible Categorization
- **Categories**: Shared across Tasks, Templates, IdeaBoards, and Links
- **Tags**: Free-form tagging on IdeaBoards and Ideas

### 6. Template System
- **TaskTemplates**: Reusable task configurations
- **TemplateChecklistItems**: Default checklist items
- **TemplateAttachments**: Default attachments
- **TaskRepeat**: Shared between Tasks and Templates

---

##  Usage Examples

### Creating a Workspace with Members
```typescript
const workspace = await prisma.workspace.create({
  data: {
    name: "Acme Corporation",
    description: "Main workspace for all departments",
    color: "#4F46E5",
    createdBy: "user-id",
    members: {
      create: [
        { userId: "user1-id", role: "owner" },
        { userId: "user2-id", role: "admin" },
        { userId: "user3-id", role: "member" }
      ]
    }
  }
});
```

### Creating a Task with Full Features
```typescript
const task = await prisma.task.create({
  data: {
    workspaceId: "workspace-id",
    title: "Complete Q4 Report",
    description: "Quarterly financial analysis",
    status: "IN_PROGRESS",
    priority: "HIGH",
    dueDate: new Date("2024-12-31"),
    categoryId: "category-id",
    groupId: "group-id",
    createdBy: "user-id",
    assignments: {
      create: [
        { userId: "user1-id" },
        { userId: "user2-id" }
      ]
    },
    loops: {
      create: [{ userId: "manager-id" }]
    },
    checklist: {
      create: [
        { title: "Gather data", order: 1 },
        { title: "Analyze trends", order: 2 },
        { title: "Write summary", order: 3 }
      ]
    },
    reminders: {
      create: [
        {
          channel: "EMAIL",
          triggerType: "BEFORE",
          triggerAt: new Date("2024-12-30"),
          recipients: {
            create: [{ userId: "user1-id" }]
          }
        }
      ]
    }
  }
});
```
