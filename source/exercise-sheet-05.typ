// ─────────────────────────────────────────────────────────────────────────────
// Exercise Sheet — Lesson 5: JavaScript Basics
// ─────────────────────────────────────────────────────────────────────────────

#let course     = "Computer Science"
#let level      = "High School"
#let term       = "[Term / Year]"
#let lesson-num = "5"
#let sheet-type = "Exercise Sheet"
#let sheet-title = "JavaScript Basics"

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

#exercise(title: "Concepts and syntax")[
  Circle the letter of the correct answer.

  #v(0.4em)
  #text(weight: "bold")[1. Where should your JavaScript code live?]

  #mc-option("A", [Inside a `<script>` block in `index.html`])
  #mc-option("B", [In a separate file called `script.js`, linked with a `<script src="...">` tag])
  #mc-option("C", [Inside the `<style>` tag in `index.html`])
  #mc-option("D", [Anywhere — it does not matter])

  #v(0.5em)
  #text(weight: "bold")[2. What does the `defer` attribute do on a `<script>` tag?]

  #mc-option("A", [It prevents the script from running at all])
  #mc-option("B", [It makes the script run faster])
  #mc-option("C", [It waits until the HTML is fully loaded before running the script])
  #mc-option("D", [It links the script to the CSS file])

  #v(0.5em)
  #text(weight: "bold")[3. Which of the following correctly declares a variable whose value can change?]

  #mc-option("A", [`const score = 0`])
  #mc-option("B", [`var score = 0`])
  #mc-option("C", [`let score = 0`])
  #mc-option("D", [`int score = 0`])

  #v(0.5em)
  #text(weight: "bold")[4. What does `document.getElementById("title")` return?]

  #mc-option("A", [The text content of the element with `id="title"`])
  #mc-option("B", [A reference to the HTML element with `id="title"`])
  #mc-option("C", [The CSS styles applied to the element with `id="title"`])
  #mc-option("D", [The number of elements with `id="title"` on the page])

  #v(0.5em)
  #text(weight: "bold")[5. What is the difference between `textContent` and `innerHTML`?]

  #mc-option("A", [There is no difference — they do the same thing])
  #mc-option("B", [`textContent` sets plain text; `innerHTML` can include HTML tags])
  #mc-option("C", [`textContent` is for headings; `innerHTML` is for paragraphs])
  #mc-option("D", [`innerHTML` only works with `<div>` elements])

  #v(0.5em)
  #text(weight: "bold")[6. What does `classList.toggle("active")` do?]

  #mc-option("A", [Always adds the class `active`])
  #mc-option("B", [Always removes the class `active`])
  #mc-option("C", [Adds `active` if it is absent; removes it if it is present])
  #mc-option("D", [Checks whether the class `active` exists and returns true or false])
]

#block(breakable: false)[
= Part 2 — Code to Output #h(1fr) #tier-core

For each JavaScript snippet, describe in your own words what would happen
on the page when this code runs. Assume the HTML contains the elements referenced.

#v(0.4em)
#text(weight: "bold")[1.]
#code-output(
  raw(lang: "js",
```js
const h = document.getElementById("greeting");
h.textContent = "Good morning!";
```.text
  ),
  [ #v(3.5em) ]
)
]

#v(0.5em)
#text(weight: "bold")[2.]
#code-output(
  raw(lang: "js",
```js
const box = document.getElementById("box");
box.style.backgroundColor = "red";
box.style.color = "white";
```.text
  ),
  [ #v(3.5em) ]
)

#v(0.5em)
#text(weight: "bold")[3.]
#code-output(
  raw(lang: "js",
```js
let count = 5;
count = count + 1;
const display = document.getElementById("num");
display.textContent = count;
```.text
  ),
  [ #v(3.5em) ]
)

#v(0.5em)
#text(weight: "bold")[4.]
#code-output(
  raw(lang: "js",
```js
const card = document.getElementById("card");
card.classList.toggle("hidden");
```.text
  ),
  [ #v(3.5em) ]
)

#block(breakable: false)[
= Part 3 — Fill in the Blank #h(1fr) #tier-extension

Complete each snippet by filling in the missing parts.

#v(0.4em)
#text(weight: "bold")[1. Declare a variable called `clicks` starting at zero, and a function that adds one to it each time it is called:]]

#fitb[
  \_____ clicks = 0; \
  \
  _____________________ addClick() \{ \
  #h(2em) clicks = clicks _____ 1; \
  \}
]

#v(0.6em)
#text(weight: "bold")[2. Select the element with `id="score"` and set its text to the value of `clicks`:]

#fitb[
  const display = document._____________________("score"); \
  display._____________________ = clicks;
]

#v(0.6em)
#text(weight: "bold")[3. Connect a button to a function called `reset` using `onclick`:]

#fitb[
  #sym.lt\button ______________________="reset()"#sym.gt\Reset#sym.lt\/button#sym.gt
]

#v(0.6em)
#text(weight: "bold")[4. Toggle a CSS class called `highlight` on an element:]

#fitb[
  const el = document.getElementById("my-div"); \
  el.classList.______________________("highlight");
]

#block(breakable: false)[
= Part 4 — Spot the Error #h(1fr) #tier-extension

Each snippet contains one mistake. Circle it and write the correction on the line below.

#v(0.4em)
#text(weight: "bold")[1.]
```js
const counter = 0;
counter = counter + 1;
```
#answer-space(lines: 1)
]

#v(0.4em)
#text(weight: "bold")[2.]
```js
function greet() {
  const msg = document.getElementById("message")
  msg.textContent = "Hello!";
}
```
#answer-space(lines: 1)

#v(0.4em)
#text(weight: "bold")[3. The button does not respond to clicks — what is wrong?]
```html
<button onclick="sayHi">Click me</button>
```
#answer-space(lines: 1)

#v(0.4em)
#text(weight: "bold")[4.]
```js
const title = document.getElementById("heading");
title.textcontent = "New title";
```
#answer-space(lines: 1)

#v(0.4em)
#text(weight: "bold")[5. The script runs before the page has loaded and cannot find any elements. What is missing?]
```html
<head>
  <script src="script.js"></script>
</head>
```
#answer-space(lines: 1)

#block(breakable: false)[
= Part 5 — Build It #h(1fr) #tier-challenge

This part is completed on your computer in your cs-intro repository.

== The task

Add a *show/hide toggle* to your about-me page. Choose a section that has
some extra content — interests, fun facts, a longer description — and let
the user reveal or hide it with a button.

== Step by step

#steps(
  [In `index.html`, find a section with content you want to hide by default.
   Wrap the extra content in a `<div>` with a unique `id`, and add
   `style="display: none"` to hide it initially. Add a `<button>` with
   `onclick="toggleSection()"` below it. Also give the button an `id` so
   you can change its label.],
  [In `script.js`, write a function called `toggleSection`. Inside it:
   select the hidden div, check whether `display` is `"none"`, show or
   hide it accordingly, and update the button label between
   `"Show more"` and `"Show less"`.],
  [Open `index.html` in your browser and test the button. Make sure it
   works in both directions — clicking once shows the content, clicking
   again hides it.],
  [Check the browser console (*right-click → Inspect → Console*) for
   any errors. Fix them if you find any.],
  [Commit your changes with a clear message and push. \
   Example: `Add show/hide toggle to about-me section`],
)

#note(
  "Stuck?",
  [Re-read the *Changing content and styles* section of the lesson notes.
   The `if/else` pattern you need is: if `display` equals `"none"`, set
   it to `"block"`; otherwise set it back to `"none"`. Use
   `console.log()` to print values and check what your code is doing.],
)
]
