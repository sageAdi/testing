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
