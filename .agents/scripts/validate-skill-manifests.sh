#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
SKILLS_DIR="$ROOT/.agents/skills"

if [[ ! -d "$SKILLS_DIR" ]]; then
  echo "ERROR: missing skills directory: $SKILLS_DIR" >&2
  exit 1
fi

found=0
while IFS= read -r -d '' skill_file; do
  found=1
  skill_dir="$(basename "$(dirname "$skill_file")")"

  first_line="$(sed -n '1p' "$skill_file")"
  if [[ "$first_line" != "---" ]]; then
    echo "ERROR: $skill_file missing opening YAML frontmatter marker" >&2
    exit 1
  fi

  if ! awk 'NR > 1 && $0 == "---" { found=1; exit } END { exit found ? 0 : 1 }' "$skill_file"; then
    echo "ERROR: $skill_file missing closing YAML frontmatter marker" >&2
    exit 1
  fi

  name="$(awk -F': *' '/^name:/ { print $2; exit }' "$skill_file")"
  description="$(awk -F': *' '/^description:/ { print $2; exit }' "$skill_file")"

  if [[ -z "$name" ]]; then
    echo "ERROR: $skill_file missing required name" >&2
    exit 1
  fi

  if [[ "$name" != "$skill_dir" ]]; then
    echo "ERROR: $skill_file name '$name' does not match directory '$skill_dir'" >&2
    exit 1
  fi

  if [[ -z "$description" ]]; then
    echo "ERROR: $skill_file missing required description" >&2
    exit 1
  fi

  if [[ ${#description} -lt 40 ]]; then
    echo "ERROR: $skill_file description is too short to be discoverable" >&2
    exit 1
  fi
done < <(find "$SKILLS_DIR" -mindepth 2 -maxdepth 2 -name SKILL.md -print0)

if [[ "$found" -eq 0 ]]; then
  echo "ERROR: no skill manifests found under $SKILLS_DIR" >&2
  exit 1
fi

echo "OK: skill manifests are valid"
