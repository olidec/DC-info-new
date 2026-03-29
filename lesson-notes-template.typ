// ─────────────────────────────────────────────────────────────────────────────
// CS Lesson Notes Template — Minimal
// Monochrome with a single steel blue accent, matching exercise-variant-a.
// ─────────────────────────────────────────────────────────────────────────────

// ── Document metadata (edit these for each lesson) ───────────────────────────
#let course          = "Computer Science"
#let level           = "High School"
#let term            = "[Term / Year]"
#let lesson-num      = "1"
#let lesson-title    = "Setup & Software Installation"
#let lesson-subtitle = "Getting your tools ready"

// ── Palette ───────────────────────────────────────────────────────────────────
#let primary = rgb("#111111")
#let accent  = rgb("#2E6DA4")   // steel blue — used sparingly
#let light   = rgb("#F5F5F5")
#let warn    = rgb("#555555")
#let muted   = rgb("#999999")

// ── Page ─────────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: muted)
    grid(
      columns: (1fr, 1fr),
      align(left,  [#lesson-title]),
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
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => block(breakable: false)[
  #v(1.2em)
  #text(size: 11pt, weight: "bold", fill: primary,
    upper(numbering("1", ..counter(heading).at(it.location())) + "  ") + it.body
  )
  #v(0.15em)
  #line(length: 100%, stroke: 1pt + accent)
  #v(0.5em)
]

#show heading.where(level: 2): it => {
  v(0.8em)
  text(size: 11pt, weight: "bold", fill: primary,
    numbering("1.1", ..counter(heading).at(it.location())) + "  "
  )
  it.body
  v(0.3em)
}

#show heading.where(level: 3): it => {
  v(0.5em)
  text(size: 10pt, weight: "bold", fill: muted,
    numbering("1.1.1", ..counter(heading).at(it.location())) + "  "
  )
  text(size: 10pt, weight: "bold", fill: muted, it.body)
  v(0.2em)
}

#show raw.where(block: false): it => {
  box(
    fill: light,
    inset: (x: 3pt, y: 1pt),
    radius: 2pt,
    text(size: 10pt, it),
  )
}

#show raw.where(block: true): it => {
  block(
    fill: rgb("#F0F0F0"),
    width: 100%,
    inset: 12pt,
    radius: 2pt,
    text(size: 10pt, fill: primary, it),
  )
}

// ── Components ────────────────────────────────────────────────────────────────
#let infobox(title, body) = block(
  fill: light,
  inset: (x: 14pt, y: 10pt),
  width: 100%,
  radius: 2pt,
  [
    #text(weight: "bold", fill: accent, title)
    #v(0.3em)
    #body
  ],
)

#let warnbox(title, body) = block(
  fill: light,
  inset: (x: 14pt, y: 10pt),
  width: 100%,
  radius: 2pt,
  [
    #text(weight: "bold", fill: warn, title)
    #v(0.3em)
    #body
  ],
)

#let steps(..items) = {
  let n = 0
  for item in items.pos() {
    n = n + 1
    grid(
      columns: (1.6em, 1fr),
      column-gutter: 8pt,
      align(top + right,
        box(
          fill: accent,
          inset: (x: 5pt, y: 2pt),
          radius: 2pt,
          text(size: 9pt, weight: "bold", fill: white, str(n)),
        )
      ),
      align(top + left, item),
    )
    v(0.4em)
  }
}

#let goals(..items) = {
  block(
    width: 100%,
    inset: (x: 14pt, y: 10pt),
    fill: light,
    radius: 2pt,
    [
      #text(weight: "bold", fill: accent)[Learning Goals]
      #v(0.3em)
      #list(..items.pos())
    ]
  )
  v(0.5em)
}

#let checklist(..items) = {
  for item in items.pos() {
    grid(
      columns: (1.4em, 1fr),
      column-gutter: 6pt,
      align(top + left,
        box(width: 0.9em, height: 0.9em, stroke: 0.8pt + muted, radius: 1pt)
      ),
      align(top + left, item),
    )
    v(0.35em)
  }
}


#{
  text(size: 18pt, weight: "bold", fill: primary)[#lesson-title]
  v(0.1em)
  text(size: 11pt, fill: muted)[#lesson-subtitle]
  v(0.3em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.8em)
}

// ─────────────────────────────────────────────────────────────────────────────
// ── LESSON CONTENT STARTS HERE ───────────────────────────────────────────────
// Replace everything below with the actual lesson content.
// ─────────────────────────────────────────────────────────────────────────────

#goals(
  [Understand what tools we will use this year and why.],
  [Successfully install VS Code and Git on your personal device.],
  [Open a terminal and run your first command.],
)

= Why Tools Matter

Before we can write a single line of code, we need to set up our working environment.
Professional developers spend a lot of time thinking about their tools — the right setup
makes everything that follows faster, cleaner, and less frustrating.

This year we will use three core tools together:

- *Visual Studio Code* (VS Code) — a powerful text editor for writing code.
- *Git* — a version control system that tracks every change you make.
- *GitHub* — a website that stores your Git repositories and lets you share your work.

These three tools are industry-standard. Learning them now means you are learning
skills that are genuinely useful beyond this classroom.

== What is a text editor?

A text editor is a program for writing plain text — no formatting, no bold, no fonts.
Unlike a word processor (Microsoft Word, Google Docs), what you see is exactly what
is stored in the file. This matters for code: the computer reads your files character
by character, so hidden formatting would break everything.

VS Code is a text editor with extras: it understands the programming languages you
write and highlights them with color, warns you about mistakes, and lets you run
programs without leaving the window.

= Installing VS Code

#steps(
  [Go to #link("https://code.visualstudio.com") and click *Download*.
   Choose the version for your operating system (Windows or macOS).],
  [Open the downloaded file and follow the installer.
   Accept all default settings — they are sensible.],
  [Once installed, open VS Code. You should see a welcome screen.
   Take a moment to look around; we will explore it together.],
)

#warnbox(
  "⚠ School network?",
  [If the download is blocked by the school network, let the teacher know.
   We have an offline installer available on a USB drive.],
)

= Installing Git

Git is a separate program from VS Code. We install it independently and then
connect the two.

== Windows

#steps(
  [Go to #link("https://git-scm.com/download/win") — the download starts automatically.],
  [Run the installer. When asked about the default editor, choose *VS Code*.
   Leave all other options at their defaults.],
  [Open the program called *Git Bash* from your Start menu.
   Type `git --version` and press Enter. You should see something like `git version 2.x.x`.],
)

== macOS

#steps(
  [Open the *Terminal* app (search for it with Spotlight: ⌘ + Space, then type "Terminal").],
  [Type `git --version` and press Enter.
   If Git is not installed, macOS will offer to install the Xcode Command Line Tools — accept this.],
  [Wait for the installation to finish, then run `git --version` again to confirm.],
)

#infobox(
  "💡 The terminal",
  [The terminal (also called the command line or shell) is a text-based way of
   talking to your computer. It looks intimidating at first, but you only need
   a handful of commands. We will learn them one at a time.],
)

= Checking Your Setup

Once both programs are installed, let us verify everything works.

Open VS Code, then open the integrated terminal inside it:
- *Windows / Linux:* press `Ctrl` + `` ` `` (backtick)
- *macOS:* press `Cmd` + `` ` ``

You should see a terminal panel appear at the bottom of the window.
Type the following two commands, pressing Enter after each:

```bash
git --version
code --version
```

If both print a version number, you are ready. If you see an error, call the teacher over.

== Your first terminal commands

Here are a few commands that are useful to know right away.
You do not need to memorize them — you will learn them by using them.

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(weight: "bold", fill: primary)[Command],
    text(weight: "bold", fill: primary)[What it does],
  ),
  `pwd`,   [Print the current directory (where you are in the file system)],
  `ls`,    [List the files and folders in the current directory],
  `cd`,    [Change directory — move to a different folder],
  `mkdir`, [Make a new directory (folder)],
  `clear`, [Clear the terminal screen],
)

= Typst: Your Note-Taking Tool

This year you will write your notes and learning reflections in *Typst* — a modern
document language, similar in spirit to LaTeX but simpler to learn.

#infobox(
  "Why Typst?",
  [Typst files are plain text, which means they work perfectly with Git.
   Every change to your notes is tracked, just like your code.
   You will push your notes to GitHub alongside your projects.],
)

We will install Typst and write your first document in the next session.
For now, bookmark the Typst documentation: #link("https://typst.app/docs").

= Summary

By the end of this lesson you should have:

- [ ] VS Code installed and open on your machine.
- [ ] Git installed and visible from the VS Code terminal.
- [ ] Run `git --version` successfully.

If any of these are not yet checked off, finish them before the next session.
The next lesson builds directly on this setup.
