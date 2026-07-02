#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: install-aidlc.sh [TARGET_DIR]

Installs the AI-DLC workflow control files into TARGET_DIR.
If TARGET_DIR is omitted, the current directory is used.

This script copies:
  - AGENTS.md
  - .agents/
  - .aidlc-rule-details/
  - README.md

It does not create aidlc-docs/ or application code.
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TARGET_DIR="${1:-.}"
TARGET_ROOT="$(cd "$TARGET_DIR" && pwd)"

required_paths=(
  "AGENTS.md"
  ".agents"
  ".aidlc-rule-details"
)

for path in "${required_paths[@]}"; do
  if [[ ! -e "$SOURCE_ROOT/$path" ]]; then
    echo "ERROR: source bundle is missing $path" >&2
    exit 1
  fi
done

mkdir -p "$TARGET_ROOT"

copy_path() {
  local source_path="$1"
  local target_path="$2"

  rm -rf "$target_path"
  cp -R "$source_path" "$target_path"
}

if [[ "$SOURCE_ROOT" == "$TARGET_ROOT" ]]; then
  echo "Source and target are the same directory; validating existing AI-DLC files."
else
  copy_path "$SOURCE_ROOT/AGENTS.md" "$TARGET_ROOT/AGENTS.md"
  copy_path "$SOURCE_ROOT/.agents" "$TARGET_ROOT/.agents"
  copy_path "$SOURCE_ROOT/.aidlc-rule-details" "$TARGET_ROOT/.aidlc-rule-details"

  if [[ -f "$SOURCE_ROOT/README.md" ]]; then
    copy_path "$SOURCE_ROOT/README.md" "$TARGET_ROOT/README.md"
  fi
fi

if [[ -x "$TARGET_ROOT/.agents/scripts/validate-skill-manifests.sh" ]]; then
  "$TARGET_ROOT/.agents/scripts/validate-skill-manifests.sh" "$TARGET_ROOT"
fi

if [[ -x "$TARGET_ROOT/.agents/scripts/validate-generated-rules.sh" ]]; then
  "$TARGET_ROOT/.agents/scripts/validate-generated-rules.sh" "$TARGET_ROOT"
fi

if [[ -x "$TARGET_ROOT/.agents/scripts/validate-approval-gates.sh" ]]; then
  "$TARGET_ROOT/.agents/scripts/validate-approval-gates.sh" "$TARGET_ROOT"
fi

if [[ -x "$TARGET_ROOT/.agents/scripts/check-token-budget.sh" ]]; then
  "$TARGET_ROOT/.agents/scripts/check-token-budget.sh" "$TARGET_ROOT"
fi

echo "AI-DLC workflow installed into $TARGET_ROOT"
echo "Start with: Using AI-DLC, [describe the work]"
