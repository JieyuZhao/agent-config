# Template Mapping

Use this file when a solicitation requirement needs to be mapped onto a standard NSF proposal repository layout.

## Common component mapping

- `Project Summary` -> usually a dedicated summary file such as `template/00-project-summary.tex`
- `Project Description` -> usually the main narrative file such as `template/00-project-description.tex`
- `References Cited` -> usually embedded in the main narrative build or a bibliography include
- `Data Management Plan` -> often `template/31-data-management.tex`
- `Facilities, Equipment and Other Resources` -> often `template/34-facility.tex`
- `Collaboration Plan` -> often `template/32-collaboration-plan.tex`
- `Broadening Participation in Computing Plan` -> often `template/33-bpc.tex`
- `Collaborators and Other Affiliations` -> often `template/30-collaborators.tex`
- `Results from Prior NSF Support` -> often `template/21-prior-nsf-support.tex`
- `Letters of Collaboration` -> stored under `<proposal-dir>/letters/`; reusable Word templates in `template/letters/`
- `Letters of Support` -> same directory, but only when the solicitation explicitly requires them
- `Team collaboration and qualification` -> often tracked in `template/03-team-qualification.tex`

## Current repository mapping

This repository keeps the reusable template under `template/`:

- `template/00-project-summary.tex`
- `template/00-project-description.tex`
- `template/03-team-qualification.tex`
- `template/20-evaluation.tex`
- `template/21-prior-nsf-support.tex`
- `template/30-collaborators.tex`
- `template/31-data-management.tex`
- `template/32-collaboration-plan.tex`
- `template/33-bpc.tex`
- `template/34-facility.tex`

Use these files as default landing zones only when the solicitation actually requires the corresponding content.

## Letters of Collaboration vs. Letters of Support

NSF distinguishes two letter types under PAPPG 24-1:

- **Letters of Collaboration** (permitted under PAPPG for substantial unfunded
  collaborations unless the solicitation says otherwise). Go in Supplementary
  Documentation. Must be limited to stating intent to collaborate. Must NOT
  contain endorsements or evaluations of the proposed project. Use the PAPPG
  recommended single-sentence format.
- **Letters of Support** (only when the solicitation explicitly requires them).
  More detailed, may describe the nature of support. Submitting unsolicited
  letters of support may cause the proposal to be returned without review.

Reusable Word templates for both types are in `template/letters/`:

- `nsf-letter-of-collaboration-template.docx` -- standard PAPPG single-sentence format
- `nsf-letter-of-support-template.docx` -- academic-support example; adapt categories
  and commitments to match the solicitation's specific requirements

When populating letters for a new proposal, copy the appropriate template into
`<proposal-dir>/letters/`, pre-fill the proposal info (title, PI, program),
rename per collaborator, and send the `.docx` for the collaborator to add
letterhead and signature. The collaborator returns a signed PDF.

### Preflight check

During preflight, verify:

1. The solicitation requires or permits the letter type being submitted.
2. Collaboration letters use only the PAPPG template language (no endorsements).
3. Support letters are present only when the solicitation explicitly requests them.
4. Every substantial unfunded collaborator mentioned in the Project Description
   or Facilities section has a corresponding letter in `<proposal-dir>/letters/`.
   Budgeted collaborators (subawards, consultants) and non-person resource
   mentions do not require a letter unless the solicitation says otherwise.
