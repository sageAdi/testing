---
name: aidlc-orchestrator
description: Coordinate the AI-DLC hybrid workflow across inception and construction stages. Use when an AI-DLC workflow starts, resumes, changes stages, needs stage routing, or must enforce approval gates, audit logging, state tracking, and token-efficient skill loading.
---

# AI-DLC Orchestrator

Use this skill to route an AI-DLC workflow without loading every stage procedure.

## Required References

Read only what is needed:

- `../../references/common/orchestration-contract.md` for stage order, gates, state, audit, and resume rules.
- `../../references/common/workspace-detection-contract.md` only when routing from workspace detection.

## Procedure

1. Confirm AI-DLC activation from the user request or existing `aidlc-docs/aidlc-state.md`.
2. Read `aidlc-docs/aidlc-state.md` first when resuming.
3. Select the next stage from the orchestration contract.
4. Load the stage skill if present under `.agents/skills/`; otherwise use the `.aidlc-rule-details/` fallback listed in `AGENTS.md`.
5. Preserve approval gates exactly. Do not move to the next gated stage until the user explicitly approves.
6. Append every prompt, response, workflow change, and blocking finding to `aidlc-docs/audit.md`.
7. Run deterministic validators when their target files exist.

## Non-Negotiables

- Keep application code out of `aidlc-docs/`.
- Load the minimum current-stage context; do not load unrelated stage references.
- Treat enabled extension findings as blocking.
- Stop at approval gates so context can be compacted or reset.
