// ─────────────────────────────────────────────────────────────────────────────
// Setup Checklist — Lessons 1 & 2
// ─────────────────────────────────────────────────────────────────────────────

#let course     = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-num = "1-2"
#let sheet-type = "Setup Checklist"
#let sheet-title = "Software, Git & GitHub"

// ── Page setup ────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: rgb("#999999"))
    grid(
      columns: (1fr, 1fr),
      align(left,  [#sheet-type — Lessons #lesson-num]),
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
  [Work through each section in order, ticking boxes as you go. You do not
   need to wait for the teacher — if you finish Part 1 early, continue with
   Part 2. Refer to the lesson notes if you are unsure about any step.],
)

// ─────────────────────────────────────────────────────────────────────────────
// PART 1
// ─────────────────────────────────────────────────────────────────────────────

#block(breakable: false)[
= Part 1 — Software Installation #h(1fr) #text(size: 9pt, fill: muted)[Lesson 1]

== Before you start

Fill in the table below so the teacher can support you quickly if needed.

#table(
  columns: (1fr, 1fr),
  stroke: 0.4pt + rgb("#CCCCCC"),
  fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Question],
    text(size: 9pt, weight: "bold", fill: white)[Your answer],
  ),
  [Operating system (Windows / macOS)], [],
  [OS version (e.g. Windows 11, macOS Sonoma)], [],
  [Is VS Code already installed?], [],
  [Is Git already installed?], [],
)
]

== Installing VS Code

#checklist(
  [Went to #link("https://code.visualstudio.com") and downloaded the installer.],
  [Ran the installer with default settings. \
   *Windows only:* confirmed that "Add to PATH" was checked.],
  [Opened VS Code — the welcome screen appeared.],
)

#block(breakable: false)[
== Installing Git

#checklist(
  [*Windows:* downloaded from #link("https://git-scm.com/download/win") and ran
   the installer, selecting VS Code as the default editor and choosing
   "Git from the command line and also from 3rd-party software" for PATH.],
  [*macOS:* ran `git --version` in Terminal and installed Xcode Command Line
   Tools when prompted.],
)
]

== Verifying the installation

Open VS Code, then open a terminal via *Terminal → New Terminal*.
Run the following commands and write the output you see:

#table(
  columns: (auto, 1fr),
  stroke: 0.4pt + rgb("#CCCCCC"),
  fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Command],
    text(size: 9pt, weight: "bold", fill: white)[Output on your machine],
  ),
  `git --version`, [],
  `code --version`, [],
)

#checklist(
  [Both commands printed a version number (not an error).],
)

== Configuring Git

Run the following two commands in the terminal, replacing the placeholder
text with your own details:

```
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Then verify with:

```
git config --global --list
```

#checklist(
  [Name and email appear correctly in the output of `git config --global --list`.],
)

#warnbox(
  "⚠ Which email should I use?",
  [Use the same address you will use to sign up to GitHub in Part 2.
   This information is used by Git internally to label your commits and
   is not shared with or distributed to any third party.],
)

#block(breakable: false)[
== Installing Tinymist

#checklist(
  [Opened the Extensions panel in VS Code via *View → Extensions*.],
  [Searched for *Tinymist* and installed *Tinymist Typst*.],
  [Created a file called `notes.typ` in `Documents/cs-course/lesson-01/`.],
  [Clicked the preview button — live preview appeared on the right.],
  [Wrote a first learning log entry and saved the file.],
)
]

// ─────────────────────────────────────────────────────────────────────────────
// PART 2
// ─────────────────────────────────────────────────────────────────────────────

#block(breakable: false)[
= Part 2 — Git & GitHub #h(1fr) #text(size: 9pt, fill: muted)[Lesson 2]

== Creating a GitHub account

#checklist(
  [Went to #link("https://github.com") and created an account.],
  [Chose a sensible username (name or initials — visible to the teacher).],
  [Confirmed the account via the verification email.],
)
]

== Accepting the GitHub Classroom assignment

#checklist(
  [Clicked the assignment link provided by the teacher.],
  [Clicked *Accept this assignment* — GitHub created a private repository.],
  [Opened the repository page and recognised the starter files:
   `index.html`, `style.css`, `script.js`, `README.md`, `JOURNAL.md`.],
)

#block(breakable: false)[
== Cloning the repository in VS Code

#checklist(
  [Copied the HTTPS URL from the green *Code* button on the repository page.],
  [Used *View → Command Palette → Git: Clone* and pasted the URL.],
  [Saved the repository inside `Documents/cs-course/` (not inside `lesson-01`).],
  [Opened the cloned repository in VS Code — files appear in Explorer.],
)
]

== First commit and push

#checklist(
  [Opened `README.md` and added your name where indicated.],
  [Saved the file (*File → Save*).],
  [Opened the Source Control panel and staged `README.md` using the *+* button.],
  [Typed a commit message: `Add my name to README`.],
  [Clicked *Commit*.],
  [Clicked *Sync Changes* to push to GitHub.],
  [Refreshed the repository page on GitHub — your name is visible in the README.],
)

#infobox(
  "You're set up — this is the workflow you'll use all year",
  [Every piece of work you submit will follow the same loop: \
   *edit → save → stage → commit → push.* \
   The tools will become second nature quickly.],
)

// ─────────────────────────────────────────────────────────────────────────────
// TERMINAL EXERCISES
// ─────────────────────────────────────────────────────────────────────────────

#block(breakable: false)[
= Terminal Exercises #h(1fr) #text(size: 9pt, fill: muted)[If you finish early]

These exercises are for students who finish Parts 1 and 2 with time to spare.
They are not required, but they will make the rest of the course easier.

#exercise(title: "Navigating the file system", points: none)[
  In the VS Code terminal, try the following commands and write what you observe.

  #table(
    columns: (auto, 1fr),
    stroke: 0.4pt + rgb("#CCCCCC"),
    fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
    inset: 8pt,
    table.header(
      text(size: 9pt, weight: "bold", fill: white)[Command],
      text(size: 9pt, weight: "bold", fill: white)[What happened?],
    ),
    `pwd`, [],
    `ls`, [],
    `cd Documents`, [],
    `pwd`, [],
    `ls`, [],
  )

  #v(0.4em)
  In your own words, what does `cd` do?
  #answer-space(lines: 2)
]
]

#exercise(title: "Creating folders from the terminal", points: none)[
  Using only terminal commands, create the following folder structure
  inside your `cs-course` folder:

  ```
  cs-course/
  └── practice/
      └── test-folder/
  ```

  Write the commands you used:

  ```bash
  # Write your commands here



  ```

  #hint[`mkdir folder-name` creates a folder. Use `cd` to move into it first.]
]
