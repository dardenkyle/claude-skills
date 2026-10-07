# Global Instructions

Loaded into every Claude Code session. This file holds imports and a
scope note only; the rules themselves live in the imported files so each
rule exists in exactly one place.

This file is version-controlled in the `claude-skills` repo and symlinked
to `~/.claude/CLAUDE.md` by its `setup.sh`. Edit it there, not in place.

## Scope

- Cross-project agent rules (communication, git, PRs, workflow, tooling,
  code): PREFERENCES.md, imported below.
- Project status and cautions: PROJECTS.md, imported below.
- Per-repo conventions: each repository's own `CLAUDE.md`.
- Coursework coding standards (ACC COSC courses): `~/Code/data-structures/CLAUDE.md`.
  Claude Code loads it automatically inside those repos because it reads
  `CLAUDE.md` files from parent directories. Those standards apply only
  there, never to other projects.

## Career Context

Canonical career and portfolio-strategy context lives in the private
`claude-context` repo. Consult it whenever career, resume, positioning,
or portfolio questions come up. Edit it in that repo, not here.

@~/Code/claude-context/CAREER.md

## Agent Behavior Rules

@~/Code/claude-context/PREFERENCES.md

## Project Status

@~/Code/claude-context/PROJECTS.md
