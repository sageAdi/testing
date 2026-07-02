---
name: aidlc-security-check
description: Enforce the AI-DLC security baseline extension. Use when security baseline is enabled or default-enforced to review stage artifacts, generated code, infrastructure, tests, and completion messages for blocking security findings.
---

# AI-DLC Security Check

Use this skill whenever the Security Baseline extension is enabled, default-enforced, or explicitly requested.

## Required Reference

Read `../../references/extensions/security-baseline-contract.md` before reviewing artifacts.

## Procedure

1. Check `aidlc-docs/aidlc-state.md` extension configuration.
2. Evaluate only rules applicable to the current stage and artifacts.
3. Mark each applicable rule `Compliant`, `Non-compliant`, or `N/A` with rationale.
4. Treat non-compliance as blocking.
5. Add a Security Findings section to the stage completion message when findings exist.
6. Log blocking findings in `aidlc-docs/audit.md`.

## Blocking Behavior

When blocking security findings exist, do not present `Continue to Next Stage`; present only `Request Changes` until resolved or explicitly accepted by the user with audit logging.
