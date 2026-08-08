// ─────────────────────────────────────────────────────────────────────────────
// Exercise Sheet — Lesson 7: HTML II + CSS II
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-num = "7"
#let sheet-type = "Exercise Sheet"
#let sheet-title = "HTML II + CSS II"

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
  #text(weight: "bold")[1. What does `display: flex` do to the direct children of the element it is applied to?]

  #mc-option("A", [It hides them.])
  #mc-option("B", [It turns them into flex items, arranged in a row by default.])
  #mc-option("C", [It gives them a border automatically.])
  #mc-option("D", [It makes them all the same size.])

  #v(0.5em)
  #text(weight: "bold")[2. Which property sets the space between flex items?]

  #mc-option("A", [`gap`])
  #mc-option("B", [`space-between`])
  #mc-option("C", [`margin-flex`])
  #mc-option("D", [`item-spacing`])

  #v(0.5em)
  #text(weight: "bold")[3. Where must a CSS custom property be defined so it applies to the whole page?]

  #mc-option("A", [Inside a `<div>` with `class="root"`])
  #mc-option("B", [On the `:root` selector])
  #mc-option("C", [Inside the `<head>` as an attribute])
  #mc-option("D", [At the very bottom of the CSS file])

  #v(0.5em)
  #text(weight: "bold")[4. How do you use a custom property called `--primary-color` in a rule?]

  #mc-option("A", [`color: --primary-color;`])
  #mc-option("B", [`color: custom(--primary-color);`])
  #mc-option("C", [`color: var(--primary-color);`])
  #mc-option("D", [`color: $primary-color;`])

  #v(0.5em)
  #text(weight: "bold")[5. What does the `:hover` pseudo-class select?]

  #mc-option("A", [An element the very first time the page loads.])
  #mc-option("B", [An element while the mouse is over it.])
  #mc-option("C", [Every second element in a list.])
  #mc-option("D", [An element that has been clicked once.])

  #v(0.5em)
  #text(weight: "bold")[6. Why should you never remove the `:focus` outline without replacing it with something else?]

  #mc-option("A", [It is required for keyboard users and accessibility.])
  #mc-option("B", [Browsers do not allow it.])
  #mc-option("C", [It breaks the page layout.])
  #mc-option("D", [There is no reason — removing it is fine.])

  #v(0.5em)
  #text(weight: "bold")[7. Which CSS property makes a change animate smoothly instead of happening instantly?]

  #mc-option("A", [`animate`])
  #mc-option("B", [`smooth`])
  #mc-option("C", [`transition`])
  #mc-option("D", [`ease`])

  #v(0.5em)
  #text(weight: "bold")[8. Which HTML element groups the header row of a table?]

  #mc-option("A", [`<thead>`])
  #mc-option("B", [`<tr>`])
  #mc-option("C", [`<th>`])
  #mc-option("D", [`<table-head>`])
]

#block(breakable: false)[
= Part 2 — Flexbox #h(1fr) #tier-core

Read the HTML and CSS below, then answer the questions.

```html
<nav class="navbar">
  <span class="logo">My Site</span>
  <ul class="nav-links">
    <li><a href="#about">About</a></li>
    <li><a href="#work">Work</a></li>
  </ul>
</nav>
```
]

```css
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 24px;
}

.nav-links {
  display: flex;
  gap: 20px;
  list-style: none;
}
```

#exercise(title: "Reading the layout")[
  #text(weight: "bold")[a)] Which two elements become flex containers in
  this example? #answer-space(lines: 1)

  #text(weight: "bold")[b)] What does `justify-content: space-between`
  do to the logo and the list inside `.navbar`?
  #answer-space(lines: 2)

  #text(weight: "bold")[c)] What happens to the two `<li>` elements if you
  remove `display: flex` from `.nav-links`? Describe how the layout would
  change.
  #answer-space(lines: 3)
]

#block(breakable: false)[
= Part 3 — CSS Variables #h(1fr) #tier-core

#exercise(title: "Find and fix")[
  The following CSS defines a custom property but never actually uses it
  — every rule still has the color hardcoded. Rewrite the two `color`
  declarations to use `var()` instead.

  ```css
  :root {
    --primary-color: #2E6DA4;
  }

  h1 {
    color: #2E6DA4;
  }

  .button {
    background-color: #2E6DA4;
  }
  ```

  #answer-space(lines: 5)
]
]

#block(breakable: false)[
= Part 4 — Pseudo-classes & Transitions #h(1fr) #tier-extension

#exercise(title: "Fill in the blank")[
  Complete the rule so that the button's background color changes to
  `#1a4a7e` on hover, animating smoothly over 0.3 seconds.

  #fitb[
    button \{ \
    #h(2em) background-color: \#2E6DA4; \
    #h(2em) transition: #blank(width: 10em); \
    \} \
    \
    button#blank(width: 4em) \{ \
    #h(2em) background-color: \#1a4a7e; \
    \}
  ]
]
]

#exercise(title: "Predict the result", points: 3)[
  A student writes the following CSS. Describe what happens visually
  when the page loads, *without* any user interaction.

  ```css
  .banner {
    opacity: 0;
    transform: translateY(20px);
    animation: fade-in 1s ease forwards;
  }

  @keyframes fade-in {
    from {
      opacity: 0;
      transform: translateY(20px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
  ```

  #answer-space(lines: 3)
]

#block(breakable: false)[
= Part 5 — Forms & Tables #h(1fr) #tier-extension

#exercise(title: "Spot the error")[
  This form has *two* accessibility problems. Find and correct them.

  ```html
  <form>
    <input type="text" id="name">
    <label>Email:</label>
    <input type="email" id="email">
    <button type="button">Send</button>
  </form>
  ```

  #answer-space(lines: 4)
]
]

#exercise(title: "Build a table", points: 4)[
  Write the HTML for a table with a header row (*Day*, *Subject*) and two
  data rows of your choice. Use `<thead>` and `<tbody>` correctly.

  #answer-space(lines: 8)
]

#block(breakable: false)[
= Part 6 — Build It #h(1fr) #tier-challenge

This part is completed on your computer, in your cs-intro repository.

== The task

Pick *two* of the following four techniques and add them to your page.
For each one, briefly note in `JOURNAL.md` what you did.

#steps(
  [Rebuild one part of your page (e.g. navigation, or a row of content)
   using Flexbox instead of float or default block layout.],
  [Move your color scheme into `:root` custom properties and reference
   them with `var()` everywhere they are used.],
  [Add a hover transition to at least two interactive elements
   (links, buttons, or cards).],
  [Add a `@keyframes` fade-in animation to one section of your page.],
)
]

#v(0.4em)

#note(
  "Going further",
  [If you finish both and still have time, try adding a simple contact
   form or a table of structured content — these are optional but count
   toward the *Content & Independent Learning* part of the project rubric
   if you can explain how you built them.],
)
