# AI-DLC Generated Rules Fallback

Generated from the hybrid skill source for rule-only agents.

**Source of truth**: `AGENTS.md`, `.agents/skills/**/SKILL.md`, and `.agents/references/**/*.md`.

**Compatibility fallback**: Keep `.aidlc-rule-details/**` available until parity is approved.

## Always-On Control Plane


This file is the lean always-on control layer for AI-DLC. Keep detailed stage procedures in on-demand skills or, until converted, in `.aidlc-rule-details/`.

## Activation

Activate AI-DLC when the user:

- Starts a request with or explicitly says `Using AI-DLC`
- Asks to run, resume, migrate, or inspect the AI-DLC workflow
- Continues a workspace that already has `aidlc-docs/aidlc-state.md`

For ordinary software development requests without an AI-DLC trigger or active AI-DLC state, use the normal project workflow.

## Jira Workflow Routing

When the user provides a Jira title and Jira description, says `jira workflow`, or asks to implement a Jira ticket, load and enforce `.agents/skills/aidlc-jira-ticket-workflow/SKILL.md` before Requirements Analysis, Workflow Planning, Workflow Changes, or Code Generation. A Jira link may be included as optional context, but it is not required.

Jira-ticket-aware requests must not proceed to implementation until Jira intake, ticket breakdown analysis, required subtickets, and implementation plan approval gates are complete.

The Jira Ticket Workflow extension is mandatory in these cases even when another AI-DLC stage skill is also active. Generic Workflow Changes may continue only after Jira intake and breakdown classification are complete.

## Source Loading Order

Load the minimum source needed for the current stage:

1. Prefer a project skill at `.agents/skills/<skill-name>/SKILL.md` when it exists.
2. Load only directly referenced files from `.agents/references/` when the skill asks for them.
3. If a stage skill does not exist in a copied or partial installation, use `.aidlc-rule-details/<stage-rule>.md` as legacy compatibility fallback.
4. For rule-only tools, use `.agents/generated-rules/AGENTS.md` as the generated compatibility fallback.
5. Do not edit generated fallback files by hand; regenerate them from `.agents/scripts/generate-rules-fallback.sh`.

Use `.aidlc-rule-details/` as the fallback rules root in this repository. If this project is copied into another tool layout, resolve fallback rules in this order:

- `.aidlc/aidlc-rules/aws-aidlc-rule-details/`
- `.aidlc-rule-details/`
- `.kiro/aws-aidlc-rule-details/`
- `.amazonq/aws-aidlc-rule-details/`

## Skill Invocation Map

- Orchestrator: `.agents/skills/aidlc-orchestrator/SKILL.md`
- Workspace Detection: `.agents/skills/aidlc-workspace-detection/SKILL.md`
- Reverse Engineering: `.agents/skills/aidlc-reverse-engineering/SKILL.md`
- Requirements Analysis: `.agents/skills/aidlc-requirements-analysis/SKILL.md`
- Grill Me Requirements Clarification: `.agents/skills/aidlc-grill-me/SKILL.md`
- User Stories: `.agents/skills/aidlc-user-stories/SKILL.md`
- Workflow Planning: `.agents/skills/aidlc-workflow-planning/SKILL.md`
- Application Design: `.agents/skills/aidlc-application-design/SKILL.md`
- Units Generation: `.agents/skills/aidlc-units-generation/SKILL.md`
- Functional Design: `.agents/skills/aidlc-functional-design/SKILL.md`
- NFR Requirements: `.agents/skills/aidlc-nfr-requirements/SKILL.md`
- NFR Design: `.agents/skills/aidlc-nfr-design/SKILL.md`
- Infrastructure Design: `.agents/skills/aidlc-infrastructure-design/SKILL.md`
- Code Generation: `.agents/skills/aidlc-code-generation/SKILL.md`
- Build and Test: `.agents/skills/aidlc-build-and-test/SKILL.md`
- Security Baseline: `.agents/skills/aidlc-security-check/SKILL.md`
- Property-Based Testing: `.agents/skills/aidlc-property-based-testing/SKILL.md`
- Jira Ticket Workflow: `.agents/skills/aidlc-jira-ticket-workflow/SKILL.md`
- Figma Nuxt UI Workflow: `.agents/skills/figma-nuxt-ui-workflow/SKILL.md`
- Workflow Changes: `.agents/skills/aidlc-workflow-changes/SKILL.md`
- Operations: `.agents/skills/aidlc-operations/SKILL.md`

`.aidlc-rule-details/` is retained as a legacy compatibility bundle, not the active source of truth.

## Stage Map

Inception determines what to build and why:

1. Workspace Detection: always execute; no approval gate.
2. Reverse Engineering: brownfield only when current reverse-engineering artifacts are missing or stale.
3. Requirements Analysis: always execute with adaptive depth.
4. User Stories: conditional for user-facing, workflow, business, or acceptance-criteria value.
5. Workflow Planning: always execute.
6. Application Design: conditional when components, services, dependencies, or method contracts need design.
7. Units Generation: conditional when decomposition into multiple units of work is useful.

Construction determines how to build it:

1. For each unit: Functional Design when business logic or domain design is needed.
2. For each unit: NFR Requirements when performance, security, scalability, reliability, or technology constraints matter.
3. For each unit: NFR Design when NFR requirements were captured.
4. For each unit: Infrastructure Design when cloud, deployment, networking, or resource mapping is needed.
5. For each unit: Code Generation always executes after required design stages.
6. Build and Test always executes after all units are complete.

Operations is a lightweight handoff stage after build and test approval. It asks whether to create a pull request, then asks whether to deploy to Vercel. Neither action runs without explicit approval.

## Approval Gates

Never proceed past an approval gate without explicit user confirmation.

- Workspace Detection has no approval gate and automatically routes to the next stage.
- Reverse Engineering, Requirements Analysis, Workflow Planning, Application Design, Units Generation, and Build and Test require explicit approval at stage completion.
- User Stories requires approval for the story plan and generated stories.
- Code Generation requires approval for the generation plan and for generated work completion.
- Code Generation must create or switch to a branch from `main` before coding begins. The branch name must be based on the work type and scope, such as `feature/feedback-collector`, `bugfix/rating-validation`, `refactor/storage-layer`, `chore/update-docs`, or another explicit user-provided name.
- Construction design stages must use the standardized two-option completion pattern from their stage rules: `Request Changes` or `Continue to Next Stage`.
- Operations requires explicit approval before creating a pull request, pushing a branch, or deploying to Vercel.
- If the user requests changes at a gate, update the artifact or plan, log the response, and repeat the same gate.

## State, Audit, And Resume

All AI-DLC artifacts live under `aidlc-docs/`. Application code must stay in the workspace root or normal project directories, never in `aidlc-docs/`.

Required tracking files:

- `aidlc-docs/aidlc-state.md`: current stage, project type, stage progress, skipped stages, extension configuration, and resume point.
- `aidlc-docs/audit.md`: append-only log of every user input, approval prompt, user response, AI response, workflow change, and blocking finding.

Audit entries must preserve the user's complete raw input exactly. Do not summarize or paraphrase user input. Append to `audit.md`; never rewrite or truncate the whole file to add an entry.

Use ISO 8601 UTC timestamps in audit entries: `YYYY-MM-DDTHH:MM:SSZ`.

On resume:

1. Read `aidlc-docs/aidlc-state.md` first.
2. Load only the current stage, next-stage artifacts, and directly required prior artifacts.
3. Avoid loading the full audit log unless needed to resolve a decision or dispute.

## Artifact Loading Policy

Use token economy by default:

- Load only the active stage skill or fallback rule.
- Load prior artifacts only when they affect the current decision.
- Load only active unit artifacts during construction.
- Prefer `minimal` depth for simple, clear, low-risk work.
- Use `standard` depth for normal feature work.
- Use `comprehensive` depth for high-risk, production, security, compliance, infrastructure, cross-service, or ambiguous work.
- Stop at approval gates so context can be compacted or reset before continuing.

## Extension And Security Policy

At requirements analysis, present available extension opt-in prompts from `extensions/**/*.opt-in.md` without loading full extension rule files. Load full extension rules only when enabled, except extension rule files without an opt-in file are enforced by default.

Before enforcing an extension, check `aidlc-docs/aidlc-state.md` under `## Extension Configuration`. Default to enforced if no configuration exists.

Security is not optional. Always preserve these invariants:

- Do not generate or recommend secrets in source code, docs, examples, tests, or logs.
- Treat authentication, authorization, input validation, encryption, auditability, logging, and least privilege as blocking concerns when applicable.
- Enabled security findings are blocking until resolved or explicitly accepted by the user with audit logging.
- Security checks must appear in design, code generation, and build/test artifacts when relevant.

## Validation

Run deterministic validators when their target artifacts exist:

- `.agents/scripts/validate-skill-manifests.sh .` after adding or changing project skills.
- `.agents/scripts/generate-rules-fallback.sh .` after changing `AGENTS.md`, skills, or references.
- `.agents/scripts/validate-generated-rules.sh .` after regenerating `.agents/generated-rules/AGENTS.md`.
- `.agents/scripts/validate-artifact-tree.sh .` after creating or changing `aidlc-docs/`.
- `.agents/scripts/validate-audit-format.sh .` after creating or appending `aidlc-docs/audit.md`.
- `.agents/scripts/validate-approval-gates.sh .` after changing `AGENTS.md` or approval text.
- `.agents/scripts/validate-jira-ticket-workflow.sh .` after creating, changing, or enforcing Jira ticket workflow artifacts.
- `.agents/scripts/validate-mermaid.sh <path>` after creating or changing Markdown files with Mermaid diagrams.
- `.agents/scripts/check-token-budget.sh .` after changing always-on instructions or skill bodies.

Before creating files with diagrams or structured content, validate content against fallback references when needed:

- `.aidlc-rule-details/common/content-validation.md`
- `.aidlc-rule-details/common/ascii-diagram-standards.md`
- `.aidlc-rule-details/common/question-format-guide.md`

## Workflow Changes

The user may add, skip, pause, resume, or rerun stages. For any workflow change:

1. Explain the impact on downstream stages.
2. Update `aidlc-docs/aidlc-state.md`.
3. Append the full request and decision to `aidlc-docs/audit.md`.
4. Revalidate affected artifacts before continuing.

## Skill Procedures

### aidlc-application-design

**Description**: Execute the AI-DLC application design stage. Use when workflow planning calls for high-level component identification, service layer design, component interfaces, responsibilities, dependencies, and communication patterns before unit decomposition or construction.


# AI-DLC Application Design

Use this skill when Application Design is marked `EXECUTE`.

## Required Reference

Read `../../references/inception/application-design-contract.md` before creating plans or artifacts.

## Procedure

1. Load requirements and user stories when available.
2. Create `aidlc-docs/inception/plans/application-design-plan.md` with checkbox steps and `[Answer]:` questions.
3. Stop until answers are complete and ambiguity-free.
4. Generate application design artifacts under `aidlc-docs/inception/application-design/`.
5. Append audit, update state, and present the approval gate.

## Gate

Do not proceed to Units Generation or Construction until the user explicitly approves Application Design.

### aidlc-build-and-test

**Description**: Execute the AI-DLC build and test stage after code generation is complete for all units. Use to produce build instructions, unit/integration/performance/security/e2e test instructions, summarize results, update state, and request approval before Operations.


# AI-DLC Build And Test

Use this skill after all unit code generation is approved.

## Required Reference

Read `../../references/construction/build-and-test-contract.md` before creating build or test artifacts.

## Procedure

1. Analyze generated code, project build tools, unit tests, integration needs, performance needs, security needs, and e2e workflows.
2. Create build and test instruction artifacts under `aidlc-docs/construction/build-and-test/`.
3. Include security and property-based testing instructions when enabled or applicable.
4. Create `build-and-test-summary.md`.
5. Update `aidlc-docs/aidlc-state.md`, append `aidlc-docs/audit.md`, and present the approval gate before Operations.

## Gate

Do not proceed to Operations until the user explicitly approves Build and Test.

### aidlc-code-generation

**Description**: Execute the AI-DLC code generation stage for a unit of work. Use after required unit design stages are complete to create an approved step-by-step generation plan, then generate or modify application code, tests, documentation summaries, and deployment artifacts.


# AI-DLC Code Generation

Use this skill for each unit after required design stages are approved.

## Required Reference

Read `../../references/construction/code-generation-contract.md` before planning or generating code.

## Procedure

1. Part 1: create `aidlc-docs/construction/plans/{unit-name}-code-generation-plan.md` with numbered checkbox steps, exact paths, story traceability, and dependencies.
2. Stop for explicit approval of the complete code generation plan.
3. Before the first coding step, create or switch to a branch from `main` unless already on an approved work branch. Name the branch from the work type and scope, such as `feature/feedback-collector`, `bugfix/rating-validation`, `refactor/storage-layer`, `chore/update-docs`, or another explicit user-provided name. Stop if this cannot be done without overwriting uncommitted user work.
4. Part 2: execute exactly the next unchecked step from the approved plan.
5. Write application code only in the workspace root or normal project directories; write markdown summaries only under `aidlc-docs/`.
6. For brownfield projects, modify existing files in place and never create duplicate modified/new copies.
7. Mark plan checkboxes `[x]` immediately after each step is complete and update state.
8. Present completion with modified/created files and stop for explicit approval.

## Gate

Code Generation has two approval gates: plan approval and generated-work approval.

### aidlc-functional-design

**Description**: Execute the AI-DLC functional design stage for a unit of work. Use when the execution plan calls for detailed business logic, domain entities, validation rules, frontend component behavior, or technology-agnostic functional design before code generation.


# AI-DLC Functional Design

Use this skill per unit when Functional Design is marked `EXECUTE`.

## Required Reference

Read `../../references/construction/functional-design-contract.md` before creating plans or artifacts.

## Procedure

1. Load the unit definition, assigned stories, and relevant application design artifacts.
2. Create `aidlc-docs/construction/plans/{unit-name}-functional-design-plan.md` with checkbox steps and `[Answer]:` questions for unresolved design decisions.
3. Stop until answers are complete; ask follow-ups for ambiguous responses.
4. Generate functional design artifacts under `aidlc-docs/construction/{unit-name}/functional-design/`.
5. Include testable properties when property-based testing is enabled or business logic has identifiable invariants.
6. Update `aidlc-docs/aidlc-state.md`, append `aidlc-docs/audit.md`, and present the two-option completion gate.

## Gate

Use only `Request Changes` and `Continue to Next Stage`. Do not proceed until the user explicitly approves.

### aidlc-grill-me

**Description**: Force deeper AI-DLC requirement clarification for short, broad, feature-level, or underspecified prompts before final requirements are generated.


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

### aidlc-infrastructure-design

**Description**: Execute the AI-DLC infrastructure design stage for a unit of work. Use when logical components must be mapped to cloud, deployment, networking, storage, messaging, monitoring, or shared infrastructure choices before code generation.


# AI-DLC Infrastructure Design

Use this skill per unit when Infrastructure Design is marked `EXECUTE`.

## Required Reference

Read `../../references/construction/infrastructure-design-contract.md` before creating plans or artifacts.

## Procedure

1. Load functional design and NFR design artifacts for the unit.
2. Create `aidlc-docs/construction/plans/{unit-name}-infrastructure-design-plan.md` with checkbox steps and `[Answer]:` questions.
3. Ask about deployment environment, compute, storage, messaging, networking, monitoring, and shared infrastructure.
4. Generate `infrastructure-design.md`, `deployment-architecture.md`, and `shared-infrastructure.md` when shared infrastructure applies.
5. Update state, append audit, and present the two-option completion gate to Code Generation.

## Gate

Use only `Request Changes` and `Continue to Next Stage`. Do not proceed until explicit approval.

### aidlc-jira-ticket-workflow

**Description**: Enforce the AI-DLC Jira ticket workflow extension. Use when the user asks for a Jira-ticket-aware workflow, provides Jira ticket details, asks to split work into Jira subtickets or tasks, or needs Jira-ready intake, breakdown, task completion logs, and final Jira comments.


# AI-DLC Jira Ticket Workflow

Use this skill when Jira workflow behavior is explicitly requested or automatically triggered by Jira ticket context.

## Required Reference

Read `../../references/extensions/jira-ticket-workflow-contract.md` before creating Jira intake, breakdown, subticket, completion log, or final comment artifacts.

## Activation

Enable this extension automatically when the user:

- Requests a Jira-ticket-aware workflow
- Provides a Jira ticket title and description
- Asks to split work into Jira subtickets or implementation tasks
- Asks for Jira-ready completion notes

If Jira may be useful but was not explicitly requested, include the opt-in question from the reference during Requirements Analysis.

## Procedure

1. Run Jira ticket intake before implementation planning.
2. Require Jira ticket title and description before proceeding beyond intake. Treat a Jira link as optional context only.
3. Classify the ticket as `Single-Go`, `Needs Breakdown`, or `Needs Clarification`.
4. If clarification is needed, write question-file artifacts and stop until answered.
5. If breakdown is needed, create canonical markdown subtickets and use them as AI-DLC units of work.
6. Before Code Generation, require an approved implementation plan for the single-go task or current subticket.
7. After each completed work item, append a task completion log.
8. After all work items are complete, prepare a Jira-ready final comment.

## Blocking Behavior

Do not proceed to implementation when required Jira intake fields are missing, breakdown analysis is incomplete, required subtickets are missing, or the implementation plan has not been approved.

### aidlc-nfr-design

**Description**: Execute the AI-DLC NFR design stage for a unit of work. Use after NFR requirements are approved to translate resilience, scalability, performance, security, and reliability requirements into logical design patterns and components.


# AI-DLC NFR Design

Use this skill per unit when NFR Design is marked `EXECUTE`.

## Required Reference

Read `../../references/construction/nfr-design-contract.md` before creating plans or artifacts.

## Procedure

1. Load `aidlc-docs/construction/{unit-name}/nfr-requirements/`.
2. Create `aidlc-docs/construction/plans/{unit-name}-nfr-design-plan.md` with checkbox steps and `[Answer]:` questions.
3. Resolve ambiguity about resilience, scalability, performance, security, and logical component choices.
4. Generate `nfr-design-patterns.md` and `logical-components.md`.
5. Update state, append audit, and present the two-option completion gate.

## Gate

Use only `Request Changes` and `Continue to Next Stage`. Do not proceed until explicit approval.

### aidlc-nfr-requirements

**Description**: Execute the AI-DLC NFR requirements stage for a unit of work. Use when performance, scalability, availability, reliability, security, usability, maintainability, or technology-stack decisions must be captured before NFR design or code generation.


# AI-DLC NFR Requirements

Use this skill per unit when NFR Requirements is marked `EXECUTE`.

## Required Reference

Read `../../references/construction/nfr-requirements-contract.md` before creating plans or artifacts.

## Procedure

1. Load the unit functional design artifacts.
2. Create `aidlc-docs/construction/plans/{unit-name}-nfr-requirements-plan.md` with checkbox steps and `[Answer]:` questions.
3. Ask about scalability, performance, availability, security, reliability, maintainability, usability, and tech stack constraints.
4. Stop until answers are complete and unambiguous.
5. Generate `nfr-requirements.md` and `tech-stack-decisions.md`.
6. Update state, append audit, and present the two-option completion gate.

## Gate

Use only `Request Changes` and `Continue to Next Stage`. Do not proceed until explicit approval.

### aidlc-operations

**Description**: Handle the AI-DLC Operations handoff after Build and Test approval, including optional pull request creation and Vercel deployment prompts.


# AI-DLC Operations

Operations is a lightweight handoff stage.

## Required Reference

Read `../../references/inception/operations-contract.md` when the workflow reaches Operations.

## Procedure

1. Confirm Build and Test is approved.
2. Summarize the completed build/test result and current branch.
3. Ask whether the user wants to create a pull request.
4. If the user explicitly approves pull request creation, prepare the commit, push the current feature branch, and create the pull request using the available GitHub workflow/tooling.
5. After the pull request step is complete or skipped, ask whether the user wants to deploy to Vercel.
6. If the user explicitly approves Vercel deployment, deploy the verified build using the available Vercel workflow/tooling and record the deployment URL.
7. Do not invent monitoring, incident response, maintenance, or production-readiness workflows.
8. Record final status in `aidlc-docs/aidlc-state.md` and append audit if an AI-DLC project is active.

### aidlc-orchestrator

**Description**: Coordinate the AI-DLC hybrid workflow across inception and construction stages. Use when an AI-DLC workflow starts, resumes, changes stages, needs stage routing, or must enforce approval gates, audit logging, state tracking, and token-efficient skill loading.


# AI-DLC Orchestrator

Use this skill to route an AI-DLC workflow without loading every stage procedure.

## Required References

Read only what is needed:

- `../../references/common/orchestration-contract.md` for stage order, gates, state, audit, and resume rules.
- `../../references/common/workspace-detection-contract.md` only when routing from workspace detection.

## Procedure

1. Confirm AI-DLC activation from the user request or existing `aidlc-docs/aidlc-state.md`.
2. Read `aidlc-docs/aidlc-state.md` first when resuming.
3. Select the next stage from the orchestration contract.
4. Load the stage skill if present under `.agents/skills/`; otherwise use the `.aidlc-rule-details/` fallback listed in `AGENTS.md`.
5. Preserve approval gates exactly. Do not move to the next gated stage until the user explicitly approves.
6. Append every prompt, response, workflow change, and blocking finding to `aidlc-docs/audit.md`.
7. Run deterministic validators when their target files exist.

## Non-Negotiables

- Keep application code out of `aidlc-docs/`.
- Load the minimum current-stage context; do not load unrelated stage references.
- Treat enabled extension findings as blocking.
- Stop at approval gates so context can be compacted or reset.

### aidlc-property-based-testing

**Description**: Enforce the AI-DLC property-based testing extension. Use when PBT is enabled or partially enabled to identify testable properties during design, carry them into code generation, and verify generated tests cover required invariants.


# AI-DLC Property-Based Testing

Use this skill when the Property-Based Testing extension is enabled or partially enabled.

## Required Reference

Read `../../references/extensions/property-based-testing-contract.md` before reviewing design, code-generation, or test artifacts.

## Procedure

1. Check `aidlc-docs/aidlc-state.md` extension configuration and enforcement mode.
2. During Functional Design, require testable property identification where business logic, transformations, algorithms, or stateful behavior exist.
3. During Code Generation, require property-based tests for enabled applicable rules.
4. During Build and Test, require execution instructions for property-based tests when generated.
5. Mark each applicable rule `Compliant`, `Non-compliant`, or `N/A`.
6. Log blocking PBT findings in `aidlc-docs/audit.md`.

## Blocking Behavior

When blocking PBT findings exist, do not present `Continue to Next Stage`; present only `Request Changes` until resolved or explicitly accepted by the user with audit logging.

### aidlc-requirements-analysis

**Description**: Execute the AI-DLC requirements analysis stage with adaptive depth. Use after workspace detection, and after reverse engineering for brownfield workspaces, to analyze intent, ask clarifying questions, record extension opt-in choices, and produce requirements artifacts.


# AI-DLC Requirements Analysis

Use this skill for every AI-DLC workflow.

## Required Reference

Read `../../references/inception/requirements-analysis-contract.md` before creating question or requirements artifacts. It defines adaptive depth, extension opt-in handling, question gates, output artifacts, and approval behavior.

When the initial request is terse, broad, feature-level, or missing product decisions, also read `../aidlc-grill-me/SKILL.md` before writing the requirements question artifact.

## Procedure

1. Load only the reverse-engineering artifacts needed for brownfield context.
2. Analyze the raw user request for clarity, type, scope, and complexity.
3. Choose minimal, standard, or comprehensive depth.
4. Load `../aidlc-grill-me/SKILL.md` when the request is short, broad, feature-level, or missing material product decisions.
5. Scan extension opt-in files and include opt-in questions in the requirements question file.
6. Create `aidlc-docs/inception/requirements/requirement-verification-questions.md` unless requirements are exceptionally clear, complete, and do not trigger grill-me clarification.
7. Stop until answers are provided, then analyze answers for ambiguity and ask follow-ups when needed.
8. Generate `aidlc-docs/inception/requirements/requirements.md`.
9. Update `aidlc-docs/aidlc-state.md`, append to `aidlc-docs/audit.md`, present the completion message, and stop for approval.

## Gate

Do not generate final requirements until question answers are complete and validated. Do not proceed past requirements completion until the user approves.

### aidlc-reverse-engineering

**Description**: Execute the AI-DLC reverse engineering stage for brownfield projects. Use when workspace detection finds existing code and current reverse-engineering artifacts are missing, stale, or explicitly requested for rerun.


# AI-DLC Reverse Engineering

Use this skill only for brownfield workspaces.

## Required Reference

Read `../../references/inception/reverse-engineering-contract.md` before generating artifacts. It defines artifact names, scan scope, completion message, state updates, and approval requirements.

## Procedure

1. Confirm the project is brownfield and reverse engineering is needed.
2. Scan all packages and important project structure, not only files mentioned by the user.
3. Identify business context, architecture, APIs, component inventory, technology stack, dependencies, infrastructure, build systems, tests, and code quality signals.
4. Generate the required reverse-engineering artifacts under `aidlc-docs/inception/reverse-engineering/`.
5. Validate Mermaid or structured visual content before writing when diagrams are included.
6. Update `aidlc-docs/aidlc-state.md` and append to `aidlc-docs/audit.md`.
7. Present the reverse engineering completion message and stop for explicit approval.

## Gate

Do not proceed to Requirements Analysis until the user approves the reverse engineering artifacts.

### aidlc-security-check

**Description**: Enforce the AI-DLC security baseline extension. Use when security baseline is enabled or default-enforced to review stage artifacts, generated code, infrastructure, tests, and completion messages for blocking security findings.


# AI-DLC Security Check

Use this skill whenever the Security Baseline extension is enabled, default-enforced, or explicitly requested.

## Required Reference

Read `../../references/extensions/security-baseline-contract.md` before reviewing artifacts.

## Procedure

1. Check `aidlc-docs/aidlc-state.md` extension configuration.
2. Evaluate only rules applicable to the current stage and artifacts.
3. Mark each applicable rule `Compliant`, `Non-compliant`, or `N/A` with rationale.
4. Treat non-compliance as blocking.
5. Add a Security Findings section to the stage completion message when findings exist.
6. Log blocking findings in `aidlc-docs/audit.md`.

## Blocking Behavior

When blocking security findings exist, do not present `Continue to Next Stage`; present only `Request Changes` until resolved or explicitly accepted by the user with audit logging.

### aidlc-units-generation

**Description**: Execute the AI-DLC units generation stage. Use when the system must be decomposed into units of work, services, modules, dependencies, and story mappings before per-unit construction design and code generation.


# AI-DLC Units Generation

Use this skill when Units Generation is marked `EXECUTE`.

## Required Reference

Read `../../references/inception/units-generation-contract.md` before creating unit plans or artifacts.

## Procedure

1. Create `aidlc-docs/inception/plans/unit-of-work-plan.md` with checkbox steps and `[Answer]:` questions.
2. Stop until answers are complete; resolve ambiguous answers with follow-ups.
3. Stop for explicit approval of the unit-of-work plan.
4. Generate unit artifacts exactly from the approved plan.
5. Mark completed plan steps `[x]`, update state, append audit, and stop for generated-units approval.

## Gates

Units Generation has two gates: unit plan approval and generated units approval.

### aidlc-user-stories

**Description**: Execute the AI-DLC user stories stage. Use when requirements indicate user-facing value, multiple personas, business workflow complexity, customer-facing APIs, acceptance criteria needs, or stakeholder alignment work before workflow planning.


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

### aidlc-workflow-changes

**Description**: Manage AI-DLC mid-workflow changes. Use when the user asks to add, skip, pause, resume, restart, rerun, change depth, change architecture, add or remove units, or otherwise alter the approved execution plan.


# AI-DLC Workflow Changes

Use this skill for any change to the approved AI-DLC flow.

## Jira Guard

If the workflow change request includes a Jira ticket link, Jira title, Jira description, says `jira workflow`, asks to implement a Jira ticket, or asks to split work into Jira subtickets/tasks, first load and enforce `../aidlc-jira-ticket-workflow/SKILL.md` and `../../references/extensions/jira-ticket-workflow-contract.md`.

Generic workflow-change handling may continue only after Jira intake and breakdown classification are complete. Do not proceed to implementation when required Jira intake fields, ticket breakdown analysis, required subtickets, or implementation plan approval are missing.

## Required Reference

Read `../../references/common/workflow-changes-contract.md` before changing state or artifacts.

## Procedure

1. Classify the change request and identify affected stages, artifacts, dependencies, and approvals.
2. Explain impact and offer safer alternatives when restart or destructive changes are requested.
3. Get explicit confirmation before destructive or cascading changes.
4. Archive affected artifacts before destructive rewrites.
5. Update execution plan, state, and affected plan checkboxes.
6. Append the full request, impact assessment, confirmation, and action to audit.
7. Revalidate affected artifacts before resuming normal execution.

### aidlc-workflow-planning

**Description**: Execute the AI-DLC workflow planning stage. Use after requirements, and after user stories when executed, to decide which remaining AI-DLC stages run or skip, produce the execution plan, initialize stage progress, and request approval.


# AI-DLC Workflow Planning

Use this skill after requirements are approved and user stories are either complete or intentionally skipped.

## Required Reference

Read `../../references/inception/workflow-planning-contract.md` before creating the execution plan. It defines context loading, phase decisions, impact/risk analysis, workflow visualization, state updates, and approval handling.

## Procedure

1. Load requirements and only the prior artifacts needed for decision-making.
2. For brownfield workspaces, load the relevant reverse-engineering artifacts and analyze cross-package impact.
3. Assess user-facing, structural, data, API, NFR, infrastructure, and operations impact.
4. Decide which remaining inception and construction stages execute or skip, with rationale.
5. Include the required branch-from-`main` note for Code Generation and the Operations handoff prompts for pull request creation and Vercel deployment.
6. Create `aidlc-docs/inception/plans/execution-plan.md` with workflow visualization and stage decisions.
7. Update `aidlc-docs/aidlc-state.md`.
8. Append to `aidlc-docs/audit.md`, present the plan summary, and stop for explicit approval.

## Gate

If the user asks to force include or skip stages, update the plan, log the workflow change, and repeat the approval gate.

### aidlc-workspace-detection

**Description**: Run the AI-DLC workspace detection stage. Use when an AI-DLC workflow starts or resumes and the agent must determine whether the workspace is greenfield or brownfield, locate existing AI-DLC state, initialize state and audit artifacts, and choose the next AI-DLC stage.


# AI-DLC Workspace Detection

Use this skill as the first AI-DLC stage. It is a pilot for the hybrid AI-DLC architecture: keep this file procedural and concise, and load shared details only when needed.

## Required Reference

Read `../../references/common/workspace-detection-contract.md` before executing this stage. It defines the shared state, audit, workspace classification, and validation contract.

## Stage Procedure

1. Check for `aidlc-docs/aidlc-state.md`.
   - If it exists, treat the workflow as a resume and load only the state needed to identify the current stage and next action.
   - If it does not exist, continue with a new workspace assessment.
2. Scan the workspace root, excluding `aidlc-docs/`, `.git/`, dependency directories, generated build output, and temporary folders.
3. Classify the project.
   - Greenfield: no source, build, package, infrastructure, or test project indicators.
   - Brownfield: existing source code or project/build structure is present.
4. For brownfield workspaces, check `aidlc-docs/inception/reverse-engineering/`.
   - If reverse engineering artifacts exist and are current, proceed to Requirements Analysis.
   - If artifacts are missing, stale, or explicitly requested for rerun, proceed to Reverse Engineering.
5. Ensure `aidlc-docs/aidlc-state.md` and `aidlc-docs/audit.md` exist for new AI-DLC workflows.
6. Append audit entries; never rewrite or truncate `audit.md`.
7. Present the workspace detection summary.
   - No approval gate is required for this stage.
   - Automatically continue to the next AI-DLC stage selected by the classification result.
8. Run deterministic validators after writing artifacts:
   - `.agents/scripts/validate-artifact-tree.sh`
   - `.agents/scripts/validate-audit-format.sh`

## Output Contract

The completion message must include:

- Project type: `Greenfield` or `Brownfield`
- Workspace root
- Existing code: `Yes` or `No`
- Reverse engineering needed: `Yes` or `No`
- Next stage: `Requirements Analysis` or `Reverse Engineering`

Do not load unrelated stage skills during workspace detection.

### figma-nuxt-ui-workflow

**Description**: Use when implementing, recreating, inspecting, or updating Nuxt/Vue UI from Figma links, screenshots, selected frames, design-system references, or Figma node IDs. Combines Figma screen discovery, Nuxt 4 implementation guidance, responsive design fidelity, optional ASU RDS CSS standardization, Code Connect/Figma MCP extraction, and package-scoped validation.


# Figma Nuxt UI Workflow

Turn Figma context into maintainable Nuxt/Vue UI code. Inspect enough of the design and local app to avoid building the wrong screen, then implement with Nuxt conventions, responsive fidelity, and RDS-aware CSS only when the target package supports it.

## Routing

- Use this skill for Nuxt/Vue UI work from Figma files, frame/node links, screenshots, selected design nodes, or design-system references.
- Use it as the front door when the exact screen is unclear, and as the implementation workflow once the frame and target Nuxt package/file are known.
- For Jira-ticket-aware implementation requests, enforce `.agents/skills/aidlc-jira-ticket-workflow/SKILL.md` first; use this skill for the Figma/UI portion only after Jira intake and planning gates allow implementation.
- If the user message starts with `Using AI-DLC,` or an active AI-DLC state exists, follow the AI-DLC control plane before implementation.

## Required Inputs
- Prefer a Figma selection URL with `node-id` and a target package, route, page, component, or Vue file.
- If the Figma URL lacks `node-id`, call Figma metadata to list pages and screen-like frames before asking the user to choose.
- If the target location is missing, inspect Nuxt packages, routes, pages, and nearby components. Infer the target only when one path is clearly plausible.

## Figma Inspection

1. Parse `fileKey` from `/design/:fileKey/...`.
2. Parse `nodeId` from `node-id=X-Y` and convert it to `X:Y`.
3. If no node ID is provided, call Figma metadata on the file, identify pages, then inspect relevant page metadata.
4. Identify screen-like frames:
   - Top-level page frames.
   - Frames with desktop, tablet, or mobile dimensions.
   - Frames named like Dashboard, Tasks, Budget, Reports, Home, Settings, Modal, Drawer, or flow steps.
5. If multiple plausible screens exist, stop and ask which screens to build. Include frame names, node IDs, and sizes.
6. For each selected screen, fetch `get_design_context` and `get_screenshot`.
7. Try Code Connect, mappings, suggestions, design-system search, and component matches when available. If Code Connect is unavailable, empty, unsupported, or blocked by permissions, continue with normal Figma context and screenshots.

## Clarification Policy

Ask only when the answer changes the implementation materially:

- Which screen or frame to build when multiple frames exist.
- Whether selected frames should become routes, tabs, sections, or replacements for existing UI.
- Which target package/file to edit when multiple local targets are plausible.
- Whether missing Figma access, MCP rate limits, or missing node IDs block inspection.
- Whether Figma and existing app behavior conflict.

Do not ask about minor spacing, colors, copy, or responsive behavior when Figma and local conventions provide a reasonable default.

## Local Nuxt Inspection

Before editing, inspect the target package and nearby patterns:

- `package.json`, `nuxt.config.ts`, `app.vue`, routes/pages/components, shared SCSS, stores, composables, middleware, and existing UI primitives.
- Detect Nuxt 4 `app/` structure, `<script setup lang="ts">`, auto imports, Pinia, Iconify/unplugin icons, Nuxt UI, RDS theme base, Bootstrap-compatible utilities, custom CSS variables, and local component naming conventions.
- Use `@nuxt/ui` only when `@nuxt/ui` is installed in the target package or the user explicitly requests it.
- Do not introduce new icon libraries, state libraries, CSS frameworks, or global dependencies unless already used locally or explicitly requested.

## Implementation Rules

- Map Figma sections to existing routes, components, selectors, state, data fetching, and API behavior where practical.
- Preserve existing product behavior, route names, middleware, runtime config, stores, and `data-testid` hooks unless deliberately replacing them.
- Use Nuxt 4 and Vue conventions: `<script setup lang="ts">`, typed props/emits, auto imports, semantic HTML, labels, keyboard-accessible controls, and meaningful alt text.
- Prefer existing components, composables, stores, CSS variables, design-system classes, and local UI primitives before adding abstractions.
- Build repeated top bars, side navs, and layout scaffolds once for multi-screen work.
- Adapt absolute Figma positioning into maintainable responsive layout using grid, flex, `minmax`, dimension `clamp()` where appropriate, and stable aspect ratios.
- Use real assets exported or referenced from Figma when they are part of the design.
- Preserve usability over pixel-perfect copying when Figma omits responsive or accessibility details.

## CSS And RDS Pass

Run a CSS maintenance pass after implementation.

- Use scoped styles for local CSS. Name custom selectors with component/page-prefixed BEM hooks, such as `landing-page__main`.
- Avoid generic custom names like `container`, `content`, `left-column`, `right-column`, `auth-btn`, `main-content`, and `hero-content`.
- Keep custom CSS only for exact Figma/page-specific dimensions, fixed visual panels, shadows, gradients, grid templates, pseudo-elements, animation, child-component overrides, custom states, and responsive one-offs not covered by utilities.
- Ban static inline styles. Allow dynamic Vue `:style` only for data-driven values that utilities cannot represent.
- Use `:deep()` only for required child-component overrides.

Apply the RDS module only when the target package uses RDS or the user explicitly requests RDS alignment:

- Detect RDS by checking `package.json` for `@rds-vue-ui/rds-theme-base`, `nuxt.config.ts` for `@rds-vue-ui/rds-theme-base/dist/css/rds-theme-base.css`, and nearby Vue files for utilities like `gap-space-*`, `text-dark-*`, `btn`, or `container-lg`.
- Prefer RDS/Bootstrap utility classes for display, spacing, alignment, typography, color, borders, radius, shadows, forms, buttons, and cards when the utility exactly matches behavior.
- Use `var(--rds-*)` tokens for remaining custom CSS. Avoid raw hex colors unless matching a non-RDS asset or unavoidable visual spec.
- Read `references/rds-utilities.md` only for broad RDS conversions or when local CSS lookup needs category guidance.
- Verify non-obvious utilities against the local compiled RDS CSS before using them.

## Multi-Screen Build Pattern

When the user asks to build all or selected screens:

1. List all screen-like frames first.
2. Ask the user to choose screens unless they explicitly said "build all".
3. Decide whether selected screens map to routes, tabs, sections, replacements, or reusable component examples.
4. Implement shared layout once.
5. Implement selected screens incrementally.
6. Validate each major screen before moving to the next when the change is large.

## Failure Handling

- If Figma MCP is unavailable, say so and ask for screenshots or frame exports.
- If Figma MCP rate limits block inspection, report the limitation and continue only with already inspected metadata or user-provided screenshots/frame links.
- If Code Connect fails because the account lacks a Developer seat or Organization/Enterprise plan, use regular Figma metadata/design-context inspection.
- If a visual detail cannot be implemented safely, state the tradeoff and choose the maintainable option.

## Validation

- Run the narrowest package command that covers the change, usually `pnpm --filter <package-name> build`.
- If available and relevant, also run package-local typecheck, lint, tests, or syntax checks.
- Do not run broad workspace commands when targeted checks cover the edited package.
- For substantial visual work, start the relevant Nuxt dev server and inspect desktop and mobile widths in a browser.
- Compare against the Figma screenshot and iterate on spacing, typography, color, imagery, and responsive behavior.
- Before finishing, search touched Vue files for static `style="`, raw hex colors, `rgba(...)`, dead CSS, and custom declarations that could be utilities.

## Completion

Finish with:

- Screens inspected and selected.
- Files changed.
- RDS detection result and CSS pass summary when applicable.
- Checks run.
- Missing visual verification, Figma access limits, or assumptions.

### rds-css-standardization

**Description**: Use when refactoring, cleaning up, or styling Vue/Nuxt pages and components to align with ASU's Responsive Design System (RDS), standard utility classes, and CSS naming conventions.


# RDS CSS Standardization Skill

Use for CSS cleanup in the target Nuxt/Vue package. Optimize for RDS/Bootstrap utilities in Vue templates, scoped CSS only where utilities cannot express the behavior.

## Source Of Truth

- Theme import: `<target-package>/nuxt.config.ts` should include `@rds-vue-ui/rds-theme-base/dist/css/rds-theme-base.css`.
- Local package: `<target-package>/node_modules/@rds-vue-ui/rds-theme-base`.
- Compiled classes: `dist/css/rds-theme-base.css`.
- Token/source files: `style/_colors.scss`, `style/_spacing-vars.scss`, `style/_variables.scss`, `style/_typography.scss`, `style/_main.scss`.

If a utility is uncertain, verify it locally before using it:

```sh
rg -n "@rds-vue-ui/rds-theme-base/dist/css/rds-theme-base.css" <target-package>/nuxt.config.ts
rg -n "\\.(gap-space-lg|text-dark-3|btn-primary)\\b" <target-package>/node_modules/@rds-vue-ui/rds-theme-base/dist/css/rds-theme-base.css
rg -n "space-|theme-colors|font-sizes|h1-small" <target-package>/node_modules/@rds-vue-ui/rds-theme-base/style -S
```

Read `references/rds-utilities.md` only for broad conversions or when local CSS lookup needs category guidance.

## Rules

1. Move utility-equivalent CSS to the Vue tag's `class` attribute.
2. Keep scoped CSS for dimensions, grid templates, complex gradients/shadows, pseudo-elements, animation, custom states, accessibility/focus rules, and responsive one-offs not covered by utilities.
3. Use `var(--rds-*)` tokens for remaining custom CSS. Avoid raw hex colors unless matching a non-RDS asset or unavoidable visual spec.
4. Ban static inline styles. Allow dynamic Vue `:style` only for data-driven values, such as chart bar width/height, when no utility can represent the value.
5. Use `<style scoped>` or `<style scoped lang="scss">` in Vue SFCs unless editing an intentional global stylesheet.
6. Use component/page-prefixed BEM hooks for custom selectors. Avoid generic custom root classes like `.container`, `.left`, `.right`, `.card`, `.content`, `.header`, `.footer`.

## Conversion Workflow

1. Inventory the touched Vue file for `style=`, raw hex/rgba, custom CSS variables, and utility-convertible declarations.
2. Check these high-miss properties first: `display`, `gap`, `row-gap`, `column-gap`, `margin`, `padding`, `color`, `background`, `border`, `border-radius`, `font-size`, `font-weight`, `line-height`, `text-align`, `justify-content`, `align-items`, `width`, `height`, `position`, `overflow`.
3. Map direct equivalents to utilities. Prefer responsive utilities such as `d-md-flex`, `gap-lg-space-md`, `px-sm-gutter` over media-query overrides when behavior matches.
4. Keep semantic BEM classes only when custom CSS remains or they improve readability/testing.
5. Remove dead CSS after extraction.

## Utility Families

RDS theme base includes Bootstrap 5.3 utilities plus ASU palette and spacing extensions. Common families:

- Color/background: `text-*`, `bg-*`, `text-bg-*`, `*-subtle`, opacity helpers.
- Spacing/gaps: `m*`, `p*`, `gap-*`, `row-gap-*`, `column-gap-*`, `g-*`, `gx-*`, `gy-*`; sizes include `0`, `auto`, `gutter`, `space-xxxs` through `space-xxxl`, and negative margin `nspace-*`.
- Layout: `d-*`, responsive display, `flex-*`, `align-*`, `justify-*`, `container*`, `row`, `col*`, `w-*`, `h-*`, `position-*`, `overflow-*`.
- Typography: `h1-*`, `h2-*`, `h3-*`, `fs-*`, `fw-*`, `lh-*`, text alignment/wrap/transform/decoration.
- Surface/components: `border*`, `rounded*`, `shadow*`, `btn*`, `card*`, `form*`, `list-group*`, `rds-list*`, `rds-link`.

## Miss Prevention

Before finishing:

- Search touched Vue files for static `style="`, raw hex colors, and `rgba(...)` values that can use `var(--rds-*-rgb)`.
- Search scoped CSS for the high-miss properties above.
- For every custom declaration left behind, confirm one reason: no utility exists, value is dynamic, selector is semantic, or behavior is too specific.
- Verify non-obvious utility classes against local `rds-theme-base.css`.

## Reference Contracts

### .agents/references/common/orchestration-contract.md

# AI-DLC Orchestration Contract

This reference captures the shared workflow rules that must remain consistent across stage skills.

## Stage Order

Inception:

1. Workspace Detection: always; no approval gate.
2. Reverse Engineering: brownfield only when artifacts are missing, stale, or rerun is requested.
3. Requirements Analysis: always; adaptive depth.
4. User Stories: conditional.
5. Workflow Planning: always.
6. Application Design: conditional.
7. Units Generation: conditional.

Construction:

1. Functional Design: conditional per unit.
2. NFR Requirements: conditional per unit.
3. NFR Design: conditional per unit when NFR requirements ran.
4. Infrastructure Design: conditional per unit.
5. Code Generation: always per unit.
6. Build and Test: always after all units.

Operations is a placeholder until operations rules are expanded.

## Approval Gates

- Workspace Detection has no approval gate.
- Reverse Engineering, Requirements Analysis, Workflow Planning, Application Design, Units Generation, and Build and Test stop for explicit approval.
- User Stories stops for story-plan approval and generated-stories approval.
- Code Generation stops for generation-plan approval and generated-work approval.
- Construction design stages use exactly two completion choices: `Request Changes` or `Continue to Next Stage`.

## State And Audit

- `aidlc-docs/aidlc-state.md` records project type, current stage, stage progress, skipped stages, extension configuration, and resume point.
- `aidlc-docs/audit.md` is append-only and records full raw user input, approval prompts, responses, AI actions, workflow changes, and blocking findings.
- Use ISO 8601 UTC timestamps.
- Never place application code in `aidlc-docs/`.

## Extension Handling

During Requirements Analysis, present `extensions/**/*.opt-in.md` prompts without loading full extension rule files. Load full extension rules only for enabled extensions. Extensions with no opt-in file are enforced by default.

Enabled extension findings are blocking until resolved or explicitly accepted by the user with audit logging.

Jira Ticket Workflow is auto-enabled when Jira ticket context is provided or requested. When enabled, Jira intake, breakdown classification, implementation-plan approval, task completion logging, and final Jira comment preparation are blocking workflow requirements.

### .agents/references/common/workflow-changes-contract.md

# Workflow Changes Contract

Use this contract for AI-DLC changes after a plan or stage is underway.

## Change Types

- Add a skipped stage
- Skip a planned stage
- Restart current or previous stage
- Change depth level
- Pause or resume workflow
- Change architectural decision
- Add, remove, merge, or split units

## Required Handling

1. Understand the request and affected stages.
2. Assess impact on artifacts, dependencies, approvals, state, and downstream work.
3. Explain consequences and alternatives.
4. Get explicit confirmation before destructive or cascading changes.
5. Archive existing artifacts before destructive rewrites.
6. Update execution plan, `aidlc-state.md`, affected plan checkboxes, and audit.
7. Revalidate affected artifacts before continuing.

## Audit Format

```markdown
## Change Request - [Stage Name]
**Timestamp**: [ISO timestamp]
**Request**: [Complete raw user request]
**Current State**: [Workflow position]
**Impact Assessment**: [Affected stages/artifacts]
**User Confirmation**: [Complete raw confirmation]
**Action Taken**: [What changed]
**Artifacts Affected**: [Files changed/reset]

---
```

### .agents/references/common/workspace-detection-contract.md

# Workspace Detection Contract

This reference is shared by the `aidlc-workspace-detection` skill and validators.

## Workspace Classification

Scan the workspace root, excluding:

- `aidlc-docs/`
- `.git/`
- dependency directories such as `node_modules/`, `vendor/`, `.venv/`, and `target/`
- generated output directories such as `dist/`, `build/`, `coverage/`, and `.cache/`

Treat a workspace as brownfield when it contains source files, package/build manifests, test structure, infrastructure definitions, or application configuration. Treat it as greenfield only when none of those indicators are present.

## State Artifact

New AI-DLC workflows must create `aidlc-docs/aidlc-state.md` with these sections:

```markdown
# AI-DLC State Tracking

## Project Information
## Workspace State
## Code Location Rules
## Stage Progress
```

The workspace state must record project type, existing code, reverse engineering need, and workspace root.

## Audit Artifact

AI-DLC workflows must create and append to `aidlc-docs/audit.md`. Each audit entry must preserve raw user input and use this shape:

```markdown
## [Stage Name or Interaction Type]
**Timestamp**: 2026-05-29T12:34:56Z
**User Input**: "[Complete raw user input]"
**AI Response**: "[AI response or action taken]"
**Context**: [Stage, action, or decision made]

---
```

Never overwrite the full audit log to append one entry.

## Stage Routing

- Greenfield workspaces route to Requirements Analysis.
- Brownfield workspaces route to Reverse Engineering unless current reverse engineering artifacts already exist or the user explicitly chooses to skip rerun.
- Workspace Detection itself has no approval gate.

### .agents/references/construction/build-and-test-contract.md

# Build And Test Contract

Build and Test runs after all unit code generation is complete.

## Inputs

- Generated code and tests
- Project build files
- Execution plan
- Enabled extension configuration

## Required Artifacts

Create under `aidlc-docs/construction/build-and-test/`:

- `build-instructions.md`
- `unit-test-instructions.md`
- `integration-test-instructions.md`
- `build-and-test-summary.md`

Create when applicable:

- `performance-test-instructions.md`
- `contract-test-instructions.md`
- `security-test-instructions.md`
- `e2e-test-instructions.md`

## Content Requirements

- Build prerequisites, dependency installation, environment setup, build commands, expected output, artifacts, troubleshooting.
- Unit test commands, expected pass/fail state, coverage and report locations.
- Integration scenarios, setup, execution, verification, cleanup.
- Performance, contract, security, e2e, and property-based testing instructions when relevant.

## Completion

Update state and audit. Completion starts with `# Build and Test Complete`, points to `build-and-test-summary.md`, and offers `Request Changes` or `Approve & Continue`.

### .agents/references/construction/code-generation-contract.md

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

### .agents/references/construction/functional-design-contract.md

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

### .agents/references/construction/infrastructure-design-contract.md

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

### .agents/references/construction/nfr-design-contract.md

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

### .agents/references/construction/nfr-requirements-contract.md

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

### .agents/references/extensions/jira-ticket-workflow-contract.md

# Jira Ticket Workflow Contract

The Jira Ticket Workflow extension adds ticket-aware intake, breakdown classification, canonical work-item mapping, implementation tracking, and Jira-ready completion comments to AI-DLC.

## Opt-In Prompt

Use this during Requirements Analysis when Jira workflow behavior may be useful but was not explicitly requested:

```markdown
## Question: Jira Ticket Workflow Extension
Should Jira-ticket-aware intake, breakdown classification, subticket drafting, and Jira-ready completion logging be enforced for this task?

A) Yes - enforce Jira-ticket-aware workflow rules as blocking constraints
B) No - use standard AI-DLC workflow without Jira ticket artifacts
X) Other (please describe after [Answer]: tag below)

[Answer]:
```

## Activation

Automatically enable and enforce this extension when the user asks for a Jira-ticket-aware workflow, provides a Jira ticket title and description, or asks to split work into Jira subtickets/tasks.

## Intake Gate

Before implementation, require:

- Jira ticket title
- Jira ticket description

Jira ticket link is optional context. Do not block intake only because no link was provided.

If any required field is missing or placeholder text, create `aidlc-docs/inception/jira-ticket/jira-ticket-intake.md`:

```markdown
# Jira Ticket Intake

## Jira Ticket Link (Optional)

[Answer]:

## Jira Ticket Title

[Answer]:

## Jira Ticket Description

[Answer]:

## Additional Context

[Answer]:

## Acceptance Criteria

[Answer]:

## Known Constraints

[Answer]:

## Notes

[Answer]:
```

Stop until the user fills the file. Then read and validate the required fields before continuing.

## Breakdown Classification

Create `aidlc-docs/inception/jira-ticket/ticket-breakdown-analysis.md` after intake.

Classify exactly one:

- `Single-Go`
- `Needs Breakdown`
- `Needs Clarification`

Use `Needs Clarification` when scope, acceptance criteria, expected behavior, affected components, dependencies, tests, or definition of done are unclear. Write blocking questions to `aidlc-docs/inception/jira-ticket/jira-ticket-clarification-questions.md` and stop until answered.

Use `Needs Breakdown` when there are multiple independently deliverable outcomes, multiple major areas, API/database/infrastructure/security/release risk, staged rollout, unresolved external dependency, review-size risk, or testability risk.

Use `Single-Go` only when scope is clear, isolated, low-risk, testable with a focused set, reviewable as one PR, and has no API/database/infra/security/release impact.

## Canonical Work Item Mapping

Jira subtickets, AI-DLC units, and implementation tasks overlap. Do not create duplicate parallel task lists.

When breakdown is needed, create `aidlc-docs/inception/jira-ticket/subtickets.md` as the canonical implementation work-item list. Use those subtickets as AI-DLC units of work during Workflow Planning and Construction. If User Stories also execute, map stories and acceptance criteria to the subtickets/units.

Each subticket/task must include:

- title
- type: frontend, backend, API, database, infrastructure, testing, documentation, or mixed
- goal
- scope
- acceptance criteria
- dependencies
- likely affected files/components
- testing required
- risk/impact
- status

## Implementation Gate

Before implementing any single-go task or subticket, create a concise implementation plan and ask for approval. If subtickets exist, implement one subticket at a time.

Do not proceed to code until:

- Jira intake is complete
- ticket breakdown analysis is complete
- subtickets are created when breakdown is needed
- implementation plan is prepared
- user approves the implementation plan

## Completion Log

After each completed single-go task or subticket, update `aidlc-docs/construction/jira-ticket/task-completion-log.md` with:

- task/subticket title
- completed date and time
- what was done
- files/components changed
- tests or validation performed
- impact assessment
- whether anything external is affected
- notes or follow-ups

Use local timezone if available; otherwise use UTC and state that UTC was used.

## Final Jira Comment

After all Jira work items are complete, prepare `aidlc-docs/construction/jira-ticket/final-jira-comment.md` with:

- date and time
- summary of work completed
- validation performed
- impact assessment
- whether anything is affected
- follow-ups or known limitations

Do not claim tests passed unless they were actually run or explicitly verified. Do not claim deployment was completed unless deployment actually happened. Do not claim real Jira subtickets were created unless they were created in Jira. If subtickets are only markdown drafts, state that clearly.

## Directory Structure

```text
aidlc-docs/
├── inception/
│   └── jira-ticket/
│       ├── jira-ticket-intake.md
│       ├── jira-ticket-clarification-questions.md
│       ├── ticket-breakdown-analysis.md
│       └── subtickets.md
└── construction/
    └── jira-ticket/
        ├── task-completion-log.md
        └── final-jira-comment.md
```

### .agents/references/extensions/property-based-testing-contract.md

# Property-Based Testing Contract

Property-Based Testing rules are blocking when enabled. In Partial mode, only the subset selected by the extension rules is blocking.

## Blocking Behavior

For any applicable non-compliant rule:

- Add a `PBT Findings` section with rule ID and description.
- Do not present `Continue to Next Stage`.
- Present only `Request Changes` with remediation guidance.
- Log the finding in `aidlc-docs/audit.md`.

Mark non-applicable rules as `N/A` with a short rationale.

## Rule Categories

Evaluate the full fallback rule file when detailed rule text is required: `.aidlc-rule-details/extensions/testing/property-based/property-based-testing.md`.

At minimum, consider:

- Property identification during Functional Design
- Round-trip properties
- Invariant properties
- Idempotency properties
- Oracle/model-based properties
- Stateful properties when applicable
- Domain-appropriate generators
- Boundary-value generation
- Shrinking/reproducibility expectations
- CI/build-test execution instructions

## Stage Integration

- Functional Design documents testable properties.
- Code Generation creates property-based tests for required properties.
- Build and Test includes commands and expectations for property-based tests.

### .agents/references/extensions/security-baseline-contract.md

# Security Baseline Contract

Security baseline rules are blocking when enabled or default-enforced.

## Blocking Behavior

For any applicable non-compliant rule:

- Add a `Security Findings` section with rule ID and description.
- Do not present `Continue to Next Stage`.
- Present only `Request Changes` with remediation guidance.
- Log the finding in `aidlc-docs/audit.md`.

Mark non-applicable rules as `N/A` with a short rationale.

## Rule Categories

Evaluate the full fallback rule file when detailed rule text is required: `.aidlc-rule-details/extensions/security/baseline/security-baseline.md`.

At minimum, consider:

- Encryption at rest and in transit
- Access logging on network intermediaries
- Structured application logging without secrets or PII
- HTTP security headers for web applications
- Input validation on all API parameters
- Least-privilege access policies
- Authentication, authorization, session, and token validation
- Network deny-by-default posture
- Auditability, monitoring, alerting, and log integrity
- Safe error handling and fail-closed behavior

## Stage Integration

Security checks must be reflected in design, code generation, and build/test artifacts when relevant.

### .agents/references/inception/application-design-contract.md

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

### .agents/references/inception/operations-contract.md

# Operations Contract

Operations is a lightweight post-build handoff in the current AI-DLC workflow.

## Current Behavior

- Operations starts only after Build and Test is approved.
- Ask whether the user wants to create a pull request. Do not create a commit, push a branch, or open a pull request without explicit approval.
- If pull request creation is approved, commit the completed work intentionally, push the current feature branch, and create the pull request using the available GitHub workflow/tooling.
- After the pull request step is complete or explicitly skipped, ask whether the user wants to deploy to Vercel. Do not deploy without explicit approval.
- If Vercel deployment is approved, deploy the verified build using the available Vercel workflow/tooling and record the deployment URL in the Operations status.
- Do not create monitoring, incident response, maintenance, or production-readiness artifacts unless future Operations rules are added.

## Branch And PR Preconditions

- Code Generation should already have created or switched to a feature branch from `main` before coding starts.
- The branch name should reflect the work type and scope, such as `feature/feedback-collector`, `bugfix/rating-validation`, `refactor/storage-layer`, or `chore/update-docs`.
- Do not open a pull request from `main`.
- If the current branch, repository remote, GitHub authentication, or uncommitted work state prevents a safe pull request, stop and ask for user direction.

## Future Scope

Potential future Operations stages include deployment planning, monitoring, observability, incident response, maintenance, support workflows, and production readiness.

### .agents/references/inception/requirements-analysis-contract.md

# Requirements Analysis Contract

Requirements Analysis always runs after Workspace Detection and after Reverse Engineering for brownfield workspaces.

## Context Loading

For brownfield workspaces, load only relevant reverse-engineering artifacts:

- `architecture.md`
- `component-inventory.md`
- `technology-stack.md`

## Intent Analysis

Classify:

- Clarity: clear, vague, incomplete
- Request type: new feature, bug fix, refactor, upgrade, migration, enhancement, new project
- Scope: single file, single component, multiple components, system-wide, cross-system
- Complexity: trivial, simple, moderate, complex

## Adaptive Depth

- Minimal: clear/simple request where basic documented understanding is enough.
- Standard: normal complexity, functional and NFR detail needed, or clarification needed.
- Comprehensive: high-risk, critical, multi-stakeholder, compliance/security/infrastructure, or high ambiguity.

## Questions And Extension Opt-In

Create `aidlc-docs/inception/requirements/requirement-verification-questions.md` unless requirements are exceptionally clear and complete.

Before using the exceptionally-clear-and-complete exception, check whether the prompt is short, broad, feature-level, or missing product decisions. If it is, load `.agents/skills/aidlc-grill-me/SKILL.md` and ask deeper clarification questions before final requirements are generated.

A request is not exceptionally clear and complete when any material implementation decision is still hidden, including target user, primary use case, must-have behavior, data persistence or retention, UI expectations, validation and error behavior, privacy or security constraints, testing expectations, or acceptance criteria.

Ask about unclear functional requirements, NFRs, user scenarios, business context, technical context, quality attributes, edge cases, and error behavior.

When grill-me clarification is triggered, ask one focused round of 3 to 7 high-impact questions, include the trigger reason in the question artifact, and stop for answers. Ask follow-ups only when answers conflict or leave a material decision unresolved. Record assumptions only for low-risk defaults, not hidden product decisions.

Include loaded extension opt-in prompts. Record answers in `aidlc-docs/aidlc-state.md` under:

```markdown
## Extension Configuration
| Extension | Enabled | Decided At |
|---|---|---|
```

Stop until answers are complete and validated. If answers conflict or remain ambiguous, ask follow-up questions before generating final requirements.

If the user asks for Jira-ticket-aware workflow behavior, provides Jira ticket details, or asks to split work into Jira subtickets/tasks, enable the Jira Ticket Workflow extension automatically. If Jira may be useful but was not explicitly requested, include the opt-in prompt from `../extensions/jira-ticket-workflow-contract.md`.

## Required Artifact

Create `aidlc-docs/inception/requirements/requirements.md` with:

- Intent analysis summary
- User request
- Request type
- Scope estimate
- Complexity estimate
- Functional requirements
- Non-functional requirements
- Incorporated question answers
- Key requirements summary

## Completion

Update `aidlc-docs/aidlc-state.md` and append audit entries. Completion message must start with `# Requirements Analysis Complete`, point to `aidlc-docs/inception/requirements/requirements.md`, and offer `Request Changes`, optional `Add User Stories`, and `Approve & Continue` to the selected next stage.

### .agents/references/inception/reverse-engineering-contract.md

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

### .agents/references/inception/units-generation-contract.md

# Units Generation Contract

Units Generation decomposes the application into development units of work.

## Inputs

- Requirements and user stories when present
- Application Design artifacts
- Execution plan stage decision

## Plan And Questions

Create `aidlc-docs/inception/plans/unit-of-work-plan.md` with checkbox steps and `[Answer]:` questions covering story grouping, dependencies, team alignment, technical concerns, business domains, and greenfield code organization.

Resolve ambiguity before plan approval.

## Artifacts

Create under `aidlc-docs/inception/application-design/`:

- `unit-of-work.md`
- `unit-of-work-dependency.md`
- `unit-of-work-story-map.md`

For greenfield multi-unit work, document code organization strategy in `unit-of-work.md`.

## Completion

Update state and audit. Completion starts with `# Units Generation Complete`, points to application-design unit artifacts, and offers `Request Changes` or `Approve & Continue`.

### .agents/references/inception/user-stories-contract.md

# User Stories Contract

User Stories converts approved requirements into user-centered stories, acceptance criteria, and personas.

## Assessment

Create `aidlc-docs/inception/plans/user-stories-assessment.md` and execute User Stories when user-facing value, multiple personas, customer-facing APIs, complex business logic, acceptance criteria, or stakeholder alignment justify the stage.

Skip only for internal refactors, isolated simple bug fixes, infrastructure-only work, tooling, or documentation-only changes with no user impact.

## Plan And Questions

Create `aidlc-docs/inception/plans/story-generation-plan.md` with checkbox steps, story breakdown options, mandatory artifacts, and `[Answer]:` questions.

Resolve ambiguity before plan approval. Do not discuss implementation tasks or sprint planning.

## Artifacts

Create under `aidlc-docs/inception/user-stories/`:

- `stories.md` with INVEST-compliant stories and acceptance criteria.
- `personas.md` with relevant user archetypes.

Map personas to stories and organize stories using the approved approach.

## Completion

Update state and audit. Completion starts with `# User Stories Complete`, points to stories and personas, and offers `Request Changes` or `Approve & Continue`.

### .agents/references/inception/workflow-planning-contract.md

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

