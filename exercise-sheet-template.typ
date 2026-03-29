// ─────────────────────────────────────────────────────────────────────────────
// CS Exercise Sheet — Variant A: Monochrome Minimal
// Exercise blocks use a bold left rule only; no background fills.
// ─────────────────────────────────────────────────────────────────────────────

#let course      = "Computer Science"
#let level       = "High School"
#let term        = "[Term / Year]"
#let lesson-num  = "1"
#let sheet-title = "Setup & First Steps"
#let sheet-type  = "Exercise Sheet"

// ── Palette: monochrome with a single teal accent ────────────────────────────
#let primary = rgb("#111111")
#let accent  = rgb("#2E6DA4")   // steel blue — used sparingly
#let light   = rgb("#F5F5F5")
#let warn    = rgb("#555555")
#let muted   = rgb("#999999")
#let ex-bg   = white

// ── Page ─────────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: muted)
    grid(
      columns: (1fr, 1fr),
      align(left,  [#sheet-type — Lesson #lesson-num]),
      align(right, [#course — #level]),
    )
    line(length: 100%, stroke: 0.4pt + muted)
  },
  footer: context {
    set text(size: 9pt, fill: muted)
    align(center, counter(page).display("1"))
  },
)

// ── Typography ────────────────────────────────────────────────────────────────
#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.75em)

#show heading.where(level: 1): it => {
  v(1.2em)
  text(size: 11pt, weight: "bold", fill: primary, upper(it.body))
  v(0.15em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.5em)
}

#show heading.where(level: 2): it => {
  v(0.6em)
  text(size: 11pt, weight: "bold", fill: primary, it.body)
  v(0.2em)
}

#show raw.where(block: false): it => {
  box(
    fill: light,
    inset: (x: 3pt, y: 1pt),
    radius: 2pt,
    text(font: "New Computer Modern Mono", size: 10pt, it),
  )
}

#show raw.where(block: true): it => {
  block(
    fill: light,
    width: 100%,
    inset: 12pt,
    radius: 2pt,
    text(font: "New Computer Modern Mono", size: 10pt, fill: primary, it),
  )
}

// ── Exercise counter & block ──────────────────────────────────────────────────
#let ex-counter = counter("exercise")

#let exercise(title: "", points: none, body) = {
  ex-counter.step()
  let pts-label = if points != none {
    text(size: 9pt, fill: muted)[(#points P.)]
  } else { [] }

  block(
    width: 100%,
    breakable: false,
    inset: (left: 0pt, right: 0pt, top: 2pt, bottom: 8pt),
    {
      grid(
        columns: (1fr, auto),
        align(left,
          text(size: 10pt, weight: "bold", fill: accent)[
            Exercise #context ex-counter.display()
            #if title != "" [#text(fill: primary)[— #title]]
          ]
        ),
        align(right, pts-label),
      )
      v(0.4em)
      body
    }
  )
  v(1em)
}

// ── Helper components ─────────────────────────────────────────────────────────
#let answer-space(lines: 4) = {
  v(0.4em)
  for _ in range(lines) {
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
  }
}

#let checklist(..items) = {
  for item in items.pos() {
    grid(
      columns: (1.4em, 1fr),
      column-gutter: 6pt,
      align(top + left,
        box(width: 1em, height: 1em, stroke: 0.8pt + primary, radius: 1pt)
      ),
      align(top + left, item),
    )
    v(0.3em)
  }
}

#let hint(body) = block(
  stroke: (left: 1.5pt + muted),
  inset: (left: 10pt, right: 0pt, top: 4pt, bottom: 4pt),
  width: 100%,
  [#text(size: 9pt, fill: muted, weight: "bold")[Hint] \ #text(size: 10pt, fill: muted, body)],
)

#let note(title, body) = block(
  fill: light,
  inset: (x: 12pt, y: 8pt),
  width: 100%,
  radius: 2pt,
  [#text(weight: "bold", fill: primary, title) \ #v(0.2em) #body],
)

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
      [Opened the VS Code integrated terminal (`Ctrl`+`` ` `` or `Cmd`+`` ` ``).],
      [Ran `git --version` in the terminal and saw a version number.],
      [Ran `code --version` in the terminal and saw a version number.],
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
