# Workflow Planning Contract

Workflow Planning always runs after Requirements Analysis and after User Stories when that stage executes.

## Context Loading

Load only decision-relevant prior artifacts:

- Brownfield reverse engineering: `architecture.md`, `component-inventory.md`, `technology-stack.md`, `dependencies.md`
- Requirements: `requirements.md` and answered `requirement-verification-questions.md`
- User Stories when executed: `stories.md` and `personas.md`

## Analysis

Assess:

- Brownfield transformation scope and related components
- User-facing, structural, data model, API, NFR, infrastructure, and operations impact
- Component relationships and dependency constraints
- Risk: low, medium, high, or critical
- Rollback and testing complexity
- Multi-module update sequence when applicable

## Stage Decisions

Decide execute or skip with rationale:

- User Stories if not already executed
- Application Design
- Units Generation
- Functional Design
- NFR Requirements
- NFR Design
- Infrastructure Design
- Code Generation: always execute
- Build and Test: always execute
- Operations: execute as a lightweight handoff for optional pull request creation and Vercel deployment prompts after Build and Test approval

## Required Artifact

Create `aidlc-docs/inception/plans/execution-plan.md` with:

- Detailed analysis summary
- Change impact assessment
- Component relationships for brownfield work
- Risk assessment
- Mermaid workflow visualization with EXECUTE/SKIP/COMPLETED/PLACEHOLDER status
- Phases to execute and skip, with rationale
- Branching and handoff notes: code generation must start from a work-type branch created from `main`, such as `feature/<scope>` or `bugfix/<scope>`; Operations asks about pull request creation and then Vercel deployment after Build and Test approval
- Package change sequence for brownfield work when applicable
- Estimated timeline
- Success criteria and quality gates

Validate Mermaid syntax before writing when tooling is available; otherwise review the diagram structure manually against Mermaid flowchart syntax.

## State And Completion

Update `aidlc-docs/aidlc-state.md` with execution plan summary, stage progress, current status, and next stage.

Completion message must start with `# Workflow Planning Complete`, summarize risk, impact, affected components, execute/skip recommendations, point to `aidlc-docs/inception/plans/execution-plan.md`, and offer `Request Changes`, optional `Add Skipped Stages`, and `Approve & Continue`.
