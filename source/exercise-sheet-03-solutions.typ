// ─────────────────────────────────────────────────────────────────────────────
// Solutions — Exercise Sheet, Lesson 3: HTML Basics
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-num = "3"
#let sheet-type = "Solutions"
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

// ── Solution components ───────────────────────────────────────────────────────
// Answer key table for multiple-choice parts
#let key(..cells) = table(
  columns: (3em, 4.5em, 1fr),
  stroke: 0.4pt + rgb("#CCCCCC"),
  inset: 7pt,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[No.],
    text(size: 9pt, weight: "bold", fill: white)[Answer],
    text(size: 9pt, weight: "bold", fill: white)[Comment],
  ),
  ..cells,
)

// Model answer — numbered item with accent bar
#let sol(num, body) = block(
  width: 100%,
  breakable: false,
  stroke: (left: 2pt + accent),
  inset: (left: 10pt, top: 4pt, bottom: 4pt),
  [#text(weight: "bold")[#num] #h(0.3em) #body],
)

// Teacher-only remark (marking guidance, known issues)
#let tnote(body) = block(
  width: 100%,
  fill: light,
  inset: (x: 12pt, y: 8pt),
  radius: 2pt,
  [#text(size: 9pt, weight: "bold", fill: warn)[Teacher note] \ #text(size: 10pt, body)],
)

#align(center, text(size: 16pt, weight: "bold")[Solutions — #sheet-title])
#v(0.5em)

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

= Part 1 — Multiple Choice #h(1fr) #tier-core

#key(
  "1.", [*B*], [Tags use angle brackets; the paragraph tag is `<p>`.],
  "2.", [*B*], [A closing tag repeats the name with a slash: `</p>`.],
  "3.", [*C*], [`<!DOCTYPE html>` tells the browser this is a modern HTML document.],
  "4.", [*C*], [Everything visible goes in `<body>`; `<head>` holds information _about_ the page.],
  "5.", [*C*], [`<ul>` = unordered list. `<ol>` is numbered; `<li>` is a single item.],
)

= Part 2 — Code to Output #h(1fr) #tier-core

#sol("1.")[A large, bold heading "Hello". Below it, in normal-sized text,
  the paragraph "How are you?".]

#sol("2.")[A bulleted list with three items, each on its own line and
  slightly indented: Cats, Dogs, Fish.]

#sol("3.")[One line of text: "Visit my website for more." The words
  "my website" are a clickable link (usually blue and underlined) that
  leads to `https://example.com`.]

#sol("4.")[A numbered list: 1. Wake up, 2. Eat breakfast, 3. Open VS Code.]

#tnote[In question 3, the line breaks in the source code do *not*
  appear on the page — the browser treats them like ordinary spaces.
  Worth pointing out if students draw the link on a separate line.]

= Part 3 — Which Code Gives This Output? #h(1fr) #tier-core

#key(
  "1.", [*B*], [`<h1>` is the largest heading. `<title>` only sets the browser tab text; `<heading>` does not exist.],
  "2.", [*C*], [A link needs `<a>` _and_ an `href` attribute. `<link>` is used for stylesheets, not clickable links.],
  "3.", [*D*], [C also displays the image, but D is better practice (see below). `<image>` is not an HTML element.],
  "4.", [*B*], [`<ol>` gives numbers, and each item needs its own `<li>`.],
)

#sol("Follow-up:")[*D* is better practice because it includes an `alt`
  text. The `alt` text is read aloud by screen readers for people who
  cannot see the image, and it is shown if the image fails to load.]

= Part 4 — Fill in the Blank #h(1fr) #tier-extension

#sol("1.")[The four missing pieces, in order:]

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>My Page</title>
  </head>
  <body>
    <!-- content here -->
  </body>
</html>
```

#sol("2.")[Attribute `href`, value: any full web address, e.g.
  `https://example.com`.]

```html
<a href="https://example.com">
```

#sol("3.")[`src` for the file path, `alt` for the description:]

```html
<img src="images/dog.jpg"
     alt="A brown dog sitting in a park">
```

= Part 5 — Spot the Error #h(1fr) #tier-extension

#sol("1.")[The closing tag is missing its slash.]
```html
<p>Welcome to my page.</p>
```

#sol("2.")[The list is opened with `<ul>` but closed with `</ol>`. The
  closing tag must match the opening tag.]
```html
</ul>
```

#sol("3.")[The link has no `href`, so it does not lead anywhere.]
```html
<a href="https://example.com">Visit my site</a>
```

#sol("4.")[The image has no `src`, so the browser does not know which file
  to show. (Any sensible file name is fine.)]
```html
<img src="images/sunset.jpg" alt="A sunset over the mountains">
```

#sol("5.")[A heading level is skipped (`h1` → `h3`). Headings describe the
  _structure_ of the page, like chapters and sections, so a subtitle
  directly under the main title should be an `<h2>`. If the subtitle
  should look smaller, that is a job for CSS — not a reason to pick a
  different heading level.]
