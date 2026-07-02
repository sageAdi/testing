#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
MAX_AGENTS_BYTES="${MAX_AGENTS_BYTES:-12000}"
MAX_SKILL_LINES="${MAX_SKILL_LINES:-120}"

AGENTS="$ROOT/AGENTS.md"
if [[ ! -f "$AGENTS" ]]; then
  echo "ERROR: missing AGENTS.md" >&2
  exit 1
fi

agents_bytes="$(wc -c < "$AGENTS" | tr -d ' ')"
if (( agents_bytes > MAX_AGENTS_BYTES )); then
  echo "ERROR: AGENTS.md is ${agents_bytes} bytes; max is ${MAX_AGENTS_BYTES}" >&2
  exit 1
fi

if [[ -d "$ROOT/.agents/skills" ]]; then
  while IFS= read -r -d '' skill_file; do
    lines="$(wc -l < "$skill_file" | tr -d ' ')"
    if (( lines > MAX_SKILL_LINES )); then
      echo "ERROR: $skill_file is ${lines} lines; max is ${MAX_SKILL_LINES}" >&2
      exit 1
    fi
  done < <(find "$ROOT/.agents/skills" -mindepth 2 -maxdepth 2 -name SKILL.md -print0)
fi

echo "OK: token budget checks passed"
