# claude-skills

Personal Claude Code skills and managed dotfiles, installed by symlink so
that local edits show up as reviewable git diffs here. Companion to the
private `claude-context` repo, which holds the durable context these files
import (CAREER.md, PREFERENCES.md, PROJECTS.md).

## Layout

```
setup.sh           idempotent installer (symlinks skills and dotfiles)
skills/            one directory per skill, linked into ~/.claude/skills/
dotfiles/
  CLAUDE.md        global CLAUDE.md, linked to ~/.claude/CLAUDE.md
  settings.json    Claude Code settings, linked to ~/.claude/settings.json
```

## New-machine bootstrap

1. Clone the context and skills repos to their canonical paths:

   ```
   git clone git@github.com:dardenkyle/claude-context.git ~/Code/claude-context
   git clone git@github.com:dardenkyle/claude-skills.git ~/Code/claude-skills
   ```

2. Run the installer:

   ```
   bash ~/Code/claude-skills/setup.sh
   ```

   Re-running is safe: links that already resolve correctly print `ok` and
   nothing is touched. Anything else found at a destination is moved into
   `~/.claude/claude-skills-backup-<timestamp>/` before linking.

3. Heed the warnings it prints at the end (missing `claude-context` clone,
   missing CLI tools such as `gh`, `gh-axi`, `chrome-devtools-axi`,
   `lavish-axi`, `jq`).

## Editing

- Skills and dotfiles: edit in this repo (the symlinks make in-place edits
  land here anyway), review the diff, commit.
- Durable context and agent rules: edit in `~/Code/claude-context`, not
  here. `dotfiles/CLAUDE.md` only imports those files.
