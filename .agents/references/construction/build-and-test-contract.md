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
