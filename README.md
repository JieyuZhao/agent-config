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

The copied block downloads the latest shared `bootstrap.ps1` or `bootstrap.sh`
at runtime. Those scripts refresh the consuming repo's root `AGENTS.md` to
match the shared copy. If a project later needs local overrides, put them in
`AGENTS.local.md`.

## Quick Start Prompt

After pasting the bootstrap block into the project's `AGENTS.md`, tell the agent:

```
阅读 AGENTS.md 并执行其中的 bootstrap 脚本。
```

## Validation

This repo includes zero-dependency validation tests for the bootstrap contract, skill layout, Claude/Codex wrappers, and temp-project smoke tests for the bootstrap flow.

Use any Python 3.12 interpreter to run them locally:

```bash
python -B -m unittest discover -s tests -p "test_*.py" -v
```

GitHub Actions runs the same test suite on Ubuntu and Windows for every push and pull request.

## Override Rules

- Project-local `AGENTS.md` rules override shared defaults.
- Project-local `skills/<name>/SKILL.md` overrides the shared copy of the same skill.

## Codex MCP Integration

Codex can be used from within Claude Code as an MCP server. See [AGENTS.md — Codex MCP Integration](AGENTS.md#codex-mcp-integration) for full setup instructions (registration, Windows path, approval policy, Bitdefender workarounds).

## Shared Skills

| Skill | Description |
|-------|-------------|
| `dual-pass-workflow` | Outer shell for two-pass tasks: first pass builds the artifact, optional second pass audits and reconciles. Works with any domain skill (paper review, bug fix, writing, frontend edit, etc.). |
| `bibref-filler` | Add new external verified citations while keeping curated bibliography files stable, placing machine-added entries in a separate `working.bib`, and leaving visible unresolved notes instead of guessing. |
| `figure-prompt-builder` | Build copy-ready prompts for explanatory figures such as overviews, workflows, mechanisms, timelines, and conceptual illustrations, using a small bundled reference bank when helpful. |
| `implement-review` | Review loop for staged changes. Detects content type, sends to Codex (plugin or MCP) for review using established frameworks (Google/Microsoft for code, NeurIPS/ACL for papers, NSF/NIH for proposals), categorizes feedback, revises, and iterates. |

## Skill Usage

After bootstrap, mention the skill name directly in the prompt. In Claude Code, the matching pointer command under `.claude/commands/` provides the same entry point. Each skill's `SKILL.md` contains full usage instructions and examples.

## Structure

```
AGENTS.md                          # Shared agent config (entry point)
docs/
  claude-code-tips.md              # Workflows and best practices
  claude-code-reference.md         # Keyboard shortcuts, slash commands, vim mode
  claude-code-extras.md            # Buddy/companion, plugins
bootstrap/
  bootstrap.ps1                   # Windows bootstrap logic
  bootstrap.sh                    # Unix bootstrap logic
skills/
  bibref-filler/
    SKILL.md                       # Skill definition
    agents/openai.yaml             # Codex wrapper
    assets/
      working.bib                 # Starter template for machine-added entries
    references/
      citation-rules.md            # Density, placement, and storage guidance
    scripts/
      check_cite_keys.py           # Local cite-key validation helper
  figure-prompt-builder/
    SKILL.md                       # Skill definition
    agents/openai.yaml             # Codex wrapper
    assets/
      reference-bank/              # Portable donor figures bundled with the skill
    references/
      figure-archetypes.md         # Figure-type selection guide
      reference-bank.md            # Curated donor bank index
      prompt-design.md             # Cross-model prompting guidance
      tool-selection.md            # Output-path and tool-choice guidance
      external-handoff.md          # Outside-tool handoff and reprompt guidance
    scripts/
      init_figure_spec.py          # Figure brief scaffold helper
  dual-pass-workflow/
    SKILL.md                       # Skill definition (single source of truth)
    agents/openai.yaml             # Codex wrapper
    references/
      contracts.md                 # Task packet and handoff/audit contracts
      task-mappings.md             # Audit emphasis per task type
    assets/
      workflow.yaml                # Task packet template
      handoff.md, audit.md, reconcile.md  # Workflow note templates
  implement-review/
    SKILL.md                       # Skill definition
    agents/openai.yaml             # Codex wrapper
    references/
      review-lenses.md             # Framework-grounded review criteria (Google, NeurIPS, NSF, NIH)
.claude/commands/
  bibref-filler.md                 # Claude Code pointer to SKILL.md
  figure-prompt-builder.md         # Claude Code pointer to SKILL.md
  dual-pass-workflow.md            # Claude Code pointer to SKILL.md
  implement-review.md              # Claude Code pointer to SKILL.md
.claude/settings.json              # Shared Claude project defaults (effortLevel, permissions, etc.)
```
