// ─────────────────────────────────────────────────────────────────────────────
// Exercise Sheet — Lesson 3: HTML Basics
// ─────────────────────────────────────────────────────────────────────────────

#let course     = "Computer Science"
#let level      = "High School"
#let term       = "[Term / Year]"
#let lesson-num = "3"
#let sheet-type = "Exercise Sheet"
#let sheet-title = "HTML Basics"

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

// ── Extra component: fill-in-the-blank line ───────────────────────────────────
// Draws a fixed-width underline for written answers inside code blocks
#let blank(width: 4em) = box(
  width: width,
  box(width: 100%, stroke: (bottom: 0.8pt + rgb("#111111")))
)

// ── Extra component: multiple choice option ───────────────────────────────────
#let mc-option(label, body) = {
  grid(
    columns: (1.6em, 1fr),
    column-gutter: 4pt,
    align(top + left,
      box(
        width: 1em, height: 1em,
        stroke: 0.8pt + rgb("#111111"),
        radius: 50%,
      )
    ),
    align(top + left)[*#label* #h(0.4em) #body],
  )
  v(0.25em)
}

// ── Extra component: side-by-side code and output ─────────────────────────────
#let code-output(code-content, output-content) = block(
  width: 100%,
  breakable: false,
  grid(
    columns: (1fr, 1fr),
    column-gutter: 12pt,
    block(
      fill: rgb("#F0F0F0"),
      width: 100%,
      inset: 10pt,
      radius: 2pt,
      text(size: 9.5pt, font: "New Computer Modern Mono", fill: rgb("#111111"), code-content)
    ),
    block(
      fill: rgb("#F5F5F5"),
      width: 100%,
      inset: 10pt,
      radius: 2pt,
      stroke: 0.5pt + rgb("#CCCCCC"),
      output-content
    ),
  )
)

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

= Part 1 — Multiple Choice

#exercise(title: "Tag syntax")[
  Circle the letter of the correct answer for each question.

  #text(weight: "bold")[1. Which of the following is a correctly written HTML opening tag?]

  #mc-option("A", [`<paragraph>`])
  #mc-option("B", [`<p>`])
  #mc-option("C", [`(p)`])
  #mc-option("D", [`[p]`])

  #v(0.5em)
  #text(weight: "bold")[2. How do you write a closing tag for a paragraph?]

  #mc-option("A", [`<p/>`])
  #mc-option("B", [`</p>`])
  #mc-option("C", [`<-p>`])
  #mc-option("D", [`<!--p-->`])

  #v(0.5em)
  #text(weight: "bold")[3. Which element should always be the very first line of an HTML document?]

  #mc-option("A", [`<html>`])
  #mc-option("B", [`<head>`])
  #mc-option("C", [`<!DOCTYPE html>`])
  #mc-option("D", [`<meta charset="UTF-8">`])

  #v(0.5em)
  #text(weight: "bold")[4. Where does visible page content go?]

  #mc-option("A", [Inside the `<head>` element])
  #mc-option("B", [Inside the `<html>` element, but outside `<body>`])
  #mc-option("C", [Inside the `<body>` element])
  #mc-option("D", [Inside the `<title>` element])

  #v(0.5em)
  #text(weight: "bold")[5. Which tag creates an unordered (bulleted) list?]

  #mc-option("A", [`<list>`])
  #mc-option("B", [`<ol>`])
  #mc-option("C", [`<ul>`])
  #mc-option("D", [`<li>`])
]

#block(breakable: false)[
= Part 2 — Code to Output

For each HTML snippet on the left, describe in your own words what a browser
would display. Write your answer in the box on the right.

#v(0.5em)
#text(weight: "bold")[1.]
#code-output(
  raw(
    "<h1>Hello</h1>\n<p>How are you?</p>",
    lang: "html"
  ),
  [
    #v(3em)
  ]
)
]

#v(0.6em)
#text(weight: "bold")[2.]
#code-output(
  raw(
    "<ul>\n  <li>Cats</li>\n  <li>Dogs</li>\n  <li>Fish</li>\n</ul>",
    lang: "html"
  ),
  [
    #v(4em)
  ]
)

#v(0.6em)
#text(weight: "bold")[3.]
#code-output(
  raw(
    "<p>Visit\n<a href=\"https://example.com\">\n  my website\n</a>\nfor more.</p>",
    lang: "html"
  ),
  [
    #v(4em)
  ]
)

#v(0.6em)
#text(weight: "bold")[4.]
#code-output(
  raw(
    "<ol>\n  <li>Wake up</li>\n  <li>Eat breakfast</li>\n  <li>Open VS Code</li>\n</ol>",
    lang: "html"
  ),
  [
    #v(4em)
  ]
)

#block(breakable: false)[
= Part 3 — Which Code Gives This Output?

Each question shows a desired result. Circle the letter of the HTML snippet
that would produce it.

#v(0.5em)
#text(weight: "bold")[1. You want a large heading that reads "My Hobbies".]

#mc-option("A", raw("<p>My Hobbies</p>", lang: "html"))
#mc-option("B", raw("<h1>My Hobbies</h1>", lang: "html"))
#mc-option("C", raw("<heading>My Hobbies</heading>", lang: "html"))
#mc-option("D", raw("<title>My Hobbies</title>", lang: "html"))
]

#v(0.6em)
#text(weight: "bold")[2. You want a clickable link that says "Open Google" and goes to https://google.com.]

#mc-option("A", raw("<a>Open Google</a>", lang: "html"))
#mc-option("B", raw("<link href=\"https://google.com\">Open Google</link>", lang: "html"))
#mc-option("C", raw("<a href=\"https://google.com\">Open Google</a>", lang: "html"))
#mc-option("D", raw("<p href=\"https://google.com\">Open Google</p>", lang: "html"))

#v(0.6em)
#text(weight: "bold")[3. You want to display an image stored at ]
#raw("images/cat.jpg")
#text(weight: "bold")[ with a description.]

#mc-option("A", raw("<img>images/cat.jpg</img>", lang: "html"))
#mc-option("B", raw("<image src=\"images/cat.jpg\">", lang: "html"))
#mc-option("C", raw("<img src=\"images/cat.jpg\">", lang: "html"))
#mc-option("D", raw("<img src=\"images/cat.jpg\" alt=\"A photo of a cat\">", lang: "html"))

#v(0.6em)
#text(weight: "bold")[4. You want a numbered list with two items: "First" and "Second".]

#mc-option("A", raw("<ul>\n  <li>First</li>\n  <li>Second</li>\n</ul>", lang: "html"))
#mc-option("B", raw("<ol>\n  <li>First</li>\n  <li>Second</li>\n</ol>", lang: "html"))
#mc-option("C", raw("<list>\n  <item>First</item>\n  <item>Second</item>\n</list>", lang: "html"))
#mc-option("D", raw("<ol>\n  First\n  Second\n</ol>", lang: "html"))

Note: for question 3, both C and D are technically valid HTML. Which one is
*better practice* and why?

#answer-space(lines: 2)

#block(breakable: false)[
= Part 4 — Fill in the Blank

Complete each HTML snippet by filling in the missing parts.

#text(weight: "bold")[1. A valid document skeleton — fill in the four missing tag names:]

#v(0.4em)
#block(
  fill: rgb("#F0F0F0"),
  width: 100%,
  inset: 12pt,
  radius: 2pt,
  text(size: 10pt, font: "New Computer Modern Mono")[
    \<____________________\> \
    \<html lang="en"\> \
    #h(2em) \<____________________\> \
    #h(4em) \<meta charset="UTF-8"\> \
    #h(4em) \<title\>My Page\</title\> \
    #h(2em) \</head\> \
    #h(2em) \<____________________\> \
    #h(4em) \<!-- content here --\> \
    #h(2em) \</____________________\> \
    \</html\>
  ]
)
]

#v(0.8em)
#text(weight: "bold")[2. A paragraph with a link — fill in the missing attribute and value:]

#v(0.4em)
#block(
  fill: rgb("#F0F0F0"),
  width: 100%,
  inset: 12pt,
  radius: 2pt,
  text(size: 10pt, font: "New Computer Modern Mono")[
    \<p\>My favourite website is \
    #h(2em)\<a ____________________="____________________"\> \
    #h(4em)click here \
    #h(2em)\</a\>. \
    \</p\>
  ]
)

#v(0.8em)
#text(weight: "bold")[3. An image element — fill in both missing attributes:]

#v(0.4em)
#block(
  fill: rgb("#F0F0F0"),
  width: 100%,
  inset: 12pt,
  radius: 2pt,
  text(size: 10pt, font: "New Computer Modern Mono")[
    \<img ____________________="images/dog.jpg" \
    #h(4em) ____________________="A brown dog sitting in a park"\>
  ]
)

#block(breakable: false)[
= Part 5 — Spot the Error

Each snippet below contains one mistake. Find it, circle it, and write
a correction on the line below.

#text(weight: "bold")[1.]
```html
<p>Welcome to my page.<p>
```
#answer-space(lines: 1)

#text(weight: "bold")[2.]
```html
<ul>
  <li>Cats</li>
  <li>Dogs</li>
</ol>
```
#answer-space(lines: 1)

#text(weight: "bold")[3.]
```html
<a>Visit my site</a>
```
#answer-space(lines: 1)

#text(weight: "bold")[4.]
```html
<img alt="A sunset over the mountains">
```
#answer-space(lines: 1)

#text(weight: "bold")[5.]
```html
<h1>Title</h1>
<h3>Subtitle</h3>
```

This code is syntactically valid — but what is wrong with it from a
best-practice point of view?
#answer-space(lines: 2)
]
