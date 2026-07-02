#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
JIRA_INCEPTION="$ROOT/aidlc-docs/inception/jira-ticket"
JIRA_CONSTRUCTION="$ROOT/aidlc-docs/construction/jira-ticket"

if [[ ! -d "$JIRA_INCEPTION" && ! -d "$JIRA_CONSTRUCTION" ]]; then
  echo "OK: no Jira ticket workflow artifacts present"
  exit 0
fi

require_file() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "ERROR: missing required Jira workflow artifact: $file" >&2
    exit 1
  fi
}

answer_after_heading() {
  local file="$1"
  local heading="$2"
  awk -v heading="$heading" '
    $0 == heading { in_section=1; next }
    in_section && /^## / { exit }
    in_section && /^\[Answer\]:/ {
      sub(/^\[Answer\]:[[:space:]]*/, "")
      print
      exit
    }
  ' "$file"
}

if [[ -d "$JIRA_INCEPTION" ]]; then
  intake="$JIRA_INCEPTION/jira-ticket-intake.md"
  breakdown="$JIRA_INCEPTION/ticket-breakdown-analysis.md"
  require_file "$intake"
  require_file "$breakdown"

  for heading in "## Jira Ticket Title" "## Jira Ticket Description"; do
    value="$(answer_after_heading "$intake" "$heading")"
    if [[ -z "$value" || "$value" == "["* || "$value" == "TBD" || "$value" == "TODO" ]]; then
      echo "ERROR: Jira intake field is missing or placeholder: $heading" >&2
      exit 1
    fi
  done

  if ! grep -Eq 'Single-Go|Needs Breakdown|Needs Clarification' "$breakdown"; then
    echo "ERROR: Jira breakdown analysis must classify as Single-Go, Needs Breakdown, or Needs Clarification" >&2
    exit 1
  fi

  if grep -Eq 'Needs Breakdown' "$breakdown"; then
    require_file "$JIRA_INCEPTION/subtickets.md"
  fi

  if grep -Eq 'Needs Clarification' "$breakdown"; then
    require_file "$JIRA_INCEPTION/jira-ticket-clarification-questions.md"
  fi
fi

if [[ -d "$JIRA_CONSTRUCTION" ]]; then
  if [[ -f "$JIRA_CONSTRUCTION/final-jira-comment.md" && ! -f "$JIRA_CONSTRUCTION/task-completion-log.md" ]]; then
    echo "ERROR: final Jira comment exists without task completion log" >&2
    exit 1
  fi
fi

echo "OK: Jira ticket workflow artifacts are valid"
