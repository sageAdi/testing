# Integration Test Instructions

## Integration Scope

The relevant integration boundary is between:

- HTML form controls
- JavaScript validation and rendering logic
- browser localStorage

There are no backend, API, database, authentication, analytics, or external-service integrations.

## Setup

Open:

```text
file:///Users/adi/Documents/testing/index.html
```

Clear browser localStorage before running integration checks.

## Scenarios

1. Load the page and verify the empty state appears.
2. Attempt submit with no rating or message and verify validation errors.
3. Enter invalid optional email and verify email validation.
4. Submit valid feedback and verify it appears in the saved list.
5. Refresh and verify the entry persists.
6. Submit a second item and verify newest-first ordering.
7. Delete one item and verify only that item is removed.
8. Clear all entries and verify the empty state returns.

## Cleanup

Clear `localStorage` key `feedbackCollector.entries` after testing if needed.

## Actual Result

Automated browser integration checks passed on 2026-07-02T18:06:11Z.
