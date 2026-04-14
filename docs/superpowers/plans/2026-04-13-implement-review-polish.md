# implement-review Skill Polish Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Sharpen the Phase 1 prompt contract, add three new focused sub-lenses (`website`, `plan`, `skill`) plus a multi-target structural note, and seed four lightly anonymized real-review exemplars so future Codex reviews are more at-point and comprehensive.

**Architecture:** Three targeted edits to `skills/implement-review/SKILL.md` (Phase 1b items 4 and 6, Phase 1c save instruction). Four additions to `skills/implement-review/references/review-lenses.md` (three new sub-lens subsections plus one multi-target note). New directory `skills/implement-review/references/example-reviews/` with four exemplar Markdown files drawn from real `CodexReview.md` artifacts across `<nsf-proposal-project>`, `pyod`, `<writing-project>/papers/<paper-A>`, and `<writing-project>/papers/<paper-B>`.

**Tech Stack:** Markdown only. No runtime tests — acceptance checks use `grep` and file-existence verification.

**Execution shell:** Bash or Git Bash is required. Acceptance checks use `grep`, `test`, `wc`, shell globs, and `for ...; do ...` loops, which are not PowerShell-compatible as written. On this machine Git Bash is available at `C:\Program Files\Git\bin\bash.exe` (verified by running the Task 13 checks there during Codex Round 2 and Round 3).

**Git safety:** Every commit step pauses for explicit user approval per the user's AGENTS.md rule. Do not auto-commit. Commits are grouped into three logical units (one per section) rather than one-per-task, since atomic per-task commits would create excessive noise for docs-only edits.

**Design reference:** `docs/superpowers/specs/2026-04-13-implement-review-polish-design.md`

---

## Section A — SKILL.md Phase 1 prompt contract changes

Implements spec section 1. Single commit at the end of Task 4.

### Task 1: Rewrite Phase 1b item 4 (Additional focus)

**Files:**
- Modify: `skills/implement-review/SKILL.md` (around line 69, the Phase 1b item 4 paragraph)

- [ ] **Step 1: Verify current state exists**

Run: `grep -n 'watch for equity-related terminology drift' skills/implement-review/SKILL.md`
Expected: one match in the current item 4 paragraph.

- [ ] **Step 2: Verify new text is not yet present**

Run: `grep -n 'Always ask the user explicitly' skills/implement-review/SKILL.md`
Expected: no matches.

- [ ] **Step 3: Apply the Edit**

Use the Edit tool on `skills/implement-review/SKILL.md`.

`old_string`:
```
4. **Additional focus** -- specific concerns beyond the generic lens. This is often the highest-value part of the prompt because it catches real bugs that generic criteria miss. Examples: "check that all appendix URLs are anonymized", "verify Year 3 budget matches the narrative", "watch for equity-related terminology drift." Ask the user if they have a specific focus, or propose one based on the nature of the change.
```

`new_string`:
```
4. **Additional focus** -- specific concerns beyond the generic lens. This is often the highest-value part of the prompt because it catches real bugs that generic criteria miss. **Always ask the user explicitly rather than guessing.** Recurring project concerns belong here: phased-development coupling, anonymization checks, page-limit compliance, budget-to-narrative consistency, terminology drift, benchmark-claim calibration, overclaim flagging. If there are no project-specific concerns this round, write "none" rather than padding the line. Examples: "check that all appendix URLs are anonymized", "verify Year 3 budget matches the narrative", "flag any overclaim in intro / conclusion", "watch for Phase 1 / Phase 2 coupling issues".
```

- [ ] **Step 4: Verify new text landed**

Run: `grep -n 'Always ask the user explicitly' skills/implement-review/SKILL.md`
Expected: one match.

- [ ] **Step 5: Verify old-only text is gone**

Run: `grep -n 'watch for equity-related terminology drift' skills/implement-review/SKILL.md`
Expected: no matches.

### Task 2: Insert Phase 1b new item 6 (Variant targets), renumber Round history to item 7

**Files:**
- Modify: `skills/implement-review/SKILL.md` (around line 70, between the item 5 line and the item 6 (Round history) paragraph)

- [ ] **Step 1: Verify the transition point exists**

Run: `grep -n '5. \*\*Round number\*\*' skills/implement-review/SKILL.md`
Expected: one match.

Run: `grep -n '6. \*\*Round history\*\*' skills/implement-review/SKILL.md`
Expected: one match.

- [ ] **Step 2: Verify new item is not yet present**

Run: `grep -n 'Variant targets (multi-target reviews)' skills/implement-review/SKILL.md`
Expected: no matches.

- [ ] **Step 3: Apply the Edit**

Use the Edit tool on `skills/implement-review/SKILL.md`.

`old_string`:
```
5. **Round number** -- which iteration this is (starting at 1).
6. **Round history** (rounds 2+ only) -- a one-line-per-finding summary of what prior rounds raised and how each was resolved. Tag each finding as `Resolved`, `Still open`, or `Deferred`. This prevents Codex from re-litigating closed decisions and lets it verify that fixes landed instead of re-reviewing from scratch. Example:
```

`new_string`:
```
5. **Round number** -- which iteration this is (starting at 1).
6. **Variant targets (multi-target reviews)** -- if the staged files cover two or more variant targets that should be reviewed separately (long + short paper version, narrative + appendix tracker, internal + external report, primary + supplement), list each target by directory or file pattern. Tell Codex to review each target in its own top-level section and then add a cross-variant drift check at the end (tables that should match, claims that should be consistent, terminology that should align).
7. **Round history** (rounds 2+ only) -- a one-line-per-finding summary of what prior rounds raised and how each was resolved. Tag each finding as `Resolved`, `Still open`, or `Deferred`. This prevents Codex from re-litigating closed decisions and lets it verify that fixes landed instead of re-reviewing from scratch. Example:
```

- [ ] **Step 4: Verify new item landed and round history was renumbered**

Run: `grep -n 'Variant targets (multi-target reviews)' skills/implement-review/SKILL.md`
Expected: one match.

Run: `grep -n '7. \*\*Round history\*\*' skills/implement-review/SKILL.md`
Expected: one match.

Run: `grep -n '6. \*\*Round history\*\*' skills/implement-review/SKILL.md`
Expected: no matches.

### Task 3: Extend Phase 1c full save instruction

**Files:**
- Modify: `skills/implement-review/SKILL.md` (around line 83, the `> IMPORTANT: Save your complete review...` blockquote)

- [ ] **Step 1: Verify current save instruction exists**

Run: `grep -n 'Save your complete review to' skills/implement-review/SKILL.md`
Expected: at least two matches (one in the full Phase 1c instruction blockquote, one inside the abbreviated fenced prompt).

- [ ] **Step 2: Verify "Verification notes" is not yet in the full save instruction**

Run: `grep -n 'Verification notes' skills/implement-review/SKILL.md`
Expected: no matches.

- [ ] **Step 3: Apply the Edit to the full save instruction blockquote**

Use the Edit tool on `skills/implement-review/SKILL.md`.

`old_string`:
```
> IMPORTANT: Save your complete review to `CodexReview.md` in the repository root. Overwrite any existing content. Use plain Markdown. Start the file with a `<!-- Round N -->` comment (matching the round number below) so the reader can verify freshness. Separate findings into **New** (raised for the first time) and **Previously raised** (with status: Fixed, Still open, Reopened, or Deferred) sections. On Round 1, the Previously raised section may be omitted or shown as "None." Then include the file/diff scope, review lens, findings in priority order, and concrete recommended changes. Do not skip this step.
```

`new_string`:
```
> IMPORTANT: Save your complete review to `CodexReview.md` in the repository root. Overwrite any existing content. Use plain Markdown. Start the file with a `<!-- Round N -->` comment (matching the round number below) so the reader can verify freshness. **Begin the review with a short "Verification notes" paragraph (or "Validation notes" — either name accepted) stating exactly what was compiled, run, or verified (e.g., `latexmk built cleanly`, `pytest pyod/test/... 5 passed`, `checked citation X against arXiv:YYYY`). If nothing was verified at runtime, write "Verification notes: none."** Separate findings into **New** (raised for the first time) and **Previously raised** (with status: Fixed, Still open, Reopened, or Deferred) sections. On Round 1, the Previously raised section may be omitted or shown as "None." Then include the file/diff scope, review lens, findings in priority order, and concrete recommended changes. **For any finding flagged High priority, include an exact suggested rewrite with file path and line range. Use a fenced code block for multi-line rewrites.** Do not skip this step. **For examples of the expected depth and format, see `skills/implement-review/references/example-reviews/`.**
```

- [ ] **Step 4: Verify new contract elements landed**

Run: `grep -n 'Verification notes' skills/implement-review/SKILL.md`
Expected: at least one match in the full save instruction blockquote.

Run: `grep -n 'High priority, include an exact suggested rewrite' skills/implement-review/SKILL.md`
Expected: one match.

Run: `grep -n 'references/example-reviews' skills/implement-review/SKILL.md`
Expected: at least one match.

### Task 4: Extend the abbreviated terminal-path save instruction

**Files:**
- Modify: `skills/implement-review/SKILL.md` (around line 88, inside the fenced `````` block that Claude Code emits for copy-paste)

- [ ] **Step 1: Verify current abbreviated instruction exists**

Run: `grep -n 'Save your complete review to CodexReview.md in the repository root. Overwrite any existing content. Start with' skills/implement-review/SKILL.md`
Expected: one match inside the fenced prompt block.

- [ ] **Step 2: Apply the Edit**

Use the Edit tool on `skills/implement-review/SKILL.md`.

`old_string`:
```
IMPORTANT: Save your complete review to CodexReview.md in the repository root. Overwrite any existing content. Start with <!-- Round N -->. Include file/diff scope and review lens. Separate findings into New and Previously raised (Fixed / Still open / Reopened / Deferred) sections. Include concrete recommended changes.
```

`new_string`:
```
IMPORTANT: Save your complete review to CodexReview.md in the repository root. Overwrite any existing content. Start with <!-- Round N -->. Begin with a "Verification notes" paragraph (what was compiled, run, or verified; "none" if nothing). Include file/diff scope and review lens. Separate findings into New and Previously raised (Fixed / Still open / Reopened / Deferred) sections. For High-priority findings, include an exact rewrite with file:line. See skills/implement-review/references/example-reviews/ for expected depth.
```

- [ ] **Step 3: Verify abbreviated contract landed**

Run: `grep -c 'Verification notes' skills/implement-review/SKILL.md`
Expected: at least 2 (full save instruction + abbreviated version).

Run: `grep -c 'For High-priority findings, include an exact rewrite' skills/implement-review/SKILL.md`
Expected: 1.

### Commit for Section A

- [ ] **Stage and confirm with user**

Show the user the diff of `skills/implement-review/SKILL.md`. Ask explicit permission to commit. Do not skip this confirmation per git safety rule.

Run: `git diff skills/implement-review/SKILL.md`

Once user approves, run:

```bash
git add skills/implement-review/SKILL.md
git commit -m "implement-review: sharpen Phase 1 prompt contract

- Phase 1b item 4 (Additional focus): promote to high-leverage field, demand explicit user answer, expand recurring-concern examples.
- Phase 1b new item 6 (Variant targets): handle multi-target reviews (long + short, narrative + tracker). Round history moves to item 7.
- Phase 1c save instruction: require Verification notes at top; require exact rewrites with file:line for High-priority findings; point Codex at new example-reviews/ directory."
```

---

## Section B — review-lenses.md additions

Implements spec section 2. Single commit at the end of Task 8.

### Task 5: Add `website` sub-lens

**Files:**
- Modify: `skills/implement-review/references/review-lenses.md` (Focused sub-lenses table + new `### Website` subsection)

- [ ] **Step 1: Verify current focused-sub-lenses table exists and does not yet include `website`**

Run: `grep -n '| \`website\`' skills/implement-review/references/review-lenses.md`
Expected: no matches.

Run: `grep -n '| \`paper/submission-ready\`' skills/implement-review/references/review-lenses.md`
Expected: one match (this is the line above the insertion point).

- [ ] **Step 2: Add the table row**

Use the Edit tool on `skills/implement-review/references/review-lenses.md`.

`old_string`:
```
| `proposal/compliance` | Proposal | Common items 1, 6 (alignment with call, formatting) | Formatting and solicitation compliance checks |
```

`new_string`:
```
| `proposal/compliance` | Proposal | Common items 1, 6 (alignment with call, formatting) | Formatting and solicitation compliance checks |
| `website` | General | items 1-5 in the Website subsection | Static sites, personal sites, documentation sites, landing pages |
```

- [ ] **Step 3: Add the `### Website` subsection**

Find a stable anchor line ("When using a focused sub-lens, include only..." is the sentence immediately after the table). Use the Edit tool.

`old_string`:
```
When using a focused sub-lens, include only the referenced parent criteria in the review prompt, not the full lens. For `paper/submission-ready`, also add: verify no author-identifying information remains and confirm the paper meets venue page limits.
```

`new_string`:
```
When using a focused sub-lens, include only the referenced parent criteria in the review prompt, not the full lens. For `paper/submission-ready`, also add: verify no author-identifying information remains and confirm the paper meets venue page limits.

### Website

Criteria for the `website` focused sub-lens. Parent: General.

1. **Version and metadata consistency** -- JSON-LD `softwareVersion`, meta tags, footer versions, and similar markers match the underlying source of truth (repo, release notes, upstream README).
2. **Factual accuracy of external claims** -- download counts, credits, citations, affiliated institutions, publication lists. Verify against upstream sources when possible.
3. **Structured data consistency** -- JSON-LD, OpenGraph, and Twitter card metadata consistent with visible page content (no mismatched titles, descriptions, or version strings).
4. **Asset correctness** -- images have the right dimensions for their use (social cards at 1200x630, avatars square-cropped), alt text present, no broken links.
5. **Regression against prior review rounds** -- do not flag earlier-round fixes as new issues; explicitly note prior findings still in force.

When to use: static sites, personal sites, documentation sites, landing pages.
```

- [ ] **Step 4: Verify insertion landed**

Run: `grep -n '| \`website\`' skills/implement-review/references/review-lenses.md`
Expected: one match.

Run: `grep -n '^### Website$' skills/implement-review/references/review-lenses.md`
Expected: one match.

### Task 6: Add `plan` sub-lens

**Files:**
- Modify: `skills/implement-review/references/review-lenses.md` (extend the table and add a new `### Plan` subsection)

- [ ] **Step 1: Verify `plan` is not yet in the table**

Run: `grep -n '| \`plan\`' skills/implement-review/references/review-lenses.md`
Expected: no matches.

- [ ] **Step 2: Add the table row**

Use the Edit tool.

`old_string`:
```
| `website` | General | items 1-5 in the Website subsection | Static sites, personal sites, documentation sites, landing pages |
```

`new_string`:
```
| `website` | General | items 1-5 in the Website subsection | Static sites, personal sites, documentation sites, landing pages |
| `plan` | General | items 1-6 in the Plan subsection | Methodology docs, roadmaps, research backlogs, migration plans, phased-development design docs, superpowers-style spec docs |
```

- [ ] **Step 3: Add the `### Plan` subsection**

Use the Edit tool.

`old_string`:
```
When to use: static sites, personal sites, documentation sites, landing pages.
```

`new_string`:
```
When to use: static sites, personal sites, documentation sites, landing pages.

### Plan

Criteria for the `plan` focused sub-lens. Parent: General.

1. **Completeness** -- does the plan cover the steps it claims to? Are there missing preconditions, hand-offs, or post-conditions?
2. **Feasibility** -- is the timeline realistic given scope and dependencies? Are external dependencies and blockers named?
3. **Internal consistency** -- do sections presuppose things other sections assume? Do the "what" and the "how" match?
4. **Alignment with implementation** -- if the plan describes code, config, or content that already exists, does the description match what is actually there?
5. **Risk surfacing** -- are known failure modes named, and are mitigations proposed or explicitly deferred?
6. **Acceptance criteria** -- can "done" be checked objectively? Are success metrics or verification steps stated?

When to use: methodology docs, research backlogs, roadmaps, migration plans, phased-development design docs, superpowers-style design specs (`docs/superpowers/specs/*.md`).
```

- [ ] **Step 4: Verify insertion landed**

Run: `grep -n '| \`plan\`' skills/implement-review/references/review-lenses.md`
Expected: one match.

Run: `grep -n '^### Plan$' skills/implement-review/references/review-lenses.md`
Expected: one match.

### Task 7: Add `skill` (meta) sub-lens

**Files:**
- Modify: `skills/implement-review/references/review-lenses.md`

- [ ] **Step 1: Verify `skill` lens is not yet in the table**

Run: `grep -n '| \`skill\` |' skills/implement-review/references/review-lenses.md`
Expected: no matches.

- [ ] **Step 2: Add the table row**

Use the Edit tool.

`old_string`:
```
| `plan` | General | items 1-6 in the Plan subsection | Methodology docs, roadmaps, research backlogs, migration plans, phased-development design docs, superpowers-style spec docs |
```

`new_string`:
```
| `plan` | General | items 1-6 in the Plan subsection | Methodology docs, roadmaps, research backlogs, migration plans, phased-development design docs, superpowers-style spec docs |
| `skill` | General | items 1-6 in the Skill subsection | Editing `SKILL.md` files, adding references/scripts to a skill, meta-skill work |
```

- [ ] **Step 3: Add the `### Skill` subsection**

Use the Edit tool.

`old_string`:
```
When to use: methodology docs, research backlogs, roadmaps, migration plans, phased-development design docs, superpowers-style design specs (`docs/superpowers/specs/*.md`).
```

`new_string`:
```
When to use: methodology docs, research backlogs, roadmaps, migration plans, phased-development design docs, superpowers-style design specs (`docs/superpowers/specs/*.md`).

### Skill

Criteria for the `skill` focused sub-lens. Parent: General. Meta-lens for editing skill definitions.

1. **Frontmatter accuracy** -- does the `description` field match the actual behavior? Would a routing layer pick the right tasks to invoke it?
2. **Instruction clarity** -- can a cold reader (human or agent) follow the skill without additional context?
3. **Edge-case coverage** -- what happens when a required precondition is missing? What happens on failure at each phase?
4. **Contract consistency** -- do all sections use the same terminology and data shapes? Does the save/output contract match the intake/parsing contract?
5. **Invocation guarantees** -- are inputs, outputs, and side effects declared at the top? Are dependencies on other skills or external tools named?
6. **Integration** -- how does this skill interact with other skills, hooks, or the broader workflow? Are hand-off points clear?

When to use: editing SKILL.md files, adding references/scripts to a skill, meta-skill work (e.g., polishing the `implement-review` skill itself).
```

- [ ] **Step 4: Verify insertion landed**

Run: `grep -n '| \`skill\` |' skills/implement-review/references/review-lenses.md`
Expected: one match.

Run: `grep -n '^### Skill$' skills/implement-review/references/review-lenses.md`
Expected: one match.

### Task 8: Add multi-target review structural note

**Files:**
- Modify: `skills/implement-review/references/review-lenses.md`

- [ ] **Step 1: Verify the note is not yet present**

Run: `grep -n 'Multi-target reviews' skills/implement-review/references/review-lenses.md`
Expected: no matches.

- [ ] **Step 2: Find the anchor line**

The note should go at the end of the "Focused Sub-Lenses and Agency-Specific Lenses" section, just before the `## General` section header.

Run: `grep -n '^## General$' skills/implement-review/references/review-lenses.md`
Expected: one match (used as insertion anchor).

- [ ] **Step 3: Apply the Edit**

Use the Edit tool.

`old_string`:
```
When using an agency-specific lens, include the full agency framework from the Proposal section above (NSF or NIH subsection). Always also include the Common proposal dimensions (alignment with call, feasibility, significance, budget, clarity, formatting), as these apply regardless of agency.

## General
```

`new_string`:
```
When using an agency-specific lens, include the full agency framework from the Proposal section above (NSF or NIH subsection). Always also include the Common proposal dimensions (alignment with call, feasibility, significance, budget, clarity, formatting), as these apply regardless of agency.

### Multi-target reviews

When the staged diff contains two or more variant targets that should be reviewed separately (long + short paper version, narrative + tracker, internal + external report, primary + supplement), structure the review with one top-level section per target plus a cross-variant drift check at the end. Treat each target as a self-contained sub-review -- its own scope line, findings, and recommendations -- then add a final "Cross-variant drift" section that flags tables, claims, terminology, or numbers that should be consistent across targets but are not.

## General
```

- [ ] **Step 4: Verify the note landed**

Run: `grep -n 'Multi-target reviews' skills/implement-review/references/review-lenses.md`
Expected: one match.

Run: `grep -n 'Cross-variant drift' skills/implement-review/references/review-lenses.md`
Expected: one match.

### Commit for Section B

- [ ] **Stage and confirm with user**

Show the user the diff. Ask explicit permission to commit.

Run: `git diff skills/implement-review/references/review-lenses.md`

Once user approves:

```bash
git add skills/implement-review/references/review-lenses.md
git commit -m "implement-review: add website, plan, skill sub-lenses plus multi-target note

- website: static sites, personal sites, documentation sites (5 criteria).
- plan: methodology docs, roadmaps, research backlogs, phased-dev design docs, superpowers-style specs (6 criteria).
- skill: meta-lens for editing SKILL.md files (6 criteria).
- Multi-target reviews: structural note for reviewing two or more variants with a cross-variant drift check."
```

---

## Section C — example-reviews exemplars

Implements spec section 3. Single commit at the end of Task 12.

All four exemplars are drawn from real `CodexReview.md` files in the user's sibling project repos (dated 2026-04-13). Light anonymization per the rules in each task.

### Task 9: Create example-reviews directory and example-proposal-nsf.md

**Files:**
- Create: `skills/implement-review/references/example-reviews/example-proposal-nsf.md`

- [ ] **Step 1: Verify directory does not yet exist**

Run: `ls skills/implement-review/references/example-reviews/ 2>&1 || echo 'directory does not exist'`
Expected: "directory does not exist" or an empty listing.

- [ ] **Step 2: Create directory**

Run: `mkdir -p skills/implement-review/references/example-reviews`

- [ ] **Step 3: Write the exemplar file**

Source: `<nsf-proposal-project>/CodexReview.md` Round 2 (as captured on 2026-04-13).

Anonymization rules applied:
- `CIS251004` → `<ALLOC_A>`
- `CIS250073` → `<ALLOC_B>`
- `500k` → `$X00k`
- `600k` → `$Y00k`
- `nsf-access-supplement-2026` → `<project>`
- `template/context/team/zhao-yue/` → `template/context/team/<pi>/`
- `NSF-ACCESS` kept (public program name)
- `AAAI`, `ACL 2026` kept (public venues)
- "Validation notes" renamed to "Verification notes" to model the preferred name

Use the Write tool to create `skills/implement-review/references/example-reviews/example-proposal-nsf.md` with the exact content below:

```markdown
<!-- Round 2 -->

# Review

Verification notes: I reviewed the staged diff, rechecked the original NSF-ACCESS proposal task/budget language in `examples/proposals/NSF-ACCESS/<previous-proposal>.zip` (`main.tex` lines 86, 105-112, 131-134, 179-188), and compiled `progress_report.tex` locally. The LaTeX source compiles cleanly on the second pass to a 2-page letter PDF with no overfull/underfull or undefined-reference warnings after rerun.

File/diff scope: staged changes from `git diff --cached` for `proposals/registry.yaml`, `proposals/<project>/README.md`, `proposals/<project>/reason.txt`, `proposals/<project>/progress_report.tex`, `proposals/<project>/progress_report.pdf`, and `template/context/team/<pi>/nsf-access-acknowledgements.md`.

Review lens: `proposal/nsf` plus common proposal dimensions, with extra focus on ACCESS Progress Report / Supplement expectations, remaining-month feasibility, Table 2 to narrative consistency, skim clarity, and formatting compliance.

## New

None.

## Previously raised

### Fixed

1. T3 mislabeled as the largest compute line. This is fixed. `proposals/<project>/progress_report.tex:122-127`, `proposals/<project>/progress_report.tex:143-145`, and `proposals/<project>/reason.txt:16-18` now describe T3 as the largest unfinished workstream rather than the largest original budget line, and Table 2 has been rebalanced to keep T3 at $X00k while shifting T2 to $Y00k at `proposals/<project>/progress_report.tex:158-178`.

2. Burn-rate mismatch unexplained. This is fixed. `proposals/<project>/progress_report.tex:75-85` now gives two concrete causes, expanded open-weight model coverage and less favorable Delta exchange rates, and the short form carries the same explanation at `proposals/<project>/reason.txt:4-10`. For an ACCESS reviewer, this now reads as a real utilization explanation rather than an empty claim of "used everything."

3. Tracker acknowledgement text baked in both allocations verbatim. This is fixed. `template/context/team/<pi>/nsf-access-acknowledgements.md:21-54` is now a real template with an explicit "insert only the allocations actually used" instruction, plus one-allocation and two-allocation examples. That rewrite materially lowers the chance of future over-claiming.

### Still open

1. The publication-evidence issue is improved but not fully closed, because the README still overstates the AAAI paper's acknowledgement status and now contradicts the tracker's own stricter rule. `proposals/<project>/README.md:23` tells the user to add three papers that "acknowledge <ALLOC_A> compute," including the AAAI paper. But the tracker says the AAAI paper published with stale `<ALLOC_B>` boilerplate at `template/context/team/<pi>/nsf-access-acknowledgements.md:82-91`, and its process rule says ACCESS reports should list only papers that cite the target allocation in the camera-ready at `template/context/team/<pi>/nsf-access-acknowledgements.md:129-131`. This is now the only material inconsistency left in the submission instructions.

   Recommended change: revise the README publications step so it matches the tracker exactly. Two clean options:
   - If the ACCESS form should list only papers whose published camera-ready cites `<ALLOC_A>`, tell the user to list only the two ACL 2026 papers and keep the AAAI paper only in the attached progress report with the stale-boilerplate caveat.
   - If the ACCESS form allows papers that used `<ALLOC_A>` compute even when the published acknowledgement is stale, say that explicitly: two papers cite `<ALLOC_A>` directly, while the AAAI paper used `<ALLOC_A>` compute but published with stale `<ALLOC_B>` boilerplate.

### Deferred

None.

### Reopened

None.

## Additional notes

The burn-rate explanation is now concrete and credible. Section 5 and Table 2 are internally consistent after the T2/T3 rebalance. The `reason.txt` caveat reads honest rather than hedged.

There is now page headroom if you want to add one more sentence, but I would spend it only on clarifying the README/publications rule above, not on expanding the narrative elsewhere.
```

- [ ] **Step 4: Verify file landed with required markers**

Run: `test -f skills/implement-review/references/example-reviews/example-proposal-nsf.md && echo OK`
Expected: `OK`.

Run: `grep -c 'Verification notes' skills/implement-review/references/example-reviews/example-proposal-nsf.md`
Expected: 1.

Run: `grep -c '<!-- Round 2 -->' skills/implement-review/references/example-reviews/example-proposal-nsf.md`
Expected: 1.

Run: `grep -c 'CIS251004\|CIS250073\|nsf-access-supplement-2026\|zhao-yue' skills/implement-review/references/example-reviews/example-proposal-nsf.md`
Expected: 0 (anonymization complete).

### Task 10: Create example-code-phased.md

**Files:**
- Create: `skills/implement-review/references/example-reviews/example-code-phased.md`

Source: `pyod/CodexReview.md` Round 1 (as captured on 2026-04-13).

Anonymization rules:
- PyOD is a public library; keep detector names, API names, file structure.
- `C:/Users/yuezh/PycharmProjects/pyod/` → `pyod/` (repo-relative).
- `C:\Users\yuezh\miniforge3\envs\py312\python.exe` → `python`.

- [ ] **Step 1: Verify file does not exist**

Run: `test -f skills/implement-review/references/example-reviews/example-code-phased.md && echo EXISTS || echo MISSING`
Expected: `MISSING`.

- [ ] **Step 2: Write the exemplar**

Use the Write tool to create `skills/implement-review/references/example-reviews/example-code-phased.md`:

```markdown
<!-- Round 1 -->

# Review

**Verification notes**

- `python -m pytest pyod/test/test_regen_skill.py pyod/test/test_skill_kb_consistency.py -q` passed.
- `python -m pytest pyod/test/test_cli.py -q` failed only at `pyod/test/test_cli.py:352`.
- `docutils.core.publish_doctree(...)` on `docs/skill_maintenance.rst` succeeded.

**File / Diff Scope**

`git diff --cached` over the 10 staged Phase 1 files for the v3.2.0 od-expert deep-skill work: installer/package-data changes, `scripts/regen_skill.py`, the new KB-consistency and regen tests, the methodology doc, the research/backlog docs, and the docs toctree update.

**Review Lens**

`code` with an Additional focus on Phase 1 versus Phase 2 coupling: design, functionality, error handling, test strength, and consistency between `docs/skill_maintenance.rst` and the actual generator/test implementation. I also spot-checked RST parsing for the new methodology doc.

**New**

1. **High — Phase 1 stages a knowingly failing test, so the diff is not green on its own.** `pyod/test/test_cli.py:352` now asserts that `pyod install skill` copies `references/workflow.md`, but the packaged skill tree does not contain any `references/` directory yet. I verified the current Phase 1 state: `pyod/test/test_regen_skill.py` and `pyod/test/test_skill_kb_consistency.py` both pass, while `pytest pyod/test/test_cli.py -q` fails only at this new test. That makes the Phase 1 commit red until Phase 2 content lands.

   Recommended change: either move this test into the Phase 2 content commit, or mark it `skip`/`xfail` until `pyod/skills/od_expert/references/` exists, or ship placeholder reference files in the same phase. The tree-aware installer change in `pyod/skills/__init__.py:133` can stay; only the Phase 2 expectation needs deferral.

2. **Medium — KB-consistency allowlist exempts real detector names, weakening the rename/staleness guard.** In `_BACKTICK_ALLOWLIST` at `pyod/test/test_skill_kb_consistency.py:29`, `EmbeddingOD`, `MultiModalOD`, `PCA`, and `TimeSeriesOD` are all allowlisted even though they are live keys in `ADEngine().kb.algorithms`. If any of those detectors are renamed or removed later, stale backtick references to them will keep passing the safety-net test.

   Recommended change: remove any allowlist entry that is also a live KB detector key, and add a small regression assertion that `_BACKTICK_ALLOWLIST` has empty intersection with `ADEngine().kb.algorithms`.

3. **Medium — `_render_detector_list()` does not normalize KB metadata before formatting, so generated markdown will contain raw Python dict reprs.** `scripts/regen_skill.py:64` reads `complexity` and `scripts/regen_skill.py:68` reads `paper`, but those fields are dicts in the live KB, so the current output becomes strings like `complexity: {'time': ...}` and `paper: {'id': ..., 'short': ...}`. That does not match the methodology doc's promise of clean "complexity" and "paper reference" bullets in `docs/skill_maintenance.rst:56`.

   Recommended change: add explicit formatter helpers for structured KB fields before concatenating them into markdown. For example, render complexity as a compact `time / space` string and render paper from a stable human-facing field such as `paper["short"]` with optional id handling if needed.

4. **Medium — Generator turns raw KB `requires` tokens into `pyod[...]` extras verbatim, producing at least one wrong install hint.** `scripts/regen_skill.py:67` and `scripts/regen_skill.py:75` assume every KB requirement name is also a PyOD extra. That is not true for graph detectors: the KB reports `requires=['torch_geometric']`, while `pyproject.toml:58` exposes the supported extra as `pyod[graph]`. The methodology doc currently promises `pyod[extra]` install hints in `docs/skill_maintenance.rst:58`, so this will generate incorrect guidance as soon as the graph reference file lands.

   Recommended change: introduce an explicit mapping layer from KB dependency tokens to user-facing install hints, for example `torch_geometric -> pyod[graph]`, instead of interpolating the raw token directly.

5. **Medium — Combined `text-image-detector-list` renderer will duplicate multimodal detectors.** `_SECTION_RENDERERS` at `scripts/regen_skill.py:118` builds that section by concatenating the text list and the image list, but the live KB already includes `EmbeddingOD` and `MultiModalOD` in both modalities. The generated section will therefore repeat those detectors twice.

   Recommended change: build the text/image combined section from a deduplicated ordered collection keyed by detector name, then render once per unique detector. Add a regression test that `EmbeddingOD` and `MultiModalOD` appear exactly once in `text-image-detector-list`.

**Previously raised**

None. This is Round 1.
```

- [ ] **Step 3: Verify file and markers**

Run: `test -f skills/implement-review/references/example-reviews/example-code-phased.md && echo OK`
Expected: `OK`.

Run: `grep -c '^\*\*Verification notes\*\*$' skills/implement-review/references/example-reviews/example-code-phased.md`
Expected: 1.

Run: `grep -c 'C:/Users/yuezh\|C:\\\\Users\\\\yuezh' skills/implement-review/references/example-reviews/example-code-phased.md`
Expected: 0 (local paths stripped).

Run: `grep -c 'High —\|Medium —' skills/implement-review/references/example-reviews/example-code-phased.md`
Expected: at least 5 (one High, four Medium findings).

### Task 11: Create example-paper-multi-target.md

**Files:**
- Create: `skills/implement-review/references/example-reviews/example-paper-multi-target.md`

Source: `<writing-project>/papers/<paper-A>/CodexReview.md` Round 4 (as captured on 2026-04-13).

Anonymization rules:
- Public arXiv IDs kept (public record).
- Paper names "PyOD 2", "PyOD 3" kept (public releases).
- "AutoGluon", "AD-AGENT", "cardiotocography" kept (public papers/datasets).
- Internal section file paths kept (they are generic `sections/*.tex` names).
- The source paper's working title → `<proj>` only where it appears as a project identifier, not a topic word. The review does not use the working title literally.

- [ ] **Step 1: Verify file does not exist**

Run: `test -f skills/implement-review/references/example-reviews/example-paper-multi-target.md && echo EXISTS || echo MISSING`
Expected: `MISSING`.

- [ ] **Step 2: Write the exemplar**

Use the Write tool to create `skills/implement-review/references/example-reviews/example-paper-multi-target.md`:

```markdown
<!-- Round 4 -->

# Review

Verification notes: I read the staged files, compiled `arxiv-main.tex` (it builds to 4 pages), spot-compiled `main.tex`, and checked the cited primary papers for AutoGluon, PyOD 2, and AD-Agent to verify the taxonomy. I did not treat the intentional `\todo{}` placeholders or the two red figure-placeholder blocks as findings. Per-target history: the long-paper deep rewrite is on round 4; the arxiv short version is on round 1.

File/diff scope: staged changes covering `FIGURES.md`, `arxiv-main.tex`, `build-arxiv.sh`, `build-arxiv.bat`, and the long-paper section files `sections/{intro,background,architecture,adengine,deployment,discussion,related-work,conclusion}.tex`.

Review lens: `paper/content` -- soundness, novelty, significance, clarity, related-work positioning.

Overall assessment: the deep rewrite mostly works. The four-shift vocabulary now ties together the introduction, novelty delta, ADEngine section, discussion, and related work much more tightly than in earlier rounds. The remaining problems are concentrated in three places: the shift taxonomy is still not fully fair to prior systems, the Discussion section presents internal design/usage observations as if they were evidence, and both versions reintroduce conclusion-level scope claims that outrun the support on the page.

## (A) New findings on the long version's deep rewrite

### 1. High — The related-work taxonomy still overstates AutoGluon's similarity to the proposed pattern, and AD-AGENT is still described inaccurately (`sections/related-work.tex:23,37-41`, `sections/background.tex:21-23`).

Under the paper's own definition, Shift 2 is not generic automation; it is expertise made available as auditable routing evidence, specifically benchmark-backed rules. AutoGluon's paper presents a one-line `fit()` API with internal preprocessing, validation, model fitting, and stacking, plus a predefined model order and adaptive ensembling, not benchmark-backed routing or an exposed workflow state (AutoGluon-Tabular, arXiv:2003.06505, esp. Sections 2.1-2.3). Giving it a checkmark on S2 and a tilde on S1 makes the table look like a family-resemblance chart rather than a principled rubric. By contrast, the current tilde for PyOD 2 on S2 still looks fair: PyOD 2 does automate model choice, but through symbolic metadata plus LLM reasoning rather than benchmark-backed routing (PyOD 2, arXiv:2412.12154 Section 2.2).

Separately, the background delta table still calls AD-AGENT a "fixed 4-agent pipeline," but the cited paper describes Processor, Selector, Info Miner, Generator, Reviewer, Evaluator, and Optimizer agents with optional feedback loops (AD-Agent, arXiv:2505.12594 Sections 2.1-2.2). The partial-S1 classification is defensible; the "4-agent" wording is not.

Suggested row rewrite for `tab:related-shifts`:

```tex
\textsc{AutoGluon}~\cite{erickson2020autogluon} & $\times$ & $\sim$ & $\sim$ & $\times$ \\
```

Suggested text rewrite for the AutoGluon paragraph:

```tex
\textsc{AutoGluon}~\cite{erickson2020autogluon} is the KDD ADS precedent \pyodthree\ follows structurally: a widely deployed open-source library that operationalizes expert supervised-learning practice behind a simple \texttt{fit()} interface. We therefore treat it as a structural analogue rather than as a partial workflow substrate under our four-shift definition.
```

Suggested wording fix for the AD-AGENT row in `tab:method-deltas`:

```tex
Model selection & LLM-powered, single model & LLM-driven, multi-agent pipeline with optional feedback loops & Benchmark-backed top-$k$ consensus \\
```

### 2. Medium — Section 6 turns undocumented design history and usage impressions into paper-level evidence (`sections/discussion.tex:6-13`).

The discussion is at its best when it extracts design lessons from the artifact. It weakens when it states unevidenced facts about the artifact's history or usage, for example "the six-phase session state machine ... is the third iteration of the design," "the one-shot convenience method dominates in practice," and "users in early testing also reached for the natural-language path." None of these observations is supported elsewhere in the paper, and the section does not mark them as anecdotal author experience. That is exactly the kind of sentence a reviewer will push on because it sounds empirical while carrying no method behind it.

Suggested replacement for the first three discussion paragraphs:

```tex
\paragraph{Choosing the phase granularity mattered.}
Designing Shift~1 was mainly a question of phase granularity. Too fine, and the agent drowns in transitions and the one-shot path becomes awkward; too coarse, and iteration loses the handles it needs. The design lesson is that exposing a state machine is not enough; the state partition has to match how the workflow is revisited.
```

### 3. Medium — The new framing reintroduces broad scope claims that the paper cannot currently defend (`sections/intro.tex:27`, `sections/related-work.tex:44`, `sections/conclusion.tex:15-16`).

The strongest remaining overclaiming is no longer about OD quality; it is about scope. Three sentences are doing too much work:

- `sections/intro.tex:27` moves from a real installed base to "already how a significant fraction of the world's AD code will meet the agentic era."
- `sections/related-work.tex:44` claims "the first open-source Python scientific library in any domain" to name and implement the pattern.
- `sections/conclusion.tex:15-16` says the conditions that make the pattern work "hold" for causal inference, drug target identification, and financial factor research.

Each sentence is plausible as ambition, but none is supported as a result of the present paper.

Suggested rewrite for the introduction sentence:

```tex
\pyodthree\ is the first anomaly-detection library built as a workflow substrate, implementing all four shifts in \adengine, its Layer-2 Python API (\S\ref{sec:adengine}). It ships as the third generation of a widely deployed Python AD library, with 39M+ PyPI downloads and documented production deployments, so the substrate is presented in a library with genuine production reach rather than in a demonstration artifact.
```

Suggested rewrite for the beyond-OD future-directions paragraph:

```tex
\textit{(i) Beyond anomaly detection.}
The workflow-substrate pattern may extend to domains such as causal inference, drug target identification, and financial factor research, where expert workflows and evaluation ecosystems already exist, but that is a hypothesis rather than a result of the present paper.
```

## (B) Previously raised items from Rounds 1-3

- `R1 #1: intro stiffness` -- Fixed. The stakes-first opener survives the rewrite.
- `R1 #5: residual overclaims in intro/deployment/conclusion` -- Reopened. The earlier overclaim wording stayed fixed, but the deep rewrite introduces fresh scope claims. See A3.
- `R2 #1: image modality overclaim` -- Fixed. Long table and closing sentence still state image inputs share the interface without a dedicated routing benchmark.
- `R3 #1: AD-LLM mischaracterization` -- Fixed. Related-work now treats AD-LLM as a benchmark study rather than as a workflow system.

## (C) New findings on the arxiv short version

Stand-alone assessment: the short version is close to a citable preprint. The build lands at 4 pages, the cardiotocography walkthrough still keeps the essential Turn-4 disagreement check, and `tab:related-shifts-arxiv` does not drift from the long table. The remaining issues are about claim calibration, not narrative completeness.

### 1. High — The short version still states the empirical thesis as achieved while explicitly deferring the validating evidence (`arxiv-main.tex:100-102`).

The preprint does a good job telling the reader that oracle comparisons, the PyOD 2 pairing, calibration, overhead, and case studies are deferred. But the sentence immediately before that still says `\pyodthree` "gives agents enough structure to run competent anomaly detection workflows with less OD expertise." In the 4-page version, that sentence reads as the earned result, not as the design target.

Suggested rewrite:

```tex
The claim is narrower than expert-level automation: \pyodthree\ is designed to give agents the structure needed for more competent anomaly-detection workflows with less OD expertise. This preprint motivates that design claim and shows a worked example.
```

### 2. Medium — The compressed conclusion keeps the same two biggest scope jumps from the long version (`arxiv-main.tex:193,197`).

There is no classification drift between the long and short related-work tables; the symbols match. The problem is that the short version inherits the same overreach in an even more exposed form.

## Cross-variant drift

The long and short versions' related-work shift tables agree (no drift). The overclaiming in intro and conclusion also appears in both versions in parallel form, so fixing one side without the other would introduce new drift. Coordinate the fixes for A3 (long) with C1 and C2 (short) to keep the two variants aligned.
```

- [ ] **Step 3: Verify file and markers**

Run: `test -f skills/implement-review/references/example-reviews/example-paper-multi-target.md && echo OK`
Expected: `OK`.

Run: `grep -c '^## (A) New findings' skills/implement-review/references/example-reviews/example-paper-multi-target.md`
Expected: 1.

Run: `grep -c '^## (B) Previously raised items' skills/implement-review/references/example-reviews/example-paper-multi-target.md`
Expected: 1.

Run: `grep -c '^## (C) New findings on the arxiv short version' skills/implement-review/references/example-reviews/example-paper-multi-target.md`
Expected: 1.

Run: `grep -c '^## Cross-variant drift$' skills/implement-review/references/example-reviews/example-paper-multi-target.md`
Expected: 1.

### Task 12: Create example-paper-verification.md

**Files:**
- Create: `skills/implement-review/references/example-reviews/example-paper-verification.md`

Source: `<writing-project>/papers/<paper-B>/CodexReview.md` Round 1 (as captured on 2026-04-13).

Anonymization rules:
- Paper topic "auditable agents" kept (public research area).
- Section file names kept (generic `06b_limitations.tex`, `07_conclusion.tex`, `neurips_2026.tex`).
- "openclaw2026" bib entry (user-local internal identifier) → `<internal-bib>`.

- [ ] **Step 1: Verify file does not exist**

Run: `test -f skills/implement-review/references/example-reviews/example-paper-verification.md && echo EXISTS || echo MISSING`
Expected: `MISSING`.

- [ ] **Step 2: Write the exemplar**

Use the Write tool to create `skills/implement-review/references/example-reviews/example-paper-verification.md`:

```markdown
<!-- Round 1 -->

# Review

## Verification notes

- `git diff --cached --check` is clean.
- `latexmk -pdf -interaction=nonstopmode -halt-on-error neurips_2026.tex` succeeds.
- The build still emits a pre-existing BibTeX warning for `<internal-bib>` having an undefined entry type in `references.bib`; that does not come from the staged changes under review and should not be held against this diff.

File/diff scope: `git diff --cached` in the working paper directory; staged files are `06b_limitations.tex` (new), `07_conclusion.tex` (rewritten), and `neurips_2026.tex` (section inclusion only).

Review lens: `paper/content` (arXiv preprint) -- assess whether the rewritten conclusion lands the argument with conviction without overpromising, whether the new Limitations section and Conclusion work as a sequence, and whether tone and writing quality remain consistent with the rest of the paper.

## New

1. Medium -- `07_conclusion.tex:14` and `07_conclusion.tex:31`

   The new conclusion is stronger than the previous one, but it now overshoots the paper's own limitation framing in two places. `Layered evidence ... demonstrates that the auditability gap is real, that closing it is engineering-feasible` is stronger than the paper has actually established after the new Limitations section has just said the evidence is partly proxy-based, author-built, limited in scale, and not end-to-end. The final sentence then goes all the way to `It is the foundation on which trust, accountability, and responsible deployment ultimately rest.` That reads as a manifesto line rather than a conclusion anchored in the scoped claims of this paper.

   Recommended changes:
   - Tone down `demonstrates` and especially `closing it is engineering-feasible` to something aligned with the evidence actually presented.
   - Replace `the foundation` with `a foundation` or another slightly less absolute phrase.
   - A safe revision would be: `Layered evidence from ecosystem scans, runtime mediation, and missing-log recovery supports the claim that the auditability gap is real, that core auditability mechanisms are engineering-feasible, and that partial accountability can survive even when conventional logs fail.`
   - A safe final sentence would be: `Auditability is not a tax on agent development. It is a foundation for trust, accountability, and responsible deployment.`

2. Low -- `06b_limitations.tex:15`

   `We release all code and data to facilitate independent replication.` is an unusually concrete factual claim for a limitations paragraph, but the paper does not appear to tell the reader where those artifacts are. In the current form, a reviewer who wants to verify the claim has no pointer, and the sentence risks reading as a promise rather than a documented availability statement.

   Recommended changes:
   - Add a URL, footnote, or short artifact-availability pointer if the release already exists.
   - If the artifacts are not yet public, change the tense to match reality instead of asserting a present release.
   - If you want to keep the sentence here, something like `Code and data are available at ...` is better than a bare release claim with no locator.

## Previously raised

### Fixed

- None. Round 1.

### Still open

- None. Round 1.

### Reopened

- None. Round 1.

### Deferred

- None. Round 1.

## Overall assessment

The new section sequence basically works. `Limitations` is honest and substantive, and the rewritten conclusion is cleaner and more forceful than the previous version. The remaining issue is calibration: the ending should recover confidence after the limitations section, but it should not sound as if those limitations no longer matter.
```

- [ ] **Step 3: Verify file and markers**

Run: `test -f skills/implement-review/references/example-reviews/example-paper-verification.md && echo OK`
Expected: `OK`.

Run: `grep -c '^## Verification notes$' skills/implement-review/references/example-reviews/example-paper-verification.md`
Expected: 1.

Run: `grep -c 'latexmk' skills/implement-review/references/example-reviews/example-paper-verification.md`
Expected: 1.

Run: `grep -c 'does not come from the staged changes' skills/implement-review/references/example-reviews/example-paper-verification.md`
Expected: 1.

Run: `grep -c 'openclaw2026' skills/implement-review/references/example-reviews/example-paper-verification.md`
Expected: 0 (anonymization complete).

### Commit for Section C

- [ ] **Stage and confirm with user**

Show the user the directory listing and all four exemplar files. Ask explicit permission to commit.

Run: `ls -la skills/implement-review/references/example-reviews/`
Expected: four `.md` files.

Run: `git status skills/implement-review/references/example-reviews/`
Expected: all four files listed as new.

Once user approves:

```bash
git add skills/implement-review/references/example-reviews/
git commit -m "implement-review: add four curated review exemplars

- example-proposal-nsf.md (from <nsf-proposal-project> R2): proposal/nsf lens, Fixed/Still open classification, two-option recommendation pattern for ambiguous fixes.
- example-code-phased.md (from pyod R1): code lens with Phase-1/Phase-2 Additional focus, Verification notes with exact pytest commands, High-priority finding with file:line.
- example-paper-multi-target.md (from <writing-project>/papers/<paper-A> R4): paper/content lens with long+short variant structure and Cross-variant drift check, LaTeX rewrite code blocks.
- example-paper-verification.md (from <writing-project>/papers/<paper-B> R1): paper/content lens on narrow scope, Verification notes at top with exact latexmk command, orthogonal-issue flagging.

Content lightly anonymized (allocation IDs, budget numbers, local paths)."
```

---

## Section D — Final smoke test

### Task 13: Verify all changes are in place

No commit for this task. It is a dry-run sanity check before handing off to a reviewer.

- [ ] **Step 1: SKILL.md — all three Phase 1 edits present**

Run: `grep -c 'Always ask the user explicitly\|Variant targets (multi-target reviews)\|Verification notes\|For any finding flagged High priority' skills/implement-review/SKILL.md`
Expected: at least 4 (one match per pattern).

- [ ] **Step 2: review-lenses.md — all three sub-lenses and the note present**

Run: `grep -c '^### Website$\|^### Plan$\|^### Skill$\|^### Multi-target reviews$' skills/implement-review/references/review-lenses.md`
Expected: 4.

Run: `grep -c '^| \`website\`\|^| \`plan\`\|^| \`skill\` |' skills/implement-review/references/review-lenses.md`
Expected: 3 (one per new table row).

- [ ] **Step 3: Exemplars — all four files exist**

Run: `ls skills/implement-review/references/example-reviews/ | wc -l`
Expected: 4.

Run: `ls skills/implement-review/references/example-reviews/`
Expected: `example-code-phased.md`, `example-paper-multi-target.md`, `example-paper-verification.md`, `example-proposal-nsf.md`

- [ ] **Step 4a: Every exemplar has a canonical `<!-- Round N -->` marker**

Run: `grep -l -E '^<!-- Round [0-9]+ -->$' skills/implement-review/references/example-reviews/*.md | wc -l`
Expected: `4`. Non-canonical markers like `<!-- Round 4 long + Round 1 arxiv -->` will fail this check.

- [ ] **Step 4b: Every exemplar has a Verification notes section**

Run: `grep -l 'Verification notes' skills/implement-review/references/example-reviews/*.md | wc -l`
Expected: `4`.

- [ ] **Step 4c: Verification notes appears BEFORE the first findings heading (ordering check)**

Run:

```bash
for f in skills/implement-review/references/example-reviews/*.md; do
  v=$(grep -n 'Verification notes' "$f" | head -1 | cut -d: -f1)
  n=$(grep -n -E '^## New$|^\*\*New\*\*$|^## \(A\) New' "$f" | head -1 | cut -d: -f1)
  if [ -n "$v" ] && [ -n "$n" ] && [ "$v" -lt "$n" ]; then
    echo "$f: Order OK (V@$v < N@$n)"
  else
    echo "$f: Order FAIL (V@$v, N@$n)"
  fi
done
```

Expected: 4 lines, each of the form `<filename>: Order OK (V@<v> < N@<n>)` where `<v>` and `<n>` are line numbers. Any line matching `Order FAIL` indicates the exemplar places Verification notes after (or next to) a findings section, which contradicts the new Phase 1c contract.

- [ ] **Step 5: No residual anonymization leaks**

Run: `grep -l 'CIS251004\|CIS250073\|C:/Users/yuezh\|C:\\\\Users\\\\yuezh\|openclaw2026\|zhao-yue' skills/implement-review/references/example-reviews/*.md`
Expected: no output (no files match any of the unanonymized markers).

- [ ] **Step 6: Report results to the user**

Summarize the smoke test outcome: all three file areas touched, all exemplars created, no anonymization leaks. Hand off to the user for `/implement-review` on the accumulated staged changes (if not already committed) or on the polish commits as a whole.
