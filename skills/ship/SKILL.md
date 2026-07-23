---
name: ship
description: Take finished work on the current branch through verify, commit, push, and PR, then stop. Use when the user says "ship", "ship it", "/ship", "open a PR for this", or "commit and push this work". Not for starting new work (that is /start-work) and not a substitute for the /no-mistakes validation pipeline.
---

# Ship

Procedure for landing finished work as a pull request. Rules (commit style,
PR etiquette, attribution, review conventions) live in
`~/Code/claude-context/PREFERENCES.md` and are loaded globally; this skill
encodes procedure, not rules.

## 1. Preflight

- Confirm the current branch is not `main`/`master`. If it is, stop and
  offer /start-work instead.
- `git fetch origin`, then confirm the branch's base is up-to-date main:
  `git merge-base HEAD origin/main` should be an ancestor of `origin/main`
  with no unmerged PR branch in between.
- Never proceed on a stacked branch (based on another branch whose PR has
  not merged). If detected, report it and stop.
- Check for uncommitted changes that do not belong to this work; surface
  them before continuing.

## 2. Driving issue

- Identify the GitHub issue this branch implements (branch name, prior
  commits, or `gh issue list`).
- If there is no driving issue, stop and offer /start-work to file and
  claim one. Do not invent an issue silently.

## 3. Verify

- Run the project's test suite with coverage (Python: `uv run pytest
  --cov`; Node: `npm ci` then the repo's test script) and capture the
  total coverage percentage.
- Failing tests block shipping: fix them or report and stop. Fix lint and
  flakiness encountered along the way.

## 4. Commit

- Announce the commit plan, then commit all planned changes at once.
- Subject or trailer carries the issue reference; body explains what, how,
  why and quotes the coverage number. No attribution lines.

## 5. Push and PR

- Push the branch to origin.
- Read `.github/PULL_REQUEST_TEMPLATE.md` and fill every section; put the
  test count and coverage percentage in the verification section; link the
  driving issue (`Closes #N`).
- Open the PR with `gh pr create`, report the URL, and stop. At most one
  CI status check; no polling loops.

## Relationship to /no-mistakes

/no-mistakes is the heavier pipeline (automated code review, lint, docs,
CI gating). Ship does not duplicate it. If the change is risky or the user
asks for full validation, suggest /no-mistakes instead of extending ship.
