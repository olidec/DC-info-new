// ─────────────────────────────────────────────────────────────────────────────
// Lesson 5 — JavaScript Basics
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "JavaScript Basics"
#let lesson-subtitle = "Making your page interactive"

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

#tier-legend

#v(0.5em)

#goals(
  [Understand what JavaScript is and how it connects to HTML.],
  [Declare and use variables with `let` and `const`.],
  [Understand what the DOM is and how to select elements.],
  [Change page content and styles from JavaScript.],
  [Respond to button clicks using `onclick`.],
  [Build a working click counter in your cs-intro repository.],
)

= What is JavaScript? #h(1fr) #tier-core

HTML gives a page its structure. CSS gives it its appearance. JavaScript
gives it *behavior* — the ability to respond to what the user does and
change what is on the screen without loading a new page.

JavaScript is a full programming language. Unlike HTML and CSS, it has
variables, logic, loops, and functions. This lesson introduces the parts
you need to make a simple interactive page. We will go deeper in Lesson 8.

#infobox(
  "JavaScript runs in the browser",
  [You do not need to install anything to run JavaScript — every modern
   browser already includes a JavaScript engine. When you open a webpage,
   the browser reads the HTML, applies the CSS, and then executes any
   JavaScript it finds. The result is a live, interactive page.],
)

= Connecting JavaScript to HTML #h(1fr) #tier-core

Like CSS, JavaScript lives in a separate file. In your cs-intro repository
that file is `script.js`. It is already linked to your `index.html` in
the skeleton:

```html
<script src="script.js" defer></script>
```

This `<script>` tag should go at the end of the `<head>` element. The
`src` attribute points to the JavaScript file, and the `defer` attribute
tells the browser to wait until the HTML is fully loaded before running
the script. This is important — if the script runs before the HTML exists,
it will not be able to find the elements it is looking for.

#warnbox(
  "⚠ No JavaScript inside index.html",
  [Just as CSS belongs in `style.css`, all JavaScript belongs in
   `script.js`. Do not write `<script>` blocks inside `index.html` —
   this is penalized in the project rubric for the same reason as
   inline styles: it mixes concerns and makes code harder to maintain.],
)

= Variables #h(1fr) #tier-core

A variable is a named container for a value. In JavaScript you declare
variables using `let` or `const`:

```js
let score = 0;
const name = "Anna";
```

- `let` declares a variable whose value can change later.
- `const` declares a variable whose value is fixed — if you try to
  reassign it, JavaScript will throw an error.

As a rule of thumb: use `const` by default. Switch to `let` only when
you know the value needs to change — like a counter.

== Data types

JavaScript variables can hold different kinds of values:

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Type],
    text(size: 9pt, weight: "bold", fill: white)[Example],
    text(size: 9pt, weight: "bold", fill: white)[Notes],
  ),
  [Number],  [`42`, `3.14`],       [Integers and decimals — no quotes.],
  [String],  [`"Hello"`, `'Hi'`],  [Text — always in quotes.],
  [Boolean], [`true`, `false`],    [Only two possible values.],
)

You do not need to declare the type — JavaScript figures it out from
the value you assign.

= The DOM #h(1fr) #tier-core

The *DOM* stands for *Document Object Model*. It is the browser's
internal representation of your HTML page as a tree of objects. When
JavaScript runs in the browser, it can access the DOM and read or
change any element on the page.

Think of the DOM as a live map of your HTML. If you change something
in the DOM using JavaScript, the page updates immediately — no reload
required.

== Selecting elements

Before you can change something on the page, you need to get a reference
to it. The most common way is `document.getElementById`:

```js
const heading = document.getElementById("main-title");
```

This finds the element with `id="main-title"` in your HTML and stores
a reference to it in the variable `heading`. From that point on, you
can read and change that element through the variable.

For this to work, the element must have a matching `id` in your HTML:

```html
<h1 id="main-title">Welcome</h1>
```

#infobox(
  "getElementById vs querySelector",
  [`document.getElementById` is the simplest and fastest way to find
   a single element by its ID. There is also `document.querySelector`,
   which is more flexible and accepts any CSS selector. We will use
   `getElementById` for now — it does exactly what we need and its
   name is self-explanatory.],
)

= Changing Content and Styles #h(1fr) #tier-core

Once you have a reference to an element, you can change it.

== Changing text content

```js
const heading = document.getElementById("main-title");
heading.textContent = "Hello, world!";
```

`textContent` gives you the plain text inside an element. Assigning a
new value replaces whatever was there before.

If you need to set HTML content — including tags — use `innerHTML`
instead:

```js
heading.innerHTML = "Hello, <em>world</em>!";
```

Use `textContent` when you are working with plain text. Use `innerHTML`
only when you genuinely need to insert HTML markup — it is more powerful
but also more dangerous if the content comes from user input.

== Changing styles

You can change an element's CSS directly from JavaScript using the
`style` property:

```js
const box = document.getElementById("my-box");
box.style.backgroundColor = "#2E6DA4";
box.style.color = "white";
```

Note that CSS property names with hyphens become camelCase in JavaScript:
`background-color` becomes `backgroundColor`, `font-size` becomes
`fontSize`.

== Adding and removing CSS classes

Directly setting styles in JavaScript has the same problem as inline
CSS in HTML — it mixes concerns. The cleaner approach is to define
styles in `style.css` and then add or remove classes from JavaScript:

```css
/* In style.css */
.highlighted {
  background-color: #fff3cd;
  border: 2px solid #f5c842;
}
```

```js
// In script.js
const box = document.getElementById("my-box");
box.classList.add("highlighted");     // adds the class
box.classList.remove("highlighted");  // removes it
box.classList.toggle("highlighted");  // adds if absent, removes if present
```

`classList.toggle` is particularly useful for on/off interactions — a
single line handles both directions.

= Responding to Clicks with onclick #h(1fr) #tier-core

To make something happen when a user clicks a button, you connect a
JavaScript *function* to the button's `onclick` attribute.

A *function* is a named block of code that runs when called. Here is
how you define and connect one:

```html
<!-- In index.html -->
<button onclick="sayHello()">Click me</button>
```

```js
// In script.js
function sayHello() {
  const message = document.getElementById("message");
  message.textContent = "Hello!";
}
```

When the button is clicked, the browser calls `sayHello()`. The function
runs, finds the element with `id="message"`, and changes its text.

The key parts:
- `function sayHello() { ... }` defines the function. The name is up
  to you.
- `onclick="sayHello()"` in the HTML calls it on click. The parentheses
  are required.
- The function body (inside `{ }`) contains the code that runs.

= A Worked Example: Click Counter #h(1fr) #tier-core

Let us build a counter that increments each time a button is clicked.
This brings together everything from this lesson.

== The HTML

Add this to your `index.html`, inside `<body>`, wherever it makes sense
on your page:

```html
<div id="counter-section">
  <p>You have clicked <span id="count">0</span> times.</p>
  <button onclick="increment()">Click me</button>
</div>
```

Two elements have IDs here:
- `count` — the `<span>` that displays the current number.
- The `<button>` calls `increment()` on each click.

== The JavaScript

Add this to `script.js`:

```js
let clickCount = 0;

function increment() {
  clickCount = clickCount + 1;
  const countDisplay = document.getElementById("count");
  countDisplay.textContent = clickCount;
}
```

Let us read through this line by line:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Line],
    text(size: 9pt, weight: "bold", fill: white)[What it does],
  ),
  [`let clickCount = 0`],
    [Declares a variable to store the count. We use `let` because
     its value will change. It starts at `0`.],
  [`function increment() {`],
    [Defines a function called `increment`. Everything inside the
     curly braces runs when the function is called.],
  [`clickCount = clickCount + 1`],
    [Takes the current value of `clickCount`, adds 1, and stores
     the result back in `clickCount`.],
  [`const countDisplay = ...`],
    [Finds the `<span id="count">` element and stores a reference.],
  [`countDisplay.textContent = clickCount`],
    [Updates the text inside the span to show the new count.],
)

== Try it

Save both files, then open `index.html` in your browser. Click the
button and watch the number increase. Open the browser developer tools
(*right-click → Inspect → Console*) — if there are any errors, they
will appear there in red.

#infobox(
  "The console is your best friend",
  [The browser console shows JavaScript errors and also lets you run
   JavaScript directly. If something is not working, check the console
   first. You can also add `console.log(clickCount)` inside your
   function to print the value of a variable every time the function
   runs — useful for understanding what your code is doing.],
)

= Adding Your Counter to Your Page #h(1fr) #tier-challenge

Now adapt the counter to fit naturally into your about-me page. A few
ideas:

- A "likes" button for a section of content.
- A counter that tracks how many times a fun fact has been read.
- A simple quiz where clicking the right answer adds a point.

The counter does not have to count clicks — it can count anything. What
matters is that you use the same pattern: a variable, a function, a
button with `onclick`, and an element whose content you update.

Once it works, commit with a clear message and push.

= Summary

By the end of this lesson you should have:

#checklist(
  [A `<script src="script.js" defer></script>` tag in your `<head>`.],
  [At least one variable declared with `let` or `const` in `script.js`.],
  [A function that selects a DOM element and changes its content.],
  [A button connected to that function using `onclick`.],
  [A working click counter visible on your page.],
  [Changes committed and pushed with a clear commit message.],
)
