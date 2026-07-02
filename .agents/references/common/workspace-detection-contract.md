# Workspace Detection Contract

This reference is shared by the `aidlc-workspace-detection` skill and validators.

## Workspace Classification

Scan the workspace root, excluding:

- `aidlc-docs/`
- `.git/`
- dependency directories such as `node_modules/`, `vendor/`, `.venv/`, and `target/`
- generated output directories such as `dist/`, `build/`, `coverage/`, and `.cache/`

Treat a workspace as brownfield when it contains source files, package/build manifests, test structure, infrastructure definitions, or application configuration. Treat it as greenfield only when none of those indicators are present.

## State Artifact

New AI-DLC workflows must create `aidlc-docs/aidlc-state.md` with these sections:

```markdown
# AI-DLC State Tracking

## Project Information
## Workspace State
## Code Location Rules
## Stage Progress
```

The workspace state must record project type, existing code, reverse engineering need, and workspace root.

## Audit Artifact

AI-DLC workflows must create and append to `aidlc-docs/audit.md`. Each audit entry must preserve raw user input and use this shape:

```markdown
## [Stage Name or Interaction Type]
**Timestamp**: 2026-05-29T12:34:56Z
**User Input**: "[Complete raw user input]"
**AI Response**: "[AI response or action taken]"
**Context**: [Stage, action, or decision made]

---
```

Never overwrite the full audit log to append one entry.

## Stage Routing

- Greenfield workspaces route to Requirements Analysis.
- Brownfield workspaces route to Reverse Engineering unless current reverse engineering artifacts already exist or the user explicitly chooses to skip rerun.
- Workspace Detection itself has no approval gate.
