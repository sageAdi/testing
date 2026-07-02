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
