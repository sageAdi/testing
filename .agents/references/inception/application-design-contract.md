# Application Design Contract

Application Design identifies high-level components, services, interfaces, dependencies, and communication patterns.

## Inputs

- `aidlc-docs/inception/requirements/requirements.md`
- `aidlc-docs/inception/user-stories/stories.md` when present
- Execution plan stage decision

## Plan And Questions

Create `aidlc-docs/inception/plans/application-design-plan.md` with checkbox steps and `[Answer]:` questions covering component boundaries, methods, service orchestration, dependencies, and design patterns.

Resolve ambiguity before artifact generation.

## Artifacts

Create under `aidlc-docs/inception/application-design/`:

- `components.md`
- `component-methods.md`
- `services.md`
- `component-dependency.md`
- `application-design.md`

Detailed business rules belong in Functional Design, not Application Design.

## Completion

Update state and audit. Completion starts with `# Application Design Complete`, points to the application-design directory, and offers `Request Changes`, optional `Add Units Generation`, and `Approve & Continue`.
