# Functional Design Contract

Functional Design creates detailed, technology-agnostic business logic design for one unit.

## Inputs

- Unit definition and story map from inception/application-design artifacts.
- Relevant application design artifacts when present.
- Execution plan stage decision.

## Plan

Create `aidlc-docs/construction/plans/{unit-name}-functional-design-plan.md` with checkbox steps and `[Answer]:` questions for business logic, domain model, business rules, data flow, integration points, error handling, scenarios, and frontend components when applicable.

Do not proceed while answers are missing, vague, contradictory, or ambiguous.

## Artifacts

Create under `aidlc-docs/construction/{unit-name}/functional-design/`:

- `business-logic-model.md`
- `business-rules.md`
- `domain-entities.md`
- `frontend-components.md` when UI is in scope

Include testable properties when PBT is enabled or when the unit contains business logic, transformations, algorithms, or stateful behavior.

## Completion

Completion starts with `# Functional Design Complete - [unit-name]`, points to the functional-design directory, and offers only `Request Changes` and `Continue to Next Stage`.
