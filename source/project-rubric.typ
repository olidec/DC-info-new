// ─────────────────────────────────────────────────────────────────────────────
// Web Development Project — Grading Rubric
// ─────────────────────────────────────────────────────────────────────────────

#let course = "Computer Science"
#let level  = "Gymnasium Muttenz"
#let term   = "2026-27"
#let sheet-type = "Grading Rubric"

// ── Page setup ────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: rgb("#999999"))
    grid(
      columns: (1fr, 1fr),
      align(left,  [#sheet-type — Web Development]),
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
#show heading.where(level: 1): it => block(breakable: false)[
  #v(1.2em)
  #text(size: 11pt, weight: "bold", fill: rgb("#111111"), upper(it.body))
  #v(0.15em)
  #line(length: 100%, stroke: 1pt + rgb("#2E6DA4"))
  #v(0.5em)
]

#show heading.where(level: 2): it => {
  v(0.6em)
  text(size: 11pt, weight: "bold", fill: rgb("#111111"), it.body)
  v(0.2em)
}

// ── Import shared styles and components ───────────────────────────────────────
#import "../cs-style.typ": *

// ── Rubric-specific component: a criterion block with 5 level descriptors ─────
#let level-row(label, pct, desc) = (
  [#text(size: 9pt, weight: "bold")[#label] \ #text(size: 8pt, fill: muted)[#pct]],
  text(size: 9.5pt, desc),
)

#let criterion(name, max-pts, levels) = {
  block(breakable: false)[
    #grid(
      columns: (1fr, auto),
      align(left, text(size: 12pt, weight: "bold", fill: accent)[#name]),
      align(right, text(size: 10pt, fill: muted)[max #max-pts pts]),
    )
    #v(0.3em)
  ]
  table(
    columns: (5.5em, 1fr),
    stroke: 0.4pt + rgb("#DDDDDD"),
    inset: 7pt,
    ..levels.map(l => level-row(..l)).flatten()
  )
  v(0.8em)
}

// ── Title block ───────────────────────────────────────────────────────────────
#{
  text(size: 20pt, weight: "bold", fill: primary)[Grading Rubric]
  v(0.05em)
  text(size: 12pt, fill: muted)[Web Development Project #sym.dot.c #course #sym.bar.v #level #sym.bar.v #term]
  v(0.3em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.8em)
}

// ─────────────────────────────────────────────────────────────────────────────
// HOW THIS RUBRIC WORKS
// ─────────────────────────────────────────────────────────────────────────────

= How This Rubric Works

Five criteria are scored normally and added together for a *raw score out
of 12*. The sixth criterion, *Oral Defense*, does not add points — instead
it acts as a *percentage multiplier* on that raw score.

#block(
  fill: light,
  width: 100%,
  inset: (x: 14pt, y: 10pt),
  radius: 2pt,
  align(center)[
    #text(size: 11pt)[
      (Planning + Process + Implementation + Content + Submission)
      #linebreak()
      #text(fill: accent, weight: "bold")[× Oral Defense percentage]
      #linebreak()
      = Final Score #sym.arrow.r Grade
    ]
  ]
)

#v(0.5em)

#warnbox(
  "⚠ Why it works this way",
  [A rubric where every section simply adds up lets a strong website
   compensate for an oral defense where the student cannot explain their
   own code. That is exactly backwards: understanding what you built is
   the whole point of this project. Making the Oral Defense a *multiplier*
   means no amount of polish elsewhere can substitute for being able to
   explain your own work.],
)

== The five levels

All six criteria — including Oral Defense — are scored on the same
five-level scale:

#table(
  columns: (5.5em, auto, 1fr),
  stroke: 0.4pt + rgb("#DDDDDD"),
  fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
  inset: 7pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Symbol],
    text(size: 9pt, weight: "bold", fill: white)[Meaning],
    text(size: 9pt, weight: "bold", fill: white)[Percentage],
  ),
  [`++`],  [Full marks], [100%],
  [`+`],   [Good],       [75%],
  [`+/-`], [Partial],    [50%],
  [`-`],   [Weak],       [25%],
  [`--`],  [Not achieved], [0%],
)

For the five additive criteria, the percentage is applied to that
criterion's maximum points. For Oral Defense, the percentage is applied
to the *entire raw score*.

== Worked examples

#table(
  columns: (1fr, 1fr, auto, auto, auto),
  stroke: 0.4pt + rgb("#DDDDDD"),
  fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
  inset: 7pt,
  table.header(
    text(size: 8.5pt, weight: "bold", fill: white)[Raw score (/12)],
    text(size: 8.5pt, weight: "bold", fill: white)[Oral Defense],
    text(size: 8.5pt, weight: "bold", fill: white)[Multiplier],
    text(size: 8.5pt, weight: "bold", fill: white)[Final (/12)],
    text(size: 8.5pt, weight: "bold", fill: white)[Grade],
  ),
  [12 — everything perfect], [`++`],  [100%], [12.0], [6.0],
  [12 — everything perfect], [`+`],   [75%],  [9.0],  [4.75],
  [12 — everything perfect], [`+/-`], [50%],  [6.0],  [3.5],
  [12 — everything perfect], [`--`],  [0%],   [0.0],  [1.0],
  [9 — solid, minor gaps],   [`++`],  [100%], [9.0],  [4.75],
  [9 — solid, minor gaps],   [`+/-`], [50%],  [4.5],  [2.875],
  [7 — simple but complete], [`++`],  [100%], [7.0],  [3.92],
  [7 — simple but complete], [`+`],   [75%],  [5.25], [3.19],
)

#infobox(
  "Read these rows carefully",
  [Rows 1–4 show the *same* excellent website scoring anywhere from a 6.0
   to a failing grade, depending only on the Oral Defense. That is
   deliberate. Compare row 6 (a solid project, `+/-` defense) to row 8
   (a simpler project, `+` defense) — the simpler-but-better-understood
   project scores higher. A confident, accurate Oral Defense is worth
   more to your grade than almost anything else you can do.],
)

#pagebreak()

// ─────────────────────────────────────────────────────────────────────────────
// PLANNING
// ─────────────────────────────────────────────────────────────────────────────

= Planning

#criterion("Planning", 2, (
  ("++", "100%",
    "Worksheet Parts A and B are complete before coding began (checked against commit timestamps). Brainstorm shows three genuinely different ideas with real reasoning for the final choice. Plan is specific and realistic. Part C is completed honestly and compares the outcome to the original plan in real detail."),
  ("+", "75%",
    "Parts A and B completed with reasonable detail and pushed early. Part C completed, but the comparison to the original plan is somewhat brief."),
  ("+/-", "50%",
    "Brainstorm or plan is thin — for example only two ideas, or a vague plan with no real timeline. Part C attempted but incomplete."),
  ("-", "25%",
    "A plan exists but is minimal or generic, giving little evidence of real thought. Part C missing or extremely short."),
  ("--", "0%",
    "No plan submitted, or the plan was clearly written after the project was already underway (commit timestamps do not match)."),
))

// ─────────────────────────────────────────────────────────────────────────────
// PROCESS
// ─────────────────────────────────────────────────────────────────────────────

= Process

#criterion("Process", 3, (
  ("++", "100%",
    "Commit history shows clear, granular, incremental progress matching the plan's rough timeline. Commit messages are specific and informative. The student's own contribution is clearly distinguishable from AI or external help throughout."),
  ("+", "75%",
    "Good commit history with occasional gaps — for example one or two commits that bundle several changes together. Messages are mostly clear."),
  ("+/-", "50%",
    "Commit history shows some large \"dump\"commits alongside smaller ones. Messages are present but often generic (\"update\", \"fix\")."),
  ("-", "25%",
    "Very few commits, or commit messages that do not describe what changed. Progress is hard to reconstruct from the history."),
  ("--", "0%",
    "A single commit, or nearly so. No visible development process."),
))

// ─────────────────────────────────────────────────────────────────────────────
// IMPLEMENTATION
// ─────────────────────────────────────────────────────────────────────────────

= Implementation

#criterion("Implementation", 3, (
  ("++", "100%",
    "HTML, CSS, and JS are cleanly separated with no inline styles or embedded scripts. All stated minimums (10 tags, 5 properties, 1 interaction) are met with every element used correctly and meaningfully. Classes and IDs are used purposefully."),
  ("+", "75%",
    "Minimums are met and mostly correct. Separation is clean. A small number of minor syntax issues that do not affect how the page works."),
  ("+/-", "50%",
    "Most minimums are met, but one or two elements are used incorrectly, or a minimum is narrowly missed. The occasional inline style or embedded script appears."),
  ("-", "25%",
    "Several minimums are not met. Tags or properties are frequently used incorrectly or without real purpose."),
  ("--", "0%",
    "Minimums are not met. HTML, CSS, and JS are not meaningfully separated, or the page has errors that prevent it from working."),
))

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT & INDEPENDENT LEARNING
// ─────────────────────────────────────────────────────────────────────────────

= Content & Independent Learning

#criterion("Content & Independent Learning", 3, (
  ("++", "100%",
    "All three tagged JOURNAL.md entries (HTML, CSS, JS) are present and each includes all four required parts. The entries clearly show genuine engagement — real research, real understanding, real adaptation to this specific project, not paste-and-forget. Content on the site is coherent and matches the stated plan."),
  ("+", "75%",
    "All three tagged entries are present and mostly complete, with minor gaps in one of the four parts. Content is coherent."),
  ("+/-", "50%",
    "Only two of the three tagged entries are present, or entries are thin and generic. Content is present but only loosely connected to the stated plan."),
  ("-", "25%",
    "Only one tagged entry is present, or entries are extremely superficial (a single line each). Content is minimal."),
  ("--", "0%",
    "No correctly tagged entries. Content is minimal or shows clear signs of being copied without adaptation."),
))

#pagebreak()

// ─────────────────────────────────────────────────────────────────────────────
// SUBMISSION
// ─────────────────────────────────────────────────────────────────────────────

= Submission

#criterion("Submission", 1, (
  ("++", "100%",
    "The site is fully functional and serves its stated purpose. It runs without errors immediately after a fresh clone. Submitted on time."),
  ("+/-", "50%",
    "The site mostly works after a fresh clone but has a minor issue (e.g. one broken image path), or was submitted slightly late with a valid reason communicated in advance."),
  ("--", "0%",
    "The site does not run after a fresh clone, or the submission is missing or very late without communication."),
))

// ─────────────────────────────────────────────────────────────────────────────
// ORAL DEFENSE
// ─────────────────────────────────────────────────────────────────────────────

= Oral Defense #h(1fr) #text(size: 11pt, fill: accent, weight: "bold")[multiplier, not additive]

#block(
  fill: light,
  width: 100%,
  inset: (x: 14pt, y: 10pt),
  radius: 2pt,
  [This criterion does not add points to your total. It scales your
   *entire raw score* up or down. See "How This Rubric Works" on page 1
   for the full mechanism and worked examples.]
)

#v(0.6em)

#criterion("Oral Defense (applied as a multiplier)", 0, (
  ("++", "100%",
    "Explains every part of the code fluently and accurately, including the reasoning behind specific choices. Can answer questions about any line of code correctly. Clearly distinguishes their own understanding from anything suggested by an AI or found online. Can explain what would happen if a given piece of code were changed."),
  ("+", "75%",
    "Explains most of the code correctly, with only minor gaps or hesitation. Understands the overall structure and most individual choices. Small inaccuracies appear only under close follow-up questioning."),
  ("+/-", "50%",
    "Can describe the general structure and purpose of the site but struggles with specifics. Several answers are vague, uncertain, or partially incorrect (\"I think this does...\"without being sure)."),
  ("-", "25%",
    "Can only explain a small portion of the code with any confidence. Significant sections cannot be explained at all, or the explanation given contradicts what the code actually does."),
  ("--", "0%",
    "Cannot explain how the code works. Cannot answer basic questions about their own submission. Evidence suggests the code was copied or generated without real engagement."),
))

#infobox(
  "How to prepare",
  [Re-read your `JOURNAL.md` entries and Part C of your planning
   worksheet before the Technical Discussion — both are designed to give
   you material to draw on. Being able to explain *why* you made a
   choice, not just *what* the code does, is what separates a `+` from
   an `++`.],
)

// ─────────────────────────────────────────────────────────────────────────────
// GRADE FORMULA
// ─────────────────────────────────────────────────────────────────────────────

= Grade Formula

#block(
  fill: light,
  width: 100%,
  inset: (x: 14pt, y: 12pt),
  radius: 2pt,
  align(center)[
    #text(size: 12pt)[
      Grade #h(0.3em) = #h(0.3em)
      ((Raw score #sym.times Oral %) / 12) #h(0.3em) #sym.times #h(0.3em) 5 #h(0.3em) + #h(0.3em) 1
    ]
    #v(0.3em)
    #text(size: 9pt, fill: muted)[(rounded to one decimal place, maximum 6, minimum 1)]
  ]
)

#v(0.8em)

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { rgb("#111111") } else { rgb("#F5F5F5") },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Planning],
    text(size: 9pt, weight: "bold", fill: white)[Process],
    text(size: 9pt, weight: "bold", fill: white)[Impl.],
    text(size: 9pt, weight: "bold", fill: white)[Content],
    text(size: 9pt, weight: "bold", fill: white)[Submission],
    text(size: 9pt, weight: "bold", fill: white)[Oral %],
  ),
  text(size: 9pt, fill: rgb("#555555"))[/ 2],
  text(size: 9pt, fill: rgb("#555555"))[/ 3],
  text(size: 9pt, fill: rgb("#555555"))[/ 3],
  text(size: 9pt, fill: rgb("#555555"))[/ 3],
  text(size: 9pt, fill: rgb("#555555"))[/ 1],
  text(size: 9pt, fill: rgb("#555555"))[#sym.times],
)

#v(0.4em)
#text(size: 10pt, fill: muted)[Raw score total: #h(1fr) / 12 #h(2em) Final grade: #h(1fr)]
