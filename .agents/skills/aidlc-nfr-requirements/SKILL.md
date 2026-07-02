---
name: aidlc-nfr-requirements
description: Execute the AI-DLC NFR requirements stage for a unit of work. Use when performance, scalability, availability, reliability, security, usability, maintainability, or technology-stack decisions must be captured before NFR design or code generation.
---

# AI-DLC NFR Requirements

Use this skill per unit when NFR Requirements is marked `EXECUTE`.

## Required Reference

Read `../../references/construction/nfr-requirements-contract.md` before creating plans or artifacts.

## Procedure

1. Load the unit functional design artifacts.
2. Create `aidlc-docs/construction/plans/{unit-name}-nfr-requirements-plan.md` with checkbox steps and `[Answer]:` questions.
3. Ask about scalability, performance, availability, security, reliability, maintainability, usability, and tech stack constraints.
4. Stop until answers are complete and unambiguous.
5. Generate `nfr-requirements.md` and `tech-stack-decisions.md`.
6. Update state, append audit, and present the two-option completion gate.

## Gate

Use only `Request Changes` and `Continue to Next Stage`. Do not proceed until explicit approval.
