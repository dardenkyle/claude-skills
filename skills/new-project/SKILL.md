---
name: new-project
description: Scaffold a new repo the standard way - discuss shape first, then git init, type-specific scaffold from templates, first commit, and gh repo create. Use when the user says "/new-project", "new repo", "start a new project", or "scaffold X".
---

# New Project

Procedure for creating a new repository. Rules (commit style, public repo
wording, tooling choices) live in `~/Code/claude-context/PREFERENCES.md`
and are loaded globally; this skill encodes procedure, not rules.

## 1. Discuss shape first

Ask before writing anything:

- **Name** (lowercase, no spaces).
- **Type**: `python-uv` or `node`.
- **Visibility**: public or private (affects wording everywhere; public
  repos are portfolio surfaces).
- **Purpose**: one-paragraph statement of what it is and who it is for.

Then sketch the intended layout and get agreement before scaffolding.

## 2. Initialize

```
mkdir <name> && cd <name>
git init -b main
```

## 3. Scaffold from templates

Templates live in this skill's `templates/` directory.

- `README.md.template` - fill name, purpose, setup, usage.
- `CLAUDE.md.template` - fill overview, commands, conventions, cautions.
- `gitignore-python` or `gitignore-node` - copy to `.gitignore` by type.
- `settings.json.template` - copy to `.claude/settings.json`.
- Type-specific:
  - python-uv: `uv init` (PEP 621 `pyproject.toml`, uv-only, no Poetry);
    add `pytest` with coverage as a dev dependency.
  - node: `npm init -y`, adjust `package.json` fields; commit the
    lockfile once generated.

## 4. First commit

- One commit containing the full scaffold. Message explains what the
  project is and how it was scaffolded.

## 5. Publish

- Confirm visibility one more time, then:
  `gh repo create dardenkyle/<name> --<public|private> --source . --push`
- Report the repo URL.

## 6. Register

- Suggest a PROJECTS.md entry (What / Status / Cautions) for
  `~/Code/claude-context`, and add it on approval.
