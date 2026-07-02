---
name: aidlc-reverse-engineering
description: Execute the AI-DLC reverse engineering stage for brownfield projects. Use when workspace detection finds existing code and current reverse-engineering artifacts are missing, stale, or explicitly requested for rerun.
---

# AI-DLC Reverse Engineering

Use this skill only for brownfield workspaces.

## Required Reference

Read `../../references/inception/reverse-engineering-contract.md` before generating artifacts. It defines artifact names, scan scope, completion message, state updates, and approval requirements.

## Procedure

1. Confirm the project is brownfield and reverse engineering is needed.
2. Scan all packages and important project structure, not only files mentioned by the user.
3. Identify business context, architecture, APIs, component inventory, technology stack, dependencies, infrastructure, build systems, tests, and code quality signals.
4. Generate the required reverse-engineering artifacts under `aidlc-docs/inception/reverse-engineering/`.
5. Validate Mermaid or structured visual content before writing when diagrams are included.
6. Update `aidlc-docs/aidlc-state.md` and append to `aidlc-docs/audit.md`.
7. Present the reverse engineering completion message and stop for explicit approval.

## Gate

Do not proceed to Requirements Analysis until the user approves the reverse engineering artifacts.
