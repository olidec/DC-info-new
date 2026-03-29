// ─────────────────────────────────────────────────────────────────────────────
// Exercise Sheet — Lesson 1: Setup & First Steps
// ─────────────────────────────────────────────────────────────────────────────

#let course     = "Computer Science"
#let level      = "High School"
#let term       = "[Term / Year]"
#let lesson-num = "1"
#let sheet-type = "Exercise Sheet"
#let sheet-title = "Setup & First Steps"

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

// ── Heading styles (no numbering for exercise sheets) ─────────────────────────
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
#import "cs-style.typ": *

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

= Getting Oriented

Before you start installing software, take a few minutes to check what is already
on your machine and note it down. This helps the teacher support you more quickly
if something goes wrong.

#exercise(title: "System check")[
  Fill in the table below about your device.

  #table(
    columns: (auto, 1fr),
    stroke: 0.4pt + rgb("#CCCCCC"),
    fill: (_, row) => if calc.odd(row) { light } else { white },
    inset: 8pt,
    table.header(
      text(weight: "bold")[Question],
      text(weight: "bold")[Your answer],
    ),
    [Operating system (Windows / macOS)], [],
    [OS version], [],
    [Is VS Code already installed?], [],
    [Is Git already installed?], [],
  )
]

#block(breakable: false)[
  = Installing Your Tools

  Work through the installation steps from the lesson notes.
  Use the checklist below to track your progress.

  #exercise(title: "Installation checklist")[
    Tick each box as you complete it. Do not move on until the current step works.

    #checklist(
      [Downloaded the VS Code installer for my operating system.],
      [Ran the VS Code installer and completed setup.],
      [Opened VS Code for the first time — the welcome screen appeared.],
      [Downloaded and installed Git (Windows) or confirmed Git via terminal (macOS).],
      [Opened the VS Code integrated terminal via *Terminal → New Terminal*.],
      [Ran `git --version` in the terminal and saw a version number.],
      [Ran `code --version` in the terminal and saw a version number.],
      [Configured Git with `git config --global user.name` and `user.email`.],
    )
  ]
]

#block(breakable: false)[
  = First Steps in the Terminal

  #exercise(title: "Exploring the terminal", points: 4)[
    Open the integrated terminal in VS Code and run the following commands.
    Write the output you see next to each command.

    #table(
      columns: (auto, 1fr),
      stroke: 0.4pt + rgb("#CCCCCC"),
      fill: (_, row) => if calc.odd(row) { light } else { white },
      inset: 8pt,
      table.header(
        text(weight: "bold")[Command],
        text(weight: "bold")[Output on your machine],
      ),
      `pwd`,   [],
      `ls`,    [],
      `git --version`, [],
      `code --version`, [],
    )

    #v(0.5em)
    Based on the output of `pwd`, where does your terminal start by default?

    #answer-space(lines: 2)
  ]
]

#exercise(title: "Navigating directories", points: 4)[
  In the terminal, create a folder for this course and navigate into it.

  + Create a new folder called `cs-course` using the `mkdir` command.
  + Move into that folder using the `cd` command.
  + Confirm you are in the right place using `pwd`.
  + Create another folder inside it called `lesson-01`.

  Write the exact commands you used, in order:

  ```bash
  # Write your commands here



  ```

  #hint[`mkdir folder-name` creates a folder. `cd folder-name` moves into it.]
]

#block(breakable: false)[
  = Reflection

  #exercise(title: "Learning log — first entry")[
    Open VS Code and create a new file called `notes.typ` in your `lesson-01` folder.
    Write a short entry (3–5 sentences) answering the following:

    - What did you install today and what does each tool do?
    - Was anything harder than expected? What did you do to solve it?
    - What are you still unsure about?

    You do not need to hand in the file — but the teacher may ask to see it.

    #note(
      "Remember:",
      [The point of the learning log is honest reflection, not a perfect answer.
       Writing "I don't understand why we need Git" is a perfectly good entry.],
    )
  ]
]
