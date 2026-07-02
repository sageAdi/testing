# NFR Design Contract

NFR Design translates approved NFR requirements into patterns and logical components.

## Inputs

- `aidlc-docs/construction/{unit-name}/nfr-requirements/`
- Execution plan stage decision

## Plan And Questions

Create `aidlc-docs/construction/plans/{unit-name}-nfr-design-plan.md` with checkbox steps and `[Answer]:` questions covering resilience, scalability, performance, security, and logical components.

Resolve ambiguity before generating artifacts.

## Artifacts

Create under `aidlc-docs/construction/{unit-name}/nfr-design/`:

- `nfr-design-patterns.md`
- `logical-components.md`

## Completion

Completion starts with `# NFR Design Complete - [unit-name]`, points to the nfr-design directory, and offers only `Request Changes` and `Continue to Next Stage`.
