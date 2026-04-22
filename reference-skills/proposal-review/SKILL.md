---
name: proposal-review
description: Review a research proposal draft against a CFP or stated research intent. Use when Codex needs to check compliance, evaluate content quality, simulate reviewer scoring, or produce a priority-ordered list of revision targets. Works for NSF, NIH, DARPA, and industry proposals. Focuses substantive review on intent fit, challenge clarity, differentiation, causal chain, scope discipline, evidence posture, and structural alignment before copyediting.
---

# Proposal Reviewer

## Overview

Use this skill after a draft exists. It is a content quality reviewer, not a
compliance checker — for solicitation-level compliance (required sections,
page limits, personnel, letters), use `nsf-proposal-guardrail` instead.

This skill works for any sponsor (NSF, NIH, DARPA, industry, foundation). When
agency-specific scoring criteria apply, load them from the CFP before running
Step 3.

Use it when the user asks for work such as:

- review this draft against the CFP
- score this proposal
- what are the weakest sections?
- is the challenge stated clearly?
- does the related work differentiate us?
- does the proposal hold together as a coherent argument?

When a full review-revise loop is needed (send to Codex, iterate over rounds),
wrap this skill inside `implement-review` using the `proposal` lens.

Read the writing rules in `AGENTS.md` (or the shared `.agent-config/AGENTS.md`)
before reviewing. Flag any banned words found in the draft.

## Workflow

### 1. Establish Scope

Before reviewing, identify:

- the CFP or stated research intent (read the CFP file if available; otherwise
  ask the user to describe the funder and intent in one paragraph)
- which sections are present in the draft
- the user's review priority: full review, targeted section, or quick scoring pass

If the CFP provides explicit evaluation criteria and scoring weights, load them
now — they override generic defaults in Step 3.

### 2. Compliance Check

Verify the draft against the CFP requirements:

- [ ] All required sections present
- [ ] Page or word limits respected
- [ ] Required supplementary items included (data management plan, budget, letters, etc.)
- [ ] Formatting requirements met

Report PASS or FAIL with a list of issues. Do not proceed to content review
until compliance is at least PASS with known gaps documented.

### 3. Substantive Review

Run these checks in order. Prioritize finding conceptual mismatches and
structural weaknesses before moving to wording or style.

#### 3.1 Intent Fit

Check whether the draft actually answers the user's stated research question
or CFP intent, not just whether it sounds polished. If the user gave an
informal concept, test whether the proposal's core thesis, research questions,
and methods all map back to that concept directly. Flag misalignments as high
severity — a technically polished draft that answers the wrong question fails
at the first test.

#### 3.2 Challenge Clarity

Load `../nsf-proposal-composer/references/drafting-rules.md` for the full
definition. In brief: the challenge must be concrete (not "X is an open
problem"), placed prominently in the Problem Statement opening paragraph, and
immediately followed by the proposed solution in one sentence.

Rate: PASS / WEAK / FAIL. Quote the challenge statement or flag its absence.

#### 3.3 Differentiation

Load `../nsf-proposal-composer/references/drafting-rules.md` for the full
definition. In brief: Related Work must close with an explicit gap statement.
Differentiation by juxtaposition alone is insufficient. For each major prior
work, the proposal must state what it achieves and where it falls short.

Rate: PASS / WEAK / FAIL. Quote or locate the gap statement. Name the closest
prior work and verify the contrast is explicit.

#### 3.4 Concept vs. Rhetoric

Distinguish among what the proposal claims conceptually, what it can support
empirically, and how strongly it phrases those claims. Flag places where
hypotheses are stated as established facts. Flag sentences that use strong
positive language ("will show", "will prove") without corresponding evidence
commitments.

#### 3.5 Causal Chain

For theory-heavy or mechanism-heavy proposals, verify that the document clearly
answers the key "why" and "under what conditions" questions. If the proposal is
about behavior, check that internal representation, external behavior, and
anthropomorphic language (feeling, fear, intention) are clearly distinguished
where relevant.

#### 3.6 Scope Discipline

Check whether the draft stays focused on the central problem or inflates into
a broader framework that dilutes the main contribution. A smaller number of
well-defended claims is stronger than a large branded framework with weak
support. Flag scope inflation as a structural issue, not a style issue.

#### 3.7 Evidence Posture

Identify which claims depend on verified citations, which depend on provisional
evidence, and which are currently unsupported. Require explicit markers such as
`[VERIFY]` or `[CITE NEEDED]` when key citations are incomplete or uncertain.
Do not accept "well-known" as a substitute for a citation.

#### 3.8 Structural Alignment

Confirm that the project summary, problem statement, research questions,
methodology, and contributions all point to the same central claim. If one
section promises more than the methods can test, flag this as a structural
problem. Check that each section is internally coherent: opening claim,
supporting evidence, closing connection to the next section.

### 4. Scoring Simulation

If the CFP provides evaluation criteria, score each criterion on a 1–5 scale
and explain the reasoning. Be calibrated — a 3 with clear feedback is more
useful than an inflated 5. If no CFP criteria are available, use:

- **Intellectual Merit / Technical Soundness** — Is the science or engineering
  rigorous and well-motivated?
- **Novelty and Differentiation** — Does it advance the field beyond prior work?
- **Feasibility** — Is the plan realistic given the team, timeline, and resources?
- **Clarity and Coherence** — Is the argument easy to follow for a non-specialist
  reviewer?
- **Broader Impact** (NSF) or **Significance and Innovation** (NIH) — as applicable

### 5. Section-by-Section Feedback

For each section, produce:

- verdict: `[OK]` or `[NEEDS WORK]`
- one-sentence diagnosis
- concrete suggestion when flagged (not "improve this" — a specific fix)
- priority: High / Medium / Low

Report in this order: Major Gaps → Overclaims → Section-by-Section → Style.
Never lead with style comments when structural problems exist.

## Output Format

Return a structured review report in Markdown:

```
## Compliance: PASS / FAIL
  — List any missing or noncompliant items.

## Overall Verdict
  — One paragraph: does the draft answer the CFP and the user's stated intent?

## Challenge Clarity: PASS / WEAK / FAIL
  — Quote the challenge statement or flag its absence.
  — One-sentence diagnosis.

## Differentiation: PASS / WEAK / FAIL
  — Quote or locate the gap statement in Related Work.
  — Name the closest prior work and whether the contrast is explicit.

## Strongest Sections

## Major Gaps or Misalignments
  — Structural and conceptual issues only. Priority-ordered.

## Overclaims or Weakly Supported Claims

## Section-by-Section Feedback
  — For each section: [OK] or [NEEDS WORK], one-sentence diagnosis, concrete suggestion.

## Simulated Score: X/Y (or per-criterion scores if CFP criteria provided)

## Top 3 Priorities for Revision
```

Keep each finding actionable. "Section 2 lacks a gap statement — add one
explicit sentence naming what prior work cannot do" is useful. "Related work
could be stronger" is not.

## Writing Constraints

When reviewing, also check for:

- banned words from the shared writing rules (see `AGENTS.md`): encompass,
  bridge, delve, leverage, robust, utilize, foster, holistic, synergy, paradigm
- contractions (`it's`, `he'd`) — flag in formal sections
- unsupported assertions using "well-known", "clearly", "obviously"
- DEI terminology in federal proposals where the solicitation does not require it

## When Not To Use

- For solicitation compliance checking (missing sections, page limits, personnel,
  letter types) — use `nsf-proposal-guardrail` instead.
- For unit-level technical deepening (sharpening a thrust, adding citations,
  figure planning) — use `nsf-thrust-refiner` instead.
- For multi-round review with Codex in a loop — wrap this skill inside
  `implement-review` using the `proposal` lens.
