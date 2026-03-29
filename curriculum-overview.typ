// ─────────────────────────────────────────────────────────────────────────────
// CS Curriculum Overview — Web Development Unit
// Teacher planning reference. Not for distribution to students.
// ─────────────────────────────────────────────────────────────────────────────

#let course = "Computer Science"
#let level  = "Gymnasium Muttenz"
#let term   = "2026-27"

// ── Palette (matches lesson notes and exercise sheets) ────────────────────────
#let primary = rgb("#111111")
#let accent  = rgb("#2E6DA4")   // steel blue
#let light   = rgb("#F5F5F5")
#let muted   = rgb("#999999")
#let warn    = rgb("#555555")
#let holiday = rgb("#E8E8E8")   // used for the holiday row

// ── Page ─────────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: muted)
    grid(
      columns: (1fr, 1fr),
      align(left,  [Curriculum Overview — Web Development]),
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
  v(1.4em)
  text(size: 11pt, weight: "bold", fill: primary, upper(it.body))
  v(0.15em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.6em)
}

#show heading.where(level: 2): it => {
  v(0.8em)
  text(size: 10pt, weight: "bold", fill: accent, upper(it.body))
  v(0.3em)
}

#show raw.where(block: false): it => {
  box(
    fill: light,
    inset: (x: 3pt, y: 1pt),
    radius: 2pt,
    text(size: 10pt, it),
  )
}

// ── Components ────────────────────────────────────────────────────────────────

// Week block — the main building unit of this document
#let week(number, theme, sessions, goals, assignment: none, notes: none) = {
  block(
    width: 100%,
    breakable: false,
    {
      // Week header bar
      block(
        fill: primary,
        width: 100%,
        inset: (x: 12pt, y: 7pt),
        radius: (top: 3pt),
        grid(
          columns: (auto, 1fr),
          column-gutter: 12pt,
          align(horizon,
            text(size: 9pt, weight: "bold", fill: accent)[WEEK #number]
          ),
          align(horizon,
            text(size: 11pt, weight: "bold", fill: white)[#theme]
          ),
        )
      )
      // Week body
      block(
        fill: light,
        width: 100%,
        inset: (x: 14pt, y: 11pt),
        radius: (bottom: 3pt),
        {
          // Sessions row
          grid(
            columns: (9em, 1fr),
            column-gutter: 8pt,
            rows: auto,
            row-gutter: 8pt,
            // Sessions
            text(size: 9pt, weight: "bold", fill: muted, upper[Sessions]),
            text(size: 10pt, sessions),
            // Learning goals
            text(size: 9pt, weight: "bold", fill: muted, upper[Learning Goals]),
            text(size: 10pt, goals),
            // Assignment (optional)
            if assignment != none {
              text(size: 9pt, weight: "bold", fill: muted, upper[Assignment])
            } else { [] },
            if assignment != none {
              text(size: 10pt, assignment)
            } else { [] },
            // Notes (optional)
            if notes != none {
              text(size: 9pt, weight: "bold", fill: muted, upper[Notes])
            } else { [] },
            if notes != none {
              text(size: 10pt, fill: warn, notes)
            } else { [] },
          )
        }
      )
    }
  )
  v(0.8em)
}

// Holiday block
#let holiday-block(label) = {
  block(
    fill: holiday,
    width: 100%,
    inset: (x: 14pt, y: 8pt),
    radius: 3pt,
    align(center,
      text(size: 10pt, fill: muted, style: "italic", label)
    )
  )
  v(0.8em)
}

// Pill label — for tagging tools/topics inline
#let tag(body) = box(
  fill: white,
  stroke: 0.5pt + muted,
  inset: (x: 5pt, y: 2pt),
  radius: 10pt,
  text(size: 9pt, fill: muted, body),
)

// ─────────────────────────────────────────────────────────────────────────────
// TITLE BLOCK
// ─────────────────────────────────────────────────────────────────────────────
#{
  text(size: 9pt, fill: muted)[#course #sym.bar.v #level #sym.bar.v #term]
  v(0.15em)
  text(size: 20pt, weight: "bold", fill: primary)[Web Development]
  v(0.05em)
  text(size: 12pt, fill: muted)[Curriculum Overview — Unit 1]
  v(0.3em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.3em)
  text(size: 9pt, fill: muted)[
    Teacher planning document. Weeks 1–12 including fall holidays.
    All sessions are 90 minutes. Theory: 2×/week. Lab: 2× every other week.
  ]
  v(1em)
}

// ─────────────────────────────────────────────────────────────────────────────
// QUICK REFERENCE TABLE
// ─────────────────────────────────────────────────────────────────────────────

= At a Glance

#table(
  columns: (3em, 8em, 1fr, 7em),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Week],
    text(size: 9pt, weight: "bold", fill: white)[Phase],
    text(size: 9pt, weight: "bold", fill: white)[Theme],
    text(size: 9pt, weight: "bold", fill: white)[Milestone],
  ),
  [1],  [Onboarding],     [Software setup, terminal, Typst],            [—],
  [2],  [Onboarding],     [Git, GitHub, first commit],                  [First assignment live],
  [3],  [HTML],           [Document structure, semantic tags],           [Assignment: HTML],
  [4],  [CSS],            [Selectors, colours, fonts, box model],        [Assignment: + CSS],
  [5],  [JavaScript],     [Variables, events, DOM basics],               [Assignment: + JS],
  table.cell(colspan: 4,
    align(center, text(size: 9pt, fill: muted, style: "italic")[— Fall Holidays —])
  ),
  [6],  [Consolidation],  [Written exam + review],                       [Written exam],
  [7],  [HTML II + CSS II], [Semantic depth, layout, classes/IDs],      [Extension assignment],
  [8],  [JS II + Project], [Functions, DOM, project kickoff],            [Project assigned],
  [9],  [Project],        [Building, committing, JOURNAL.md],            [—],
  [10], [Project],        [Continued development],                       [—],
  [11], [Project],        [Polish, testing, finalising],                 [Submission],
  [12], [Wrap-up],        [Technical Discussions, next topic intro],     [Discussions],
)

#block(breakable: false)[
  #v(0.5em)
#text(size: 9pt, fill: muted)[
  *Contact time:* ~2 theory + 1 lab session per week (every other week: 2 theory + 2 lab).

  *Assessment:* written exam (week 6) + graded project with Technical Discussion (week 12).
]
]
// ─────────────────────────────────────────────────────────────────────────────
// WEEK-BY-WEEK DETAIL
// ─────────────────────────────────────────────────────────────────────────────

= Week-by-Week Plan

#week(
  "1",
  "Onboarding I — Setup & Tools",
  [
    *Theory:* Why we use these tools; installing VS Code and Git; first look
    at the terminal; opening and navigating files. \
    *Lab:* Hands-on installation troubleshooting; first terminal commands
    (`pwd`, `ls`, `cd`, `mkdir`); intro to Typst — students create a
    `notes.typ` file and write their first entry.
  ],
  list(
    [Understand the role of VS Code, Git, and GitHub in a developer's workflow.],
    [Successfully install VS Code and Git on a personal device.],
    [Navigate the filesystem using the terminal.],
    [Write and compile a minimal Typst document.],
  ),
  notes: [Allow extra time for troubleshooting. Have a USB drive with offline
          installers ready. Typst is introduced very lightly — just enough to
          write a paragraph and push it next week.],
)

#week(
  "2",
  "Onboarding II — Git & GitHub",
  [
    *Theory:* What version control is and why it matters; Git concepts
    (repository, commit, push, pull); the GitHub Classroom workflow;
    accepting an assignment and cloning a repo. \
    *Lab:* Students accept the first GitHub Classroom assignment; clone the
    repo in VS Code; edit `README.md`; stage, commit, and push. Second lab:
    practice the full cycle independently.
  ],
  list(
    [Explain what a commit is and why granular commits matter.],
    [Accept a GitHub Classroom assignment and clone the repository.],
    [Make a meaningful first commit and push it to GitHub.],
    [Use the VS Code Source Control panel for basic git operations.],
  ),
  assignment: [
    *cs-intro* repository goes live. \
    Template contains: `index.html` (skeleton), `style.css` (empty, linked),
    `script.js` (empty, linked), `README.md`, `JOURNAL.md`. \
    Week 2 task: add name to README, write first JOURNAL entry, commit and push.
  ],
  notes: [The goal by end of week 2 is a reliable "clone → edit → commit → push"
          loop. Do not move on until every student has achieved this.],
)

#week(
  "3",
  "HTML I — Document Structure",
  [
    *Theory:* What HTML is and how browsers read it; the anatomy of a tag;
    document structure (`<!DOCTYPE>`, `<html>`, `<head>`, `<body>`);
    semantic elements (`<header>`, `<nav>`, `<main>`, `<section>`,
    `<article>`, `<footer>`); text tags (`<h1>`–`<h3>`, `<p>`, `<ul>`,
    `<ol>`, `<a>`); images (`<img>`). Worked example built live. \
    *Lab:* Students build out `index.html` in their assignment repo with
    real content on a topic of their choice. Commit after each meaningful
    addition.
  ],
  list(
    [Understand the structure of a valid HTML document.],
    [Use at least 8 semantic HTML elements correctly.],
    [Add links and images to a page.],
    [Commit changes with clear, descriptive messages.],
  ),
  assignment: [
    Continue *cs-intro* repo. \
    Week 3 task: build out `index.html` with meaningful content; at least
    6 different HTML tags used correctly; at least 2 commits with clear messages.
  ],
)

#week(
  "4",
  "CSS I — Styling the Page",
  [
    *Theory:* What CSS is and how it connects to HTML (the `<link>` tag);
    selectors (element, class, ID); properties and values; colours and
    backgrounds; typography (`font-family`, `font-size`, `font-weight`,
    `line-height`); the box model (`margin`, `padding`, `border`).
    Live styling of the HTML from week 3. \
    *Lab:* Students style their own `index.html` using `style.css`.
    Emphasis on experimenting, committing each visible change.
  ],
  list(
    [Link a CSS file to an HTML document correctly.],
    [Use element, class, and ID selectors purposefully.],
    [Apply at least 5 CSS properties correctly.],
    [Understand the box model and use margin and padding intentionally.],
  ),
  assignment: [
    Continue *cs-intro* repo. \
    Week 4 task: style the page in `style.css`; no inline styles; at least
    5 different properties; commit each significant visual change.
  ],
)

#week(
  "5",
  "JavaScript I — First Interactivity",
  [
    *Theory:* What JavaScript does in the browser; linking `script.js`;
    variables (`let`, `const`); the DOM — what it is and how JS sees the
    page; selecting elements (`querySelector`); events (`addEventListener`,
    `click`); changing content (`textContent`, `innerHTML`, `classList`).
    Worked example: a button that changes a heading. \
    *Lab:* Students add one piece of interactivity to their assignment repo.
    Write first meaningful JOURNAL.md entry documenting what they researched
    and how they adapted it.
  ],
  list(
    [Understand the role of JavaScript in a webpage.],
    [Select a DOM element and respond to a click event.],
    [Change page content or appearance dynamically.],
    [Document a learning process honestly in JOURNAL.md.],
  ),
  assignment: [
    Continue *cs-intro* repo. \
    Week 5 task: add at least one JS interaction to `script.js`; write a
    JOURNAL.md entry; push all changes before the holidays.
  ],
  notes: [End of pre-holiday block. Remind students to push everything before
          the break. The completed repo is a useful reference during the exam.],
)

#holiday-block("Fall Holidays")

#week(
  "6",
  "Consolidation — Written Exam & Review",
  [
    *Theory (exam session):* Written exam covering HTML structure and tags,
    CSS selectors and properties, basic JS and DOM manipulation, git
    vocabulary and workflow. Open-reference-sheet format recommended. \
    *Theory (review session):* Go through the exam together; address common
    weak spots; Q&A. Students may look back at their assignment repo. \
    *Lab:* Targeted practice on whichever topics the exam revealed as weak.
    Students can also clean up and improve their cs-intro repo.
  ],
  list(
    [Demonstrate understanding of HTML, CSS, and JS fundamentals in writing.],
    [Identify and address gaps in understanding before the project begins.],
  ),
  notes: [Keep the review session flexible — let the exam results guide it
          rather than following a fixed plan. This is the most valuable
          teaching session of the unit if used well.],
)

#week(
  "7",
  "HTML II + CSS II — Going Deeper",
  [
    *Theory:* HTML: forms (`<form>`, `<input>`, `<label>`, `<button>`),
    tables (`<table>`, `<tr>`, `<td>`, `<th>`), multimedia (`<video>`,
    `<audio>`), `<figure>` and `<figcaption>`. CSS: layout with Flexbox
    (concepts and key properties); `display`, `position`; CSS variables
    (`--custom-property`); pseudo-classes (`:hover`, `:focus`). \
    *Lab:* Students extend their cs-intro repo or work on a new standalone
    practice page applying the new techniques.
  ],
  list(
    [Use HTML forms and tables correctly.],
    [Understand and apply basic Flexbox layout.],
    [Use CSS pseudo-classes for interactive styling.],
    [Define and use at least one CSS custom property.],
  ),
  assignment: [
    Optional extension to *cs-intro* repo, or a separate practice page. \
    Not graded — for consolidation and experimentation.
  ],
)

#week(
  "8",
  "JavaScript II + Project Kickoff",
  [
    *Theory:* JS functions (declaration, parameters, return values);
    conditionals (`if`/`else`); working with multiple DOM elements;
    simple form validation; `setTimeout` / `setInterval` for basic
    animation. Introduction to the project: walkthrough of the assignment
    sheet, rubric, and timeline. \
    *Lab:* Project kickoff — students choose their topic, sketch a layout
    on paper, create their README plan, accept the project assignment on
    GitHub Classroom, and make their first project commit.
  ],
  list(
    [Write and call a JS function with parameters.],
    [Use conditionals to control program flow.],
    [Understand the project requirements and rubric in full.],
    [Make a realistic plan and document it in README.md.],
  ),
  assignment: [
    *Project repository* goes live via GitHub Classroom. \
    Week 8 task: write a clear README plan (topic, intended features,
    rough layout); make first commit (at minimum a valid HTML skeleton).
  ],
  notes: [Spend time on the project brief in theory — students who plan well
          build well. The README is graded, so it is worth doing properly now.],
)

#week(
  "9",
  "Project — HTML & CSS Phase",
  [
    *Theory:* Short guided session on common project pitfalls (messy commit
    history, inline styles, copy-paste without understanding). Remainder
    of theory sessions are open project work with teacher circulating. \
    *Lab:* Project work. Focus: building and styling the HTML/CSS structure.
    Students should have a visually complete (if not yet interactive) page
    by end of week.
  ],
  list(
    [Build the HTML structure of the project site.],
    [Apply CSS styling with clean separation of concerns.],
    [Maintain a regular, meaningful commit history.],
    [Make at least one JOURNAL.md entry.],
  ),
  notes: [Check commit histories mid-week. Students who have only one or two
          commits need a nudge early, not at submission.],
)

#week(
  "10",
  "Project — JavaScript Phase",
  [
    *Theory:* Short session on debugging JS in the browser (DevTools console,
    breakpoints). Open project work. \
    *Lab:* Project work. Focus: adding and refining JavaScript interactivity.
    Students update JOURNAL.md to document what they researched and adapted.
  ],
  list(
    [Add at least one working JS interaction to the project.],
    [Use the browser DevTools console to debug errors.],
    [Document the JS development process in JOURNAL.md.],
  ),
)

#week(
  "11",
  "Project — Polish & Submission",
  [
    *Theory:* Peer review session — students swap repos and give written
    feedback against the rubric criteria. Final open work session. \
    *Lab:* Final project work. Students polish, test in browser, review
    commit history, and ensure JOURNAL.md is complete. Submission deadline
    at end of week.
  ],
  list(
    [Test the site thoroughly and fix errors.],
    [Ensure the commit history tells a clear development story.],
    [Complete JOURNAL.md with all significant entries.],
    [Submit on time via GitHub Classroom.],
  ),
  notes: [Remind students: the site must work after cloning from a fresh
          clone. Test this themselves before submitting.],
)

#week(
  "12",
  "Technical Discussions + Next Topic Intro",
  [
    *Theory:* Self-directed work on the next topic introduction (materials
    provided — designed to be fully self-sufficient). Students not yet in
    discussion work independently. \
    *Lab:* Continued discussions and self-directed work.
  ],
  list(
    [Demonstrate understanding of HTML, CSS, and JS as used in the project.],
    [Explain technical and design decisions clearly and confidently.],
    [Begin engaging with the next topic independently.],
  ),
  notes: [
    Schedule discussions across both theory and lab sessions. At 5 minutes
    each, 20 students = ~2 full sessions. Prepare the next topic materials
    in advance — they must be self-sufficient enough that the class runs
    without teacher input while discussions are ongoing.
  ],
)

// ─────────────────────────────────────────────────────────────────────────────
// ASSESSMENT SUMMARY
// ─────────────────────────────────────────────────────────────────────────────

= Assessment Summary

== Written Exam (Week 6)

The written exam covers material from weeks 1–5. It is intended as a
formative checkpoint, not a high-stakes summative assessment. An open
reference sheet (one A4 page, student-prepared) is recommended to shift
the focus from syntax recall to conceptual understanding.

*Suggested coverage:*

#table(
  columns: (1fr, auto),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Topic],
    text(size: 9pt, weight: "bold", fill: white)[Approx. weight],
  ),
  [HTML — structure, tags, semantics], [30%],
  [CSS — selectors, properties, box model], [30%],
  [JavaScript — variables, events, DOM], [25%],
  [Git — vocabulary, workflow, commit messages], [15%],
)

== Graded Project (Weeks 8–11, Discussion Week 12)

See the separate assignment sheet and rubric for full details.
Maximum: 20 points. Grade formula: points / 20 × 5 + 1.

#table(
  columns: (1fr, auto, auto),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Criterion],
    text(size: 9pt, weight: "bold", fill: white)[Max],
    text(size: 9pt, weight: "bold", fill: white)[Weight],
  ),
  [Planning], [2], [10%],
  [Process (git, independence, AI use)], [4], [20%],
  [Implementation (HTML, CSS, JS quality)], [4], [20%],
  [Content & Independent Learning], [4], [20%],
  [Technical Discussion], [4], [20%],
  [Final Submission (functional, on time)], [2], [10%],
)

// ─────────────────────────────────────────────────────────────────────────────
// GITHUB CLASSROOM ASSIGNMENTS
// ─────────────────────────────────────────────────────────────────────────────

= GitHub Classroom Assignments

== cs-intro (Weeks 2–5)

A single repository that grows over four weeks. Students accept it in
week 2 and keep building in the same repo through week 5.

*Template file structure:*

```
cs-intro/
├── index.html    ← skeleton: DOCTYPE, head, linked CSS+JS, empty body
├── style.css     ← empty file, ready to use
├── script.js     ← empty file, ready to use
├── README.md     ← prompts: name, what is this site about?
└── JOURNAL.md    ← prompts: date, what I tried, where I looked, what I learned
```

*Weekly tasks:*

#table(
  columns: (4em, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Week],
    text(size: 9pt, weight: "bold", fill: white)[Task],
  ),
  [2], [Add name to README; write first JOURNAL entry; commit and push.],
  [3], [Build out `index.html` with real content; ≥6 HTML tags; ≥2 commits.],
  [4], [Style in `style.css`; no inline styles; ≥5 CSS properties; commit each change.],
  [5], [Add ≥1 JS interaction in `script.js`; write JOURNAL entry; push before holidays.],
)

== Project Repository (Weeks 8–11)

Distributed in week 8 via GitHub Classroom. See the assignment sheet for
the full specification and grading rubric.

*Template file structure:*

```
project/
├── index.html    ← empty valid skeleton
├── style.css     ← empty
├── script.js     ← empty
├── README.md     ← students write their project plan here
└── JOURNAL.md    ← ongoing learning log
```
