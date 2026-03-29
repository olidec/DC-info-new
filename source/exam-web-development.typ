// ─────────────────────────────────────────────────────────────────────────────
// Written Exam — Web Development Unit
// ─────────────────────────────────────────────────────────────────────────────

#let course     = "Computer Science"
#let level      = "High School"
#let term       = "[Term / Year]"
#let sheet-type = "Written Exam"

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

// ── Exam-specific components ──────────────────────────────────────────────────
#let mc-option(label, body) = {
  grid(
    columns: (1.6em, 1fr),
    column-gutter: 4pt,
    align(top + left,
      box(width: 1em, height: 1em, stroke: 0.8pt + rgb("#111111"), radius: 50%)
    ),
    align(top + left)[*#label* #h(0.4em) #body],
  )
  v(0.25em)
}

// Points badge — shown at top right of each question
#let pts(n) = box(
  fill: rgb("#F5F5F5"),
  stroke: 0.5pt + rgb("#CCCCCC"),
  inset: (x: 6pt, y: 2pt),
  radius: 2pt,
  text(size: 9pt, fill: rgb("#555555"))[#n #if n == 1 [pt] else [pts]]
)

// Question block with number, points, and content
#let exam-counter = counter("exam-question")
#let question(points: 1, body) = {
  exam-counter.step()
  block(
    width: 100%,
    breakable: false,
    inset: (bottom: 6pt),
    {
      grid(
        columns: (1fr, auto),
        align(left,
          text(weight: "bold", fill: rgb("#2E6DA4"))[
            Q#context exam-counter.display()
          ]
        ),
        align(right, pts(points)),
      )
      v(0.3em)
      body
    }
  )
  v(0.6em)
}

// ── Title block ───────────────────────────────────────────────────────────────
#{
  text(size: 18pt, weight: "bold", fill: rgb("#111111"))[Written Exam]
  v(0.1em)
  text(size: 11pt, fill: rgb("#999999"))[Web Development — #course #sym.bar.v #level #sym.bar.v #term]
  v(0.3em)
  line(length: 100%, stroke: 1pt + rgb("#2E6DA4"))
  v(0.5em)
}

// ── Exam info box ─────────────────────────────────────────────────────────────
#block(
  fill: rgb("#F5F5F5"),
  width: 100%,
  inset: (x: 14pt, y: 10pt),
  radius: 2pt,
  grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    [
      *Allowed aids:* One self-prepared A4 reference sheet (both sides). \
      *Duration:* 45 minutes.
    ],
    [
      *Name:* #h(1fr) #line(length: 85%, stroke: 0.5pt + rgb("#111111")) \
      #v(0.4em)
      *Total: #h(1fr) / 34 pts*
    ],
  )
)

#v(0.8em)

// ─────────────────────────────────────────────────────────────────────────────
// SECTION A — GIT & VERSION CONTROL  (8 pts)
// ─────────────────────────────────────────────────────────────────────────────

= Section A — Git & Version Control

#question(points: 1)[
  What is a *repository*?

  #mc-option("A", [A folder that Git is tracking, containing the full history of all changes.])
  #mc-option("B", [A backup copy of a file stored on your desktop.])
  #mc-option("C", [The website where you download Git.])
  #mc-option("D", [A branch of your project on GitHub.])
]

#question(points: 1)[
  What is the correct order of steps to save and share a change using Git?

  #mc-option("A", [Push → Commit → Stage])
  #mc-option("B", [Stage → Push → Commit])
  #mc-option("C", [Stage → Commit → Push])
  #mc-option("D", [Commit → Stage → Push])
]

#question(points: 1)[
  What does `git push` do?

  #mc-option("A", [Downloads changes from GitHub to your local machine.])
  #mc-option("B", [Creates a new branch on GitHub.])
  #mc-option("C", [Sends your local commits to the remote repository on GitHub.])
  #mc-option("D", [Stages all changed files ready for a commit.])
]

#question(points: 2)[
  A student has been working on their project and has made three changes:
  they updated `index.html`, added an image to the `images/` folder, and
  edited `style.css`. They want to commit only the HTML and CSS changes
  for now and leave the image for later.

  Describe in your own words the steps they should take.

  #answer-space(lines: 4)
]

#question(points: 3)[
  A classmate shows you their GitHub repository. Their entire project
  history looks like this:

  #block(
    fill: rgb("#F0F0F0"),
    inset: 10pt,
    radius: 2pt,
    width: 100%,
    text(size: 10pt)[
      - `final version` \
      - `almost done` \
      - `stuff` \
      - `first commit`
    ]
  )

  #v(0.4em)
  *a)* What is wrong with this commit history? *(1 pt)*
  #answer-space(lines: 2)

  *b)* Write two example commit messages that would be better. *(2 pts)*
  #answer-space(lines: 2)
]

// ─────────────────────────────────────────────────────────────────────────────
// SECTION B — HTML  (10 pts)
// ─────────────────────────────────────────────────────────────────────────────

= Section B — HTML

#question(points: 1)[
  Which of the following is a valid, complete HTML document skeleton?

  #mc-option("A")[
    ```html
    <html>
      <p>Hello</p>
    </html>
    ```
  ]
  #mc-option("B")[
    ```html
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8">
        <title>My Page</title>
      </head>
      <body>
        <p>Hello</p>
      </body>
    </html>
    ```
  ]
  #mc-option("C")[
    ```html
    <!DOCTYPE html>
    <body>
      <p>Hello</p>
    </body>
    ```
  ]
  #mc-option("D")[
    ```html
    <head>
      <title>My Page</title>
    </head>
    <body>
      <p>Hello</p>
    </body>
    ```
  ]
]

#question(points: 1)[
  What is the difference between `<ul>` and `<ol>`?

  #mc-option("A", [`<ul>` creates a numbered list; `<ol>` creates a bulleted list.])
  #mc-option("B", [`<ul>` creates a bulleted list; `<ol>` creates a numbered list.])
  #mc-option("C", [They are identical — either can be used for any list.])
  #mc-option("D", [`<ul>` is for links; `<ol>` is for images.])
]

#question(points: 2)[
  Write the HTML for an image of a cat stored at `images/cat.jpg`.
  The image should have an appropriate `alt` attribute.

  #answer-space(lines: 2)
]

#question(points: 2)[
  Write the HTML for a link that reads "Visit MDN" and goes to
  `https://developer.mozilla.org`.

  #answer-space(lines: 2)
]

#question(points: 4)[
  The following HTML contains *four mistakes*. Find and correct each one.
  Mark them directly on the page and write your corrections below.

  #block(
    fill: rgb("#F0F0F0"),
    inset: 12pt,
    radius: 2pt,
    width: 100%,
    raw(lang: "html",
"<!DOCTYPE html>
<html>
  <head>
    <title>My Page<title>
  </head>
  <body>
    <h1>Welcome</h1>
    <p>My favorite color is blue.
    <ul>
      <li>Cats</li>
      <li>Dogs</li>
    </ol>
    <img src=\"images/dog.jpg\">
  </body>
</html>")
  )

  #v(0.4em)
  Corrections:
  #answer-space(lines: 4)
]

// ─────────────────────────────────────────────────────────────────────────────
// SECTION C — CSS  (8 pts)
// ─────────────────────────────────────────────────────────────────────────────

= Section C — CSS

#question(points: 1)[
  Which CSS selector targets *all* `<p>` elements on a page?

  #mc-option("A", [`#p { }`])
  #mc-option("B", [`.p { }`])
  #mc-option("C", [`p { }`])
  #mc-option("D", [`*p { }`])
]

#question(points: 1)[
  What is the difference between `margin` and `padding`?

  #mc-option("A", [There is no difference — they both add space around an element.])
  #mc-option("B", [`margin` is space inside the border; `padding` is space outside it.])
  #mc-option("C", [`padding` is space inside the border; `margin` is space outside it.])
  #mc-option("D", [`margin` controls font size; `padding` controls border thickness.])
]

#question(points: 2)[
  Write a CSS rule that makes all `<h2>` elements dark blue (`#1a1a6e`)
  and gives them a font size of `24px`.

  #answer-space(lines: 3)
]

#question(points: 4)[
  Read the following HTML and CSS, then answer the questions below.

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 12pt,
    block(
      fill: rgb("#F0F0F0"),
      inset: 10pt,
      radius: 2pt,
      width: 100%,
      raw(lang: "html",
"<div id=\"banner\">
  <h1 class=\"title\">Hello</h1>
  <p class=\"title\">Welcome!</p>
  <p>Come on in.</p>
</div>")
    ),
    block(
      fill: rgb("#F0F0F0"),
      inset: 10pt,
      radius: 2pt,
      width: 100%,
      raw(lang: "css",
"#banner {
  background-color: #2E6DA4;
  padding: 20px;
}

.title {
  color: white;
  font-weight: bold;
}

p {
  font-size: 14px;
}")
    ),
  )

  #v(0.5em)
  *a)* What color is the text "Hello"? *(1 pt)*
  #answer-space(lines: 1)

  *b)* What color is the text "Come on in."? *(1 pt)*
  #answer-space(lines: 1)

  *c)* Which elements have `font-size: 14px` applied? Explain why. *(2 pts)*
  #answer-space(lines: 3)
]

// ─────────────────────────────────────────────────────────────────────────────
// SECTION D — JAVASCRIPT  (8 pts)
// ─────────────────────────────────────────────────────────────────────────────

= Section D — JavaScript

#question(points: 1)[
  What does `document.getElementById("box")` return?

  #mc-option("A", [The text content of the element with `id="box"`.])
  #mc-option("B", [A reference to the HTML element with `id="box"`.])
  #mc-option("C", [The CSS styles applied to the element with `id="box"`.])
  #mc-option("D", [The number `1`, if an element with `id="box"` exists.])
]

#question(points: 1)[
  When should you use `let` instead of `const`?

  #mc-option("A", [Always — `let` is newer and better than `const`.])
  #mc-option("B", [When the variable's value needs to change after it is declared.])
  #mc-option("C", [When the variable holds a string.])
  #mc-option("D", [Only inside functions.])
]

#question(points: 2)[
  Read the following code. What text will the element with `id="output"`
  display after the button is clicked *three times*? Show your working.

  #block(
    fill: rgb("#F0F0F0"),
    inset: 12pt,
    radius: 2pt,
    width: 100%,
    raw(lang: "js",
"let count = 10;

function update() {
  count = count - 3;
  const el = document.getElementById(\"output\");
  el.textContent = count;
}")
  )

  #answer-space(lines: 3)
]

#question(points: 4)[
  Write the HTML and JavaScript needed to create a button that, when
  clicked, changes the text of a paragraph from "The light is off" to
  "The light is on".

  Requirements:
  - The paragraph must have an appropriate `id`.
  - The button must use `onclick` to call a function.
  - The function must be defined in JavaScript.

  *HTML:*
  #answer-space(lines: 3)

  *JavaScript:*
  #answer-space(lines: 5)
]

// ─────────────────────────────────────────────────────────────────────────────
// SECTION E — READING CODE  (8 pts)
// ─────────────────────────────────────────────────────────────────────────────

= Section E — Reading Code

#question(points: 4)[
  Study the following three files carefully, then answer the questions.

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 10pt,
    block(
      fill: rgb("#F0F0F0"),
      inset: 10pt,
      radius: 2pt,
      width: 100%,
      stack(
        spacing: 4pt,
        text(size: 8pt, weight: "bold", fill: rgb("#555555"))[index.html],
        raw(lang: "html",
"<body>
  <h1 id=\"title\">Score: 0</h1>
  <button onclick=\"addPoint()\">
    +1
  </button>
  <button onclick=\"reset()\">
    Reset
  </button>
</body>")
      )
    ),
    block(
      fill: rgb("#F0F0F0"),
      inset: 10pt,
      radius: 2pt,
      width: 100%,
      stack(
        spacing: 4pt,
        text(size: 8pt, weight: "bold", fill: rgb("#555555"))[script.js],
        raw(lang: "js",
"let score = 0;

function addPoint() {
  score = score + 1;
  const t = document.getElementById(\"title\");
  t.textContent = \"Score: \" + score;
}

function reset() {
  score = 0;
  const t = document.getElementById(\"title\");
  t.textContent = \"Score: \" + score;
}")
      )
    ),
  )

  #v(0.5em)
  *a)* What does the page display when it first loads? *(1 pt)*
  #answer-space(lines: 1)

  *b)* What does the page display after the "+1" button is clicked four times? *(1 pt)*
  #answer-space(lines: 1)

  *c)* What happens when the Reset button is clicked? Describe both the variable and the page. *(2 pts)*
  #answer-space(lines: 3)
]

#question(points: 4)[
  The following code is supposed to toggle a CSS class called `dark-mode`
  on the `<body>` element when a button is clicked. It has *two bugs*.
  Find them, explain what is wrong, and write the corrected code.

  #block(
    fill: rgb("#F0F0F0"),
    inset: 12pt,
    radius: 2pt,
    width: 100%,
    raw(lang: "js",
"function toggleDark() {
  const page = document.getElementById(\"body\");
  page.classList.add(\"dark-mode\");
}")
  )

  *Bug 1:*
  #answer-space(lines: 2)

  *Bug 2:*
  #answer-space(lines: 2)

  *Corrected code:*
  #answer-space(lines: 4)
]

// ─────────────────────────────────────────────────────────────────────────────
// POINTS SUMMARY
// ─────────────────────────────────────────────────────────────────────────────

#v(1em)
#line(length: 100%, stroke: 0.5pt + rgb("#CCCCCC"))
#v(0.5em)

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { rgb("#111111") } else { rgb("#F5F5F5") },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Section A \ Git],
    text(size: 9pt, weight: "bold", fill: white)[Section B \ HTML],
    text(size: 9pt, weight: "bold", fill: white)[Section C \ CSS],
    text(size: 9pt, weight: "bold", fill: white)[Section D \ JavaScript],
    text(size: 9pt, weight: "bold", fill: white)[Section E \ Reading],
    text(size: 9pt, weight: "bold", fill: white)[Total],
  ),
  text(size: 9pt, fill: rgb("#555555"))[#"/ 8"],
  text(size: 9pt, fill: rgb("#555555"))[#"/ 10"],
  text(size: 9pt, fill: rgb("#555555"))[#"/ 8"],
  text(size: 9pt, fill: rgb("#555555"))[#"/ 8"],
  text(size: 9pt, fill: rgb("#555555"))[#"/ 8"],
  text(size: 9pt, weight: "bold")[#"/ 34"],
)
