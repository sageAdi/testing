---
name: aidlc-build-and-test
description: Execute the AI-DLC build and test stage after code generation is complete for all units. Use to produce build instructions, unit/integration/performance/security/e2e test instructions, summarize results, update state, and request approval before Operations.
---

# AI-DLC Build And Test

Use this skill after all unit code generation is approved.

## Required Reference

Read `../../references/construction/build-and-test-contract.md` before creating build or test artifacts.

## Procedure

1. Analyze generated code, project build tools, unit tests, integration needs, performance needs, security needs, and e2e workflows.
2. Create build and test instruction artifacts under `aidlc-docs/construction/build-and-test/`.
3. Include security and property-based testing instructions when enabled or applicable.
4. Create `build-and-test-summary.md`.
5. Update `aidlc-docs/aidlc-state.md`, append `aidlc-docs/audit.md`, and present the approval gate before Operations.

## Gate

Do not proceed to Operations until the user explicitly approves Build and Test.
