// ─────────────────────────────────────────────────────────────────────────────
// cs-style.typ — Shared styles for all CS course documents
//
// Usage in any document:
//   #import "cs-style.typ": *
//
// Required variables — define BEFORE the import:
//   For lesson notes:    lesson-title, lesson-subtitle (optional)
//   For exercise sheets: sheet-type, sheet-title, lesson-num
//
// Optional variables with defaults:
//   course, level, term
// ─────────────────────────────────────────────────────────────────────────────

// ── Default metadata (override in each document before importing) ─────────────
#let course = "Computer Science"
#let level  = "High School"
#let term   = "[Term / Year]"

// ── Palette ───────────────────────────────────────────────────────────────────
#let primary = rgb("#111111")
#let accent  = rgb("#2E6DA4")   // steel blue — used sparingly
#let light   = rgb("#F5F5F5")
#let warn    = rgb("#555555")
#let muted   = rgb("#999999")
#let ex-bg   = white

// ── Typography ────────────────────────────────────────────────────────────────
#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.75em)

// Inline code
#show raw.where(block: false): it => {
  box(
    fill: light,
    inset: (x: 3pt, y: 1pt),
    radius: 2pt,
    text(size: 10pt, it),
  )
}

// Code blocks
#show raw.where(block: true): it => {
  block(
    fill: rgb("#F0F0F0"),
    width: 100%,
    inset: 12pt,
    radius: 2pt,
    text(size: 10pt, fill: primary, it),
  )
}

// ── Shared components ─────────────────────────────────────────────────────────

// Info box — steel blue title, light background
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

// Warning box — dark gray title, light background
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

// Numbered steps — accent-colored badge, plain text beside it
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

// Learning goals block — used at the top of lesson notes
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

// Checklist — tick boxes for summary sections
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

// ── Exercise sheet components ─────────────────────────────────────────────────
// (only used in exercise sheets, harmless to include in notes)

#let ex-counter = counter("exercise")

// Exercise block — auto-numbered, optional title and points
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

// Answer space — ruled lines for written responses
#let answer-space(lines: 4) = {
  v(0.4em)
  for _ in range(lines) {
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
  }
}

// Hint box — subtle, muted
#let hint(body) = block(
  stroke: (left: 1.5pt + muted),
  inset: (left: 10pt, right: 0pt, top: 4pt, bottom: 4pt),
  width: 100%,
  [#text(size: 9pt, fill: muted, weight: "bold")[Hint] \ #text(size: 10pt, fill: muted, body)],
)

// Note box — light background, no stroke
#let note(title, body) = block(
  fill: light,
  inset: (x: 12pt, y: 8pt),
  width: 100%,
  radius: 2pt,
  [#text(weight: "bold", fill: primary, title) \ #v(0.2em) #body],
)
