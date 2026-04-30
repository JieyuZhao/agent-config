# Drafting Rules

Argument quality conventions for proposal drafting and review. Load this file
when drafting or reviewing proposal sections — especially the Problem Statement,
Related Work, and proposed-work subsections.

## Challenge Statement

Every proposal must contain a challenge statement: one or two sentences that
name the specific technical or scientific barrier being addressed.

- **Be concrete.** "X is an open problem" or "X remains challenging" are not
  sufficient. Name what exactly cannot be done today and why it is hard.
- **Place it prominently.** The challenge statement belongs in the opening
  paragraph of the Problem Statement. Do not bury it in background or
  motivation.
- **Pair with the solution.** Immediately after the challenge, state the
  proposed approach in one sentence. The reader must hold both in mind
  simultaneously.

When reviewing: quote the challenge statement or flag its absence. A vague or
buried challenge is a high-severity structural issue, not a style issue.

## Differentiation from Related Work

The Related Work section must close with an explicit gap statement: what prior
work cannot do, and why this proposal's approach addresses that gap.

- **Do not rely on juxtaposition.** Differentiation implied by side-by-side
  comparison is not enough. State the gap explicitly.
- **Be precise about limits.** For each major prior work cited, state what it
  achieves and where it falls short: "X achieves Y but does not address Z
  because..."
- **Avoid dismissive phrasing.** "X simply does not work" is not a useful
  contrast. Name the specific limitation.
- **One explicit gap sentence.** The last paragraph of Related Work should
  contain at least one sentence of the form: "None of these approaches address
  [specific gap], which is the central challenge this proposal targets."

When reviewing: locate the gap statement or flag its absence. Name the closest
prior work and verify the contrast is explicit, not implied.

## Subsection Motivation

After the proposed work in a subsection, the reader should leave understanding
two things: why it would work, and what it delivers.

- **Check the "so what?" question.** If the answer is not already clear from
  the body text, add a closing paragraph (2–4 sentences) that states the impact
  or benefit — not a summary of what was already said.
- **Do not add redundant motivation.** If the body already makes the rationale
  clear, a closing motivational paragraph only weakens the case by padding.
- **Placement is flexible.** The motivational close often belongs at the end of
  the subsection but need not be — place it where it best serves the argument.

When reviewing: flag subsections where proposed work ends without any rationale
for its benefit. Equally flag where a motivational close duplicates reasoning
already in the body.

## Section Annotation

After drafting each section, annotate it with one of:

- `[SECTION OK]` — section is self-contained, coherent, and complete.
- `[NEEDS WORK: <reason>]` — section has a specific gap or weakness that
  requires attention before submission. The reason must be concrete, for
  example: "missing gap statement", "challenge not quantified",
  "timeline missing milestones".

These annotations are for the author's review pass, not for the final
submission. Remove them before submitting.

## See Also

For sentence-level moves and voice rules — sharp thesis phrasing, the "to our
knowledge" pattern, the "lesson from prior work" reframe, hedge audit, and the
reinforcement-vs-repetition rule — see `skills/research-proposal-style/SKILL.md`.
The drafting rules in this file cover argument *structure* (challenge,
differentiation, motivation); the style skill covers how the prose around those
arguments actually sounds.
