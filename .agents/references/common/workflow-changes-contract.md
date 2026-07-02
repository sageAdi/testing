# Workflow Changes Contract

Use this contract for AI-DLC changes after a plan or stage is underway.

## Change Types

- Add a skipped stage
- Skip a planned stage
- Restart current or previous stage
- Change depth level
- Pause or resume workflow
- Change architectural decision
- Add, remove, merge, or split units

## Required Handling

1. Understand the request and affected stages.
2. Assess impact on artifacts, dependencies, approvals, state, and downstream work.
3. Explain consequences and alternatives.
4. Get explicit confirmation before destructive or cascading changes.
5. Archive existing artifacts before destructive rewrites.
6. Update execution plan, `aidlc-state.md`, affected plan checkboxes, and audit.
7. Revalidate affected artifacts before continuing.

## Audit Format

```markdown
## Change Request - [Stage Name]
**Timestamp**: [ISO timestamp]
**Request**: [Complete raw user request]
**Current State**: [Workflow position]
**Impact Assessment**: [Affected stages/artifacts]
**User Confirmation**: [Complete raw confirmation]
**Action Taken**: [What changed]
**Artifacts Affected**: [Files changed/reset]

---
```
