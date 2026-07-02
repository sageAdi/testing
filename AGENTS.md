# AI-DLC Hybrid Control Plane

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
