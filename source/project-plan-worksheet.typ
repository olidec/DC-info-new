// ─────────────────────────────────────────────────────────────────────────────
// Project Planning & Retrospective Worksheet
// Filled in twice: Part A+B at the start of the project, Part C at the end.
// ─────────────────────────────────────────────────────────────────────────────

#let course = "Computer Science"
#let level  = "Gymnasium Muttenz"
#let term   = "2026-27"
#let sheet-type = "Project Worksheet"

// ── Page setup ────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: rgb("#999999"))
    grid(
      columns: (1fr, 1fr),
      align(left,  [#sheet-type — Planning & Retrospective]),
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

// ── Title block ───────────────────────────────────────────────────────────────
#{
  text(size: 18pt, weight: "bold", fill: primary)[Project Planning & Retrospective]
  v(0.1em)
  text(size: 11pt, fill: muted)[#course #sym.bar.v #level #sym.bar.v #term]
  v(0.3em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.5em)
}

#block(
  fill: light,
  width: 100%,
  inset: (x: 14pt, y: 10pt),
  radius: 2pt,
  [
    *When to fill this in:* Parts A and B are completed *before you write any
    code* — in your first project session. Part C is completed in your
    *final* project session, after your site is finished. \
    \
    This worksheet is graded as part of the *Planning* criterion. Submit it
    alongside your repository — either as a scan/photo of the handwritten
    sheet, or filled in digitally in Typst and exported as a PDF.
  ]
)

#v(0.8em)

// ── Name / date fields ────────────────────────────────────────────────────────
#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  [*Name:* #h(1fr) #line(length: 75%, stroke: 0.5pt + primary)],
  [*Date started:* #h(1fr) #line(length: 65%, stroke: 0.5pt + primary)],
)

// ─────────────────────────────────────────────────────────────────────────────
// PART A — BRAINSTORM
// ─────────────────────────────────────────────────────────────────────────────

= Part A — Brainstorm

#infobox(
  "Before you decide, generate options",
  [The best idea is rarely the first one you think of. Come up with at
   least *three genuinely different* ideas before choosing one — different
   topics, not three small variations on the same idea.],
)

#table(
  columns: (1.5em, 1fr, 1fr),
  stroke: 0.4pt + rgb("#CCCCCC"),
  fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[#""],
    text(size: 9pt, weight: "bold", fill: white)[Idea — what would the site be about?],
    text(size: 9pt, weight: "bold", fill: white)[Why is this interesting, or what makes it a good fit for HTML/CSS/JS?],
  ),
  [1], [ #v(2.5em) ], [ #v(2.5em) ],
  [2], [ #v(2.5em) ], [ #v(2.5em) ],
  [3], [ #v(2.5em) ], [ #v(2.5em) ],
)

#v(0.5em)

#block(breakable: false)[
== Your choice

Which idea did you choose? Why this one over the other two — what made it
a better fit given the time you have and what you already know how to do?

#answer-space(lines: 4)
]

// ─────────────────────────────────────────────────────────────────────────────
// PART B — THE PLAN
// ─────────────────────────────────────────────────────────────────────────────

= Part B — The Plan

#block(breakable: false)[
== What is your site about?

In one or two sentences, describe what the finished site will show or do.

#answer-space(lines: 2)
]

#block(breakable: false)[
== Planned features

List what you intend to build. Label each one using the same system from
class: what you *must* have for the site to work, what would be *nice to
have* if time allows, and what would be a genuine *stretch* if everything
else goes well.

#table(
  columns: (1fr, 6em),
  stroke: 0.4pt + rgb("#CCCCCC"),
  fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Feature],
    text(size: 9pt, weight: "bold", fill: white)[Tier],
  ),
  [ #v(1.6em) ], [#tier-core],
  [ #v(1.6em) ], [#tier-core],
  [ #v(1.6em) ], [#tier-extension],
  [ #v(1.6em) ], [#tier-extension],
  [ #v(1.6em) ], [#tier-challenge],
)

#hint[Not sure which tier something belongs in? Ask yourself: "if I ran
  out of time, could I submit a working project without this?" If yes,
  it is not #tier-core.]
]

#block(breakable: false)[
== Timeline

Roughly how will you use the weeks you have? You do not need exact dates —
a rough plan is enough, and it is fine if reality ends up different (that
is exactly what Part C is for).

#table(
  columns: (6em, 1fr),
  stroke: 0.4pt + rgb("#CCCCCC"),
  fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Week],
    text(size: 9pt, weight: "bold", fill: white)[What you plan to have done by the end of this week],
  ),
  [Week 1], [ #v(1.6em) ],
  [Week 2], [ #v(1.6em) ],
  [Week 3], [ #v(1.6em) ],
  [Week 4], [ #v(1.6em) ],
)
]

#block(breakable: false)[
== Commitment

#answer-space(lines: 0)
*Signature:* #h(1fr) #line(length: 60%, stroke: 0.5pt + primary)

#note(
  "This is a real commitment, not a formality",
  [Push this plan to your repository — either as this worksheet or
   summarized in your `README.md` — as one of your *first* commits.
   Your teacher will check the timestamp. A plan written or backdated
   after the fact defeats its purpose.],
)
]

#pagebreak()

// ─────────────────────────────────────────────────────────────────────────────
// PART C — RETROSPECTIVE
// ─────────────────────────────────────────────────────────────────────────────

= Part C — Retrospective

#block(
  fill: light,
  width: 100%,
  inset: (x: 14pt, y: 10pt),
  radius: 2pt,
  [*Fill this in during your final project session*, after your site is
   finished. Look back at Parts A and B before you start.]
)

#v(0.6em)

#block(breakable: false)[
== Feature by feature

Go through your planned features from Part B. For each one, say whether
you built it, and if not (or if it changed), say why.

#table(
  columns: (1fr, 5em, 1fr),
  stroke: 0.4pt + rgb("#CCCCCC"),
  fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Planned feature],
    text(size: 9pt, weight: "bold", fill: white)[Built?],
    text(size: 9pt, weight: "bold", fill: white)[If not, or if changed — why?],
  ),
  [ #v(1.6em) ], [ ], [ #v(1.6em) ],
  [ #v(1.6em) ], [ ], [ #v(1.6em) ],
  [ #v(1.6em) ], [ ], [ #v(1.6em) ],
  [ #v(1.6em) ], [ ], [ #v(1.6em) ],
  [ #v(1.6em) ], [ ], [ #v(1.6em) ],
)
]

#block(breakable: false)[
== Was your plan realistic?

Looking back at your Week-by-Week timeline in Part B — did things take
roughly as long as you expected? What took longer than planned? What was
faster or easier than you thought?

#answer-space(lines: 4)
]

#block(breakable: false)[
== One moment you got stuck

Describe one specific point where you were stuck and did not know how to
proceed. What was the problem, and how did you resolve it? Be specific —
"I looked it up" is not enough; say *what* you looked up and *what you
learned* from it.

#answer-space(lines: 5)

#note(
  "This connects to your Oral Defense",
  [You may well be asked about this moment during your Technical
   Discussion. Answering it honestly and in detail here is good
   preparation, not just paperwork.],
)
]

#block(breakable: false)[
== Looking back

If you started this project again from scratch, what would you plan
differently? This can be about scope, time management, choice of topic,
or anything else.

#answer-space(lines: 4)
]
