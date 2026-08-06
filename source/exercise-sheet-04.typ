// ─────────────────────────────────────────────────────────────────────────────
// Exercise Sheet — Lesson 4: CSS Basics
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-num = "4"
#let sheet-type = "Exercise Sheet"
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

// ── Extra components ──────────────────────────────────────────────────────────
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
      text(size: 9.5pt, fill: rgb("#111111"), code-content)
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

// ── Fill-in-the-blank monospace block ─────────────────────────────────────────
#let fitb(content) = block(
  fill: rgb("#F0F0F0"),
  width: 100%,
  inset: 12pt,
  radius: 2pt,
  text(size: 10pt, content)
)

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

#tier-legend

#v(0.5em)

= Part 1 — Multiple Choice #h(1fr) #tier-core

#exercise(title: "Concepts and syntax", breakable: true)[
  Circle the letter of the correct answer.

  #v(0.4em)
  #text(weight: "bold")[1. How is a CSS file connected to an HTML document?]

  #mc-option("A", [With a `<style>` element inside the `<body>`.])
  #mc-option("B", [With a `<link rel="stylesheet" href="style.css">` element in the `<head>`.])
  #mc-option("C", [With a `<script src="style.css">` element in the `<head>`.])
  #mc-option("D", [CSS files are detected automatically if they are in the same folder.])

  #v(0.5em)
  #text(weight: "bold")[2. Which of the following is a correctly written CSS rule?]

  #mc-option("A", [`p { color: navy; }`])
  #mc-option("B", [`p ( color = navy )`])
  #mc-option("C", [`p: color navy;`])
  #mc-option("D", [`{ p: color: navy; }`])

  #v(0.5em)
  #text(weight: "bold")[3. What does the selector `.intro` target?]

  #mc-option("A", [The element with `id="intro"`.])
  #mc-option("B", [All elements with `class="intro"`.])
  #mc-option("C", [All `<intro>` elements.])
  #mc-option("D", [The first paragraph of the page.])

  #colbreak()
  #v(0.5em)
  #text(weight: "bold")[4. Which property controls the space between the content and the border?]

  #mc-option("A", [`margin`])
  #mc-option("B", [`border-spacing`])
  #mc-option("C", [`padding`])
  #mc-option("D", [`line-height`])

  #v(0.5em)
  #text(weight: "bold")[5. Which of these is a valid hex color value?]

  #mc-option("A", [`#2E6DA4`])
  #mc-option("B", [`2E6DA4#`])
  #mc-option("C", [`hex(2E6DA4)`])
  #mc-option("D", [`rgb(#2E6DA4)`])

  #v(0.5em)
  #text(weight: "bold")[6. Why should you avoid writing styles directly in the HTML, like \ `<p style="color: red">`?]

  #mc-option("A", [Because it does not work in modern browsers.])
  #mc-option("B", [Because it mixes structure and appearance, making the code harder to maintain.])
  #mc-option("C", [Because inline styles are always ignored by the browser.])
  #mc-option("D", [There is no reason — it is the recommended approach.])
]

#block(breakable: false)[
= Part 2 — Reading CSS #h(1fr) #tier-core

For each rule, describe in your own words what a browser would display.

#v(0.4em)
#text(weight: "bold")[1.]
#code-output(
  raw(lang: "css",
```css
body {
  background-color: #f5f5f5;
  color: #222222;
}
```.text
  ),
  [ #v(3.5em) ]
)
]
#pagebreak()
#v(0.5em)
#text(weight: "bold")[2.]
#code-output(
  raw(lang: "css",
```css
h1 {
  color: navy;
  font-size: 32px;
  font-family: Arial, sans-serif;
}
```.text
  ),
  [ #v(3.5em) ]
)

#v(0.5em)
#text(weight: "bold")[3.]
#code-output(
  raw(lang: "css",
```css
.card {
  padding: 20px;
  border: 2px solid #cccccc;
  margin: 16px 0;
}
```.text
  ),
  [ #v(3.5em) ]
)

#v(0.5em)
#text(weight: "bold")[4.]
#code-output(
  raw(lang: "css",
```css
.portrait {
  float: left;
  margin: 0 20px 10px 0;
  width: 150px;
}
```.text
  ),
  [ #v(3.5em) ]
)

#block(breakable: false)[
= Part 3 — Selectors #h(1fr) #tier-core

Read the HTML below, then answer the questions that follow.

```html
<div id="profile">
  <h1 class="name">Anna Müller</h1>
  <p class="tagline">Student and photographer</p>
  <p>I live in Basel and enjoy hiking in the Jura.</p>
  <ul class="facts">
    <li class="fact">Born in 2010</li>
    <li class="fact">Favorite subject: Mathematics</li>
  </ul>
</div>
```
]

#v(0.5em)

#exercise(title: "Which elements are targeted?")[
  For each selector, write down exactly which elements from the HTML above
  it would style.

  #v(0.3em)
  #text(weight: "bold")[a)] `p`
  #answer-space(lines: 1)

  #text(weight: "bold")[b)] `.tagline`
  #answer-space(lines: 1)

  #text(weight: "bold")[c)] `#profile`
  #answer-space(lines: 1)

  #text(weight: "bold")[d)] `.fact`
  #answer-space(lines: 1)

  #text(weight: "bold")[e)] `li`
  #answer-space(lines: 1)
]

#exercise(title: "Write the selector")[
  Write the CSS selector you would use to target each of the following.
  You only need the selector, not the whole rule.

  #v(0.3em)
  #text(weight: "bold")[a)] Every heading of level 1 on the page.
  #answer-space(lines: 1)

  #text(weight: "bold")[b)] Only the element whose `id` is `profile`.
  #answer-space(lines: 1)

  #text(weight: "bold")[c)] Every element with the class `fact`.
  #answer-space(lines: 1)

  #v(0.4em)
  #text(weight: "bold")[d)] The paragraph "I live in Basel..." has no class
  and no id. Describe one way you could style *only* that paragraph and not
  the tagline.
  #answer-space(lines: 2)

  #hint[Think about what you would have to change in the HTML first.]
]

#block(breakable: false)[
= Part 4 — The Box Model #h(1fr) #tier-extension

#exercise(title: "Label the layers")[
  Write the correct name — *content*, *padding*, *border*, or *margin* —
  next to each description.

  #v(0.4em)
  #table(
    columns: (1fr, 8em),
    stroke: 0.4pt + rgb("#CCCCCC"),
    fill: (_, row) => if row == 0 { rgb("#111111") } else if calc.odd(row) { light } else { white },
    inset: 8pt,
    table.header(
      text(size: 9pt, weight: "bold", fill: white)[Description],
      text(size: 9pt, weight: "bold", fill: white)[Layer],
    ),
    [The text or image itself], [],
    [Space between the content and the border], [],
    [Space outside the element, separating it from its neighbors], [],
    [An optional visible line around the element], [],
  )
]
]

#exercise(title: "Calculate the width")[
  A `<div>` has the following CSS applied:

  ```css
  .box {
    width: 200px;
    padding: 20px;
    border: 3px solid black;
    margin: 10px;
  }
  ```

  #v(0.3em)
  #text(weight: "bold")[a)] How wide is the box on screen, from the left
  edge of the border to the right edge of the border? Show your working.
  #answer-space(lines: 3)

  #text(weight: "bold")[b)] How much horizontal space does the element take
  up in total, including its margins?
  #answer-space(lines: 2)

  #hint[Padding and border are applied on *both* sides of the content.]
]

#block(breakable: false)[
= Part 5 — Fill in the Blank #h(1fr) #tier-extension

Complete each snippet by filling in the missing parts.

#v(0.4em)
#text(weight: "bold")[1. Link the stylesheet `style.css` from the HTML `<head>`:]

#fitb[
  #raw("<link ____________=\"stylesheet\" ____________=\"style.css\">")
]
]

#v(0.6em)
#text(weight: "bold")[2. Make every paragraph dark grey with comfortable line spacing:]

#fitb[
  #raw("p {") \
  #h(2em) #raw("____________: #333333;") \
  #h(2em) #raw("line-height: ____________;") \
  #raw("}")
]

#v(0.6em)
#text(weight: "bold")[3. Style all elements with the class `highlight`:]

#fitb[
  #raw("____________highlight {") \
  #h(2em) #raw("background-color: #fff3cd;") \
  #raw("}")
]

#v(0.6em)
#text(weight: "bold")[4. Set a serif font with a fallback, and add 16px of space inside the element on all sides:]

#fitb[
  #raw(".quote {") \
  #h(2em) #raw("font-____________: Georgia, ____________;") \
  #h(2em) #raw("____________: 16px;") \
  #raw("}")
]

#block(breakable: false)[
= Part 6 — Spot the Error #h(1fr) #tier-extension

Each snippet contains one mistake. Circle it and write the correction below.

#v(0.4em)
#text(weight: "bold")[1.]
```css
h1 {
  color blue;
}
```
#answer-space(lines: 1)
]


#v(0.4em)
#pagebreak()
#text(weight: "bold")[2.]
```css
intro {
  font-size: 18px;
}
```
The rule is supposed to style `<p class="intro">`.
#answer-space(lines: 1)

#v(0.4em)
#text(weight: "bold")[3.]
```css
.card {
  padding: 20px;
  border: 1px solid #ccc;
```
#answer-space(lines: 1)

#v(0.4em)
#text(weight: "bold")[4.]
```css
p {
  colour: #222222;
}
```
#answer-space(lines: 1)

#v(0.4em)
#text(weight: "bold")[5. The heading does not change color. Why not?]
```css
#title {
  color: #2E6DA4;
}
```
```html
<h1 class="title">My Page</h1>
```
#answer-space(lines: 2)

#block(breakable: false)[
= Part 7 — Build It #h(1fr) #tier-challenge

This part is completed on your computer, in your cs-intro repository.

== The task

Take the HTML below (or the equivalent section of your own page) and write
the CSS to match the description. Add your rules to `style.css` — no inline
styles.

```html
<div id="profile">
  <img class="portrait"
       src="images/me.jpg"
       alt="A photo of me">
  <h1 class="name">Your Name</h1>
  <p class="tagline">A short description of yourself</p>
  <p>A longer paragraph about your interests and background.</p>
</div>
```
]

== Requirements

#checklist(
  [The whole page uses a font of your choosing, with a sensible fallback.],
  [Body text is at least 16px with a line height between 1.4 and 1.8.],
  [The `#profile` box has a background color and padding on all sides.],
  [The heading uses a different color from the body text.],
  [The tagline is italic and a lighter grey than the main text.],
  [The portrait floats to one side with a margin so the text does not touch it.],
  [Nothing is styled using an inline `style` attribute.],
)

#v(0.4em)

== Going further

If you finish the requirements, try one of these:

#steps(
  [Research the `border-radius` property and use it to round the corners
   of your portrait or your profile box.],
  [Research the `text-align` property and use it somewhere meaningful.],
  [Find a color palette you like (for example at #link("https://coolors.co"))
   and rebuild your page's colors around it.],
)

#note(
  "Remember:",
  [Commit each significant change separately with a clear message.
   Your commit history should show the page developing step by step,
   not appear all at once at the end.],
)
