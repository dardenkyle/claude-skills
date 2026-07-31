---
name: red-team
description: Adversarial fresh-context conformance review - a separate agent gets only the requirements doc and the final files and tries to refute conformance. Use when the user says "/red-team", "red team this", "adversarial review", "check this against the spec", or before submitting/shipping work built against a requirements document.
---

# Red Team

The session that wrote the code must never be its only reviewer: it
carries the rationalizations that made its mistakes look intentional.
This skill runs a cold read - a fresh-context agent that sees only the
requirements document and the deliverable files, prompted to refute
conformance rather than confirm it. Origin: a copy-and-swap that
silently violated a "once created, only operates as that type" spec
sentence, survived in-session review, and was caught only by an
external cold read.

## 1. Identify inputs

- Requirements doc: the argument if one was given; otherwise look for
  assignment.md, spec.md, requirements.md, or a requirements section
  in README.md. If ambiguous, ask which doc governs.
- Deliverable files: the final artifacts the doc governs (source,
  docs, packaging). List them explicitly before launching.

## 2. Launch the reviewer

- Spawn a general-purpose subagent. Its prompt contains ONLY: the
  requirements doc text, the deliverable file paths to read, and the
  instructions below. Never include this session's design rationale,
  decisions, or justifications - a cold read is the entire point.
- Reviewer instructions to include verbatim:
  - Extract every normative sentence from the requirements doc
    (must, only, always, never, shall, required, plus numeric limits
    and mandated names/signatures/behaviors).
  - For each sentence, attempt to REFUTE conformance: find inputs,
    states, or call sequences where the implementation does what the
    sentence forbids, or omits what it requires. Check every code
    path that could touch the constraint, not just the obvious one.
  - Also flag implemented behavior that no sentence authorizes
    (undocumented rejection rules, extra interfaces, semantic
    extras), and tests that assert behavior no sentence backs.
  - Report per finding: the spec sentence verbatim, file and line,
    a concrete failure scenario, and a severity.
  - Report the sentences that traced clean as a coverage list.
    "No findings" is acceptable only with the full trace shown.

## 3. Verify before reporting

- Independently confirm each finding against the code: read the
  cited lines; reproduce the scenario with a quick build or test
  where cheap. Label each finding CONFIRMED or dropped-on-verify.
  Never forward the reviewer's claims unchecked.

## 4. Report and stop

- Findings ranked by severity: spec sentence, location, scenario,
  suggested fix direction. Include the clean coverage list so the
  user can see what was actually traced.
- Fix nothing. Findings become issues or fixes only on explicit
  go-ahead (issues-first per PREFERENCES.md).
