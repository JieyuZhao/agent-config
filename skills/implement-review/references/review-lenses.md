# Review Lenses

Content-type-specific criteria for Codex reviews. Each lens is grounded in established review frameworks so the reviewer applies recognized standards rather than ad-hoc checks. The review request should include the relevant lens so Codex knows what to focus on.

## Code

Based on Google's eng-practices code review guidelines and Microsoft's Engineering Fundamentals Playbook.

1. **Design** -- Does the change belong here or in a library? Do the pieces interact sensibly? Does it fit the system's architecture? (Google)
2. **Functionality** -- Does it do what the developer intended? Check edge cases, concurrency, and race conditions. (Google)
3. **Complexity** -- Can a reader understand it quickly? Is any part over-engineered or prematurely generalized? Flag functions with more than three arguments. (Google, Microsoft)
4. **Security and data protection** -- Injection, hardcoded secrets, unsafe deserialization, OWASP top-10 issues. Any PII or customer data exposure? (Microsoft)
5. **Error handling** -- Are errors handled gracefully and explicitly? Are failure modes clear? (Microsoft)
6. **Tests** -- Are new behaviors covered? Do existing tests still make sense? Will they actually fail when the code breaks? (Google)
7. **Naming and readability** -- Are names clear and proportional? Is control flow easy to follow? (Google)
8. **Consistency** -- Does the change follow the style guide? If the guide is silent, is it consistent with surrounding code? (Google)
9. **Performance** -- Obvious inefficiencies, unnecessary allocations, or algorithmic complexity issues? (Microsoft)
10. **Documentation** -- If the change affects how users build, test, or interact with the code, is documentation updated? (Google)

Overarching standard: approve once the change *definitely improves overall code health*, even if it is not perfect. Seek continuous improvement, not perfection. (Google)

## Paper

Based on NeurIPS, ICLR, ICML, and ACL Rolling Review guidelines.

1. **Soundness** -- Are claims well-supported by theoretical analysis or experimental evidence? Are there methodological flaws? (NeurIPS 1-4, ACL 1-5)
2. **Novelty and originality** -- Does the work present new ideas, methods, or combinations? How does it differ from prior work? (NeurIPS, ICLR, AAAI)
3. **Significance** -- Does it address an important problem? Will it influence future research or practice? (NeurIPS 1-4, ICLR)
4. **Clarity and presentation** -- Can a knowledgeable reader follow the exposition? Is it well-organized? (NeurIPS 1-4, ICLR)
5. **Related work** -- Are key references present and fairly characterized? Is the positioning in the literature accurate? (ICLR, AISTATS)
6. **Reproducibility** -- Is there enough detail (setup, hyperparameters, code, data) to reproduce the results? (ACL 1-5, AISTATS)
7. **Figures and tables** -- Do they add information? Are captions self-contained? Are axes labeled and readable?
8. **Limitations and ethical concerns** -- Are limitations honestly disclosed? Any potential negative societal impact? (NeurIPS, ACL)
9. **Writing quality** -- Grammar, consistency of notation, adherence to venue style.

Optional scoring dimensions (useful when preparing venue-style reviews):
- Soundness: 1-4. Presentation: 1-4. Contribution: 1-4. Overall: 1-10. Confidence: 1-5.

## Proposal

Based on NSF Merit Review criteria and NIH Simplified Peer Review Framework (January 2025).

### NSF lens (two criteria, five elements each)

**Intellectual Merit** -- potential to advance knowledge within or across fields.
**Broader Impacts** -- potential to benefit society and achieve desired societal outcomes.

Five elements applied to both criteria:
1. **Creative and transformative potential** -- Does it explore original or potentially transformative concepts?
2. **Quality of plan** -- Is the plan well-reasoned, well-organized, with a mechanism to assess success?
3. **Qualifications** -- Is the team qualified to conduct the proposed activities?
4. **Resource adequacy** -- Are resources (institutional, collaborative) sufficient?
5. **Portfolio fit** -- Does it address gaps or build capacity in emerging areas?

Rating scale: Excellent / Very Good / Good / Fair / Poor (narrative, no numerical score).

### NIH lens (three factors, post-January 2025)

1. **Importance of the research** (Significance + Innovation) -- Does it address an important gap? Is the approach a conceptual or technical advance? (Scored 1-9)
2. **Rigor and feasibility** (Approach) -- Will compelling, reproducible findings result? Is the timeline realistic? (Scored 1-9)
3. **Expertise and resources** (Investigators + Environment) -- Is expertise appropriate? Are institutional resources sufficient? (Binary: Sufficient / Gaps Identified)

### Common proposal dimensions (all agencies)

1. **Alignment with call** -- Does the narrative address the solicitation requirements point by point?
2. **Feasibility** -- Is the timeline realistic? Are risks and mitigation strategies acknowledged?
3. **Significance and impact** -- Is the contribution clearly articulated?
4. **Budget justification** -- Do requested resources match the proposed activities?
5. **Clarity** -- Can a panel reviewer skim and extract the key points?
6. **Formatting** -- Page limits, required sections, font and margin compliance.

## Focused Sub-Lenses and Agency-Specific Lenses

Full lenses cover all criteria for a content type. Two kinds of narrower lens are available:

- **Focused sub-lenses** select a subset of the parent lens criteria. Use them when the change is narrow (e.g., formatting only, tests only) or when the full lens produces too much generic feedback.
- **Agency-specific lenses** replace the generic proposal lens with the evaluation framework for a known agency. They are complete lenses, not subsets.

If unsure which to use, use the full parent lens and add an "additional focus" to the review prompt.

### Focused sub-lenses

| Name | Parent | Criteria | When to use |
|---|---|---|---|
| `code/security` | Code | Items 4, 5 (security, error handling) | Security-sensitive changes, dependency updates |
| `code/tests` | Code | Items 6, 2 (tests, functionality) | Test-only changes or changes that should have tests |
| `paper/formatting` | Paper | Items 7, 9 (figures/tables, writing quality) | Layout, style, or venue compliance changes |
| `paper/content` | Paper | Items 1-5 (soundness through related work) | Substantive content or argument changes |
| `paper/submission-ready` | Paper | Items 7, 8, 9 plus anonymization checks and page-limit compliance | Blind-submission preparation (pre-acceptance) |
| `proposal/compliance` | Proposal | Common items 1, 6 (alignment with call, formatting) | Formatting and solicitation compliance checks |

When using a focused sub-lens, include only the referenced parent criteria in the review prompt, not the full lens. For `paper/submission-ready`, also add: verify no author-identifying information remains and confirm the paper meets venue page limits.

### Agency-specific lenses

| Name | Replaces | Framework | When to use |
|---|---|---|---|
| `proposal/nsf` | Proposal (generic) | NSF Merit Review: Intellectual Merit, Broader Impacts, five elements each | NSF proposals when agency is known |
| `proposal/nih` | Proposal (generic) | NIH Simplified Peer Review: Importance, Rigor and Feasibility, Expertise and Resources | NIH proposals when agency is known |

When using an agency-specific lens, include the full agency framework from the Proposal section above (NSF or NIH subsection). Always also include the Common proposal dimensions (alignment with call, feasibility, significance, budget, clarity, formatting), as these apply regardless of agency.

## General

Fallback lens when content type does not match the above or is mixed.

1. **Completeness** -- Does the change cover what was intended? Anything missing?
2. **Correctness** -- Are facts, logic, and references accurate?
3. **Consistency** -- Does the change match the style and conventions of the surrounding content?
4. **Clarity** -- Is the writing or code easy to understand?
5. **Over-engineering** -- Is anything more complex than it needs to be?
6. **Impact on existing work** -- Does the change break or conflict with anything already in place?
