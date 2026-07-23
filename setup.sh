#!/usr/bin/env bash
# Idempotent installer for the claude-skills repo.
#
# Symlinks every skills/*/ directory into ~/.claude/skills/ and the two
# managed dotfiles (CLAUDE.md, settings.json) into ~/.claude/, so local
# edits show up as reviewable git diffs in this repo. Anything already at
# a destination is moved into a timestamped backup directory (created
# lazily, so re-runs that change nothing create no backup dir).
set -u

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$CLAUDE_DIR/claude-skills-backup-$(date +%Y%m%d-%H%M%S)"

link() {
    local src="$1"
    local dst="$2"
    if [ "$(readlink -f "$dst" 2>/dev/null)" = "$(readlink -f "$src")" ]; then
        echo "ok      $dst"
    else
        if [ -e "$dst" ] || [ -L "$dst" ]; then
            mkdir -p "$BACKUP_DIR"
            mv "$dst" "$BACKUP_DIR/"
            echo "backup  $dst -> $BACKUP_DIR/$(basename "$dst")"
        fi
        mkdir -p "$(dirname "$dst")"
        ln -s "$src" "$dst"
        echo "linked  $dst -> $src"
    fi
}

warn() {
    echo "warning: $*" >&2
}

for skill_dir in "$REPO_DIR"/skills/*/; do
    if [ -d "$skill_dir" ]; then
        link "${skill_dir%/}" "$CLAUDE_DIR/skills/$(basename "$skill_dir")"
    fi
done

link "$REPO_DIR/dotfiles/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
link "$REPO_DIR/dotfiles/settings.json" "$CLAUDE_DIR/settings.json"

if [ ! -d "$HOME/Code/claude-context" ]; then
    warn "~/Code/claude-context is not cloned; CLAUDE.md imports will not resolve"
fi
for cmd in gh gh-axi chrome-devtools-axi lavish-axi jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        warn "$cmd not found on PATH"
    fi
done

echo "done"
