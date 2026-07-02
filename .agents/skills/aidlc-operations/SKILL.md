---
name: aidlc-operations
description: Handle the AI-DLC Operations handoff after Build and Test approval, including optional pull request creation and Vercel deployment prompts.
---

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
