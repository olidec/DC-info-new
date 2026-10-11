// ─────────────────────────────────────────────────────────────────────────────
// Solutions — Exercise Sheet, Lesson 4: CSS Basics
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-num = "4"
#let sheet-type = "Solutions"
#let sheet-title = "CSS Basics"

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
  "1.", [*B*], [The `<link>` element goes in the `<head>`. `<script>` is for JavaScript.],
  "2.", [*A*], [Selector, curly braces, then `property: value;` pairs.],
  "3.", [*B*], [A dot selects a class. `#intro` would select an id.],
  "4.", [*C*], [Padding is inside the border; margin is outside.],
  "5.", [*A*], [A hex color starts with `#`, followed by six hex digits.],
  "6.", [*B*], [Inline styles work, but they mix structure (HTML) and appearance (CSS).],
)

= Part 2 — Reading CSS #h(1fr) #tier-core

#sol("1.")[The whole page gets a very light gray background. All text is
  very dark gray (almost black).]

#sol("2.")[Every level-1 heading is navy blue and 32 pixels tall, in the
  font Arial. If Arial is not installed, the browser uses some other
  font without serifs.]

#sol("3.")[Every element with the class `card` gets 20px of space inside,
  around its content, and a thin (2px) solid light-gray border. There is
  16px of space above and below the card, but none to the left and right.]

#sol("4.")[Every element with the class `portrait` (presumably an image) is
  150px wide and is pushed to the left side; the following text flows
  around it on the right. There is a 20px gap to the right of the image and
  10px below it, but no margin at the top or on the left.]

#tnote[In question 4, check that students read the four `margin` values
  in the right order: top, right, bottom, left (clockwise).]

= Part 3 — Selectors #h(1fr) #tier-core

== Which elements are targeted?

#sol("a)")[Both paragraphs: "Student and photographer" _and_ "I live in Basel…".]
#sol("b)")[Only the paragraph "Student and photographer".]
#sol("c)")[The `<div>` that contains the whole profile.]
#sol("d)")[Both list items: "Born in 2010" and "Favorite subject: Mathematics".]
#sol("e)")[The same two list items as in d).]

#tnote[c): Some properties (e.g. `color`, `font-family`) are inherited,
  so styling `#profile` can visibly change the elements inside it as well.
  Accept answers that mention this, but the element that is _selected_ is
  only the `<div>`. d) and e) select the same elements here, but would
  differ as soon as the page contained another list.]

== Write the selector

#sol("a)")[`h1`]
#sol("b)")[`#profile`]
#sol("c)")[`.fact`]
#sol("d)")[Give the paragraph its own class (or id) in the HTML, then use
  that class as the selector:]

```html
<p class="bio">I live in Basel and enjoy hiking in the Jura.</p>
```
```css
.bio {
  color: #444444;
}
```

#tnote[Stronger students may find selectors such as `.tagline + p` or
  `#profile p:not(.tagline)`. These are correct but were not covered in
  class; the intended answer is adding a class.]

= Part 4 — The Box Model #h(1fr) #tier-extension

== Label the layers

#table(
  columns: (1fr, 8em),
  stroke: 0.4pt + rgb("#CCCCCC"),
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Description],
    text(size: 9pt, weight: "bold", fill: white)[Layer],
  ),
  [The text or image itself], [*content*],
  [Space between the content and the border], [*padding*],
  [Space outside the element, separating it from its neighbors], [*margin*],
  [An optional visible line around the element], [*border*],
)

== Calculate the width

#sol("a)")[Content + padding on both sides + border on both sides:
  $ 200 + 2 dot 20 + 2 dot 3 = 246 "px" $]

#sol("b)")[Add the margin on both sides:
  $ 246 + 2 dot 10 = 266 "px" $]

#tnote[This assumes the browser default `box-sizing: content-box`, where
  `width` only measures the content. With `box-sizing: border-box`, the
  border-to-border width would be exactly 200px. Not needed at this level,
  but a student who has looked at other websites' CSS may ask.]

= Part 5 — Fill in the Blank #h(1fr) #tier-extension

#sol("1.")[`rel` and `href`]
```html
<link rel="stylesheet" href="style.css">
```

#sol("2.")[`color`, and any line height from about 1.4 to 1.8, e.g. 1.5]
```css
p {
  color: #333333;
  line-height: 1.5;
}
```

#sol("3.")[A dot — the class selector.]
```css
.highlight {
  background-color: #fff3cd;
}
```

#sol("4.")[`family`, the generic fallback `serif`, and `padding`]
```css
.quote {
  font-family: Georgia, serif;
  padding: 16px;
}
```

= Part 6 — Spot the Error #h(1fr) #tier-extension

#sol("1.")[The colon between property and value is missing: `color: blue;`]

#sol("2.")[The dot is missing, so the rule looks for an `<intro>` element:
  `.intro { … }`]

#sol("3.")[The closing curly brace `}` is missing at the end of the rule.]

#sol("4.")[— *see teacher note* —]

#tnote[This snippet (`p { color: #222222; }`) is correct as printed —
  there is no error to find.]

#sol("5.")[The selector `#title` looks for an element with `id="title"`,
  but the heading has `class="title"`. Either change the selector to
  `.title`, or change the HTML to `<h1 id="title">`.]

= Part 7 — Build It #h(1fr) #tier-challenge

A sample solution that meets all requirements. Students' fonts, colors and
sizes will of course differ.

```css
body {
  font-family: "Trebuchet MS", Arial, sans-serif;
  font-size: 16px;
  line-height: 1.6;
  color: #222222;
}

#profile {
  background-color: #f5f5f5;
  padding: 24px;
  display: flow-root;   /* keeps the floated image inside the box */
}

.name {
  color: #2E6DA4;
}

.tagline {
  font-style: italic;
  color: #777777;
}

.portrait {
  float: left;
  width: 150px;
  margin: 0 20px 10px 0;
}
```

#tnote[`display: flow-root` was not taught, but is useful: if the text
  next to the floated portrait is short, the image sticks out of the bottom
  of the `#profile` box. Expect students to run into this — it is a good
  moment to introduce the fix rather than a requirement to check.

  *Going further:* `border-radius: 50%` on a square image makes a round
  portrait; `border-radius: 8px` on `#profile` rounds its corners.
  `text-align: center` is a sensible choice for the name or tagline.]

#tnote[*Checking the requirements:* the `style.css` file should be linked
  in `index.html`, and a search for `style=` in `index.html` should find
  nothing. The commit history should show several separate commits.]
