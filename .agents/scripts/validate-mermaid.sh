#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-.}"

if [[ ! -e "$TARGET" ]]; then
  echo "ERROR: target does not exist: $TARGET" >&2
  exit 1
fi

files=()
if [[ -d "$TARGET" ]]; then
  while IFS= read -r -d '' file; do
    files+=("$file")
  done < <(find "$TARGET" -type f \( -name '*.md' -o -name '*.markdown' \) -print0)
else
  files+=("$TARGET")
fi

checked=0
for file in "${files[@]}"; do
  if ! grep -q '```mermaid' "$file"; then
    continue
  fi
  checked=1

  fence_count="$(grep -c '^```' "$file")"
  if (( fence_count % 2 != 0 )); then
    echo "ERROR: unmatched markdown code fence in $file" >&2
    exit 1
  fi

  if ! awk '
    /^```mermaid/ { in_block=1; has_type=0; next }
    in_block && /^```$/ {
      if (!has_type) {
        printf("ERROR: Mermaid block without diagram type in %s\n", FILENAME) > "/dev/stderr"
        exit 1
      }
      in_block=0
      next
    }
    in_block && $0 ~ /^(flowchart|graph|sequenceDiagram|classDiagram|stateDiagram|erDiagram|gantt|timeline|pie|journey)/ {
      has_type=1
    }
    END {
      if (in_block) {
        printf("ERROR: unclosed Mermaid block in %s\n", FILENAME) > "/dev/stderr"
        exit 1
      }
    }
  ' "$file"; then
    exit 1
  fi
done

if [[ "$checked" -eq 0 ]]; then
  echo "OK: no Mermaid blocks found"
else
  echo "OK: Mermaid blocks have basic valid structure"
fi
