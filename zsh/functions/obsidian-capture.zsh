# ------------------------------------------------------------
# Obsidian Quick Capture
# ------------------------------------------------------------

export OBSIDIAN_VAULT="${OBSIDIAN_VAULT:-$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/bryan-journal}"

_oc_date() {
  date '+%Y-%m-%d'
}

_oc_time() {
  date '+%H:%M'
}

_oc_box() {
  local title="$1"
  local file="$2"

  printf '\n'
  printf '╭─ %s\n' "$title"
  printf '│ Captured to: %s\n' "$file"
  printf '╰─ done\n'
  printf '\n'
}

_oc_require_text() {
  local cmd="$1"
  shift

  if [[ $# -eq 0 ]]; then
    echo "Usage: $cmd your note text here"
    return 1
  fi

  return 0
}

_oc_append() {
  local title="$1"
  local file="$2"
  local entry="$3"

  mkdir -p "$(dirname "$file")"

  if [[ ! -f "$file" ]]; then
    {
      echo "# $(_oc_date)"
      echo ""
    } > "$file"
  fi

  {
    echo "$entry"
  } >> "$file"

  _oc_box "$title" "$file"
}

# oi = Obsidian inbox
oi() {
  _oc_require_text "oi" "$@" || return 1

  local file="$OBSIDIAN_VAULT/00-Inbox/$(_oc_date)-inbox.md"
  local entry="- $(_oc_time) — $* #inbox"

  _oc_append "Obsidian inbox entry added" "$file" "$entry"
}

# ow = Obsidian work-sanitized inbox
ow() {
  _oc_require_text "ow" "$@" || return 1

  local file="$OBSIDIAN_VAULT/00-Inbox/$(_oc_date)-work-sanitized.md"
  local entry="- $(_oc_time) — $* #work/sanitized #inbox"

  _oc_append "Obsidian work-sanitized entry added" "$file" "$entry"
}

# oa = Obsidian action/task
oa() {
  _oc_require_text "oa" "$@" || return 1

  local file="$OBSIDIAN_VAULT/30-Actions/$(_oc_date)-actions.md"
  local entry="- [ ] $* #action captured::$(_oc_date)T$(_oc_time)"

  _oc_append "Obsidian action added" "$file" "$entry"
}

# or = Obsidian reminder
or() {
  _oc_require_text "or" "$@" || return 1

  local file="$OBSIDIAN_VAULT/30-Actions/$(_oc_date)-reminders.md"
  local entry="- [ ] $* #reminder captured::$(_oc_date)T$(_oc_time)"

  _oc_append "Obsidian reminder added" "$file" "$entry"
}

# om = Obsidian meeting note
om() {
  _oc_require_text "om" "$@" || return 1

  local file="$OBSIDIAN_VAULT/20-Meetings/$(_oc_date)-meetings.md"
  local entry="- $(_oc_time) — $* #meeting"

  _oc_append "Obsidian meeting note added" "$file" "$entry"
}

# op = Obsidian Plaud note
op() {
  _oc_require_text "op" "$@" || return 1

  local file="$OBSIDIAN_VAULT/10-Plaud/$(_oc_date)-plaud.md"
  local entry="- $(_oc_time) — $* #plaud"

  _oc_append "Obsidian Plaud note added" "$file" "$entry"
}

# os = Obsidian git sync
os() {
  cd "$OBSIDIAN_VAULT" || return 1

  echo "Vault: $OBSIDIAN_VAULT"
  echo "Pulling latest changes..."
  git pull --rebase --autostash origin main || return 1

  echo "Staging changes..."
  git add -A

  if git diff --cached --quiet; then
    echo "No vault changes to commit."
    return 0
  fi

  git commit -m "capture: $(date '+%Y-%m-%d %H:%M')"
  git push origin main
}

# oh = Obsidian capture help
oh() {
  cat <<'HELP'
Obsidian quick capture commands:

  oi  personal inbox note
  ow  sanitized work inbox note
  oa  action/task checkbox
  or  reminder checkbox
  om  meeting note
  op  Plaud-related note
  os  git pull/add/commit/push vault
  oh  show this help

Examples:

  oi Need to research Plaud AutoFlow export options
  ow Follow up on Azure Update Manager without server details
  oa Trim 9-hour Plaud recording to first 55 minutes
  or Renew passport next week
  om Meeting with IT-SEC about Linux update remediation
  op Import trimmed Plaud audio and transcribe only the short version
  os
HELP
}
