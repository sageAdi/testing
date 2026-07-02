#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
GENERATED="$ROOT/.agents/generated-rules/AGENTS.md"

if [[ ! -f "$GENERATED" ]]; then
  echo "ERROR: missing generated fallback: $GENERATED" >&2
  exit 1
fi

if [[ -x "$ROOT/.agents/scripts/generate-rules-fallback.sh" ]]; then
  tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/aidlc-generated-rules.XXXXXX")"
  cleanup() {
    rm -rf "$tmp_dir"
  }
  trap cleanup EXIT

  mkdir -p "$tmp_dir/.agents"
  cp -R "$ROOT/.agents/skills" "$tmp_dir/.agents/skills"
  cp -R "$ROOT/.agents/references" "$tmp_dir/.agents/references"
  cp "$ROOT/AGENTS.md" "$tmp_dir/AGENTS.md"
  mkdir -p "$tmp_dir/.agents/scripts"
  cp "$ROOT/.agents/scripts/generate-rules-fallback.sh" "$tmp_dir/.agents/scripts/generate-rules-fallback.sh"
  chmod +x "$tmp_dir/.agents/scripts/generate-rules-fallback.sh"
  "$tmp_dir/.agents/scripts/generate-rules-fallback.sh" "$tmp_dir" >/dev/null

  if ! cmp -s "$GENERATED" "$tmp_dir/.agents/generated-rules/AGENTS.md"; then
    echo "ERROR: generated fallback is stale; rerun .agents/scripts/generate-rules-fallback.sh ." >&2
    exit 1
  fi
fi

required=(
  "# AI-DLC Generated Rules Fallback"
  "Source of truth"
  "Workspace Detection"
  "Reverse Engineering"
  "Requirements Analysis"
  "User Stories"
  "Workflow Planning"
  "Application Design"
  "Units Generation"
  "Functional Design"
  "NFR Requirements"
  "NFR Design"
  "Infrastructure Design"
  "Code Generation"
  "Build and Test"
  "Security Baseline"
  "Property-Based Testing"
  "Approval Gates"
  "Never proceed past an approval gate without explicit user confirmation."
  "aidlc-docs/audit.md"
  "Security is not optional"
  "Request Changes"
  "Continue to Next Stage"
)

for text in "${required[@]}"; do
  if ! grep -Fq "$text" "$GENERATED"; then
    echo "ERROR: generated fallback missing required content: $text" >&2
    exit 1
  fi
done

if [[ -d "$ROOT/.agents/skills" ]]; then
  while IFS= read -r -d '' skill_file; do
    skill_name="$(awk -F': *' '/^name:/ { print $2; exit }' "$skill_file")"
    if ! grep -Fq "### ${skill_name}" "$GENERATED"; then
      echo "ERROR: generated fallback missing skill section: $skill_name" >&2
      exit 1
    fi
  done < <(find "$ROOT/.agents/skills" -mindepth 2 -maxdepth 2 -name SKILL.md -print0)
fi

if [[ -d "$ROOT/.agents/references" ]]; then
  while IFS= read -r -d '' reference_file; do
    relative_path="${reference_file#"$ROOT/"}"
    if ! grep -Fq "### ${relative_path}" "$GENERATED"; then
      echo "ERROR: generated fallback missing reference section: $relative_path" >&2
      exit 1
    fi
  done < <(find "$ROOT/.agents/references" -type f -name '*.md' -print0)
fi

echo "OK: generated rules fallback is valid"
