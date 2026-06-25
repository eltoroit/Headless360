# Salesforce Headless 360

**Dreamforce 2026 · Salesforce Headless 360 Hands-On Workshop**

> _Written by: Andres Perez (ELTOROit)._

---

## What you'll learn

In this workshop you understand Salesforce Headless 360 by working with the different components

- How to use Agentforce Vibes IDE to work with case data as the project manager
- How to automate processes with skills
- How to work with MCP servers, and how to expose Apex classes as MCP Servers
- How to properly use Agentforce Vibes for Vibe Coding
- How to call Agentforce from Agentforce Vibes

---

## What You'll Build

This workshop helps you undertand Salesforce Headless 360 by loking at the TODO app from three different personas:

- Product manager: Assigns cases to developer
- Developer: Maintains the app
- End User: Uses teh app and create cases

---

## The Narrative

Your support team has 61 open cases. Four customers from different accounts are asking for the same thing: **table sorting**.

The agent finds them, ranks them by business risk (SLA status, account tier, renewal dates), creates a master case, and tells you to fix it first.

You fix it in under 15 minutes using Vibes AI and two CLI commands.

Then you close the master case. Flow 2 cascades — all four child cases close automatically.

One agent invocation opened the loop. One closed it.

---

## Architecture

```
Salesforce Org
│
├── LWC Components
│   └── c-todo-app
│       └── c-todo-table ← Reads + writes TODO data
│           └── c-todo-form ← Edits the TDOO data
│
├── Agentforce Agent: ET_Case_ConsolidationAgent
│   ├── et_analyze_and_consolidate
│   │   ├── ET_GetOpenCases (Apex)          → fetch all open cases
│   │   ├── ET_Case_DuplicateAnalysis (PT)  → find duplicates, rank by risk
│   │   └── ET_CaseConsolidator (Apex)      → create master, link children
│   └── et_close_cases
│       └── closes master → Flow 2 cascades to children
│
├── Flow 1: ET_Case_AssignCategory
│   └── fires on every Case create → calls ET_Case_Categorization prompt template
│
└── Flow 2: ET_Case_CloseChildren
    └── fires when IsMaster__c case closes → bulk-closes all child cases
```

---

## Data Model

### `TODO__c` (Custom Object)

| Field    | API Name      | Type                                            |
| -------- | ------------- | ----------------------------------------------- |
| Title    | `Title__c`    | Text (80)                                       |
| Status   | `Status__c`   | Picklist: Not Started / In Progress / Completed |
| Priority | `Priority__c` | Picklist: High / Medium / Low                   |
| Due Date | `DueDate__c`  | Date                                            |
| Contact  | `Contact__c`  | Lookup (Contact)                                |

### Case Extensions

| Field              | API Name               | Type     | Purpose                                      |
| ------------------ | ---------------------- | -------- | -------------------------------------------- |
| Category           | `Category__c`          | Picklist | Auto-assigned by Flow 1                      |
| Is Duplicate       | `IsDuplicate__c`       | Checkbox | Set by agent on child cases                  |
| Is Master          | `IsMaster__c`          | Checkbox | Set by agent on consolidated master          |
| Customers Affected | `CustomersAffected__c` | Number   | Agent counts unique accounts across children |
| Risk Level         | `RiskLevel__c`         | Formula  | Mirrors `Account.RiskLevel__c` in real time  |

---

## Presenter

**Andres Perez** · [@ELTOROIT](https://github.com/eltoroit)

Dreamforce 2026
