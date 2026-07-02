#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
AGENTS="$ROOT/AGENTS.md"

if [[ ! -f "$AGENTS" ]]; then
  echo "ERROR: missing AGENTS.md" >&2
  exit 1
fi

required=(
  "## Approval Gates"
  "Never proceed past an approval gate without explicit user confirmation."
  "Workspace Detection has no approval gate"
  "User Stories requires approval for the story plan and generated stories."
  "Code Generation requires approval for the generation plan and for generated work completion."
  "Construction design stages must use the standardized two-option completion pattern"
  "Request Changes"
  "Continue to Next Stage"
)

for text in "${required[@]}"; do
  if ! grep -Fq "$text" "$AGENTS"; then
    echo "ERROR: AGENTS.md missing approval-gate invariant: $text" >&2
    exit 1
  fi
done

if [[ -d "$ROOT/aidlc-docs" ]]; then
  if find "$ROOT/aidlc-docs" -type f -name '*plan.md' -print -quit | grep -q .; then
    if ! grep -R -Eq '\[[ x]\]' "$ROOT/aidlc-docs"; then
      echo "ERROR: plan artifacts exist but no checkbox tracking was found" >&2
      exit 1
    fi
  fi
fi

echo "OK: approval gate invariants are present"
