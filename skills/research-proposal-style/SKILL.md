---
name: research-proposal-style
description: Apply this user's preferred style for writing research proposals, grant applications, white papers, and any technical document where they need to persuade reviewers (Amazon Research Awards, NSF, NIH, foundation grants, internal funding pitches, conference proposals, etc.). Use this whenever the user asks for help drafting, revising, restructuring, or sharpening a proposal, an opening section, a project summary, an aims page, an executive summary, or any persuasive technical writing where they want the result to feel scholarly, confident, and concretely argued rather than journalistic, vague, or hedged. Trigger this skill even when the user does not name it — if they are working on a proposal-shaped document and want feedback on flow, framing, or impact, this captures their preferences.
---

# Research Proposal Writing Style

This skill captures a specific user's preferences for persuasive technical writing — primarily research proposals, grant applications, and similar documents aimed at scientific or technical reviewers.

The goal is to produce writing that lands as **scholarly and confident** rather than journalistic or vague, while still being **memorable** rather than dry. The user has rejected purely emotional openings (vignettes, scenes) and purely conventional ones (statistics-only summaries) in favor of a particular middle path described below.

This skill is the funder-agnostic voice layer. It is complementary to NSF-specific composition skills (`nsf-proposal-composer`, `nsf-thrust-refiner`): those skills decide structure, family, unit count, and section-to-file mapping; this skill decides how each section actually reads.

---

## The five-beat opening structure

Every proposal opening should follow this exact storyline arc, in order:

1. **Why this is important.** State the stakes directly. Cite an authoritative source (e.g., a National Academy report, a major review, a definitive statistic). Frame the problem as a *structural* or *systemic* one whenever possible — the kind of problem the proposed work is uniquely positioned to address.

2. **What is missing from existing work.** Name the relevant prior approaches *by name and category* (e.g., "monolithic models like X and Y," "multi-agent frameworks like A, B, and C"). State the specific operational gap they leave open. Frame the gap as a question (or set of questions) the existing work cannot answer. The user likes this gap to be expressible as *the question(s) the field cannot answer*, in italics or bold.

3. **What we propose, and why our framing is sharp.** Introduce the system or approach. Anchor it on a single quotable thesis sentence — a *sharp claim* that reframes the problem space. Examples of the form the user likes: "X is a graph problem, not a prediction problem"; "Y is a coordination problem, not a reasoning problem." This sentence should be bolded and italicized so a reviewer's eye lands on it. Briefly describe the system's components but do not get into mechanism yet.

4. **Why now.** Describe the convergence of conditions that makes this work feasible *and* necessary at this moment, but not three years ago. Typically three independent curves crossing — capability, infrastructure, demand. This section should answer the unspoken reviewer question "why hasn't someone already done this."

5. **How the world will be different (vision).** Close with the world that exists after the work succeeds. Not a deliverables list — a *vision*. The user particularly values endings that argue the work's contribution will become structural to the field (e.g., "five years from now, X will be obvious in the same way that Y is obvious today"). Include a generalization claim if applicable: the methodology extends beyond the immediate domain to other settings the reviewer cares about.

The five beats should fit on the opening page. If they don't, prose is too long, not the structure.

---

## What the user explicitly rejects

These are corrections the user has actually made — treat them as hard constraints, not preferences:

- **No vignettes or scenes opening.** The user finds opening with a fictional patient/case/scenario too journalistic for a research-proposal audience. Worked examples and cases belong later in the document, where they explain methodology by illustrating a figure.
- **No hedged language.** Avoid "we may propose," "we believe this could," "this might enable." Use "we propose," "this enables," "the system identifies." Hedging is read as lack of conviction.
- **No bullet points where prose is sharper.** The opening should be prose paragraphs. Bullets are reserved for contributions lists, evaluation metrics with concrete targets, and risks.
- **No statistics-as-drama.** Don't lead with "X% of patients" or "$Y billion in costs." Use authoritative sources (National Academy reports, peer-reviewed reviews) for stakes-setting, not press-release numbers.
- **No "decoration figures" on the opening page.** Figures must earn their place by explaining methodology. They go in the Research Plan or Methods section, where they are referenced from the prose that introduces them.
- **No vague novelty claims.** Don't write "we are the first to consider X." Write "to our knowledge, no existing system in [named subfield] explicitly represents X." Specificity beats grandeur.

---

## Figures: how the user wants them used

Figures have two jobs in this style:

1. **Architecture overview** — a clean system diagram introduced at the start of the Research Plan section, not in the opening. Boxes for components, arrows for data flow, color-coded by role.
2. **Worked example or case progression** — a multi-panel figure showing the system *working*, not just sitting still. The user particularly values figures that show state evolving over time (T = 0, T = 1, T = 2). When such a figure exists, write the surrounding prose to walk through the panels: "At T = 0, the system... By T = 30 minutes... By T = 65 minutes..."

The worked-example figure is where the *story* lives, displaced from the opening. After walking through the example, end with a sharp three-way comparison that contrasts the proposed system with the two main classes of prior work. The form: "In a [class A], X happens. In a [class B], Y happens. In our system, [the distinguishing capability]." The final clause should be quotable.

---

## Sentence-level moves the user likes

Specific writing moves to reach for:

- **The sharp comparison line.** Compress the contribution against prior work into one sentence with parallel structure. *"They give you an answer; we give you the structure of the case."* *"Their ceiling is the question the prompt asked; ours is the case the patient brought."*
- **The "lesson from prior work" reframe.** When discussing approaches that failed or stalled, name the lesson rather than dismissing them. *"The lesson from CDSS is not that explicit structure is wrong; it is that static structure is wrong."* This signals the writer has thought carefully about the field's history.
- **The "loud failure" pattern.** When discussing reliability, contrast loud failure (the system identifies what's missing) with silent failure (the system gives a confidently-wrong answer). The user finds this distinction load-bearing.
- **Bolded thesis fragments inside paragraphs.** Reviewers skim. A bolded clause like **what is blocking, what is missing, who should resolve it** in the middle of a paragraph survives skimming and gets remembered.
- **"To our knowledge" instead of "the first."** Honest and defensible. Avoids the reviewer reflexively reaching for a counterexample.

---

## Reinforcement, not repetition

The most load-bearing claims — the central thesis, the sharp comparison, the why-now logic — should *recur* across the proposal so the reviewer leaves remembering them. They should not recur as copy-paste. Verbatim repetition reads as filler and signals the writer had nothing else to say.

The rule:

- **One sentence earns a verbatim echo, no others.** The sharp thesis sentence may appear once in the opening and once again in the closing as a deliberate quotable bookend. Every other recurring point gets re-framed.
- **Each recurrence does new work.** If a point appears twice, the second must add a sharper consequence, a more specific implication, or a tie to a different reader concern. If it cannot, cut the second appearance.
- **Reframe across sections.** A thesis like *"X is a graph problem, not a prediction problem"* can show up as the framing claim in the summary, the bolded thesis in the intro, the lens for C1 in the contributions, and the criterion in the evaluation — but each occurrence should foreground a different facet (framing → claim → contribution → measurable consequence).
- **Watch for tells of lazy repetition.** Phrases like "as discussed above," "as mentioned previously," and paragraph openers that copy-paste from earlier sections are signals the writing is reminding itself, not the reviewer.

The test: the reviewer should remember the central claim *because they encountered it in three different lights*, not because they read it three times.

---

## Section structure and naming

After the opening, the user prefers this section order:

1. **Project Overview** (the five-beat opening as one section)
2. **Related Work** — survey by category, not by paper. Each subsection covers one class of approaches and ends with the specific operational gap.
3. **Our Contributions** — bulleted list with C1, C2, C3, C4 labels. Each bullet starts with a bold name, then a sentence stating what is new, then a sentence stating what it unlocks.
4. **Research Plan and Technical Approach** — divided into 4–5 subsections. The architecture figure goes here. The worked-example figure goes in the orchestrator/methods subsection.
5. **Evaluation Plan and Success Criteria** — bullets with concrete numerical targets, not just metric names. Format: *"Diagnostic accuracy. [metrics]. **Target:** [specific number]."*
6. **Risks and Mitigation** — each risk a bullet, mitigation in the same bullet. Treat risks as engineering questions with answers.
7. **Open-Source Contributions and Tools** — what gets released, what infrastructure is used. Combine into one section unless the funder's CFP requires them separated.
8. **Timeline, Budget, and Team** — usually one section with three labeled paragraphs.
9. **References** — selected, not exhaustive (10–15 is the right count for a proposal).

Section titles should be substantive nouns, not verbs. *"Why This Matters"* is acceptable as a heading. *"What We Will Do"* is not — that's the entire proposal.

---

## Concrete numerical targets in evaluation

Every evaluation bullet must include a concrete target. The user has been firm about this.

**Bad:** "We will measure diagnostic accuracy on AgentClinic."
**Good:** "Top-1 and top-5 differential accuracy on MedQA, MedMCQA, NEJM Case Records, and AgentClinic. **Target:** match or exceed MDAgents top-5 on AgentClinic; +5 points top-1 on a held-out NEJM subset."

If a target genuinely cannot be specified (a brand-new metric the field has no baseline for), say so explicitly: *"No prior system has been evaluated on this axis because no prior system claims this capability."* This honesty reads better than a fake target.

---

## Worked example: opening rewrite

This is the kind of revision the user keeps asking for.

**Original draft (too journalistic):**
> A 67-year-old man arrives at the emergency department with chest pain. The triage nurse routes him to internal medicine; an ECG is ordered, but the read is delayed. Three hours later, an aortic dissection is found...

**Rewritten in this style:**
> Diagnostic error is the largest source of preventable harm in modern medicine, and the errors that matter most are rarely failures of any single clinician's reasoning. They are failures of *coordination*: a test result that no one is waiting for, a question no one knew to ask, a finding one specialist saw but never communicated to another. The U.S. National Academy of Medicine concluded in 2015 that essentially every American will experience at least one diagnostic error in their lifetime, and two settings concentrate the harm — emergency-department triage and multi-specialist diagnosis. These are exactly the settings this project targets.

The chest-pain case from the original draft is not deleted — it moves to the methods section where it explains the dependency-graph figure. The opening keeps the *idea* the case was illustrating ("errors live in the seams") without the narrative scaffolding.

---

## When to push back on the user

The user values honest assessment over compliance. If asked to evaluate a draft, do not just compliment — name what is genuinely missing. Specifically watch for:

- A storyline beat present but not in its proper position (e.g., "why now" tucked at the end).
- A thesis sentence that is descriptive rather than sharp ("we model dependencies" is descriptive; "X is a graph problem, not a prediction problem" is sharp).
- Hedged language that snuck in.
- Risks section that is too short or too generic.
- Evaluation metrics without targets.
- Figures that don't earn their place.
- Section titles that are verbs or overly generic.
- A load-bearing sentence repeated verbatim in two places without earning the echo, or recurring points that do not add new work the second time.

When you see one of these, name it directly and offer the specific fix. The user appreciates "honest audit" framing — listing what is and is not in the document and what would make it stronger.

---

## Tone and voice

- **Confident, not boastful.** "We propose" not "we may propose"; "this enables" not "this might enable." But also: "to our knowledge" not "this is the first."
- **Specific, not grand.** Specific named comparisons beat grand sweeping claims.
- **Scholarly, not corporate.** No marketing language ("revolutionary," "cutting-edge," "next-generation" used as a buzzword).
- **Memorable, not viral.** A good thesis sentence is the kind a reviewer might quote to a colleague over coffee. Not the kind that would trend on Twitter.

---

## Quick checklist before delivering a draft

Run through this mentally before showing the user a proposal section:

- [ ] Does the opening follow the five beats in order?
- [ ] Is there a sharp thesis sentence, bolded and italicized?
- [ ] Is "why now" present and concrete (three converging conditions)?
- [ ] Does the closing argue a vision, not just deliverables?
- [ ] Are figures placed where they explain methodology, not as openers?
- [ ] Do contributions have C1, C2, C3 labels with bold-name + what's new + what it unlocks?
- [ ] Do evaluation bullets each have a concrete numerical target?
- [ ] Are risks treated as engineering questions with answers?
- [ ] Has every "may," "might," "could potentially" been audited?
- [ ] Is there at least one sharp comparison line and one "lesson from prior work" reframe?
- [ ] Does each repeated load-bearing claim do new work the second time, or is it copy-paste?
