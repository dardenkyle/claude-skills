# claude-skills

Claude Code skills and managed configuration for an issue-driven,
verification-gated development workflow. Each skill is a written
procedure the agent follows for one unit of work: opening it, shipping
it, reviewing it against a spec, or auditing a repository for design
debt.

## The workflow

Work starts from a GitHub issue and ends in a pull request, with the
agent stopping at each hand-off point instead of running ahead.

1. `/start-work` finds or files the issue, claims it, branches from
   fresh `main` (never from another unmerged branch), and states the
   plan before any code is written.
2. The work happens, under the project's own `CLAUDE.md` and the
   global rules.
3. `/ship` verifies (test suite with coverage, plus the type checker
   using the exact invocation from the repo's CI workflow), makes one
   commit whose message carries the issue reference and the coverage
   number, fills the repo's PR template completely, opens the PR, does
   at most one CI status check, and stops.

Two review skills sit beside that loop:

- `/red-team` is for work built against a requirements document. A
  fresh-context agent receives only the spec and the final files, with
  none of the writing session's reasoning, and is told to refute
  conformance rather than confirm it. Findings are verified against the
  code before being reported, and nothing is fixed without a go-ahead.
- `/design-review` is a read-only audit of a whole repository or one
  path in it, across architecture, duplication, performance,
  correctness, data, configuration, tests, and maintainability. Every
  finding cites file and line and is labelled confirmed or suspected.
  The output is a review page with proposed issues, not edits.

## Skills

| Skill | Purpose |
| --- | --- |
| `start-work` | Issue-first entry into a unit of work: find or file, claim, branch from fresh main, state the plan. |
| `ship` | Verify, commit once, push, open the PR from the template, one status check, stop. |
| `red-team` | Fresh-context adversarial conformance review against a requirements document. |
| `design-review` | Staff-level read-only design-debt review with a severity-ranked findings page. |
| `new-project` | Scaffold a repository from templates after agreeing on name, type, visibility, and purpose. |
| `memory-gardener` | Supervised audit of the agent's local session memories: promote durable facts, prune the rest. |

## Design

- **Procedure here, rules elsewhere.** The skills say what steps to
  take. The rules they obey (commit style, review etiquette, tooling
  choices) live in one private file that every session imports, so each
  rule exists in exactly one place and a change there applies to every
  skill at once.
- **The session that wrote the code is never its only reviewer.**
  `red-team` exists because an in-session review carries the
  rationalizations that made a mistake look intentional. A cold read
  with only the spec and the files caught a conformance bug that
  in-session review had signed off on.
- **Stop points, not autonomy.** Issue creation, commits, and pull
  requests each wait for an explicit go-ahead. Review skills report and
  stop; they create nothing.
- **Verification is quoted, not asserted.** The coverage number and the
  CI type-check command are captured and written into the commit and PR,
  so the record shows what was run.

## Layout

```
setup.sh           idempotent installer (symlinks skills and dotfiles)
skills/            one directory per skill, linked into ~/.claude/skills/
dotfiles/
  CLAUDE.md        global CLAUDE.md, linked to ~/.claude/CLAUDE.md
  settings.json    Claude Code settings, linked to ~/.claude/settings.json
```

The symlinks mean an in-place edit under `~/.claude/` shows up as a
reviewable diff here. The `.gitignore` is a whitelist: everything is
ignored unless re-allowed, so nothing lands in the repo by accident.

## Install

```
git clone git@github.com:dardenkyle/claude-skills.git ~/Code/claude-skills
bash ~/Code/claude-skills/setup.sh
```

Re-running is safe: links that already resolve print `ok`, and anything
else found at a destination is moved into a timestamped backup
directory before linking.

Requirements: Claude Code, `gh`, and `jq` (for the status line). The
skills use `gh` directly. `design-review` additionally needs
`lavish-axi` for its review page and `gh-axi` for issue and label
lookups; the SessionStart hooks in `settings.json` register those tools
and `chrome-devtools-axi` when present and are harmless when they are
not. The global `CLAUDE.md` imports three files from a private
companion repo; without it the imports do not resolve and the skills
still work, minus the shared rules.

## Editing

Skills and dotfiles are edited in this repo, reviewed as a diff, and
committed. Cross-project rules are edited in the companion repo, not
here.
