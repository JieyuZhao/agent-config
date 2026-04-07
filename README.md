# agent-config

Personal shared configuration for Codex and Claude Code. Not intended for general use.

## What This Repo Does

Other project repos bootstrap from this repo to get shared agent defaults and skills. The bootstrap script (defined in `AGENTS.md`) fetches:

- **`AGENTS.md`** — user profile, writing/formatting defaults, environment notes, skill-sharing rules
- **`skills/`** — shared skills (e.g., `dual-pass-workflow`, `bibref-filler`)
- **`.claude/commands/`** — Claude Code pointer commands for shared skills
- **`.claude/settings.json`** — shared Claude project defaults (`effortLevel: high`, permissions, etc.)

## Adding to a Project

Paste the bootstrap block from `AGENTS.md` into the top of your project's `AGENTS.md`. The script will:

1. Download the latest `AGENTS.md` into `.agent-config/`.
2. Sparse-clone `skills/` and the shared `.claude/` files into `.agent-config/repo/`.
3. Copy shared commands into the project's `.claude/commands/` (non-destructive).
4. Merge shared keys into the project's `.claude/settings.json` on every run; project-only keys are preserved.
5. Auto-add `.agent-config/` to the project's `.gitignore`.

## Quick Start

After pasting the bootstrap block into the project's `AGENTS.md`, tell the agent:

```
阅读 AGENTS.md 并执行其中的 bootstrap 脚本。
```

## New Project Workflow

1. Create the project directory and run `git init`
2. Create `AGENTS.md` with the bootstrap block and run bootstrap
3. Copy needed reference skills from `reference-skills/` into the project's `skills/`
4. Run `/latex-setup` if the project contains `.tex` files
5. Add project-local overrides to `AGENTS.local.md` (never edit the root `AGENTS.md` directly — bootstrap overwrites it)

## Shared Skills

| Skill | Description |
|-------|-------------|
| `dual-pass-workflow` | Outer shell for two-pass tasks: first pass builds the artifact, optional second pass audits and reconciles. |
| `bibref-filler` | Add new external verified citations while keeping curated bibliography files stable. |
| `figure-prompt-builder` | Build copy-ready prompts for explanatory figures such as overviews, workflows, and timelines. |
| `implement-review` | Review loop for staged changes. Detects content type, sends to Codex for review, categorizes feedback, revises, and iterates. |
| `ci-mockup-figure` | Build interactive HTML mockups of systems, flowcharts, dashboards, and timelines, then capture as space-efficient figures. |
| `my-router` | Context-aware dispatcher that detects work type and routes to the right domain skill automatically. |

## Reference Skills

Reference skills are domain-specific and must be copied into a project's `skills/` directory before use.

### Proposal Writing

| Skill | Description |
|-------|-------------|
| `nsf-proposal-composer` | Turn proposal ideas into aligned NSF aim-file drafts; bidirectional intro-aim sync. |
| `nsf-thrust-refiner` | Deepen individual thrusts or aims with sharper gaps, literature grounding, and evaluation hooks. |
| `nsf-proposal-guardrail` | Compliance checking: solicitation parsing, requirements baseline, preflight gap check. |
| `nsf-figure-builder` | Figure archetypes and prompt design for NSF proposal figures. |
| `proposal-reviewer` | Content quality review for any sponsor: intent fit, challenge clarity, differentiation, causal chain, scope, evidence posture. |

### Paper Writing and Review

| Skill | Description |
|-------|-------------|
| `cs-paper-review` | Draft grounded peer reviews for CS/ML papers with integrity checks and venue-specific criteria. |
| `cs-meta-review` | Area chair meta-review across venues. |
| `paper-improve` | Paragraph-level writing diagnosis and rewrite with change log. |

### Presentations

| Skill | Description |
|-------|-------------|
| `paper-to-beamer` | Convert a paper to a Beamer slide deck. |
| `deck-assembler` | Build slide decks from source material. |
| `profile-intro-slides` | Build intro/profile presentation slides from personal website and CV. |

### Administrative

| Skill | Description |
|-------|-------------|
| `condense-cv` | Condense an academic CV for specific submission requirements. |
| `usc-reimbursement` | Travel and expense reimbursement workflow. |

## Validation

```bash
python -B -m unittest discover -s tests -p "test_*.py" -v
```

GitHub Actions runs the same test suite on Ubuntu and Windows for every push and pull request.

## Override Rules

- Project-local `AGENTS.md` rules override shared defaults.
- Project-local `skills/<name>/SKILL.md` overrides the shared copy of the same skill.
- Project-local overrides go in `AGENTS.local.md` — bootstrap overwrites the root `AGENTS.md` on every run.

## Structure

```
AGENTS.md                          # Shared agent config (entry point)
assets/
  vscode/
    latex-settings.json            # LaTeX Workshop settings template (copy via /latex-setup)
docs/
  claude-code-tips.md
  claude-code-reference.md
  claude-code-extras.md
bootstrap/
  bootstrap.ps1                    # Windows bootstrap logic
  bootstrap.sh                     # Unix bootstrap logic
skills/
  bibref-filler/
  ci-mockup-figure/
  dual-pass-workflow/
  figure-prompt-builder/
  implement-review/
  my-router/
reference-skills/
  nsf-proposal-composer/
  nsf-thrust-refiner/
  nsf-proposal-guardrail/
  nsf-figure-builder/
  proposal-reviewer/
  cs-paper-review/
  cs-meta-review/
  paper-improve/
  paper-to-beamer/
  deck-assembler/
  profile-intro-slides/
  condense-cv/
  usc-reimbursement/
.claude/commands/                  # Claude Code slash commands
user/
  settings.json                    # User-level permissions and hooks (merged into ~/.claude/settings.json)
```
