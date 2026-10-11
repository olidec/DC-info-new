// ─────────────────────────────────────────────────────────────────────────────
// Solutions — Exercise Sheet, Lesson 5: JavaScript Basics
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-num = "5"
#let sheet-type = "Solutions"
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
  "1.", [*B*], [A would also run, but JavaScript belongs in its own file, just as CSS belongs in `style.css`.],
  "2.", [*C*], [Without `defer`, the script may run before the elements it looks for exist.],
  "3.", [*C*], [`const` cannot be reassigned; `int` does not exist in JavaScript.],
  "4.", [*B*], [It returns the element itself; `.textContent` would then give its text.],
  "5.", [*B*], [`innerHTML` interprets tags such as `<strong>`; `textContent` shows them as plain text.],
  "6.", [*C*], [Toggle = switch on if off, off if on.],
)

#tnote[Question 3: `var score = 0` (B) also works. It is the old way of
  declaring variables and has some surprising behavior, which is why we
  use `let` instead. If a student circles B, it is worth a short
  conversation rather than just marking it wrong.]

= Part 2 — Code to Output #h(1fr) #tier-core

#sol("1.")[The text of the element with `id="greeting"` is replaced by
  "Good morning!". Whatever text it showed before disappears.]

#sol("2.")[The element with `id="box"` gets a red background and white text.]

#sol("3.")[The element with `id="num"` shows the number 6. (The variable
  starts at 5 and is increased by 1 before it is displayed.)]

#sol("4.")[The class `hidden` is switched on the element with `id="card"`:
  if the card already had the class, it is removed; otherwise it is added.
  Assuming the CSS contains a rule like `.hidden { display: none; }`, a
  visible card disappears and a hidden card reappears.]

#tnote[Question 4: `classList.toggle` by itself changes nothing visible —
  the effect depends entirely on what `.hidden` does in the CSS. Good
  answers mention this.]

= Part 3 — Fill in the Blank #h(1fr) #tier-extension

#sol("1.")[`let`, `function`, and `+`]
```js
let clicks = 0;

function addClick() {
  clicks = clicks + 1;
}
```

#sol("2.")[`getElementById` and `textContent`]
```js
const display = document.getElementById("score");
display.textContent = clicks;
```

#sol("3.")[`onclick`]
```html
<button onclick="reset()">Reset</button>
```

#sol("4.")[`toggle`]
```js
el.classList.toggle("highlight");
```

= Part 4 — Spot the Error #h(1fr) #tier-extension

#sol("1.")[A `const` variable cannot be changed later. Since the counter is
  increased, it must be declared with `let`:]
```js
let counter = 0;
counter = counter + 1;
```

#sol("2.")[The semicolon is missing at the end of the second line:]
```js
const msg = document.getElementById("message");
```

#tnote[Question 2 is not a real error: JavaScript inserts missing
  semicolons automatically, so this code runs without problems. Students
  who test it will notice. Either accept "it is missing a semicolon, but
  it still works" or replace the snippet with a genuine mistake, e.g.
  `getElementByID` (wrong capitalization) or `getElementById(message)`
  (missing quotes).]

#sol("3.")[The parentheses are missing, so the function is never called:]
```html
<button onclick="sayHi()">Click me</button>
```

#sol("4.")[JavaScript is case-sensitive: the property is called
  `textContent` with a capital C.]
```js
title.textContent = "New title";
```

#tnote[Question 4 is a nasty one in practice: `textcontent` does *not*
  cause an error message in the console. JavaScript silently creates a new,
  useless property and the page just does not change. Worth demonstrating
  live.]

#sol("5.")[The `defer` attribute is missing, so the script runs before the
  `<body>` has been read:]
```html
<script src="script.js" defer></script>
```

= Part 5 — Build It #h(1fr) #tier-challenge

A sample solution. Students' content, ids and labels will differ.

*In `index.html`:*
```html
<section>
  <h2>About me</h2>
  <p>I am a student at Gymnasium Muttenz.</p>

  <div id="more-info" style="display: none">
    <p>In my free time I play the guitar and go climbing.</p>
  </div>

  <button id="toggle-button" onclick="toggleSection()">Show more</button>
</section>
```

*In `script.js`:*
```js
function toggleSection() {
  const section = document.getElementById("more-info");
  const button = document.getElementById("toggle-button");

  if (section.style.display === "none") {
    section.style.display = "block";
    button.textContent = "Show less";
  } else {
    section.style.display = "none";
    button.textContent = "Show more";
  }
}
```

*Checklist when marking:* the button works in both directions, the label
changes each time, the console shows no errors, `script.js` is linked with
`defer`, and the change is committed and pushed with a clear message.

#tnote[*Things to be aware of:*
  - `if`/`else` and the comparison operator `===` do not appear in the
    lesson 5 notes; students rely entirely on the "Stuck?" box. Expect
    `=` instead of `===` inside the condition — this always "succeeds",
    so the section opens once and never closes again.
  - The initial `style="display: none"` must be written _inline_ in the
    HTML. If a student hides the div with a CSS rule in `style.css`
    instead, `section.style.display` is an empty string on the first
    click, so the first click appears to do nothing.
  - The task contradicts the advice in the lesson notes (and on sheet 4)
    to avoid inline styles. A cleaner version uses a class instead:
    `.hidden { display: none; }` in `style.css`, `class="hidden"` on the
    div, and `section.classList.toggle("hidden")` in the function. Good
    challenge for students who finish early.]
