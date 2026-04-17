// ─────────────────────────────────────────────────────────────────────────────
// Style Guide — Writing Clean HTML, CSS, and JavaScript
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "Style Guide"
#let lesson-subtitle = "Writing clean HTML, CSS, and JavaScript"

// ── Page setup ────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: rgb("#999999"))
    grid(
      columns: (1fr, 1fr),
      align(left,  [#lesson-title]),
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
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => block(breakable: false)[
  #v(1.2em)
  #text(size: 11pt, weight: "bold", fill: rgb("#111111"),
    upper(numbering("1", ..counter(heading).at(it.location())) + "  ") + it.body
  )
  #v(0.15em)
  #line(length: 100%, stroke: 1pt + rgb("#2E6DA4"))
  #v(0.5em)
]

#show heading.where(level: 2): it => {
  v(0.8em)
  text(size: 11pt, weight: "bold", fill: rgb("#111111"),
    numbering("1.1", ..counter(heading).at(it.location())) + "  "
  )
  it.body
  v(0.3em)
}

#show heading.where(level: 3): it => {
  v(0.5em)
  text(size: 10pt, weight: "bold", fill: rgb("#999999"),
    numbering("1.1.1", ..counter(heading).at(it.location())) + "  "
  )
  text(size: 10pt, weight: "bold", fill: rgb("#999999"), it.body)
  v(0.2em)
}

// ── Import shared styles and components ───────────────────────────────────────
#import "../cs-style.typ": *

// ── Title block ───────────────────────────────────────────────────────────────
#{
  text(size: 18pt, weight: "bold", fill: primary)[#lesson-title]
  v(0.1em)
  text(size: 11pt, fill: muted)[#lesson-subtitle]
  v(0.3em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.8em)
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

This document is your reference for writing clean, readable, professional
code. The rules below apply to every file you submit in this course:
`index.html`, `style.css`, and `script.js`.

Clean code is not about personal taste. It is about clarity — code you
write today should be readable by someone else tomorrow, including your
future self. In a professional context, messy code slows teams down,
introduces bugs, and is expensive to fix. Learning good habits now saves
a great deal of pain later.

#warnbox(
  "⚠ These rules are graded",
  [Code style is part of the project rubric. A working page with messy
   code will score lower than a working page with clean code. Read this
   guide carefully and refer back to it whenever you are unsure.],
)

#v(0.5em)

= Formatting Tools for VS Code

Before learning the rules, set up your editor to enforce them
automatically. The extensions below watch your code as you work and
reformat it the moment you save — catching indentation problems, missing
semicolons, and inconsistent spacing without any effort on your part.

#infobox(
  "Let the tools do the boring work",
  [Professional developers do not manually count spaces or hunt for
   missing semicolons. They configure their editor to handle that
   automatically so they can focus on the actual problem they are
   solving. Setting this up now is a one-time investment that will
   save you time for the rest of the course — and beyond.],
)

== Prettier — the auto-formatter

*Prettier* is the industry-standard formatter for HTML, CSS, and
JavaScript. When you save a file, Prettier rewrites it to a consistent
style: correct indentation, consistent quote style, line breaks in the
right places, and so on.

=== Installation

#steps(
  [Open the Extensions panel in VS Code: click the blocks icon in the
   Activity Bar on the left, or press
   #box(fill: light, inset: (x:4pt, y:2pt), radius: 2pt)[Ctrl+Shift+X]
   (Windows) /
   #box(fill: light, inset: (x:4pt, y:2pt), radius: 2pt)[⌘ Shift+X]
   (macOS).],
  [Search for *Prettier - Code formatter*.],
  [Click *Install* on the extension by *Prettier* (publisher name shown
   below the title). It has over 50 million downloads — you will find
   it immediately.],
)

=== Configuration

Prettier needs to be set as the default formatter and told to run on
save. Open VS Code Settings with
#box(fill: light, inset: (x:4pt, y:2pt), radius: 2pt)[Ctrl+,]
(Windows) /
#box(fill: light, inset: (x:4pt, y:2pt), radius: 2pt)[⌘ ,]
(macOS), then search for and change the following three settings:

#table(
  columns: (1fr, auto),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Setting name],
    text(size: 9pt, weight: "bold", fill: white)[Value],
  ),
  [Editor: Default Formatter],    [Prettier - Code formatter],
  [Editor: Format On Save],       [✓ (enabled)],
  [Editor: Tab Size],             [2],
)

Once configured, save any `.html`, `.css`, or `.js` file and watch
Prettier reformat it instantly.

=== A configuration file for your project

Prettier can also read a configuration file that lives in your project
folder. This guarantees everyone on a team uses the same settings,
regardless of their personal VS Code configuration. Create a file
called `.prettierrc` in the root of your repository with the following
content:

```json
{
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": false,
  "trailingComma": "es5"
}
```

These settings mean: wrap lines at 80 characters, use 2-space
indentation (not tabs), keep semicolons in JavaScript, use double
quotes for strings, and allow trailing commas where valid. These match
the conventions used in this course.

#warnbox(
  "⚠ Prettier formats, but does not teach",
  [Prettier fixes *how* your code looks, not *what* it does. It will
   not warn you about a meaningless variable name like `x`, a missing
   `alt` attribute, or logic errors. Use it as a safety net — not as
   a replacement for understanding the rules in this guide.],
)

== ESLint — the JavaScript linter

While Prettier handles formatting, *ESLint* checks for actual problems
in your JavaScript: variables that are declared but never used,
comparisons that will never work as expected, and other patterns that
are legal JavaScript but almost always mistakes.

=== Installation

#steps(
  [In the Extensions panel, search for *ESLint*.],
  [Install the extension by *Microsoft*.],
  [In your project folder, create a file called `eslint.config.js`
   with the following content:

```js
export default [
  {
    rules: {
      "no-unused-vars": "warn",
      "no-undef": "warn",
      "eqeqeq": "warn",
      "no-console": "warn",
    },
  },
];
```
  ],
)

These four rules cover the most common beginner mistakes:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Rule],
    text(size: 9pt, weight: "bold", fill: white)[What it catches],
  ),
  [`no-unused-vars`],
    [Variables declared with `let` or `const` that are never actually used.
     A common sign of leftover or forgotten code.],
  [`no-undef`],
    [References to variables that were never declared. Usually a typo in
     a variable or function name.],
  [`eqeqeq`],
    [Use of `==` instead of `===`. In JavaScript, `==` has surprising
     behavior; `===` (strict equality) is almost always what you want.],
  [`no-console`],
    [Reminds you to remove `console.log()` calls before submitting.],
)

ESLint warnings appear as yellow underlines in the editor. Hover over
the underline to read the explanation. Errors appear in red. Neither
stops your code from running — they are warnings to help you write
better code.

== Checking your setup

Once both extensions are installed and configured, do a quick test:

#steps(
  [Open `script.js` and declare a variable you never use:
   ```js
   const unused = 42;
   ```
   You should see a yellow underline under `unused` — ESLint is working.],
  [Add some badly indented HTML to `index.html`:
   ```html
   <p>
         Too much indentation here.
   </p>
   ```
   Save the file. Prettier should reformat it to two-space indentation
   automatically.],
  [Delete the test code and save again.],
)

If both behaviors appear, your tools are set up correctly.

= General Principles

Three principles apply to all three languages. Keep them in mind even
when they are not explicitly mentioned in the rules below.

*Indentation is mandatory.* Code that is not indented is hard to read.
Use two spaces per level of nesting throughout all three files. Do not
use the Tab key — configure VS Code to insert spaces when you press Tab
(Settings → Editor: Tab Size → 2, Insert Spaces → on).

*Names must be meaningful.* A variable called `x` or a class called
`box2` tells the reader nothing. Names should describe what something
*is* or *does*: `userScore`, `highlight-box`, `calculateTotal`. When in
doubt, be more descriptive, not less.

*One file, one job.* HTML describes structure. CSS describes appearance.
JavaScript describes behavior. Each language belongs in its own file —
`index.html`, `style.css`, and `script.js`. Mixing them together
violates the *separation of concerns*, which is a core principle of good
software design.

#infobox(
  "Why separation of concerns matters",
  [Imagine having to change the background color of every page on a
   100-page website. If the color is in a single CSS file, you change
   it once. If it is scattered in inline `style` attributes across
   every HTML file, you change it 100 times — and probably miss some.
   Separation of concerns is not a style preference; it is a practical
   engineering principle.],
)

= HTML

== Structure and formatting

Use proper indentation to reflect nesting. Each child element is indented
two spaces relative to its parent:

```html
<!-- ✓ Correct -->
<body>
  <header>
    <h1>My Page</h1>
  </header>
  <main>
    <p>Hello, world!</p>
  </main>
</body>
```

```html
<!-- ✗ Incorrect — no indentation -->
<body>
<header>
<h1>My Page</h1>
</header>
</body>
```

Every HTML file must begin with a valid document skeleton. Do not
delete or change the skeleton provided in the course template:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Title</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js" defer></script>
  </head>
  <body>
    <!-- Your content here -->
  </body>
</html>
```

== Tags and attributes

Write all tag names and attribute names in lowercase:

```html
<!-- ✓ Correct -->
<section id="about">
  <img src="photo.jpg" alt="A portrait photo">
</section>

<!-- ✗ Incorrect -->
<Section ID="About">
  <IMG SRC="photo.jpg" ALT="A portrait photo">
</Section>
```

Always close every tag that has a closing tag. Self-closing tags
(`<img>`, `<input>`, `<br>`, `<link>`, `<meta>`) do not need a
closing tag, but all others do:

```html
<!-- ✓ Correct -->
<p>This paragraph is closed.</p>
<ul>
  <li>Item one</li>
  <li>Item two</li>
</ul>

<!-- ✗ Incorrect — missing closing tags -->
<p>This paragraph is never closed.
<ul>
  <li>Item one
  <li>Item two
```

Always include the `alt` attribute on every `<img>` tag. The `alt` text
describes the image for visitors who cannot see it (screen reader users,
broken image links). Leave it empty (`alt=""`) only for purely decorative
images that carry no meaning:

```html
<!-- ✓ Correct -->
<img src="chart.png" alt="Bar chart showing monthly sales figures">
<img src="divider.png" alt="">  <!-- decorative — empty alt is intentional -->

<!-- ✗ Incorrect — missing alt attribute entirely -->
<img src="chart.png">
```

== Using headings correctly

Use heading tags (`<h1>` through `<h6>`) to express document structure,
not to make text bigger or bolder. There should be exactly one `<h1>`
per page — it is the main title. Subheadings should use `<h2>`, and
sections within those use `<h3>`. Do not skip levels:

```html
<!-- ✓ Correct — logical hierarchy -->
<h1>About Me</h1>
  <h2>Education</h2>
    <h3>Primary School</h3>
  <h2>Hobbies</h2>

<!-- ✗ Incorrect — skips from h1 to h4 -->
<h1>About Me</h1>
<h4>Education</h4>
```

== Comments

Use HTML comments to label the major sections of your page. A reader
should be able to scan the comments and understand the overall structure
without reading every tag:

```html
<!-- Header -->
<header>
  <h1>Welcome</h1>
  <nav> ... </nav>
</header>

<!-- Main content -->
<main>
  <section id="about"> ... </section>
  <section id="projects"> ... </section>
</main>

<!-- Footer -->
<footer> ... </footer>
```

== What not to do

#warnbox(
  "⚠ No inline styles",
  [Never use the `style` attribute directly on an HTML element.
   All visual styling belongs in `style.css`.

```html
<!-- ✗ Never do this -->
<p style="color: red; font-size: 20px;">Hello</p>

<!-- ✓ Do this instead -->
<p class="intro">Hello</p>
```

   Inline styles override your stylesheet, make your HTML unreadable,
   and are impossible to maintain at scale.],
)

= CSS

== File organization

Organize your CSS file from general to specific. A logical order makes
it easy to find any rule quickly:

#steps(
  [*Reset / global defaults* — rules that apply to the whole page (`body`, `*`).],
  [*Typography* — fonts, sizes, line heights.],
  [*Layout* — widths, margins, padding for major structural elements.],
  [*Components* — styles for specific sections or repeated elements.],
  [*Utilities* — small, reusable classes (`.hidden`, `.highlight`, etc.).],
)

Leave a blank line between rules, and a comment above each logical group:

```css
/* ── Global ───────────────────────────────────── */
body {
  font-family: Georgia, serif;
  font-size: 16px;
  line-height: 1.6;
  color: #111111;
  background-color: #ffffff;
}

/* ── Typography ───────────────────────────────── */
h1, h2, h3 {
  font-family: Arial, Helvetica, sans-serif;
}

h1 {
  font-size: 2em;
  color: #2E6DA4;
}
```

== Formatting rules

Each declaration goes on its own line, and every declaration ends with
a semicolon — including the last one. The opening brace `{` stays on
the same line as the selector:

```css
/* ✓ Correct */
p {
  color: #333333;
  font-size: 16px;
  line-height: 1.6;
}

/* ✗ Incorrect — cramped on one line, missing semicolon */
p { color: #333333; font-size: 16px; line-height: 1.6 }
```

Use lowercase for all property names and color values. Use hex codes
for colors (e.g., `#2E6DA4`) rather than named colors — hex is more
precise and more common in professional work:

```css
/* ✓ Correct */
a {
  color: #2e6da4;
}

/* ✗ Incorrect — named colors are imprecise */
a {
  color: steelblue;
}
```

== Naming classes and IDs

Use *kebab-case* for class and ID names — all lowercase, words separated
by hyphens. Do not use spaces, underscores, or camelCase:

```css
/* ✓ Correct */
.nav-bar { ... }
.intro-text { ... }
#main-content { ... }

/* ✗ Incorrect */
.navBar { ... }       /* camelCase */
.intro_text { ... }   /* underscores */
.Intro Text { ... }   /* spaces — invalid CSS */
```

Names should describe what an element *is*, not what it *looks like*.
A class named `.highlight-box` is better than `.yellow-box` — if you
later change the color to blue, `.yellow-box` becomes misleading:

```css
/* ✓ Meaningful — describes role */
.warning-message { background-color: #fff3cd; }
.nav-link { color: #2E6DA4; }

/* ✗ Fragile — describes appearance */
.yellow-box { background-color: #fff3cd; }
.blue-text { color: #2E6DA4; }
```

== Selectors

Prefer class selectors for reusable styles. Use ID selectors only for
truly unique page sections (e.g., `#header`, `#footer`). Avoid overly
specific selectors — they are hard to override and slow to read:

```css
/* ✓ Simple and reusable */
.card { border: 1px solid #cccccc; }

/* ✗ Overly specific — hard to reuse or override */
body main section div.card { border: 1px solid #cccccc; }
```

== Comments

Add a short comment above any rule that is not immediately obvious. You
do not need to comment every single rule — comment the ones that would
cause a future reader (or yourself) to ask "why is this here?":

```css
/* Offset the fixed header so content is not hidden beneath it */
main {
  margin-top: 60px;
}

/* Float clears — without this, the container collapses around floated children */
.clearfix::after {
  content: "";
  display: block;
  clear: both;
}
```

= JavaScript

== File organization

Group related code together and label each group with a comment. A
clean `script.js` file reads like an outline:

```js
// ── Constants and initial state ───────────────────────────────
const MAX_SCORE = 10;
let currentScore = 0;

// ── DOM references ────────────────────────────────────────────
const scoreDisplay = document.getElementById("score");
const resetButton  = document.getElementById("reset-btn");

// ── Functions ─────────────────────────────────────────────────
function updateScore(newScore) {
  currentScore = newScore;
  scoreDisplay.textContent = currentScore;
}

function resetScore() {
  updateScore(0);
}

// ── Event listeners ───────────────────────────────────────────
resetButton.onclick = resetScore;
```

== Variables

Always declare variables with `const` or `let`. Never use `var` — it
has confusing scoping rules that `const` and `let` fix:

```js
// ✓ Correct
const maxAttempts = 3;    // will never change
let attempts = 0;         // will change

// ✗ Never use var
var score = 0;
```

Use `const` by default. Only switch to `let` when you know the value
will be reassigned. This communicates *intent* to the reader — seeing
`const` tells them the value is fixed:

```js
const welcomeMessage = "Hello!";   // fixed — const is correct
let counter = 0;                   // will be incremented — let is correct
```

Use *camelCase* for variable and function names — lowercase first word,
then each subsequent word capitalized:

```js
// ✓ Correct
let playerScore = 0;
const buttonLabel = "Submit";
function calculateTotal() { ... }

// ✗ Incorrect
let player_score = 0;   // snake_case
let Playerscore = 0;    // no word separation
let PLAYERSCORE = 0;    // all caps (reserved for true constants)
```

== Functions

Keep functions short and focused. A function should do *one thing*. If
a function is getting long, it is probably doing too many things — split
it up:

```js
// ✓ Clear and focused — each function does one thing
function increment() {
  count += 1;
}

function updateDisplay() {
  countDisplay.textContent = count;
}

function handleClick() {
  increment();
  updateDisplay();
}

// ✗ Doing too much in one place — harder to debug and reuse
function handleClick() {
  count += 1;
  countDisplay.textContent = count;
  countDisplay.style.color = count > 10 ? "red" : "black";
  document.title = "Count: " + count;
  // ... and so on
}
```

Name functions with a verb that describes the action they perform:
`increment`, `updateDisplay`, `handleClick`, `validateInput`,
`toggleMenu`. A function named `data` or `stuff` tells the reader
nothing.

== DOM manipulation

Collect all your DOM references at the top of your file, together.
Do not scatter `getElementById` calls throughout the code — if an ID
changes in the HTML, you want to update it in exactly one place:

```js
// ✓ All references at the top — easy to find and update
const scoreDisplay  = document.getElementById("score");
const resetButton   = document.getElementById("reset-btn");
const messageBox    = document.getElementById("message");

// ✗ References scattered through the code — hard to maintain
function increment() {
  document.getElementById("score").textContent += 1;
}

function reset() {
  document.getElementById("score").textContent = 0;
  document.getElementById("message").textContent = "";
}
```

Prefer changing CSS classes over setting inline styles from JavaScript.
Define your visual states in `style.css` and use `classList` to switch
between them:

```js
// ✓ Style stays in CSS where it belongs
element.classList.add("active");
element.classList.remove("active");
element.classList.toggle("hidden");

// ✗ Mixing CSS into JavaScript
element.style.backgroundColor = "#2E6DA4";
element.style.display = "none";
```

== Comments

Comment the *why*, not the *what*. If the code already says clearly
*what* is happening, a comment repeating that adds noise. A comment
explaining *why* a decision was made adds real value:

```js
// ✗ Useless — the code already says this
count += 1;  // add 1 to count

// ✓ Useful — explains a non-obvious decision
// Clamp the score to MAX_SCORE so the display does not overflow
if (count > MAX_SCORE) count = MAX_SCORE;
```

== What not to do

#warnbox(
  "⚠ No JavaScript inside index.html",
  [Just as CSS belongs in `style.css`, all JavaScript belongs in
   `script.js`. Do not write `<script>` blocks inside `index.html`:

```html
<!-- ✗ Never do this -->
<script>
  let count = 0;
  function increment() { count++; }
</script>
```

   The only `<script>` tag allowed in `index.html` is the one that
   loads `script.js`.],
)

#warnbox(
  "⚠ Avoid alert() and console.log() in submitted work",
  [`alert()` freezes the browser and is annoying to users.
   `console.log()` is a debugging tool — useful while you work, but
   remove it before submitting. Submitted code should be clean.],
)

= Quick Reference

The tables below summarize the most important rules for each language.

== HTML

#table(
  columns: (1fr, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Rule],
    text(size: 9pt, weight: "bold", fill: white)[Example],
  ),
  [Indent child elements 2 spaces],           [`<ul>` / `··<li>item</li>`],
  [Lowercase tag and attribute names],        [`<img src="…" alt="…">`],
  [Always close non-void tags],               [`<p>text</p>`],
  [Always include `alt` on `<img>`],          [`<img alt="Description">`],
  [One `<h1>` per page; no skipped levels],   [`h1` → `h2` → `h3`],
  [No inline `style` attributes],             [Use a class in `style.css`],
  [Comment major sections],                   [`<!-- Header -->`],
)

== CSS

#table(
  columns: (1fr, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Rule],
    text(size: 9pt, weight: "bold", fill: white)[Example],
  ),
  [One declaration per line, semicolon on each],  [`color: #111;` (on its own line)],
  [Opening brace on same line as selector],        [`p {`],
  [Blank line between rules],                      [(blank line separating blocks)],
  [kebab-case class and ID names],                 [`.nav-bar`, `#main-content`],
  [Name by role, not appearance],                  [`.warning-box` not `.red-box`],
  [Use hex colors, lowercase],                     [`#2e6da4` not `steelblue`],
  [Organize file from general to specific],        [global → layout → components],
  [Comment non-obvious rules],                     [`/* Clears floated children */`],
)

== JavaScript

#table(
  columns: (1fr, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Rule],
    text(size: 9pt, weight: "bold", fill: white)[Example],
  ),
  [Use `const` by default, `let` when needed],    [`const name = "Anna";`],
  [Never use `var`],                               [Use `const` or `let` instead],
  [camelCase for variables and functions],         [`playerScore`, `updateDisplay`],
  [Collect DOM references at the top],             [`const btn = document.get…`],
  [Name functions with a verb],                    [`handleClick`, `validateInput`],
  [Keep functions short, one task each],           [Split large functions up],
  [Toggle classes instead of inline styles],       [`el.classList.toggle("active")`],
  [Remove `console.log()` before submitting],      [(no debug output in final code)],
  [Comment the *why*, not the *what*],             [`// Clamp to avoid overflow`],
)
