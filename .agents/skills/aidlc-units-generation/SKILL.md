---
name: aidlc-units-generation
description: Execute the AI-DLC units generation stage. Use when the system must be decomposed into units of work, services, modules, dependencies, and story mappings before per-unit construction design and code generation.
---

# AI-DLC Units Generation

Use this skill when Units Generation is marked `EXECUTE`.

## Required Reference

Read `../../references/inception/units-generation-contract.md` before creating unit plans or artifacts.

## Procedure

1. Create `aidlc-docs/inception/plans/unit-of-work-plan.md` with checkbox steps and `[Answer]:` questions.
2. Stop until answers are complete; resolve ambiguous answers with follow-ups.
3. Stop for explicit approval of the unit-of-work plan.
4. Generate unit artifacts exactly from the approved plan.
5. Mark completed plan steps `[x]`, update state, append audit, and stop for generated-units approval.

## Gates

Units Generation has two gates: unit plan approval and generated units approval.
