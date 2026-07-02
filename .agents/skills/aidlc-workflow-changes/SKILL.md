---
name: aidlc-workflow-changes
description: Manage AI-DLC mid-workflow changes. Use when the user asks to add, skip, pause, resume, restart, rerun, change depth, change architecture, add or remove units, or otherwise alter the approved execution plan.
---

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
