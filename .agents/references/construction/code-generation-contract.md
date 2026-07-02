# Code Generation Contract

Code Generation runs per unit in two parts: plan approval, then generation.

## Inputs

- Unit design artifacts
- Unit story map
- NFR and infrastructure artifacts when executed
- `aidlc-docs/aidlc-state.md` for workspace root and project type
- Brownfield reverse-engineering `code-structure.md` when available

## Planning Artifact

Create `aidlc-docs/construction/plans/{unit-name}-code-generation-plan.md` with:

- Explicit numbered steps and checkboxes
- Exact target paths, never under `aidlc-docs/` for application code
- Story traceability
- Unit dependencies and interfaces
- Tests, docs summaries, migrations, API, UI, and deployment artifacts as applicable

Stop for explicit approval before generation.

## Generation Rules

- Before executing the first coding step, create or switch to a feature branch from `main`.
- Name the branch from the work type and scope, not from the agent name.
- Use a lowercase slash-prefixed category such as `feature/`, `bugfix/`, `refactor/`, `chore/`, `docs/`, or another explicit user-provided prefix.
- Use a short kebab-case scope after the slash, such as `feature/feedback-collector` or `bugfix/rating-validation`.
- Do not start application code changes directly on `main`.
- Do not stash, reset, discard, or overwrite uncommitted user work to create the branch. If the worktree cannot safely branch from `main`, stop and ask for user direction.
- Execute exactly the next unchecked step.
- Mark completed plan steps `[x]` immediately.
- Application code goes in the workspace root or normal project directories.
- Documentation summaries go under `aidlc-docs/construction/{unit-name}/code/`.
- Brownfield: modify existing files in place; never create duplicate `modified`, `new`, or copy files.
- UI code must use stable automation-friendly selectors for interactive elements.

## Completion

Completion starts with `# Code Generation Complete - [unit-name]`, lists modified and created files, points to application code and documentation summary paths, and offers `Request Changes` or `Continue to Next Stage`.
