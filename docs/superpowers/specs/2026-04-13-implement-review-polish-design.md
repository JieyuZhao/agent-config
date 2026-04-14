# implement-review skill polish — design

- Date: 2026-04-13
- Status: Draft, pending user review
- Scope: `skills/implement-review/SKILL.md`, `skills/implement-review/references/review-lenses.md`, `skills/implement-review/references/example-reviews/` (new)

## Background

The `implement-review` skill is the user's most-used skill across 9 sibling project repos spanning code, LaTeX proposals, LaTeX papers, personal site, and administrative writing. Public repos in this set include `pyod` and `yzhao062.github.io`; the remaining seven are private dev repos referenced by placeholder (`<nsf-proposal-project>`, `<writing-project>`, etc.) throughout this spec. An audit on 2026-04-13 surveyed real usage across all 9 projects.

### Real usage (5 live `CodexReview.md` artifacts on audit day)

| Project | Round | Lens | Notable pattern |
|---|---|---|---|
| `<nsf-proposal-project>` | 2 | `proposal/nsf` | Verification notes at top; two-option recommendation for ambiguous fixes |
| `yzhao062.github.io` | 3 | ad-hoc "general website/content" | Regression check against earlier rounds; deferred social-card item kept visible |
| `<writing-project>/papers/<paper-A>` | 4 | `paper/content` | Multi-target structure (long + arxiv short); LaTeX rewrite code blocks |
| `<writing-project>/papers/<paper-B>` | 1 | `paper/content` | `Verification notes` originally at the bottom (reordered to the top in the exemplar) listing exact commands run; flagged pre-existing BibTeX warning as *not* caused by the staged diff |
| `pyod` | 1 | `code` | Project-specific focus ("Phase 1 vs Phase 2 coupling") injected via Additional focus; "Checks Run" section with exact pytest commands |

### Key findings

1. **The best reviews exhibit behaviors the skill does not prescribe:** a `Verification notes` / `Validation notes` section listing runtime checks (`latexmk`, `pytest`, citation lookups); exact suggested rewrites with file:line for High-priority findings; multi-target structure when staged diffs span two variants; orthogonal-issue flagging; severity calibration with alternative-wording recommendations.
2. **"General" is stretching to cover content types that deserve dedicated framing:** website/personal-site reviews (`yzhao062.github.io`), plan and design docs (`<writing-project>/docs/superpowers/specs/*.md`, `DESIGN.md`, `FIGURE-PLAN.md`, `RESTRUCTURE-PLAN.md`), meta-skill editing.
3. **The "Additional focus" field in Phase 1b is the strongest lever for project-specific sharpness** (pyod's "Phase 1/Phase 2 coupling" came through it), but it is currently under-explained in the skill.

## Goal

Sharpen lens coverage (direction B) and review signal quality (direction C) by *extending* (not rewriting) the existing `CodexReview.md` format contract. The new contract adds two required elements (a `Verification notes` paragraph at the top of every review, and exact suggested rewrites with file:line for High-priority findings) while keeping the rest of the structure unchanged, so prior review artifacts remain format-valid. The user explicitly deprioritized flow and format-compliance concerns; reviews must be "at point and comprehensive."

## Approach chosen: A — sharpen prompt + add sub-lenses + curated exemplars

Three targeted edits in the skill, one new directory of real-review exemplars. Does not touch consumer repos. Existing `CodexReview.md` artifacts remain format-valid.

---

## Section 1 — `SKILL.md` prompt contract changes

Three targeted edits to `skills/implement-review/SKILL.md`.

### 1a. Phase 1b item 4 ("Additional focus") — promote and demand an explicit answer

Replace the current text of item 4 under Phase 1b with:

> **Additional focus** — specific concerns beyond the generic lens. This is often the highest-value part of the prompt because it catches real bugs that generic criteria miss. **Always ask the user explicitly rather than guessing.** Recurring project concerns belong here: phased-development coupling, anonymization checks, page-limit compliance, budget-to-narrative consistency, terminology drift, benchmark-claim calibration, overclaim flagging. If there are no project-specific concerns this round, write "none" rather than padding the line. Examples: "check that all appendix URLs are anonymized", "verify Year 3 budget matches the narrative", "flag any overclaim in intro / conclusion", "watch for Phase 1 / Phase 2 coupling issues".

### 1b. Phase 1b new item 6 ("Variant targets")

Insert a new item between current item 5 (Round number) and current item 6 (Round history), making it the new item 6. Current item 6 (Round history) becomes item 7. Rationale for placement: variant targets is an any-round concern and should appear before the conditional "rounds 2+ only" round history item.

> **6. Variant targets (multi-target reviews)** — if the staged files cover two or more variant targets that should be reviewed separately (long + short paper version, narrative + appendix tracker, internal + external report, primary + supplement), list each target by directory or file pattern. Tell Codex to review each target in its own top-level section and then add a cross-variant drift check at the end (tables that should match, claims that should be consistent, terminology that should align).

### 1c. Phase 1c save instruction — extend required output

Replace the current full save instruction (starting at "IMPORTANT: Save your complete review...") with the extended version below. Bold marks the new additions; the rest is unchanged.

> IMPORTANT: Save your complete review to `CodexReview.md` in the repository root. Overwrite any existing content. Use plain Markdown. Start the file with a `<!-- Round N -->` comment (matching the round number below) so the reader can verify freshness. **Begin the review with a short "Verification notes" paragraph (or "Validation notes" — either name accepted) stating exactly what was compiled, run, or verified (e.g., `latexmk built cleanly`, `pytest pyod/test/... 5 passed`, `checked citation X against arXiv:YYYY`). If nothing was verified at runtime, write "Verification notes: none."** Separate findings into **New** (raised for the first time) and **Previously raised** (with status: Fixed, Still open, Reopened, or Deferred) sections. On Round 1, the Previously raised section may be omitted or shown as "None." Then include the file/diff scope, review lens, findings in priority order, and concrete recommended changes. **For any finding flagged High priority, include an exact suggested rewrite with file path and line range. Use a fenced code block for multi-line rewrites.** Do not skip this step. **For examples of the expected depth and format, see `skills/implement-review/references/example-reviews/`.**

Also update the abbreviated terminal-path save instruction (inside the fenced text block the skill generates for copy-paste) to mirror the additions:

> IMPORTANT: Save your complete review to CodexReview.md in the repository root. Overwrite any existing content. Start with <!-- Round N -->. Begin with a "Verification notes" paragraph (what was compiled, run, or verified; "none" if nothing). Include file/diff scope and review lens. Separate findings into New and Previously raised (Fixed / Still open / Reopened / Deferred) sections. For High-priority findings, include an exact rewrite with file:line. See skills/implement-review/references/example-reviews/ for expected depth.

---

## Section 2 — `references/review-lenses.md` additions

Add three new focused sub-lenses and one structural note to `skills/implement-review/references/review-lenses.md`.

### 2a. New sub-lens `website`

Add to the "Focused sub-lenses" table:

| `website` | General | items 1-5 in the Website subsection | Static sites, personal sites, documentation sites, landing pages |

Add a new `### Website` subsection after the existing sub-lens tables with these criteria:

1. **Version and metadata consistency** — JSON-LD `softwareVersion`, meta tags, footer versions, and similar markers match the underlying source of truth (repo, release notes, upstream README).
2. **Factual accuracy of external claims** — download counts, credits, citations, affiliated institutions, publication lists. Verify against upstream sources when possible.
3. **Structured data consistency** — JSON-LD, OpenGraph, and Twitter card metadata consistent with visible page content (no mismatched titles, descriptions, or version strings).
4. **Asset correctness** — images have the right dimensions for their use (social cards at 1200×630, avatars square-cropped), alt text present, no broken links.
5. **Regression against prior review rounds** — do not flag earlier-round fixes as new issues; explicitly note prior findings still in force.

When to use: static sites, personal sites, documentation sites, landing pages. Parent: General.

### 2b. New sub-lens `plan`

Add to the "Focused sub-lenses" table:

| `plan` | General | items 1-6 in the Plan subsection | Methodology docs, roadmaps, research backlogs, migration plans, phased-development design docs, superpowers-style spec docs |

Add a new `### Plan` subsection with these criteria:

1. **Completeness** — does the plan cover the steps it claims to? Are there missing preconditions, hand-offs, or post-conditions?
2. **Feasibility** — is the timeline realistic given scope and dependencies? Are external dependencies and blockers named?
3. **Internal consistency** — do sections presuppose things other sections assume? Do the "what" and the "how" match?
4. **Alignment with implementation** — if the plan describes code, config, or content that already exists, does the description match what is actually there?
5. **Risk surfacing** — are known failure modes named, and are mitigations proposed or explicitly deferred?
6. **Acceptance criteria** — can "done" be checked objectively? Are success metrics or verification steps stated?

When to use: methodology docs, research backlogs, roadmaps, migration plans, phased-development design docs, superpowers-style design specs (`docs/superpowers/specs/*.md`). Parent: General.

### 2c. New sub-lens `skill` (meta)

Add to the "Focused sub-lenses" table:

| `skill` | General | items 1-6 in the Skill subsection | Editing `SKILL.md` files, adding references/scripts to a skill, meta-skill work |

Add a new `### Skill` subsection with these criteria:

1. **Frontmatter accuracy** — does the `description` field match the actual behavior? Would a routing layer pick the right tasks to invoke it?
2. **Instruction clarity** — can a cold reader (human or agent) follow the skill without additional context?
3. **Edge-case coverage** — what happens when a required precondition is missing? What happens on failure at each phase?
4. **Contract consistency** — do all sections use the same terminology and data shapes? Does the save/output contract match the intake/parsing contract?
5. **Invocation guarantees** — are inputs, outputs, and side effects declared at the top? Are dependencies on other skills or external tools named?
6. **Integration** — how does this skill interact with other skills, hooks, or the broader workflow? Are hand-off points clear?

When to use: editing SKILL.md files, adding references/scripts to a skill, meta-skill work (e.g., polishing the `implement-review` skill itself). Parent: General.

### 2d. Multi-target review structure — structural note

Add a new short subsection at the end of the "Focused Sub-Lenses and Agency-Specific Lenses" section:

> **Multi-target reviews.** When the staged diff contains two or more variant targets that should be reviewed separately (long + short paper version, narrative + tracker, internal + external report, primary + supplement), structure the review with one top-level section per target plus a cross-variant drift check at the end. Treat each target as a self-contained sub-review — its own scope line, findings, and recommendations — then add a final "Cross-variant drift" section that flags tables, claims, terminology, or numbers that should be consistent across targets but are not.

---

## Section 3 — `references/example-reviews/` directory

New directory: `skills/implement-review/references/example-reviews/`. Four curated exemplars drawn from real reviews, lightly anonymized.

### 3a. `example-proposal-nsf.md`

Source: `<nsf-proposal-project>/CodexReview.md` Round 2.

Demonstrates:
- `proposal/nsf` lens application with NSF-specific Additional focus (ACCESS progress report, burn-rate explanation, tracker consistency)
- Validation notes at the top listing what was compiled and cross-checked (LaTeX build, reopened example zip for number verification)
- Fixed / Still open classification with concrete evidence (file:line on each finding)
- "Two clean options" recommendation pattern for ambiguous fixes (user picks the framing, Codex provides both candidate texts)

Anonymization rules: replace allocation IDs (`CIS251004` → `<ALLOC_A>`, `CIS250073` → `<ALLOC_B>`), specific budget numbers (`500k`, `600k` → `$X00k`, `$Y00k`), co-PI and project names (→ `<proj>`, `<PI-A>`, etc.). Keep the structural shape, severity labels, file/line reference style, and the nature of findings.

### 3b. `example-code-phased.md`

Source: `pyod/CodexReview.md` Round 1.

Demonstrates:
- `code` lens with project-specific Additional focus ("Phase 1 vs Phase 2 coupling")
- "Checks Run" section with exact `pytest` and `docutils.core.publish_doctree` commands and their results
- One High-priority finding with file:line and a concrete recommended change (deferral options spelled out)
- Medium-severity findings following the same "finding → recommended change" pattern

Anonymization rules: keep real PyOD API surface since it is a public library, but strip local paths in favor of repo-relative paths. Replace any not-yet-public detector or API names with placeholders if needed (most PyOD 3 surface is already public).

### 3c. `example-paper-multi-target.md`

Source: `<writing-project>/papers/<paper-A>/CodexReview.md` Round 4.

Demonstrates:
- Multi-target review structure: (A) long version findings, (B) previously raised, (C) arxiv short version findings
- `paper/content` lens application across both variants
- Fact-vs-opinion classification ("presents as evidence what is actually design history")
- LaTeX rewrite code blocks with drop-in replacements for intro, related-work, and conclusion sentences
- Fixed / Reopened classification across rounds

Anonymization rules: keep public arXiv IDs and paper titles (public record), replace any unpublished project code names from the source with `<proj>` where they appear as identifiers rather than topic words.

### 3d. `example-paper-verification.md`

Source: `<writing-project>/papers/<paper-B>/CodexReview.md` Round 1.

Demonstrates:
- `paper/content` lens on a narrow scope (Limitations + Conclusion rewrite)
- `Verification notes` section at the top of the review (reordered from the source artifact, which originally placed it at the bottom; the exemplar models the new Phase 1c contract that requires Verification notes first) listing exact commands run (`git diff --cached --check`, `latexmk -pdf -interaction=nonstopmode -halt-on-error`)
- Orthogonal-issue flagging: pre-existing BibTeX warning noted as *not* caused by the staged diff
- Low / Medium severity calibration with alternative-wording recommendations (three candidate sentences for overclaim fix)
- Short overall-assessment paragraph at the end

Anonymization rules: keep the paper topic in abstract terms ("auditable agents"), remove any specific lab or institutional credits.

### 3e. Referenced from `SKILL.md`

Phase 1c save instruction ends with "For examples of the expected depth and format, see `skills/implement-review/references/example-reviews/`." This adds a pointer without requiring Codex to read the files in the terminal path. Codex in plugin path can open them directly; in terminal path Claude Code uses them when crafting prompts and the user can paste a relevant snippet into Codex if helpful.

---

## Out of scope

- **Per-project focus persistence (`.codex-focus.md`).** Considered under Approach B, not chosen. Project-specific focus remains a Phase 1b question that Claude Code asks each round. If this later proves to be a repetition pain, it can be added as a separate polish round.
- **Bootstrap drift fixes** for the three private repos in the audit whose `.agent-config/repo/skills/implement-review/SKILL.md` is stale or missing. These are operational (refresh bootstrap), not skill polish. Handled separately if the user wants to sweep them.
- **Discoverability in consumer repos** (adding `implement-review` references to their `AGENTS.md` or `CLAUDE.md`). Not currently required and risks being overwritten by bootstrap.
- **Flow and format compliance** (directions A and D from brainstorming). User explicitly deprioritized these.
- **A fifth synthetic `example-plan-doc.md` exemplar.** Would close the "no real plan-doc review exists yet" gap, but synthetic examples risk teaching Codex patterns that do not match the user's actual workflow. Deferred until a real plan-doc review exists.

## Success criteria

1. **Lens usage.** The next review in `yzhao062.github.io` (or a similar personal-site repo) uses the `website` lens; the next review on a `docs/superpowers/specs/*.md`, `DESIGN.md`, or `RESTRUCTURE-PLAN.md` uses the `plan` lens; the next meta-skill edit uses the `skill` lens. No new lens is invented ad-hoc when one of these applies.
2. **Verification notes.** Every future `CodexReview.md` includes a "Verification notes" (or "Validation notes") section. Empty case explicitly says "none."
3. **Exact rewrites for High priority.** Every High-priority finding in future reviews includes an exact suggested rewrite with file:line. No abstract "you should consider X" phrasing for High severity.
4. **Multi-target structure.** Any future review spanning two variant targets uses the prescribed per-target sections plus a "Cross-variant drift" section.
5. **Reduced re-specification.** Recurring project concerns (pyod Phase 1/2 coupling, NSF ACCESS tracker consistency, terminology drift) can be restated from the Phase 1b item 4 description without the user inventing the framing from scratch each round.

## Risks and trade-offs

- **Exemplar anonymization drift.** Real reviews contain project-specific content. Light anonymization preserves the teaching signal but will look slightly "off" compared to pure examples. Acceptable: real-review patterns are the point.
- **Longer prompt.** The Phase 1c save instruction grows by ~3 sentences; the abbreviated terminal-path variant grows by ~2. Both still fit within the skill's existing 20-line cap for terminal-path prompts.
- **Lens proliferation.** Three new sub-lenses take `review-lenses.md` from 6 focused sub-lenses to 9. Still manageable in table form.
- **"Verification" vs "Validation" naming.** The prompt accepts both to match current Codex drift; long-term the preference is "Verification" at the top of the review.
