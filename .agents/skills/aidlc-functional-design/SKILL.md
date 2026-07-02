---
name: aidlc-functional-design
description: Execute the AI-DLC functional design stage for a unit of work. Use when the execution plan calls for detailed business logic, domain entities, validation rules, frontend component behavior, or technology-agnostic functional design before code generation.
---

# AI-DLC Functional Design

Use this skill per unit when Functional Design is marked `EXECUTE`.

## Required Reference

Read `../../references/construction/functional-design-contract.md` before creating plans or artifacts.

## Procedure

1. Load the unit definition, assigned stories, and relevant application design artifacts.
2. Create `aidlc-docs/construction/plans/{unit-name}-functional-design-plan.md` with checkbox steps and `[Answer]:` questions for unresolved design decisions.
3. Stop until answers are complete; ask follow-ups for ambiguous responses.
4. Generate functional design artifacts under `aidlc-docs/construction/{unit-name}/functional-design/`.
5. Include testable properties when property-based testing is enabled or business logic has identifiable invariants.
6. Update `aidlc-docs/aidlc-state.md`, append `aidlc-docs/audit.md`, and present the two-option completion gate.

## Gate

Use only `Request Changes` and `Continue to Next Stage`. Do not proceed until the user explicitly approves.
