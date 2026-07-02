# Build Instructions

## Prerequisites

- A modern browser for opening `index.html`.
- Node.js for static syntax checks.
- Playwright Chromium runtime for automated browser workflow validation.

## Dependency Installation

No project dependencies are required. The application is dependency-free and has no package manager, build step, or external assets.

For automated browser validation in this environment, the matching Playwright Chromium runtime was installed with:

```bash
npx playwright@1.57.0 install chromium
```

## Environment Setup

No environment variables are required.

## Build Commands

No build command is required. Open the static file directly:

```bash
open /Users/adi/Documents/testing/index.html
```

If using a browser manually, load:

```text
file:///Users/adi/Documents/testing/index.html
```

## Expected Output

The browser renders the feedback collector page with:

- a feedback form
- optional name and email fields
- required rating and message fields
- saved feedback list
- empty state
- clear-all control

## Build Artifacts

Application files:

- `/Users/adi/Documents/testing/index.html`
- `/Users/adi/Documents/testing/styles.css`
- `/Users/adi/Documents/testing/script.js`

## Troubleshooting

- If feedback does not persist, verify browser localStorage is enabled.
- If automated browser checks cannot launch Chromium inside a sandbox, run `node aidlc-docs/construction/build-and-test/browser-workflow-check.mjs` with permission to launch the browser runtime.
- If styles do not load, verify `styles.css` is in the same directory as `index.html`.
- If JavaScript does not run, verify `script.js` is in the same directory as `index.html`.
