---
name: aidlc-workspace-detection
description: Run the AI-DLC workspace detection stage. Use when an AI-DLC workflow starts or resumes and the agent must determine whether the workspace is greenfield or brownfield, locate existing AI-DLC state, initialize state and audit artifacts, and choose the next AI-DLC stage.
---

# AI-DLC Workspace Detection

Use this skill as the first AI-DLC stage. It is a pilot for the hybrid AI-DLC architecture: keep this file procedural and concise, and load shared details only when needed.

## Required Reference

Read `../../references/common/workspace-detection-contract.md` before executing this stage. It defines the shared state, audit, workspace classification, and validation contract.

## Stage Procedure

1. Check for `aidlc-docs/aidlc-state.md`.
   - If it exists, treat the workflow as a resume and load only the state needed to identify the current stage and next action.
   - If it does not exist, continue with a new workspace assessment.
2. Scan the workspace root, excluding `aidlc-docs/`, `.git/`, dependency directories, generated build output, and temporary folders.
3. Classify the project.
   - Greenfield: no source, build, package, infrastructure, or test project indicators.
   - Brownfield: existing source code or project/build structure is present.
4. For brownfield workspaces, check `aidlc-docs/inception/reverse-engineering/`.
   - If reverse engineering artifacts exist and are current, proceed to Requirements Analysis.
   - If artifacts are missing, stale, or explicitly requested for rerun, proceed to Reverse Engineering.
5. Ensure `aidlc-docs/aidlc-state.md` and `aidlc-docs/audit.md` exist for new AI-DLC workflows.
6. Append audit entries; never rewrite or truncate `audit.md`.
7. Present the workspace detection summary.
   - No approval gate is required for this stage.
   - Automatically continue to the next AI-DLC stage selected by the classification result.
8. Run deterministic validators after writing artifacts:
   - `.agents/scripts/validate-artifact-tree.sh`
   - `.agents/scripts/validate-audit-format.sh`

## Output Contract

The completion message must include:

- Project type: `Greenfield` or `Brownfield`
- Workspace root
- Existing code: `Yes` or `No`
- Reverse engineering needed: `Yes` or `No`
- Next stage: `Requirements Analysis` or `Reverse Engineering`

Do not load unrelated stage skills during workspace detection.
