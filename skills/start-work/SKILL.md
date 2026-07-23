---
name: start-work
description: Start a unit of work the issue-driven way - find or file the GitHub issue, claim it, branch from fresh main, state the plan. Use when the user says "start work on X", "/start-work", "pick up issue N", or asks to begin a fix/feature that has no branch yet.
---

# Start Work

Procedure for opening a unit of work. Rules (issue-first workflow, public
repo wording, branch hygiene) live in
`~/Code/claude-context/PREFERENCES.md` and are loaded globally; this skill
encodes procedure, not rules.

## 1. Find or file the issue

- Search existing issues first (`gh issue list --search`), including
  closed ones, to avoid duplicates. If one fits, use it.
- Otherwise draft the issue in the repo's house style (template, label
  taxonomy - one priority, one risk, at least one type label where the
  repo uses that scheme) and present the draft for approval before
  creating it. On public repos, keep wording neutral and professional.
- Create the issue only after approval.

## 2. Claim it

- Assign the issue (`gh issue edit N --add-assignee @me`) or comment that
  it is being picked up, per the repo's convention.

## 3. Branch from fresh main

```
git fetch origin
git switch -c <type>/<issue>-<slug> origin/main
```

- `<type>` matches the issue's type label (feature, bug, docs, ...).
- Never branch from another unmerged branch.

## 4. State the plan

- Summarize scope, acceptance criteria, and out-of-scope notes from the
  issue, plus the intended approach, and confirm before writing code.

## 5. Hand off

- When the work is done and verified, finish via /ship.
