---
name: aidlc-jira-ticket-workflow
description: Enforce the AI-DLC Jira ticket workflow extension. Use when the user asks for a Jira-ticket-aware workflow, provides Jira ticket details, asks to split work into Jira subtickets or tasks, or needs Jira-ready intake, breakdown, task completion logs, and final Jira comments.
---

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
