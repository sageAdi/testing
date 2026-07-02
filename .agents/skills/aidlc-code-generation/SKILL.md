---
name: aidlc-code-generation
description: Execute the AI-DLC code generation stage for a unit of work. Use after required unit design stages are complete to create an approved step-by-step generation plan, then generate or modify application code, tests, documentation summaries, and deployment artifacts.
---

# AI-DLC Code Generation

Use this skill for each unit after required design stages are approved.

## Required Reference

Read `../../references/construction/code-generation-contract.md` before planning or generating code.

## Procedure

1. Part 1: create `aidlc-docs/construction/plans/{unit-name}-code-generation-plan.md` with numbered checkbox steps, exact paths, story traceability, and dependencies.
2. Stop for explicit approval of the complete code generation plan.
3. Before the first coding step, create or switch to a branch from `main` unless already on an approved work branch. Name the branch from the work type and scope, such as `feature/feedback-collector`, `bugfix/rating-validation`, `refactor/storage-layer`, `chore/update-docs`, or another explicit user-provided name. Stop if this cannot be done without overwriting uncommitted user work.
4. Part 2: execute exactly the next unchecked step from the approved plan.
5. Write application code only in the workspace root or normal project directories; write markdown summaries only under `aidlc-docs/`.
6. For brownfield projects, modify existing files in place and never create duplicate modified/new copies.
7. Mark plan checkboxes `[x]` immediately after each step is complete and update state.
8. Present completion with modified/created files and stop for explicit approval.

## Gate

Code Generation has two approval gates: plan approval and generated-work approval.
