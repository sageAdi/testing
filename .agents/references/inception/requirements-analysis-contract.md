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
