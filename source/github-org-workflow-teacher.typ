// ─────────────────────────────────────────────────────────────────────────────
// GitHub Organization Workflow — Teacher Guide
// ─────────────────────────────────────────────────────────────────────────────

#let course     = "Computer Science"
#let level      = "Gymnasium Muttenz"
#let term       = "2026-27"
#let lesson-num = "—"
#let sheet-type = "Teacher Guide"
#let sheet-title = "GitHub Organization Workflow"

// ── Page setup ────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: rgb("#999999"))
    grid(
      columns: (1fr, 1fr),
      align(left,  [#sheet-type — #sheet-title]),
      align(right, [#course — #level]),
    )
    line(length: 100%, stroke: 0.4pt + rgb("#999999"))
  },
  footer: context {
    set text(size: 9pt, fill: rgb("#999999"))
    align(center, counter(page).display("1"))
  },
)

// ── Heading styles ────────────────────────────────────────────────────────────
#show heading.where(level: 1): it => {
  v(1.2em)
  text(size: 11pt, weight: "bold", fill: rgb("#111111"), upper(it.body))
  v(0.15em)
  line(length: 100%, stroke: 1pt + rgb("#2E6DA4"))
  v(0.5em)
}

#show heading.where(level: 2): it => {
  v(0.6em)
  text(size: 11pt, weight: "bold", fill: rgb("#111111"), it.body)
  v(0.2em)
}

// ── Import shared styles and components ───────────────────────────────────────
#import "../cs-style.typ": *

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

#infobox(
  "What this replaces",
  [GitHub Classroom is decommissioned as of 28 August 2026. This document
   describes the plain-GitHub workflow that replaces it: students create
   their own repositories from a template inside the course organization.
   No third-party tooling is involved — only GitHub itself and the `gh`
   command-line tool on the teacher's machine.],
)

#v(0.5em)

*Organization:* `gymmu-DC-CS` #h(1fr) *Template:* `cs-intro-template`

// ─────────────────────────────────────────────────────────────────────────────

= Part 1 — One-Time Organization Setup

Do this once, before the first lesson. All settings are under
*Organization → Settings*.

== Member privileges

#checklist(
  [*Base permissions* set to *No permission*. This is the critical one — the
   default of `Read` would let every student browse every other student's
   repository.],
  [*Repository creation:* allow *Private*, disallow *Public*. Students need
   private-repo creation for the template workflow; blocking public creation
   prevents accidental publishing of student work.],
  [*Repository forking:* disabled. Not needed, and prevents a student
   forking a classmate's repo if permissions are ever loosened.],
  [*Two-factor authentication:* do *not* switch on "Require two-factor
   authentication". It will lock out students who have not set it up and
   silently remove them from the organization.],
)

== Ownership and visibility

#checklist(
  [Confirm you are listed as an *Owner* under *People → Owners*.],
  [Add a colleague as a second owner. If your account is ever locked, someone
   else must be able to reach the student repositories.],
  [Under *Member privileges → Membership visibility*, consider setting new
   members to *Private* so the member list is not publicly browsable.],
)

== Teams

Create one team per class cohort under *Teams → New team* — for example
`dc-2627`. Teams give you a roster view and let you grant or revoke access in
bulk without touching individual repositories.

#note(
  "Apply for GitHub Education",
  [A verified educational organization receives GitHub Team features at no
   cost. Apply at #link("https://education.github.com")[education.github.com]
   with proof of employment. Verification can take a few days, so do it well
   before the term starts.],
)

// ─────────────────────────────────────────────────────────────────────────────

= Part 2 — Preparing the Template Repository

#steps(
  [*Transfer the template into the organization.* On
   `olidec/cs-intro-template`, go to *Settings → General → Danger Zone →
   Transfer ownership* and transfer to `gymmu-DC-CS`. GitHub redirects the old
   URL, so any link you have already shared keeps working.],
  [*Confirm the template flag.* In *Settings → General*, the checkbox
   *Template repository* must be ticked. Without it, the green
   *Use this template* button does not appear.],
  [*Keep the template public.* Students need read access to create a repository
   from it, and the `No permission` base setting blocks org members from
   reading private repos they are not collaborators on. A public template is
   fine here because it contains only an empty skeleton — never put solutions
   in a template repository.],
  [*Check the file structure* matches what the lesson notes promise:
   `index.html`, `style.css`, `script.js`, `README.md`, `JOURNAL.md`,
   `.gitignore`.],
)

#warnbox(
  "⚠ One template, many assignments",
  [You do not need a separate template per week. The `cs-intro` repository grows
   across weeks 2–5 in the same repo. Create a second template
   (`cs-project-template`) only for the graded project in week 8.],
)

// ─────────────────────────────────────────────────────────────────────────────

= Part 3 — Onboarding the Students

Students must be organization members *before* they create their repository —
otherwise the organization does not appear in the owner dropdown.

#steps(
  [Collect GitHub usernames. The simplest method is a shared spreadsheet or a
   form filled in during the lesson. Keep this list: usernames are often not
   recognisable as names, and you will need the mapping all year.],
  [Invite in bulk: *People → Invite member*, paste a username, choose the class
   team, send. Repeat. There is no CSV import in the plain-GitHub flow.],
  [Alternatively, invite from the command line, which is faster for a full
   class:

   ```bash
   gh api -X POST /orgs/gymmu-DC-CS/invitations \
     -f invitee_id=<numeric-id> -f role=direct_member
   ```
   ],
  [Check *People → Pending invitations* at the start of the next lesson and
   chase anyone who has not accepted.],
)

#note(
  "Two practical snags",
  [*Age:* GitHub's terms require users to be at least 13. Your cohort is fine,
   but a repeating student born late in the year is worth a thought. \
   *2FA:* GitHub prompts most new accounts to set up two-factor authentication.
   Warn students to use an authenticator app on their phone and to save the
   recovery codes somewhere they will still have them in June.],
)

// ─────────────────────────────────────────────────────────────────────────────

= Part 4 — Distributing an Assignment

There is no "assignment link" any more. Distribution is: give students the
template URL and the naming convention.

#infobox(
  "Naming convention",
  [`cs-intro-2627-<lastname>` \
   Include the term so that next year's cohort does not collide, and use the
   family name rather than the GitHub username so that repositories are
   identifiable at a glance in the organization listing.],
)

What you announce in the lesson:

#steps(
  [The template URL: `github.com/gymmu-DC-CS/cs-intro-template`],
  [The exact repository name each student should use.],
  [That *Owner* must be set to `gymmu-DC-CS`, not their personal account.],
  [That visibility must be *Private*.],
)

Because you are an organization owner, every repository created inside the
organization is automatically visible to you. Students do not need to add you
as a collaborator, and there is no acceptance step to monitor.

#warnbox(
  "⚠ The one mistake that will happen",
  [Some students will create the repository under their personal account
   instead of the organization. The fix is
   *Settings → General → Danger Zone → Transfer ownership → `gymmu-DC-CS`*.
   Check the organization repository list at the end of the first lab and
   catch these immediately — it is much harder to untangle in week 5.],
)

// ─────────────────────────────────────────────────────────────────────────────

= Part 5 — Collecting Submissions

== Quick check during a lesson

Open `github.com/orgs/gymmu-DC-CS/repositories` and sort by *Last updated*.
Anyone whose repository has not been touched today has not pushed. This is the
fastest in-lesson diagnostic you have.

== Cloning everything for offline marking

Install the GitHub CLI once (`brew install gh`, `winget install GitHub.cli`,
or your package manager), authenticate with `gh auth login`, then:

```bash
# List every cs-intro repo for this cohort
gh repo list gymmu-DC-CS --limit 200 | grep cs-intro-2627

# Clone them all into a dated folder
mkdir -p submissions/$(date +%Y-%m-%d) && cd submissions/$(date +%Y-%m-%d)
gh repo list gymmu-DC-CS --limit 200 --json name \
  --jq '.[].name | select(startswith("cs-intro-2627"))' \
  | xargs -I {} gh repo clone gymmu-DC-CS/{}
```

Re-running on a later date creates a fresh folder, so you keep a snapshot of
each collection point rather than overwriting the previous one.

== Pulling updates instead of re-cloning

```bash
for d in */; do (cd "$d" && git pull --quiet && echo "updated $d"); done
```

// ─────────────────────────────────────────────────────────────────────────────

= Part 6 — Viewing and Assessing

== What to look at, and where

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[What you want to see],
    text(size: 9pt, weight: "bold", fill: white)[Where to find it],
  ),
  [The rendered page],
    [Clone locally and open `index.html`, or use the VS Code Live Preview
     extension. Viewing the raw file on GitHub shows source, not the page.],
  [Commit history and message quality],
    [Repository → *Commits*, or locally:
     `git log --oneline --graph --date=short --pretty=format:'%h %ad %s'`],
  [Work pattern over time],
    [Repository → *Insights → Commits*. A single commit at 23:40 the night
     before the deadline tells a different story from twelve commits across
     four weeks — relevant to the *Process* criterion in the project rubric.],
  [What changed between two points],
    [Repository → *Compare*, or `git diff <old-sha> <new-sha>`],
  [The learning log],
    [`JOURNAL.md` renders directly on the repository front page area — no
     cloning needed for a quick read.],
)

== Giving feedback

GitHub Classroom's "feedback pull request" has no direct equivalent, but two
plain-GitHub mechanisms work as well or better:

#steps(
  [*Open an issue* on the student's repository (*Issues → New issue*). The
   student is notified by email, can reply in the thread, and can close it when
   addressed. This is the closest thing to a written comment sheet, and it
   keeps the feedback attached to the work.],
  [*Comment on a specific line.* Open any commit, hover the line number, click
   the blue `+`. Precise, and far more useful than "your CSS is messy".],
)

#note(
  "Enable issues on student repositories",
  [Issues are on by default for new repositories. If you disable them in the
   template, you lose this feedback channel — leave them enabled.],
)

== Optional: live student sites

If your organization is verified for GitHub Team, you can enable GitHub Pages
on a private repository, which publishes the site at a public URL. For a web
development course this is genuinely motivating — students can send their
parents a link. Check the current plan requirements before promising it, and
consider whether publishing 14-year-olds' work at a public address is
appropriate for your school; it is a good discussion to hold alongside the
privacy lesson rather than a decision to make silently.

// ─────────────────────────────────────────────────────────────────────────────

= Part 7 — End of Year

#checklist(
  [Clone a final snapshot of every repository for your records.],
  [*Archive* rather than delete each repository (*Settings → Archive this
   repository*). Archived repositories become read-only, stay searchable, and
   remain available if a student later asks for their work.],
  [Remove the departing cohort from the organization (*People → Remove from
   organization*). They lose access to the organization but keep their GitHub
   accounts; if they want a personal copy of their work, they should clone or
   download it *before* you remove them — tell them this in the last lesson.],
  [Delete the class team, or rename it to mark it as finished.],
)

// ─────────────────────────────────────────────────────────────────────────────

= Troubleshooting Reference

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Symptom],
    text(size: 9pt, weight: "bold", fill: white)[Cause and fix],
  ),
  [Student cannot select the organization as owner],
    [They have not accepted the invitation yet, or `Members can create private
     repositories` is off. Check *People → Pending invitations* first.],
  [No *Use this template* button],
    [The template flag is not set on the repository, or the student is not
     signed in.],
  [Repository ended up in the student's personal account],
    [*Settings → Danger Zone → Transfer ownership* to `gymmu-DC-CS`.
     Commit history is preserved.],
  [Student pushed but you see nothing],
    [Almost always committed without pushing. Have them check the Source
     Control panel for the "Sync Changes" button with a pending count.],
  [Push rejected, "authentication failed"],
    [The credential helper has stale credentials. Signing out and back in via
     the VS Code account menu resolves it in most cases.],
  [Student repository is public by mistake],
    [*Settings → General → Danger Zone → Change visibility → Private*.
     Tightening organization settings prevents recurrence.],
)

#infobox(
  "The trade-off, stated honestly",
  [This workflow costs roughly two extra minutes of lesson time in week 2
   compared with GitHub Classroom, and gives up the roster dashboard and the
   one-click bulk clone. In exchange it removes a whole layer of tooling that
   can break, and every step the students perform is a real GitHub operation
   they will recognise outside this course. Given that the alternatives are
   themselves new and unproven this year, that is a reasonable trade.],
)
