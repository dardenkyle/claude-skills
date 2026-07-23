---
name: memory-gardener
description: Audit all local Claude memory dirs, classify every file PROMOTE / DELETE / KEEP / TRIM, and - only after explicit approval - back up, promote durable facts into ~/Code/claude-context, and prune. Use when the user says "/memory-gardener", "clean up your memories", "garden memory", or "promote memories".
---

# Memory Gardener

Supervised maintenance of the two-tier memory system: local per-project
memories (`~/.claude/projects/*/memory/`) are scratch; durable cross-project
facts belong in `~/Code/claude-context` (PREFERENCES.md for rules,
PROJECTS.md for project status, CAREER.md for career context). Rules live in
PREFERENCES.md, loaded globally; this skill encodes procedure, not rules.

Nothing is written, deleted, or committed before step 3's explicit approval.

## 1. Enumerate and classify

- List every file in every `~/.claude/projects/*/memory/` directory.
- Classify each file:
  - **PROMOTE** - durable, cross-project (or durable project status);
    destination is a specific claude-context file and section.
  - **DELETE** - duplicates a rule already promoted, or is stale/wrong.
  - **KEEP** - genuinely project-specific; stays local unchanged.
  - **TRIM** - mixed; keep the project-specific part, drop the promoted
    or stale part.
- Verify staleness where checkable before proposing DELETE: PR/issue
  states via `gh`, file paths still existing, dates.

## 2. Present the table and wait

- Present the full classification as one table (project, file, action,
  reason, destination for promotions).
- Wait for explicit approval. Apply requested adjustments and re-present.
  No writes of any kind before approval.

## 3. Back up

- `mkdir -p ~/.claude/memory-backups` and tar all memory dirs to
  `~/.claude/memory-backups/memory-<YYYYMMDD-HHMMSS>.tar.gz` before
  touching anything.

## 4. Apply

- Promotions: edit the destination files in `~/Code/claude-context`,
  preserving each fact's why, and commit there (message explains what
  moved and from where).
- Deletions and trims: apply to the local memory files.
- Rewrite each touched MEMORY.md index to match its directory's remaining
  files, with a pointer line noting that cross-project rules live in
  `~/Code/claude-context/PREFERENCES.md`.

## 5. Report

- Report counts (promoted / deleted / kept / trimmed), the claude-context
  commit(s), and the backup path with the one-line restore command.
