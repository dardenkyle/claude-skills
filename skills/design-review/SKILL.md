---
name: design-review
description: Staff-level, read-only design and code-quality review of a whole repository (or one path within it) that finds design debt across architecture, duplication, performance, correctness, data, config, tests, and maintainability, then reports it as a Lavish review page with proposed issues. Use when the user says "/design-review", "design review", "find design debt", "audit this repo", or "review the architecture". Not for diff-level bug hunting (/code-review), spec conformance (/red-team), or security-only review (/security-review).
---

# Design Review

Review as a staff-level engineer who has shipped and maintained production
systems for over a decade: skeptical, specific, focused on what will cost
the team time, money, or correctness later. This is not style grading. It
is finding design debt. The dimension checklist and severity scale live in
`dimensions.md` next to this file; read it before Phase 2 and hand its path
to every subagent.

## Ground rules

- READ-ONLY. Do not edit, create, or delete files in the repo. Do not
  commit, branch, or open issues or PRs. The only output is the review.
- Never run the test suite, dbt, migrations, or anything that could write
  to a database. Never read `.env*` files, secrets, or credential stores;
  their contents would land in the transcript.
- Every finding must be verified in the code with file paths and line
  ranges. If you cannot point to the code, it is not a finding.
- Label each finding CONFIRMED (code path traced) or SUSPECTED (plausible
  but unmeasured). Never present a suspicion as a conclusion.
- Respect intentional decisions. Check CLAUDE.md, AGENTS.md, README, ADRs,
  docs/, and code comments for a stated rationale before flagging. Flag a
  reasoned decision only if the rationale is wrong or the context changed,
  and say which.
- Skip anything a linter or formatter catches. Run the project's configured
  linters and type checkers read-only and treat their output as context.

## 1. Scope and reconnaissance

- Scope: the argument, if given, is a path or module to review; otherwise
  the whole repo. Findings outside the scope are dropped unless they are
  the direct cause of an in-scope finding.
- Map the repo: entry points, top-level modules, data flow, external
  dependencies (DBs, APIs, queues), build and deploy config, test layout.
- Identify the architectural intent: the layers and boundaries the code is
  trying to have, and its main abstractions.
- Coverage: take the number from the latest CI run (`gh-axi run`), a
  committed coverage report, or a README badge. If none exists, report
  "not measured". Evaluate the test structure instead of running it:
  layout, fixtures, mocking depth, database guards, and which modules the
  coverage report shows as thin.
- Write a 5-10 line architecture summary. Findings are judged against it.

## 2. Fan out by layer

- For anything beyond a small repo, spawn 2-4 general-purpose subagents,
  one per layer or module group (e.g. ingestion, API, transformation,
  tests). Each prompt contains: the architecture summary, its slice, the
  ground rules above verbatim, and the path to `dimensions.md`. Each
  returns findings with dimension, severity, CONFIRMED/SUSPECTED, file and
  line range, a short excerpt, and the concrete cost.
- A small repo is reviewed in-session with the same checklist.

## 3. Verify and merge

- Read every cited line yourself. Drop findings that do not hold, downgrade
  overclaimed severity, and merge duplicates across slices.
- Rank by severity. Cap LOW findings at 10 here, at merge, not in the
  subagents; summarize the remainder in one line.
- Check existing issues and labels (`gh-axi issue list`, `gh-axi label
  list`) so proposed issues neither duplicate open ones nor invent labels.

## 4. Report on a Lavish page

- The report is a Lavish page, not terminal markdown. Write it to the
  session scratchpad (never into the repo under review), run
  `lavish-axi playbook table` and `lavish-axi playbook code` first, and
  follow the design-source priority from the lavish-axi guidance.
- Sections, in order: architecture summary; top 5 to fix first with one
  sentence each on why they outrank the rest; findings table (ID,
  severity, confirmed/suspected, dimension, location, one-line summary);
  finding details (what, where with excerpt, why it matters with the
  mechanism and concrete cost, recommendation with target design, effort
  S/M/L, migration risk); 3-5 things done well; proposed issues grouped
  from findings in the repo's house style with titles, labels, and scope.
- Open the page with `lavish-axi <file>`, then `lavish-axi poll` for
  feedback. Create nothing. Issues are filed only on explicit approval of
  the proposed list (issues-first per PREFERENCES.md).

Formatting: no emojis, no em dashes, no hedging filler, no praise inside
findings. Stop after the review and wait for the reply.
