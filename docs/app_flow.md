**THE COMPLETE HIERARCHY (5 LEVELS):**

```
┌─────────────────────────────────────────────────────────────────┐
│                    LEVEL 1: YOUR COMPANY                        │
│                  (The Platform Owner - You)                     │
│                                                                 │
│  - The original product/software                                │
│  - Master database                                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ sells to
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│            LEVEL 2: SUPER AGENCY (White Label Partners)         │
│         (Companies that buy your product to resell it)          │
│                                                                 │
│  Table: super_agencies                                          │
│  - manager_agency_id (their main agency)                        │
│  - wallet_balance (credits to create sub-agencies)              │
│  - Can rebrand under their own name                             │
│  - organization_domain: "partner-company.com"                   │
│  - white_label_domain: "their-brand.com"                        │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ creates/manages
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│              LEVEL 3: AGENCIES (End Customers)                  │
│        (Businesses that buy from Super Agency OR You)           │
│                                                                 │
│  Table: agencies                                                │
│  - super_agency_id (0 = direct customer, >0 = via super agency)│
│  - customer_id (which user owns this agency)                    │
│  - organization_domain, organization_sub_domain                 │
│  - marketplace_enabled, ai_suite_enabled (features)             │
│  - sub_account_credit_price, white_label_credit_price           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ has
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│               LEVEL 4: SELLERS (Shop Owners)                    │
│         (Businesses using the agency's marketplace)             │
│                                                                 │
│  Table: sellers                                                 │
│  - agency_id (which agency they belong to)                      │
│  - user_id (seller's account)                                   │
│  - shop_name, slug                                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ employees
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│            LEVEL 5: SELLER STAFFS (Employees)                   │
│           (Staff working for the shop owners)                   │
│                                                                 │
│  Table: seller_staffs                                           │
│  - seller_id (which shop they work for)                         │
│  - user_id (staff's account)                                    │
│  - agency_id (inherited from seller)                            │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🎯 **TWO BUSINESS MODELS IN YOUR SCHEMA:**

### **Model A: White Label (Reseller)**
Companies buy your product and sell it under **their brand name**:

```
YOU (Platform Owner)
  ↓ sells white-label license to
SUPER AGENCY (Reseller Company - "TechPartner Inc")
  ↓ sells to their customers as "TechPartner CRM"
AGENCY (End Customer - "Local Store Co")
  ↓ has
SELLERS (Shop Owners)
  ↓ has
STAFF (Employees)
```

**Example:**
- You: "YourSaaS Platform"
- Super Agency: "TechPartner Inc" (pays you $10K, gets white label rights)
- They rebrand as: "TechPartner CRM" (their domain: techpartner-crm.com)
- They sell to: 100+ agencies under their brand
- Each agency manages: Their own sellers & staff

---

### **Model B: Sub-Accounts (Direct Customers)**
Customers use your product under **your brand name**:

```
YOU (Platform Owner)
  ↓ sells directly to
AGENCY (Direct Customer - uses YOUR brand)
  ↓ creates sub-accounts for
SELLERS (Their clients/merchants)
  ↓ has
STAFF (Employees)
```

**Example:**
- You: "YourSaaS Platform"
- Agency: "Big Marketing Agency" (subscribes to your platform)
- They use: yourplatform.com/bigmarketing
- They manage: Their client stores as "sellers"
- Each seller has: Staff members

---

## 🔑 **KEY SCHEMA FIELDS EXPLAINED:**

### **agencies table:**

| Field | Purpose |
|-------|---------|
| `super_agency_id` | **0** = Direct customer, **>0** = Sold through a Super Agency |
| `customer_id` | Which user account owns this agency |
| `organization_domain` | Custom domain (white-label.com) |
| `organization_sub_domain` | Subdomain (acme.yourplatform.com) |
| `white_label_credit_price` | How much they charge for white-label access |
| `sub_account_credit_price` | How much they charge for sub-accounts |
| `marketplace_enabled` | Can they use the marketplace feature? |

### **super_agencies table:**

| Field | Purpose |
|-------|---------|
| `manager_agency_id` | The main agency managing this super agency |
| `wallet_balance` | Credits to create new agencies |

### **users table:**

| Field | Purpose |
|-------|---------|
| `agency_id` | Which agency this user belongs to |
| `is_super_agency` | Is this user a super agency admin? |
| `white_label_domain` | Custom domain for white-label users |
| `user_type` | Admin, Seller, Staff, etc. |

### **user_subaccounts table:**
Links main accounts to their sub-accounts (parent-child relationship)

### **user_settings table:**

| Field | Purpose |
|-------|---------|
| `all_sub_accounts_access` | Can access all sub-accounts? |
| `all_white_label_access` | Can manage white-label settings? |

---

## 🌊 **REAL-WORLD FLOW EXAMPLES:**

### **Example 1: White Label Flow**

```javascript
// 1. YOU create a Super Agency
POST /super-agencies
{
  "manager_agency_id": "1",  // Your main agency
  "wallet_balance": 10000
}
// Returns: super_agency_id = 5

// 2. Super Agency creates their first agency
POST /agencies
{
  "super_agency_id": "5",  // Link to super agency
  "organization_domain": "reseller-platform.com",
  "white_label_credit_price": 3000,
  "marketplace_enabled": true
}
// Returns: agency_id = 100

// 3. That agency's customer creates a seller
POST /agencies/100/sellers
{
  "user_id": "500",
  "shop_name": "Electronics Store"
}
// Returns: seller_id = 1000

// 4. Seller hires staff
POST /sellers/1000/staff
{
  "user_id": "501",
  "agency_id": "100"
}
```

**Revenue Flow:**
```
End User pays → $100/month
  ↓ (Agency keeps $70)
Super Agency gets → $30/month
  ↓ (Super Agency keeps $20)
YOU get → $10/month
```

---

### **Example 2: Sub-Account Flow**

```javascript
// 1. Agency buys direct from YOU
POST /agencies
{
  "super_agency_id": "0",  // Direct customer!
  "organization_sub_domain": "bigcorp",  // bigcorp.yourplatform.com
  "customer_id": "50"
}
// Returns: agency_id = 200

// 2. Agency creates sub-account sellers
POST /agencies/200/sellers
{
  "user_id": "600",
  "shop_name": "Client Store A"
}

// 3. Link as sub-account
POST /user-subaccounts
{
  "user_id": "50",  // Main agency owner
  "subaccount_id": "600"  // Sub-account
}
```

**Access Control:**
```
Main Account (user 50):
  - Can access ALL sellers
  - Can create more sub-accounts
  - Dashboard shows: "You have 25 sub-accounts"

Sub-Account (user 600):
  - Only sees their own store
  - Limited permissions
```

---

## 🎯 **QUERY PATTERNS FOR YOUR SYSTEM:**

### **Get all agencies under a Super Agency:**
```javascript
app.get("/super-agency/:id/agencies", async (req, res) => {
    const agencies = await prisma.agencies.findMany({
        where: { super_agency_id: BigInt(req.params.id) }
    });
    res.json(agencies);
});
```

### **Get all sellers across all agencies under a Super Agency:**
```javascript
app.get("/super-agency/:id/all-sellers", async (req, res) => {
    // Get all agencies under this super agency
    const agencies = await prisma.agencies.findMany({
        where: { super_agency_id: BigInt(req.params.id) },
        select: { id: true }
    });
    
    const agencyIds = agencies.map(a => a.id);
    
    // Get all sellers for those agencies
    const sellers = await prisma.sellers.findMany({
        where: { agency_id: { in: agencyIds } }
    });
    
    res.json(sellers);
});
```

### **Check if user has sub-account access:**
```javascript
app.get("/user/:id/accessible-accounts", async (req, res) => {
    const settings = await prisma.user_settings.findFirst({
        where: { user_id: BigInt(req.params.id) }
    });
    
    if (settings.all_sub_accounts_access) {
        // Return all sub-accounts
        const subaccounts = await prisma.user_subaccounts.findMany({
            where: { user_id: BigInt(req.params.id) },
            include: {
                users_user_subaccounts_subaccount_idTousers: {
                    select: { id: true, email: true, first_name: true }
                }
            }
        });
        return res.json(subaccounts);
    }
    
    res.json({ message: "No sub-account access" });
});
```

---

## 📊 **COMPLETE HIERARCHY VISUALIZATION:**

```
┌──────────────────────────────────────────────────────────────┐
│ YOU (Platform Owner)                                         │
│ - Owns the codebase                                          │
│ - Master database                                            │
└──────────────────────────────────────────────────────────────┘
        │
        ├─────────────────┬─────────────────┐
        ▼                 ▼                 ▼
   ┌──────────┐      ┌──────────┐    ┌──────────┐
   │ Super    │      │ Super    │    │ Direct   │
   │ Agency 1 │      │ Agency 2 │    │ Agency 1 │
   │ (Reseller│      │ (Reseller│    │(Your Brand)│
   └──────────┘      └──────────┘    └──────────┘
        │                 │                │
        │                 │                │
   ┌────┴────┐       ┌────┴────┐     ┌────┴────┐
   ▼         ▼       ▼         ▼     ▼         ▼
Agency A  Agency B Agency C Agency D Agency E Agency F
   │         │       │         │     │         │
   │         │       │         │     │         │
Sellers   Sellers Sellers   Sellers Sellers  Sellers
   │         │       │         │     │         │
 Staff     Staff   Staff     Staff  Staff    Staff
 
 
 Seller
   ↓ has ONE
 Workspace
   ↓ contains
   ├─ TaskGroups (Projects) ✅
   │   └─ Tasks belong to groups
   │
   ├─ TaskCategories (Categories) ✅
   │   └─ Tasks belong to categories
   │
   ├─ Tasks ✅
   │   ├─ Can belong to BOTH category AND group
   │   ├─ Can have sub-tasks (parent_task_id)
   │   ├─ Can repeat (TaskRepeat)
   │   ├─ Can have checklist (ChecklistItem)
   │   ├─ Can have comments (TaskComment)
   │   ├─ Can have attachments (TaskAttachment)
   │   ├─ Can have reminders (TaskReminder)
   │   └─ Has history tracking (TaskHistory)
   │
   ├─ IdeaBoards ✅
   │   └─ Ideas
   │
   └─ WorkspaceLinks ✅
