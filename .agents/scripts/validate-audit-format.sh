#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
AUDIT="$ROOT/aidlc-docs/audit.md"

if [[ ! -e "$ROOT/aidlc-docs" ]]; then
  echo "OK: no aidlc-docs directory present"
  exit 0
fi

if [[ ! -f "$AUDIT" ]]; then
  echo "ERROR: missing audit file: $AUDIT" >&2
  exit 1
fi

if [[ ! -s "$AUDIT" ]]; then
  echo "ERROR: audit file is empty: $AUDIT" >&2
  exit 1
fi

required_patterns=(
  '^## .+'
  '^\*\*Timestamp\*\*: [0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$'
  '^\*\*User Input\*\*: '
  '^\*\*AI Response\*\*: '
  '^\*\*Context\*\*: '
  '^---$'
)

for pattern in "${required_patterns[@]}"; do
  if ! grep -Eq "$pattern" "$AUDIT"; then
    echo "ERROR: $AUDIT missing required audit pattern: $pattern" >&2
    exit 1
  fi
done

timestamp_count="$(grep -Ec '^\*\*Timestamp\*\*: [0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$' "$AUDIT")"
separator_count="$(grep -Ec '^---$' "$AUDIT")"

if [[ "$separator_count" -lt "$timestamp_count" ]]; then
  echo "ERROR: audit entries must end with --- separators" >&2
  exit 1
fi

echo "OK: AI-DLC audit format is valid"
