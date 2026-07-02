---
name: aidlc-infrastructure-design
description: Execute the AI-DLC infrastructure design stage for a unit of work. Use when logical components must be mapped to cloud, deployment, networking, storage, messaging, monitoring, or shared infrastructure choices before code generation.
---

# AI-DLC Infrastructure Design

Use this skill per unit when Infrastructure Design is marked `EXECUTE`.

## Required Reference

Read `../../references/construction/infrastructure-design-contract.md` before creating plans or artifacts.

## Procedure

1. Load functional design and NFR design artifacts for the unit.
2. Create `aidlc-docs/construction/plans/{unit-name}-infrastructure-design-plan.md` with checkbox steps and `[Answer]:` questions.
3. Ask about deployment environment, compute, storage, messaging, networking, monitoring, and shared infrastructure.
4. Generate `infrastructure-design.md`, `deployment-architecture.md`, and `shared-infrastructure.md` when shared infrastructure applies.
5. Update state, append audit, and present the two-option completion gate to Code Generation.

## Gate

Use only `Request Changes` and `Continue to Next Stage`. Do not proceed until explicit approval.
