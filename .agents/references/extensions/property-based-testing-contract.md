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
