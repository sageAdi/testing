# Infrastructure Design Contract

Infrastructure Design maps functional and NFR design choices to deployable infrastructure.

## Inputs

- `aidlc-docs/construction/{unit-name}/functional-design/`
- `aidlc-docs/construction/{unit-name}/nfr-design/` when present
- Execution plan stage decision

## Plan And Questions

Create `aidlc-docs/construction/plans/{unit-name}-infrastructure-design-plan.md` with checkbox steps and `[Answer]:` questions covering deployment environment, compute, storage, messaging, networking, monitoring, and shared infrastructure.

Resolve ambiguity before generating artifacts.

## Artifacts

Create under `aidlc-docs/construction/{unit-name}/infrastructure-design/`:

- `infrastructure-design.md`
- `deployment-architecture.md`

Create `aidlc-docs/construction/shared-infrastructure.md` when infrastructure is shared across units.

## Completion

Completion starts with `# Infrastructure Design Complete - [unit-name]`, points to the infrastructure-design directory, and offers only `Request Changes` and `Continue to Next Stage`.
