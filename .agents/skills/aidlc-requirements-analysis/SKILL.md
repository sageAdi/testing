---
name: aidlc-requirements-analysis
description: Execute the AI-DLC requirements analysis stage with adaptive depth. Use after workspace detection, and after reverse engineering for brownfield workspaces, to analyze intent, ask clarifying questions, record extension opt-in choices, and produce requirements artifacts.
---

# AI-DLC Requirements Analysis

Use this skill for every AI-DLC workflow.

## Required Reference

Read `../../references/inception/requirements-analysis-contract.md` before creating question or requirements artifacts. It defines adaptive depth, extension opt-in handling, question gates, output artifacts, and approval behavior.

When the initial request is terse, broad, feature-level, or missing product decisions, also read `../aidlc-grill-me/SKILL.md` before writing the requirements question artifact.

## Procedure

1. Load only the reverse-engineering artifacts needed for brownfield context.
2. Analyze the raw user request for clarity, type, scope, and complexity.
3. Choose minimal, standard, or comprehensive depth.
4. Load `../aidlc-grill-me/SKILL.md` when the request is short, broad, feature-level, or missing material product decisions.
5. Scan extension opt-in files and include opt-in questions in the requirements question file.
6. Create `aidlc-docs/inception/requirements/requirement-verification-questions.md` unless requirements are exceptionally clear, complete, and do not trigger grill-me clarification.
7. Stop until answers are provided, then analyze answers for ambiguity and ask follow-ups when needed.
8. Generate `aidlc-docs/inception/requirements/requirements.md`.
9. Update `aidlc-docs/aidlc-state.md`, append to `aidlc-docs/audit.md`, present the completion message, and stop for approval.

## Gate

Do not generate final requirements until question answers are complete and validated. Do not proceed past requirements completion until the user approves.
