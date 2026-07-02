---
name: aidlc-workflow-planning
description: Execute the AI-DLC workflow planning stage. Use after requirements, and after user stories when executed, to decide which remaining AI-DLC stages run or skip, produce the execution plan, initialize stage progress, and request approval.
---

# AI-DLC Workflow Planning

Use this skill after requirements are approved and user stories are either complete or intentionally skipped.

## Required Reference

Read `../../references/inception/workflow-planning-contract.md` before creating the execution plan. It defines context loading, phase decisions, impact/risk analysis, workflow visualization, state updates, and approval handling.

## Procedure

1. Load requirements and only the prior artifacts needed for decision-making.
2. For brownfield workspaces, load the relevant reverse-engineering artifacts and analyze cross-package impact.
3. Assess user-facing, structural, data, API, NFR, infrastructure, and operations impact.
4. Decide which remaining inception and construction stages execute or skip, with rationale.
5. Include the required branch-from-`main` note for Code Generation and the Operations handoff prompts for pull request creation and Vercel deployment.
6. Create `aidlc-docs/inception/plans/execution-plan.md` with workflow visualization and stage decisions.
7. Update `aidlc-docs/aidlc-state.md`.
8. Append to `aidlc-docs/audit.md`, present the plan summary, and stop for explicit approval.

## Gate

If the user asks to force include or skip stages, update the plan, log the workflow change, and repeat the approval gate.
