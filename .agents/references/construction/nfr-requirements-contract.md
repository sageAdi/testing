# NFR Requirements Contract

NFR Requirements captures unit-level non-functional requirements and technology decisions.

## Inputs

- `aidlc-docs/construction/{unit-name}/functional-design/`
- Execution plan stage decision

## Plan And Questions

Create `aidlc-docs/construction/plans/{unit-name}-nfr-requirements-plan.md` with checkbox steps and `[Answer]:` questions covering scalability, performance, availability, security, reliability, maintainability, usability, and technology constraints.

Do not proceed while answers are missing, vague, contradictory, or ambiguous.

## Artifacts

Create under `aidlc-docs/construction/{unit-name}/nfr-requirements/`:

- `nfr-requirements.md`
- `tech-stack-decisions.md`

## Completion

Completion starts with `# NFR Requirements Complete - [unit-name]`, points to the nfr-requirements directory, and offers only `Request Changes` and `Continue to Next Stage`.
