# AI-DLC Orchestration Contract

This reference captures the shared workflow rules that must remain consistent across stage skills.

## Stage Order

Inception:

1. Workspace Detection: always; no approval gate.
2. Reverse Engineering: brownfield only when artifacts are missing, stale, or rerun is requested.
3. Requirements Analysis: always; adaptive depth.
4. User Stories: conditional.
5. Workflow Planning: always.
6. Application Design: conditional.
7. Units Generation: conditional.

Construction:

1. Functional Design: conditional per unit.
2. NFR Requirements: conditional per unit.
3. NFR Design: conditional per unit when NFR requirements ran.
4. Infrastructure Design: conditional per unit.
5. Code Generation: always per unit.
6. Build and Test: always after all units.

Operations is a placeholder until operations rules are expanded.

## Approval Gates

- Workspace Detection has no approval gate.
- Reverse Engineering, Requirements Analysis, Workflow Planning, Application Design, Units Generation, and Build and Test stop for explicit approval.
- User Stories stops for story-plan approval and generated-stories approval.
- Code Generation stops for generation-plan approval and generated-work approval.
- Construction design stages use exactly two completion choices: `Request Changes` or `Continue to Next Stage`.

## State And Audit

- `aidlc-docs/aidlc-state.md` records project type, current stage, stage progress, skipped stages, extension configuration, and resume point.
- `aidlc-docs/audit.md` is append-only and records full raw user input, approval prompts, responses, AI actions, workflow changes, and blocking findings.
- Use ISO 8601 UTC timestamps.
- Never place application code in `aidlc-docs/`.

## Extension Handling

During Requirements Analysis, present `extensions/**/*.opt-in.md` prompts without loading full extension rule files. Load full extension rules only for enabled extensions. Extensions with no opt-in file are enforced by default.

Enabled extension findings are blocking until resolved or explicitly accepted by the user with audit logging.

Jira Ticket Workflow is auto-enabled when Jira ticket context is provided or requested. When enabled, Jira intake, breakdown classification, implementation-plan approval, task completion logging, and final Jira comment preparation are blocking workflow requirements.
