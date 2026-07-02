---
name: aidlc-user-stories
description: Execute the AI-DLC user stories stage. Use when requirements indicate user-facing value, multiple personas, business workflow complexity, customer-facing APIs, acceptance criteria needs, or stakeholder alignment work before workflow planning.
---

# AI-DLC User Stories

Use this skill when User Stories is marked `EXECUTE` or the user asks to add stories.

## Required Reference

Read `../../references/inception/user-stories-contract.md` before creating story plans or artifacts.

## Procedure

1. Assess whether stories add value and document the decision in `aidlc-docs/inception/plans/user-stories-assessment.md`.
2. Create `aidlc-docs/inception/plans/story-generation-plan.md` with checkbox steps, story approach options, and `[Answer]:` questions.
3. Stop until answers are complete; resolve ambiguous answers with follow-up questions.
4. Stop for explicit approval of the story generation plan.
5. Generate `stories.md` and `personas.md` exactly from the approved plan.
6. Mark completed plan steps `[x]`, update state, append audit, and stop for generated-story approval.

## Gates

User Stories has two gates: story-plan approval and generated-stories approval.
