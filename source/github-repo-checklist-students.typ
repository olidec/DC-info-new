// ─────────────────────────────────────────────────────────────────────────────
// Student Checklist — GitHub Organization & Assignment Repository
// ─────────────────────────────────────────────────────────────────────────────

#let course      = "Computer Science"
#let level       = "Gymnasium Muttenz"
#let term        = "2026-27"
#let lesson-num  = "2"
#let sheet-type  = "Checklist"
#let sheet-title = "GitHub & Your Assignment Repository"

// ── Page setup ────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: rgb("#999999"))
    grid(
      columns: (1fr, 1fr),
      align(left,  [#sheet-type — Lesson #lesson-num]),
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
  "How to use this sheet",
  [Work through the parts in order, ticking boxes as you go. Do not wait for the
   class — if you finish a part early, carry on with the next one. If something
   goes wrong, check the troubleshooting table on the last page before asking.],
)

#v(0.5em)

*Your class organization:* `github.com/gymmu-DC-CS` \
*The template:* `github.com/gymmu-DC-CS/cs-intro-template`

// ─────────────────────────────────────────────────────────────────────────────

#block(breakable: false)[
= Part 1 — Your GitHub Account

If you already created an account in Lesson 1, tick the boxes and move on.

#checklist(
  [Created an account at #link("https://github.com")[github.com].],
  [Chose a sensible username — your name or initials. Your teacher and your
   classmates will see it.],
  [Used an email address you can actually read. You will get an invitation
   email in Part 2.],
  [Confirmed the account through the verification email.],
)
]

#warnbox(
  "⚠ Two-factor authentication",
  [GitHub will probably ask you to set up two-factor authentication (2FA).
   Use an authenticator app on your phone. When GitHub shows you the
   *recovery codes*, save them somewhere you will still find them in June —
   a note in your password manager, or a photo you actually keep. Losing
   access to your account in April is a genuinely annoying problem to have.],
)

// ─────────────────────────────────────────────────────────────────────────────

= Part 2 — Joining the Class Organization

An *organization* on GitHub is a shared space that holds many repositories.
Your class has one. Your work will live inside it, in a private repository
that only you and your teacher can see.

#checklist(
  [Gave your GitHub username to your teacher.],
  [Received the invitation email from GitHub and clicked *Join*. \
   (No email? Go to #link("https://github.com/gymmu-DC-CS")[github.com/gymmu-DC-CS]
   while signed in — the invitation is waiting there too.)],
  [Can see the organization page without a "404" error. This confirms you
   are a member.],
)

#warnbox(
  "⚠ Do not skip this part",
  [You must be a member of the organization *before* Part 3. If you are not,
   the organization will not appear in the dropdown and your repository will
   end up in the wrong place.],
)

// ─────────────────────────────────────────────────────────────────────────────

= Part 3 — Creating Your Assignment Repository

You will make your own copy of the course template. This copy is yours: your
files, your commits, your history.

#steps(
  [Go to
   #link("https://github.com/gymmu-DC-CS/cs-intro-template")[github.com/gymmu-DC-CS/cs-intro-template].],
  [Click the green *Use this template* button, then
   *Create a new repository*.],
  [Under *Owner*, open the dropdown and select *gymmu-DC-CS*. \
   #text(fill: warn)[Not your own username — this is the step people get wrong.]],
  [Under *Repository name*, type exactly: \
   `cs-intro-2627-` followed by your family name in lower case, no spaces,
   no accents. \
   Example: Anna Müller #sym.arrow `cs-intro-2627-mueller`],
  [Set the visibility to *Private*.],
  [Click *Create repository* and wait a few seconds.],
)

#checklist(
  [The repository exists and its address starts with
   `github.com/gymmu-DC-CS/`.],
  [It is marked *Private* next to the repository name.],
  [The starter files are there: `index.html`, `style.css`, `script.js`,
   `README.md`, `JOURNAL.md`.],
)

// ─────────────────────────────────────────────────────────────────────────────

#block(breakable: false)[
= Part 4 — Cloning the Repository in VS Code

*Cloning* means downloading the repository to your own computer so you can work
on it.

#steps(
  [On your repository page, click the green *Code* button, make sure *HTTPS*
   is selected, and copy the URL.],
  [In VS Code, open *View → Command Palette*.],
  [Type `Git: Clone` and select it.],
  [Paste the URL and press Enter.],
  [Choose your `Documents/cs-course` folder as the destination and click
   *Select as Repository Destination*.],
  [When VS Code asks, click *Open* to open the cloned repository.],
  [If VS Code asks you to sign in to GitHub, do so — it needs this to push
   your work later.],
)
]

#warnbox(
  "⚠ Save inside cs-course, not inside lesson-01",
  [The repository is its own folder. Your structure should look like this:
   ```
   cs-course/
   ├── lesson-01/
   │   └── notes.typ
   └── cs-intro-2627-mueller/    ← your assignment repo
       ├── index.html
       ├── style.css
       └── ...
   ```],
)

// ─────────────────────────────────────────────────────────────────────────────

= Part 5 — Your First Commit and Push

This is the loop you will repeat all year: *edit #sym.arrow save #sym.arrow
stage #sym.arrow commit #sym.arrow push*.

#checklist(
  [Opened `README.md` and added your name where the file asks for it.],
  [Saved the file (*File → Save*, or `Ctrl`/`Cmd` + `S`).],
  [Opened the *Source Control* panel in the left sidebar.],
  [Staged `README.md` by hovering over it and clicking the `+` button.],
  [Typed a clear commit message: `Add my name to README`.],
  [Clicked *Commit*.],
  [Clicked *Sync Changes* to push the commit to GitHub.],
  [Refreshed the repository page on GitHub and can see your name in the
   README.],
)

#infobox(
  "A commit that is not pushed does not exist",
  [Committing saves a snapshot on *your laptop only*. Your teacher cannot see
   it, and it is gone if your machine dies. Always follow a commit with a push.
   The last box above is the one that actually matters.],
)

// ─────────────────────────────────────────────────────────────────────────────

= Part 6 — Working On It Later

Every lesson from now on follows the same pattern.

#steps(
  [Open the repository folder in VS Code.],
  [Click *Sync Changes* first, in case anything changed on GitHub.],
  [Do your work. Save often.],
  [Stage and commit each time you finish a small, complete piece of work —
   not once at the end of the lesson.],
  [Push before you close your laptop. Every time, without exception.],
)

#note(
  "Good commit messages",
  [`fixed stuff` tells you nothing in three weeks' time.
   `Add navigation bar to index.html` tells you exactly what changed.
   Your commit history is part of how the project is assessed, so it is
   worth thirty seconds of thought.],
)

// ─────────────────────────────────────────────────────────────────────────────

#pagebreak()

= Troubleshooting

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Problem],
    text(size: 9pt, weight: "bold", fill: white)[What to do],
  ),
  [`gymmu-DC-CS` does not appear in the Owner dropdown],
    [You have not joined the organization yet. Go back to Part 2.],
  [I created the repository under my own username],
    [Do not delete it — you would lose your work. Go to
     *Settings → General*, scroll to the bottom, and choose
     *Transfer ownership* to `gymmu-DC-CS`. Everything is preserved.],
  [There is no *Use this template* button],
    [Check that you are signed in to GitHub. If you still cannot see it,
     tell your teacher — it is a setting on the template, not your mistake.],
  [VS Code says "authentication failed" when pushing],
    [Sign out and back in through the account icon at the bottom-left of
     VS Code, then try *Sync Changes* again.],
  [I committed but my teacher cannot see my work],
    [You have not pushed. Look for *Sync Changes* in the Source Control panel
     with a small number next to it — that number is how many commits are
     stuck on your laptop.],
  [I cannot find my repository],
    [Go to #link("https://github.com/gymmu-DC-CS")[github.com/gymmu-DC-CS]
     and open the *Repositories* tab. Yours is there if you created it
     correctly. You will not see your classmates' repositories, and that is
     intentional.],
  [I opened `index.html` on GitHub and it shows code, not a web page],
    [That is normal — GitHub displays source code. To see the actual page,
     open the file from your own `cs-course` folder in a browser.],
)

#v(0.5em)

#infobox(
  "You are set up",
  [Everything you submit for the rest of the year uses exactly this workflow.
   The tools feel clumsy for about two weeks and then become invisible.],
)
