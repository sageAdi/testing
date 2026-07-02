---
name: aidlc-nfr-design
description: Execute the AI-DLC NFR design stage for a unit of work. Use after NFR requirements are approved to translate resilience, scalability, performance, security, and reliability requirements into logical design patterns and components.
---

# AI-DLC NFR Design

Use this skill per unit when NFR Design is marked `EXECUTE`.

## Required Reference

Read `../../references/construction/nfr-design-contract.md` before creating plans or artifacts.

## Procedure

1. Load `aidlc-docs/construction/{unit-name}/nfr-requirements/`.
2. Create `aidlc-docs/construction/plans/{unit-name}-nfr-design-plan.md` with checkbox steps and `[Answer]:` questions.
3. Resolve ambiguity about resilience, scalability, performance, security, and logical component choices.
4. Generate `nfr-design-patterns.md` and `logical-components.md`.
5. Update state, append audit, and present the two-option completion gate.

## Gate

Use only `Request Changes` and `Continue to Next Stage`. Do not proceed until explicit approval.
