---
name: aidlc-application-design
description: Execute the AI-DLC application design stage. Use when workflow planning calls for high-level component identification, service layer design, component interfaces, responsibilities, dependencies, and communication patterns before unit decomposition or construction.
---

# AI-DLC Application Design

Use this skill when Application Design is marked `EXECUTE`.

## Required Reference

Read `../../references/inception/application-design-contract.md` before creating plans or artifacts.

## Procedure

1. Load requirements and user stories when available.
2. Create `aidlc-docs/inception/plans/application-design-plan.md` with checkbox steps and `[Answer]:` questions.
3. Stop until answers are complete and ambiguity-free.
4. Generate application design artifacts under `aidlc-docs/inception/application-design/`.
5. Append audit, update state, and present the approval gate.

## Gate

Do not proceed to Units Generation or Construction until the user explicitly approves Application Design.
