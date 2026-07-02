---
name: aidlc-grill-me
description: Force deeper AI-DLC requirement clarification for short, broad, feature-level, or underspecified prompts before final requirements are generated.
---

# AI-DLC Grill Me

Use this skill only inside AI-DLC Requirements Analysis. It strengthens the question gate before requirements are finalized.

## Trigger

Run this skill when the initial AI-DLC request is terse, broad, feature-level, or missing product decisions that would materially change implementation.

Examples:

- `Using AI-DLC, build a tiny single-page feedback collector.`
- `Using AI-DLC, create an admin dashboard.`
- `Using AI-DLC, add search.`

Do not run this skill merely because a request is small. If the prompt already states the target users, core behavior, persistence, constraints, edge cases, and acceptance criteria clearly enough for implementation, continue with normal Requirements Analysis.

## Procedure

1. Identify the decisions that are not yet known and would affect implementation.
2. Ask one focused round of 3 to 7 high-impact questions in `aidlc-docs/inception/requirements/requirement-verification-questions.md`.
3. Include extension opt-in questions from Requirements Analysis in the same artifact.
4. Stop until the user answers.
5. After answers arrive, check whether any answer conflicts with another answer or leaves a material decision unresolved.
6. Ask follow-up questions only for unresolved material decisions.
7. Stop grilling when remaining unknowns can be handled as low-risk defaults.

## Question Coverage

Cover the relevant areas for the request:

- target user and primary use case
- must-have behavior and explicit out-of-scope behavior
- data persistence, retention, sync, import, and export expectations
- UI expectations, accessibility, responsive behavior, and content tone
- validation rules, empty states, errors, and recovery behavior
- privacy, security, permissions, auditability, and sensitive data handling
- testing expectations and acceptance criteria

Prefer questions that force concrete decisions. Avoid asking for generic preferences that will not change implementation.

## Assumptions

Record assumptions only when they are low-risk implementation defaults. Do not turn hidden product decisions into assumptions.

Acceptable defaults:

- static files in the workspace root for a tiny dependency-free web app
- simple responsive layout when no brand or design system exists
- local-only browser storage when the prompt explicitly rules out a backend

Not acceptable as silent defaults:

- who the target user is when behavior differs by persona
- what data must be retained, deleted, exported, or synced
- whether authentication, authorization, or privacy controls are required
- what counts as a successful outcome for testing or acceptance

## Output

The requirements question artifact must make the grill-me decision visible with:

- the trigger reason
- the material unknowns being resolved
- the questions requiring user answers
- any low-risk assumptions being proposed
