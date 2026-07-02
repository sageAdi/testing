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
