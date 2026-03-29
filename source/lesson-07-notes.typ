// ─────────────────────────────────────────────────────────────────────────────
// Lesson 7 — HTML II + CSS II
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "High School"
#let term            = "[Term / Year]"
#let lesson-title    = "HTML II + CSS II"
#let lesson-subtitle = "Forms, tables, layout, and animation"

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

#goals(
  [Build a contact form using HTML form elements.],
  [Display structured data in an HTML table.],
  [Use Flexbox to create simple, flexible layouts.],
  [Apply pseudo-classes to style interactive states.],
  [Use CSS custom properties to manage colors consistently.],
  [Add transitions and simple animations to page elements.],
)

= HTML Forms

A form is a section of a page that collects input from the user. You have
filled in countless forms online — login pages, search boxes, contact forms.
In HTML, forms are built with the `<form>` element and a set of input elements
inside it.

For this course, you do not need to handle what happens when a form is
submitted (that requires a server). What matters now is knowing how to
build a well-structured, accessible form — which is also a project requirement.

== The form element

```html
<form>
  <!-- inputs go here -->
</form>
```

The `<form>` element is a container. On its own it does nothing visible.

== Labels and inputs

Every input should have a `<label>` that describes it. The `for` attribute
on the label must match the `id` of its input — this links them together
so that clicking the label focuses the input:

```html
<label for="username">Your name:</label>
<input type="text" id="username" name="username">
```

The `type` attribute controls what kind of input is shown:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Type],
    text(size: 9pt, weight: "bold", fill: white)[What it produces],
  ),
  [`type="text"`],     [A single-line text field.],
  [`type="email"`],    [A text field that validates email format.],
  [`type="password"`], [A text field that hides the typed characters.],
  [`type="number"`],   [A field that only accepts numbers.],
  [`type="checkbox"`], [A tick box.],
  [`type="radio"`],    [A radio button (one of a group).],
  [`type="submit"`],   [A button that submits the form.],
)

== Textareas and buttons

For multi-line text, use `<textarea>` instead of `<input>`:

```html
<label for="message">Your message:</label>
<textarea id="message" name="message" rows="4"></textarea>
```

For a submit button, use `<button>` with `type="submit"`:

```html
<button type="button" onclick="sendMessage()">Send</button>
```

Note: use `type="button"` (not `type="submit"`) when the button triggers
a JavaScript function rather than submitting the form to a server.

== A complete contact form example

```html
<form>
  <label for="name">Name:</label>
  <input type="text" id="name" name="name">

  <label for="email">Email:</label>
  <input type="email" id="email" name="email">

  <label for="msg">Message:</label>
  <textarea id="msg" name="msg" rows="4"></textarea>

  <button type="button" onclick="handleForm()">Send</button>
</form>
```

#infobox(
  "Forms and accessibility",
  [Always pair every `<input>` with a `<label>`. Without a label, screen
   readers cannot tell users what a field is for, and clicking the label
   does not focus the input. This is one of the most common accessibility
   mistakes on the web — and one of the easiest to avoid.],
)

= HTML Tables

Tables are for displaying structured, tabular data — think schedules,
comparison charts, or statistics. They are not for page layout (that is
what CSS is for).

== Basic table structure

```html
<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Subject</th>
      <th>Grade</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Anna</td>
      <td>Mathematics</td>
      <td>6</td>
    </tr>
    <tr>
      <td>Ben</td>
      <td>English</td>
      <td>5.5</td>
    </tr>
  </tbody>
</table>
```

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Element],
    text(size: 9pt, weight: "bold", fill: white)[Purpose],
  ),
  [`<table>`],  [The container for the entire table.],
  [`<thead>`],  [Groups the header rows. Optional but good practice.],
  [`<tbody>`],  [Groups the data rows.],
  [`<tr>`],     [A table row.],
  [`<th>`],     [A header cell — bold and centered by default.],
  [`<td>`],     [A data cell.],
)

== Styling a table

By default, HTML tables have no borders and no spacing. Add CSS to make
them readable:

```css
table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  padding: 8px 12px;
  border: 1px solid #cccccc;
  text-align: left;
}

th {
  background-color: #2E6DA4;
  color: white;
}

tbody tr:nth-child(even) {
  background-color: #f5f5f5;
}
```

`border-collapse: collapse` removes the double border that appears
between adjacent cells by default. `nth-child(even)` is a pseudo-class
that targets every even row — useful for alternating row colors.

= Flexbox Layout

In Lesson 4 you used `float` to place an image next to text. Float works
for that specific case, but it was never designed as a full layout system.
*Flexbox* is CSS's modern approach to arranging elements in a row or column.

== Turning on Flexbox

Flexbox is applied to a *container* element. All direct children of that
container become *flex items* and are arranged automatically:

```css
.container {
  display: flex;
}
```

With just `display: flex`, the children line up in a row by default,
left to right.

== Key Flexbox properties

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Property],
    text(size: 9pt, weight: "bold", fill: white)[Example value],
    text(size: 9pt, weight: "bold", fill: white)[What it does],
  ),
  [`flex-direction`], [`row` / `column`],
    [Controls whether items are arranged horizontally or vertically.],
  [`justify-content`], [`center` / `space-between`],
    [Controls alignment along the main axis (horizontal for rows).],
  [`align-items`], [`center` / `flex-start`],
    [Controls alignment along the cross axis (vertical for rows).],
  [`gap`], [`16px`],
    [Sets the space between flex items.],
  [`flex-wrap`], [`wrap`],
    [Allows items to wrap onto a new line if they run out of space.],
)

== A practical example: navigation bar

```html
<nav class="navbar">
  <span class="logo">My Site</span>
  <ul class="nav-links">
    <li><a href="#about">About</a></li>
    <li><a href="#interests">Interests</a></li>
    <li><a href="#contact">Contact</a></li>
  </ul>
</nav>
```

```css
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 24px;
  background-color: #2E6DA4;
}

.nav-links {
  display: flex;
  gap: 24px;
  list-style: none;
  margin: 0;
  padding: 0;
}

.nav-links a {
  color: white;
  text-decoration: none;
}
```

`justify-content: space-between` pushes the logo to the left and the
links to the right. The `<ul>` itself is also a flex container, so the
links sit in a row with a 24px gap between them.

#infobox(
  "Flexbox is worth exploring",
  [The properties above are enough to build most common layouts. MDN's
   Flexbox guide at #link("https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_flexible_box_layout")
   is an excellent reference with interactive examples. The CSS-Tricks
   "Complete Guide to Flexbox" is another widely-used resource.],
)

= CSS Custom Properties

CSS custom properties — often called *CSS variables* — let you define a
value once and reuse it throughout your stylesheet. This makes it much
easier to keep your design consistent and to make changes later.

== Defining and using custom properties

Custom properties are defined on the `:root` selector (which targets
the entire document) and always start with two hyphens:

```css
:root {
  --primary-color: #2E6DA4;
  --accent-color: #F5C842;
  --text-color: #111111;
  --spacing: 16px;
}
```

To use them, call `var()`:

```css
h1 {
  color: var(--primary-color);
}

.highlight {
  background-color: var(--accent-color);
  padding: var(--spacing);
}
```

Now if you want to change your primary color, you change it in one place
and every rule that uses `var(--primary-color)` updates automatically.
This is especially powerful for color schemes.

#infobox(
  "Good naming practice",
  [Name your custom properties by their *role*, not their *value*.
   `--primary-color` is a good name; `--blue` is not — if you later
   decide your primary color should be green, `--blue` becomes
   confusing. Think about what the property *does*, not what it
   currently *is*.],
)

= Pseudo-classes

A *pseudo-class* is a keyword added to a selector that targets an element
in a particular *state* — hovered, focused, visited, and so on.

== :hover

`:hover` applies when the user moves their mouse over an element:

```css
a {
  color: var(--primary-color);
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
  color: var(--accent-color);
}
```

```css
button {
  background-color: var(--primary-color);
  color: white;
}

button:hover {
  background-color: #1a4a7e;
}
```

== :focus

`:focus` applies when an element has keyboard focus — typically when
a user tabs to it or clicks on an input field:

```css
input:focus {
  outline: 2px solid var(--primary-color);
  background-color: #f0f6ff;
}
```

Never remove the focus outline entirely (`outline: none`) without
replacing it with something else — it is essential for keyboard users
and accessibility.

= CSS Transitions and Animation

CSS can animate changes between states smoothly. The simplest way is
with `transition`, which tells the browser to animate a property change
over a given duration.

== transition

```css
button {
  background-color: var(--primary-color);
  color: white;
  transition: background-color 0.3s ease;
}

button:hover {
  background-color: #1a4a7e;
}
```

When the user hovers over the button, instead of snapping instantly to
the darker color, it fades over 0.3 seconds. The `ease` keyword makes
the animation start fast and slow down at the end — this feels natural.

The `transition` property takes: the property to animate, the duration,
and the timing function. You can animate multiple properties by separating
them with commas, or use `all` to animate every changing property:

```css
.card {
  transform: scale(1);
  box-shadow: none;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card:hover {
  transform: scale(1.03);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}
```

`transform: scale(1.03)` makes the card grow very slightly on hover —
a subtle but satisfying effect. `box-shadow` adds a soft shadow underneath.

== \@keyframes animation

For more complex animations that run automatically (not triggered by
hover), use `@keyframes`:

```css
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

.hero {
  animation: fade-in 0.8s ease forwards;
}
```

`from` defines the starting state, `to` defines the end state. The
browser animates smoothly between them. `forwards` means the element
stays in its final state after the animation ends.

#warnbox(
  "⚠ Keep animations subtle",
  [Animations should enhance the experience, not distract from it.
   Fast, small transitions (0.2–0.4 seconds, slight movements) feel
   polished. Slow, dramatic animations feel clunky. If you find
   yourself watching the animation instead of reading the content,
   it is probably too much.],
)

= Extending Your Page

Open your cs-intro repository and apply what you have learned today.
Commit after each significant addition.

#steps(
  [*CSS variables:* Move your colors and main spacing values into
   `:root` custom properties at the top of `style.css`. Replace
   all hardcoded color values with `var(--...)` references.],
  [*Flexbox:* If your page has a navigation section, rebuild it using
   Flexbox. If not, use Flexbox to arrange two or more sections
   side by side — for example, an image and a text block.],
  [*Pseudo-classes:* Add `:hover` states to all your links and buttons.
   Add `:focus` styles to any form inputs.],
  [*Transitions:* Add a `transition` to your hover states so changes
   animate smoothly rather than snapping.],
  [*Table or form:* Add at least one of the following to your page:
   a table displaying some structured information about yourself
   (favorite books, places visited, skills), or a simple contact form.],
  [*Animation (optional):* Add a `fade-in` animation to your page
   header or hero section.],
  [Commit all changes with clear, separate commit messages for each
   feature you add. Push when done.],
)

= Summary

By the end of this lesson you should have:

#checklist(
  [CSS custom properties defined in `:root` and used throughout `style.css`.],
  [At least one Flexbox layout on your page.],
  [`hover` and `focus` pseudo-class styles on interactive elements.],
  [Smooth transitions on at least one hover state.],
  [A table or a form added to your page.],
  [All changes committed with clear messages and pushed to GitHub.],
)
