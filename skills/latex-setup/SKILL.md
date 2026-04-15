---
name: latex-setup
description: One-time LaTeX project bootstrap. Writes the shared VS Code LaTeX Workshop config into `.vscode/settings.json` and creates the `out/` build directory, so latexmk builds, autoclean, and SyncTeX work consistently across projects. Use when a project contains `.tex` files but has no `.vscode/settings.json` with `latex-workshop` keys, typically at bootstrap stage. Non-destructive: inspects the current state, shows the diff, and asks for confirmation before writing.
---

# LaTeX Setup

## Overview

Standardizes LaTeX Workshop configuration for VS Code across projects. Consumers bootstrap their config from this skill instead of re-deriving the recipe each time.

This skill is narrow on purpose: it only touches `.vscode/settings.json` and creates `out/`. It does not install tooling (latexmk, TeX Live), edit `.tex` sources, or modify bibliography files.

## When to Use

Invoke this skill when **all** of the following are true:

- The project is a LaTeX project (e.g., `main.tex` at root, `.tex` + `.bib` files).
- `.vscode/settings.json` is missing, or it exists but has no `latex-workshop.*` keys.
- The user has not explicitly opted out of VS Code LaTeX Workshop.

The router in `my-router` triggers this skill automatically at session-start when a LaTeX project is detected without configured LaTeX Workshop settings. Users can also invoke it on demand via the `/latex-setup` command or the `latex-setup` skill name.

## Workflow

### 1. Detect Current State

Check these items before changing anything:

1. Is this a LaTeX project? Look for `.tex` files at the project root or in standard locations.
2. Does `.vscode/settings.json` exist?
3. If it exists, does it contain any `latex-workshop.*` keys?

Outcomes:

- Not a LaTeX project → stop. Do not run this skill.
- `.vscode/settings.json` already has `latex-workshop.*` keys → say "LaTeX settings already configured" and stop. Do not overwrite.
- `.vscode/settings.json` exists but has no `latex-workshop.*` keys → go to step 2 and offer to merge the skill's LaTeX keys into the existing file.
- `.vscode/settings.json` does not exist → go to step 2 and offer to create it from the skill asset.

### 2. Show the User What Will Change

Before writing, show the contents that will be added. The source is `assets/latex-settings.json` (relative to this SKILL.md):

- In the agent-config repo itself: `skills/latex-setup/assets/latex-settings.json`.
- In consuming project repos: `.agent-config/repo/skills/latex-setup/assets/latex-settings.json`.

If `.vscode/settings.json` does not exist, show the full asset contents. If it exists without LaTeX Workshop keys, show the keys that will be merged in (all `latex-workshop.*` keys from the asset). Ask for confirmation before proceeding.

### 3. Write the Config

On user confirmation:

- Create `.vscode/` if it does not exist.
- If `.vscode/settings.json` does not exist, copy the asset to `.vscode/settings.json`.
- If `.vscode/settings.json` exists without `latex-workshop.*` keys, merge the asset's keys into the existing JSON. Preserve unrelated keys. Use a JSON-aware merge (Python `json` module is fine).
- Create `out/` at the project root if it does not exist. The config sets `latex-workshop.latex.outDir` to `./out`, so this directory is expected.

### 4. Verify

After writing:

- Confirm `.vscode/settings.json` now contains the `latex-workshop.*` keys.
- Confirm `out/` exists.
- Report what was changed in one or two lines.

## What the Config Provides

The bundled `assets/latex-settings.json` configures LaTeX Workshop with:

- Auto-build on save (can be disabled by switching the commented-out line in the asset).
- `latexmk` as the recipe, with `-pdf`, `-synctex=1`, `-file-line-error`, out-of-source build to `./out`.
- Auto-clean of build artifacts after a successful build.
- PDF preview in a VS Code tab, with SyncTeX.
- BibTeX-backed citation IntelliSense.
- Suppressed Underfull/Overfull log noise.

## Non-Goals

- This skill does not install latexmk, TeX Live, or MacTeX. If `latexmk` is missing, LaTeX Workshop will error on build; direct the user to install it via their OS package manager (`brew install --cask mactex` on macOS, `apt install texlive-full` on Debian/Ubuntu, `scoop install latex` or MiKTeX on Windows).
- This skill does not edit `.tex` sources, `.bib` files, or `out/` contents.
- This skill does not push to a remote or commit changes.

## Output Style

Prefer one of these outcomes:

- A single write to `.vscode/settings.json` plus a created `out/`, with a one-line confirmation.
- A no-op with "LaTeX settings already configured".
- A clean exit with a note if the project is not a LaTeX project.
