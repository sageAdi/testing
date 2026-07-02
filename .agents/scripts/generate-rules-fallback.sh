#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
OUT_DIR="$ROOT/.agents/generated-rules"
OUT_FILE="$OUT_DIR/AGENTS.md"

if [[ ! -f "$ROOT/AGENTS.md" ]]; then
  echo "ERROR: missing AGENTS.md" >&2
  exit 1
fi

if [[ ! -d "$ROOT/.agents/skills" ]]; then
  echo "ERROR: missing skills directory" >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

{
  echo "# AI-DLC Generated Rules Fallback"
  echo
  echo "Generated from the hybrid skill source for rule-only agents."
  echo
  echo "**Source of truth**: \`AGENTS.md\`, \`.agents/skills/**/SKILL.md\`, and \`.agents/references/**/*.md\`."
  echo
  echo "**Compatibility fallback**: Keep \`.aidlc-rule-details/**\` available until parity is approved."
  echo
  echo "## Always-On Control Plane"
  echo
  sed '1d' "$ROOT/AGENTS.md"
  echo
  echo "## Skill Procedures"
  echo

  while IFS= read -r -d '' skill_file; do
    skill_name="$(awk -F': *' '/^name:/ { print $2; exit }' "$skill_file")"
    skill_description="$(awk -F': *' '/^description:/ { print $2; exit }' "$skill_file")"
    echo "### ${skill_name}"
    echo
    echo "**Description**: ${skill_description}"
    echo
    awk '
      BEGIN { frontmatter=0; done=0 }
      NR == 1 && $0 == "---" { frontmatter=1; next }
      frontmatter && $0 == "---" { frontmatter=0; done=1; next }
      done { print }
    ' "$skill_file"
    echo
  done < <(find "$ROOT/.agents/skills" -mindepth 2 -maxdepth 2 -name SKILL.md -print0 | sort -z)

  echo "## Reference Contracts"
  echo
  while IFS= read -r -d '' reference_file; do
    relative_path="${reference_file#"$ROOT/"}"
    echo "### ${relative_path}"
    echo
    cat "$reference_file"
    echo
  done < <(find "$ROOT/.agents/references" -type f -name '*.md' -print0 | sort -z)
} > "$OUT_FILE"

echo "Generated $OUT_FILE"
