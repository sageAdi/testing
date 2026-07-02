---
name: aidlc-property-based-testing
description: Enforce the AI-DLC property-based testing extension. Use when PBT is enabled or partially enabled to identify testable properties during design, carry them into code generation, and verify generated tests cover required invariants.
---

# AI-DLC Property-Based Testing

Use this skill when the Property-Based Testing extension is enabled or partially enabled.

## Required Reference

Read `../../references/extensions/property-based-testing-contract.md` before reviewing design, code-generation, or test artifacts.

## Procedure

1. Check `aidlc-docs/aidlc-state.md` extension configuration and enforcement mode.
2. During Functional Design, require testable property identification where business logic, transformations, algorithms, or stateful behavior exist.
3. During Code Generation, require property-based tests for enabled applicable rules.
4. During Build and Test, require execution instructions for property-based tests when generated.
5. Mark each applicable rule `Compliant`, `Non-compliant`, or `N/A`.
6. Log blocking PBT findings in `aidlc-docs/audit.md`.

## Blocking Behavior

When blocking PBT findings exist, do not present `Continue to Next Stage`; present only `Request Changes` until resolved or explicitly accepted by the user with audit logging.
