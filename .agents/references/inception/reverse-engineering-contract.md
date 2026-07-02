# Reverse Engineering Contract

Reverse Engineering runs for brownfield workspaces when current reverse-engineering artifacts are missing, stale, or explicitly requested for rerun.

## Scan Scope

Analyze the whole workspace, excluding generated and dependency folders. Cover:

- Packages and relationships
- Business context and business transactions
- Infrastructure definitions
- Build systems
- Service architecture and APIs
- Data stores and integration points
- Languages, frameworks, tests, CI/CD, and code quality indicators

## Required Artifacts

Create these files in `aidlc-docs/inception/reverse-engineering/`:

- `business-overview.md`
- `architecture.md`
- `code-structure.md`
- `api-documentation.md`
- `component-inventory.md`
- `technology-stack.md`
- `dependencies.md`
- `code-quality-assessment.md`
- `reverse-engineering-timestamp.md`

## Artifact Requirements

- `business-overview.md`: business description, business transactions, business dictionary, component-level business responsibilities.
- `architecture.md`: system overview, architecture diagram, component descriptions, data flow, integration points, infrastructure components.
- `code-structure.md`: build system, key classes/modules, existing file inventory, patterns, critical dependencies.
- `api-documentation.md`: REST/API endpoints, internal APIs, data models, validation.
- `component-inventory.md`: application, infrastructure, shared, and test packages with counts.
- `technology-stack.md`: languages, frameworks, infrastructure, build tools, testing tools.
- `dependencies.md`: internal dependency graph and external dependency summary.
- `code-quality-assessment.md`: test coverage signals, linting/style/docs, technical debt, patterns and anti-patterns.
- `reverse-engineering-timestamp.md`: ISO analysis timestamp, workspace, analyzed file count, generated artifact checklist.

## Completion

Update `aidlc-docs/aidlc-state.md` with Reverse Engineering completed and artifact location. Append audit entries before presenting the gate.

Completion message must start with `# Reverse Engineering Complete`, summarize key findings, point to `aidlc-docs/inception/reverse-engineering/`, and offer `Request Changes` or `Approve & Continue`.
