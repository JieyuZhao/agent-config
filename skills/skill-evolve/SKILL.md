---
name: skill-evolve
description: Harvest in-session feedback on a specific skill, summarize implied rules, show a diff against the baseline SKILL.md, and land approved changes in the right place (project-local skill override, master skill in the agent-config repo, or user memory). Use when you have been steering a skill through corrections, preferences, or confirmed judgments during a session and want to make those patterns persistent. Explicit invocation only; does not run automatically.
---

# Skill Evolve

## Overview

A meta-skill. It does not do domain work. It observes how the user has been steering another skill during the current session and proposes persistent updates to that skill's SKILL.md or to user memory.

Three kinds of signals count as feedback:

- **Explicit corrections** — "don't do X", "stop doing X", "instead of X do Y", "always X", "never X"
- **Preferences stated in passing** — "I prefer X", "I usually Y", "my style is Z"
- **Validated non-obvious judgments** — the agent made a non-obvious choice and the user accepted it without pushback, especially when they said "yes exactly" or "perfect"

One-off task-specific instructions ("add citations to the intro section") are not feedback — they are the task. Filter those out.

## Three Landing Targets

Each approved rule lands in exactly one place. The user picks per rule.

| Target | Path | When to use |
|---|---|---|
| **Project-local skill override** | `skills/<name>/SKILL.md` in the current project | Rule only makes sense in this project (e.g., only for this NSF proposal's voice) |
| **Master skill** | `~/Documents/Claude/agent-config/skills/<name>/SKILL.md` (or `reference-skills/<name>/`) | Rule generalizes to every project that uses this skill |
| **User memory** | `~/.claude/projects/-Users-veyron-Documents/memory/<name>.md` | Rule is about the user's preferences across any skill (e.g., word-avoidance, formatting defaults, collaboration style) |

Use the memory type `feedback` for guidance about how to work, `user` for identity/role facts, `project` for ongoing work context, `reference` for external-system pointers. See the memory system rules in AGENTS.md-parent / system prompt for the exact structure.

## Workflow

### 1. Identify the Target Skill

Ask the user which skill to evolve, unless the conversation makes it obvious (one skill has been used actively). If it is ambiguous, stop and ask. Do not guess.

### 2. Load the Baseline

Look up the skill's SKILL.md in this order and record which path is the baseline:

1. `skills/<name>/SKILL.md` (project-local override, if any)
2. `.agent-config/repo/skills/<name>/SKILL.md` (bootstrapped shared)
3. `.agent-config/repo/reference-skills/<name>/SKILL.md` (bootstrapped reference)
4. In the `agent-config` source repo itself: `skills/<name>/` or `reference-skills/<name>/`

If a local override already exists at (1), treat it as the live baseline. Changes to master (target 2) will not override a local copy; be explicit about this when offering targets.

### 3. Extract Feedback Signals

Scan the conversation from the start of the session. For each candidate signal, record:

- **Quote** — the user's exact words (verbatim, with a turn marker or rough position)
- **Generalizable rule** — what the signal implies as a persistent rule
- **Evidence strength** — direct correction > stated preference > inferred-from-acceptance

Drop signals that are:

- One-shot task instructions with no generalizable pattern
- Ambiguous or contradicted later in the same session
- Already captured in the current baseline SKILL.md

Do not fabricate rules. If the session did not produce a particular kind of feedback, do not manufacture one. It is fine for the output to be short or even empty.

### 4. Classify Each Signal

For each surviving signal, propose exactly one target:

- **Skill-behavior rule, project-only** → project-local override
- **Skill-behavior rule, general** → master skill
- **User preference, cross-skill** → memory (`feedback` type by default, `user` type if it is identity/role info)

Record your proposed target and one-sentence rationale per signal.

### 5. Draft the Candidate Changes

For each SKILL.md target, produce a **unified diff** against the baseline showing exactly which lines you propose to add, change, or remove. Anchor the change to a specific section of SKILL.md — do not dump everything at the end.

For each memory target, produce the full file contents of the new memory file, following the memory format in the system prompt: frontmatter with `name`, `description`, `type`, and body content.

### 6. Present for Review

Show the user a review table first:

| # | Signal (quote) | Implied rule | Proposed target | Rationale |
|---|---|---|---|---|

Then, for each row, show the actual diff or memory-file content.

Ask per row: **accept / reject / modify / defer**. Do not write anything until the user approves each row individually or approves the whole batch.

### 7. Execute Approved Changes

Once the user has approved a set of rows:

**For project-local SKILL.md overrides:**

- If `skills/<name>/` does not exist in the project, create it and copy the baseline SKILL.md into place first, so the override is a full file.
- Apply the approved diff on top.
- Also create the other required skill files if they are missing (`agents/openai.yaml`, any assets referenced in the SKILL.md). For a thin override, re-export only `SKILL.md`; the rest inherits from the baseline.

**For master skill updates:**

- Edit `SKILL.md` at the master location in `/Users/veyron/Documents/Claude/agent-config/skills/<name>/` or `reference-skills/<name>/`.
- Remind the user that the change must be committed and pushed to `origin/main` before consuming projects will see it on next bootstrap. Do not commit or push automatically; follow the session's Git Safety rule.

**For memory writes:**

- Write to `/Users/veyron/.claude/projects/-Users-veyron-Documents/memory/<file>.md` (filename should match the rule scope, e.g., `feedback_word_avoidance.md`). Do not run `mkdir`; per the system prompt the directory exists.
- Add a one-line pointer in `MEMORY.md` in the same directory.
- Use the memory frontmatter format from the system prompt; include a **Why** line and a **How to apply** line for `feedback` and `project` types.

### 8. Report What Landed Where

Print a compact summary at the end:

- `skills/<name>/SKILL.md` → N lines added / M lines removed
- `~/Documents/Claude/agent-config/skills/<name>/SKILL.md` → N lines changed (reminder: commit + push to propagate)
- `memory/<file>.md` → new rule recorded
- Any rows the user deferred

## Guardrails

- **Never write to `.agent-config/repo/` copies.** Those get overwritten on every bootstrap run.
- **Never overwrite a live SKILL.md without showing the full diff first.** No silent edits.
- **Never fabricate feedback signals.** If the session has only one or two real corrections, the output is one or two proposed changes. Do not pad.
- **Never update shared master SKILL.md files without warning the user that a commit + push to `JieyuZhao/agent-config` is needed.** The agent-config git safety rules forbid auto-commit + auto-push.
- **Never infer cross-project generality from a single project-specific signal.** If a rule only came up once in this project, default to project-local override and ask before promoting to master.
- **Distinguish skill-behavior rules from user preferences.** The same signal can look like either. When in doubt, ask the user which bucket it belongs in.

## Stop and Ask

- Stop if the conversation has no actionable feedback for the target skill. Say so instead of inventing rules.
- Stop if the target skill is ambiguous (multiple skills were active in the session).
- Stop if a proposed memory write would duplicate an existing memory rather than update it — ask whether to merge into the existing file instead.
- Stop if a proposed SKILL.md change would conflict with a recent commit on master that the user has not yet reviewed.

## Output Style

Prefer one of these outcomes:

- A short review table plus 1-3 unified diffs plus 0-2 proposed memory files.
- A clean exit with "no clear feedback found in this session" when the conversation did not produce actionable rules.
- A partial batch where some rows were accepted and some deferred, with the deferred rows listed for later.
