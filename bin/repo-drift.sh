#!/usr/bin/env bash
# Report uncommitted changes and unpushed commits in the repos that hold
# Claude Code configuration. Runs as a SessionStart hook (see
# dotfiles/settings.json). Prints nothing when every repo is clean and
# pushed, so a quiet session start means there is no drift to triage.
#
# Why: ~/.claude/settings.json is a symlink into claude-skills, and Claude
# Code rewrites it on in-app setting changes and config migrations, so
# runtime state lands in the repo as uncommitted changes nobody sees.
# Local-only commits are the same problem one step later.
set -u

REPOS=(
    "$HOME/Code/claude-skills"
    "$HOME/Code/claude-context"
)

report=""
for repo in "${REPOS[@]}"; do
    if ! git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        continue
    fi
    block=""
    status=$(git -C "$repo" status --short 2>/dev/null)
    if [ -n "$status" ]; then
        block+=$(printf '%s\n' "$status" | sed 's/^/  /')$'\n'
    fi
    ahead=$(git -C "$repo" rev-list --count '@{upstream}..HEAD' 2>/dev/null || echo 0)
    if [ "$ahead" -gt 0 ]; then
        upstream=$(git -C "$repo" rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
        block+="  ahead of $upstream by $ahead commit(s)"$'\n'
    fi
    if [ -n "$block" ]; then
        report+="$(basename "$repo")"$'\n'"$block"
    fi
done

if [ -n "$report" ]; then
    printf 'repo drift (uncommitted changes or unpushed commits; triage before other work):\n%s' "$report"
fi
