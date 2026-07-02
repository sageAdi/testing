#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
AIDLC_DOCS="$ROOT/aidlc-docs"
STATE="$AIDLC_DOCS/aidlc-state.md"
AUDIT="$AIDLC_DOCS/audit.md"

if [[ ! -d "$AIDLC_DOCS" ]]; then
  echo "OK: no aidlc-docs directory present"
  exit 0
fi

if [[ ! -f "$STATE" ]]; then
  echo "ERROR: missing required state file: $STATE" >&2
  exit 1
fi

if [[ ! -f "$AUDIT" ]]; then
  echo "ERROR: missing required audit file: $AUDIT" >&2
  exit 1
fi

for heading in \
  "# AI-DLC State Tracking" \
  "## Project Information" \
  "## Workspace State" \
  "## Code Location Rules" \
  "## Stage Progress"; do
  if ! grep -Fq "$heading" "$STATE"; then
    echo "ERROR: $STATE missing heading: $heading" >&2
    exit 1
  fi
done

if find "$AIDLC_DOCS" \
  \( -name '*.java' -o -name '*.py' -o -name '*.js' -o -name '*.ts' -o -name '*.jsx' -o -name '*.tsx' -o -name '*.go' -o -name '*.rs' -o -name '*.rb' -o -name '*.php' -o -name '*.c' -o -name '*.cpp' -o -name '*.cs' \) \
  -type f -print -quit | grep -q .; then
  echo "ERROR: application source files must not be placed under aidlc-docs" >&2
  exit 1
fi

echo "OK: AI-DLC artifact tree is valid"
