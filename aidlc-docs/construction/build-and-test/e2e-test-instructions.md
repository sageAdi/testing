# E2E Test Instructions

## Automated Browser Workflow

The automated workflow script is:

```bash
node aidlc-docs/construction/build-and-test/browser-workflow-check.mjs
```

## Covered Scenarios

- initial empty state
- required rating validation
- required message validation
- optional email validation
- valid submission success
- saved entry count
- saved entry rendering
- persistence after refresh
- newest-first ordering
- individual delete
- clear-all
- empty state after clearing
- mobile viewport horizontal overflow check
- desktop viewport horizontal overflow check

## Actual Result

The automated browser workflow passed with all checks green on 2026-07-02T18:06:11Z.
