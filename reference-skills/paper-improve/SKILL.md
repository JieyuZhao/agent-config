---
name: paper-improve
description: Diagnose and rewrite academic writing at the paragraph or sentence level. Use when the user shares text from a research paper and wants feedback on logic, clarity, or writing quality. Triggers on requests like "review this paragraph", "rewrite this", "make this clearer", "is this logically sound", "polish this", or when the user pastes academic text and asks for help. Produces a structured diagnosis (claim, logic, evidence, scope, cohesion) followed by a rewritten version with a change log.
---

# Paper Improve

## Overview

Use this skill when the user wants to improve the writing quality of their own
academic text — paragraphs, sentences, or short sections.

This skill is for writing improvement, not peer review. For writing a full
conference or journal review of someone else's paper, use `cs-paper-review`
instead.

Two modes, applied together by default:

- **Mode 1: Diagnose** — identify logical and structural problems before rewriting
- **Mode 2: Rewrite** — produce a cleaner version with a change log explaining each edit

If the user says "just rewrite" — skip the diagnosis. If they say "just review
the logic" — skip the rewrite. Default is both.

## Mode 1: Diagnose

Before rewriting anything, diagnose the paragraph. Present a compact diagnostic
block covering:

1. **Claim** — what is the core claim or argument? State it in one sentence.
2. **Logic** — do the sentences follow a coherent progression? Flag:
   - logical leaps (conclusion not supported by preceding sentences)
   - circular reasoning
   - missing links (implicit assumptions the reader must guess)
   - redundancy (sentences that repeat the same point without adding value)
3. **Evidence** — are claims backed by concrete evidence, or vague? Flag:
   - unsupported assertions ("X is well-known" without citation)
   - ambiguous quantifiers ("many", "often", "significantly" without data)
   - undefined jargon or acronyms on first use
4. **Scope** — is the claim appropriately scoped? Flag:
   - overclaiming (universal claim, narrow evidence)
   - under-hedging (missing "may", "can", "in our experiments")
   - over-hedging (so many qualifiers the point is lost)
5. **Cohesion** — does the paragraph connect to surrounding context? Flag:
   - missing topic sentence
   - dangling references ("this" or "these" without clear antecedent)
   - abrupt transitions

### Diagnostic output format

```
DIAGNOSIS
- Claim: [one sentence]
- Logic: [OK | issue description]
- Evidence: [OK | issue description]
- Scope: [OK | issue description]
- Cohesion: [OK | issue description]
```

Keep each line to 1–2 sentences. Be direct. No filler.

## Mode 2: Rewrite

After the diagnosis, produce a rewritten version applying these principles:

1. **One idea per sentence.** If a sentence carries two claims, split it.
2. **Subject-verb-object proximity.** Keep the subject and main verb close. Avoid burying the verb after long subordinate clauses.
3. **Active voice by default.** Use passive only when the agent is unknown or the object deserves emphasis (common in Methods sections).
4. **Cut filler.** Remove "it is worth noting that", "it should be mentioned that", "in order to", "the fact that". Just state the point.
5. **Precise verbs.** Replace "do/make/get/have" with specific verbs. "We obtained results" → "We measured / observed / computed results".
6. **Concrete over abstract.** Replace "a significant improvement" with "a 12% improvement in F1 score".
7. **Parallel structure.** Lists and comparisons should use the same grammatical pattern.
8. **Strong topic sentences.** Each paragraph should open with a sentence that signals its purpose.
9. **Explicit logical connectors.** Use "however", "consequently", "specifically", "in contrast" to make the argument's skeleton visible — but do not overuse them.
10. **No synonym cycling.** In technical writing, repeat the same term for the same concept. Do not swap terms for variety if it creates ambiguity.

### Rewrite output format

Present the rewrite as a clean block. Below it, add a brief **Change Log**
noting the key edits and why each change was made. List only substantive
changes, not every comma.

## Interaction Guidelines

- **Ask for context when needed.** If a term or acronym is unclear, ask the
  user what it means before rewriting. Precision requires understanding.
- **Respect the author's voice.** Do not over-polish to the point it sounds
  like a different person wrote it. Preserve intentional technical choices.
- **Flag domain concerns separately.** If a claim seems empirically
  questionable, flag it — but clearly separate domain feedback from writing
  feedback.
- **Be honest.** If the writing is already good, say so. Do not manufacture
  problems.
- **Batch mode.** If the user pastes multiple paragraphs, process each one
  separately with its own diagnosis and rewrite block.

## Output Style

Prefer one of these outcomes:

- diagnosis only (when the user asks for logic check)
- rewrite only (when the user asks to just fix it)
- diagnosis + rewrite + change log (default)
