// ─────────────────────────────────────────────────────────────────────────────
// Lesson 4 — CSS Basics
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "High School"
#let term            = "[Term / Year]"
#let lesson-title    = "CSS Basics"
#let lesson-subtitle = "Giving your page a visual style"

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
  [Understand what CSS is and how it connects to HTML.],
  [Write CSS rules using element, class, and ID selectors.],
  [Apply colors, backgrounds, and typography to a page.],
  [Use the box model to control spacing around elements.],
  [Place an image alongside text using float.],
  [Style the about-me page from Lesson 3.],
)

= What is CSS?

In Lesson 3 you built the *structure* of a webpage using HTML. The page
works, but it probably looks quite plain — black text on a white
background, default fonts, no spacing beyond what the browser adds
automatically. This is where *CSS* comes in.

CSS stands for *Cascading Style Sheets*. It is the language that
controls how HTML elements look: their colors, fonts, sizes, spacing,
and position. While HTML answers the question "what is this?", CSS
answers the question "what does it look like?"

#infobox(
  "Why are they separate?",
  [Keeping structure and appearance in separate files is a deliberate
   design decision. It means you can completely change the look of a
   page without touching the HTML — and you can apply the same stylesheet
   to multiple pages at once. It also makes both files easier to read
   and maintain.],
)

= Connecting CSS to HTML

CSS lives in a separate file — in your cs-intro repository, that file is
`style.css`. It was already linked to your `index.html` in the skeleton,
but it is worth understanding how that link works:

```html
<head>
  <meta charset="UTF-8">
  <title>My Page</title>
  <link rel="stylesheet" href="style.css">
</head>
```

The `<link>` element in the `<head>` tells the browser to load `style.css`
and apply it to this page. The two attributes that matter are:

- `rel="stylesheet"` — tells the browser what kind of file this is.
- `href="style.css"` — the path to the CSS file, relative to the HTML file.

#warnbox(
  "⚠ No inline styles",
  [It is possible to write CSS directly inside an HTML tag using the
   `style` attribute — for example `<p style="color: red;">`. Do not do
   this. It mixes structure and appearance, makes your code hard to
   maintain, and is explicitly penalised in the project rubric. All CSS
   belongs in `style.css`.],
)

= The Anatomy of a CSS Rule

A CSS file is made up of *rules*. Each rule has two parts: a *selector*
that says which HTML elements to target, and a *declaration block* that
says what to do with them.

```css
p {
  color: navy;
  font-size: 16px;
}
```

- `p` is the *selector* — this rule applies to all `<p>` elements.
- The curly braces `{}` enclose the *declaration block*.
- `color: navy;` is a *declaration* — a property name, a colon, a value,
  and a semicolon.
- You can have as many declarations as you like inside one rule.

= Selectors

The selector determines which elements a rule applies to. There are
three kinds you need to know now.

== Element selectors

An element selector targets every instance of a given HTML tag:

```css
h1 {
  color: #2E6DA4;
}

p {
  line-height: 1.6;
}
```

This is the broadest kind of selector. Every `<h1>` on the page gets
the steel blue color; every `<p>` gets the line height.

== Class selectors

A class selector targets elements that have a specific `class` attribute.
In HTML, you add a class like this:

```html
<p class="intro">This is the introductory paragraph.</p>
<p>This is a regular paragraph.</p>
```

In CSS, you target a class by prefixing its name with a dot:

```css
.intro {
  font-size: 18px;
  font-weight: bold;
}
```

Only the first paragraph gets the larger, bold text. The second paragraph
is unaffected. Classes are reusable — you can apply the same class to
as many elements as you like.

== ID selectors

An ID selector targets a single element with a specific `id` attribute.
IDs must be unique — no two elements on the same page should share an ID.

```html
<div id="about">
  <h2>About Me</h2>
</div>
```

```css
#about {
  background-color: #f5f5f5;
  padding: 20px;
}
```

In CSS, IDs are prefixed with a `#`. Use IDs sparingly — they are best
reserved for major, unique sections of a page (which is also why they
work as anchor link targets).

#infobox(
  "A rule of thumb",
  [Use *element selectors* for global defaults that apply everywhere.
   Use *class selectors* for styles you want to reuse across multiple
   elements. Use *ID selectors* for one-off styles on a unique section.
   When in doubt, use a class.],
)

= Colors and Backgrounds

== Specifying colors

CSS accepts colors in several formats. The two most common are:

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Format],
    text(size: 9pt, weight: "bold", fill: white)[Example],
    text(size: 9pt, weight: "bold", fill: white)[Notes],
  ),
  [Named color],   [`red`, `navy`, `gold`],
    [Easy to read, but limited to ~140 predefined names.],
  [Hex code],       [`#2E6DA4`, `#F5F5F5`],
    [Six hexadecimal digits representing red, green, and blue.
     The most common format in professional work.],
  [RGB],            [`rgb(46, 109, 164)`],
    [Three numbers 0–255 for red, green, blue. Useful when you
     want to compute or adjust colors programmatically.],
)

A good tool for picking hex colors is #link("https://coolors.co") or
simply searching "color picker" in any browser.

== Text and background color

```css
body {
  background-color: #ffffff;
  color: #111111;
}

h1 {
  color: #2E6DA4;
}

.highlight {
  background-color: #fff3cd;
  color: #856404;
}
```

`color` sets the text color. `background-color` sets the background
behind an element. Both accept any CSS color format.

= Typography

Typography — the choice and treatment of text — has a large impact on
how a page feels. CSS gives you fine control over it.

== Font family

```css
body {
  font-family: Georgia, serif;
}

h1, h2, h3 {
  font-family: Arial, Helvetica, sans-serif;
}
```

`font-family` accepts a list of fonts separated by commas. The browser
tries each in order and uses the first one it has available. The last
value should always be a generic family (`serif`, `sans-serif`,
`monospace`) as a final fallback.

== Font size

```css
body {
  font-size: 16px;
}

h1 {
  font-size: 2em;
}
```

`px` (pixels) gives an absolute size. `em` is relative to the parent
element's font size — `2em` means twice the size of the surrounding text.
For body text, 16px is a comfortable starting point.

== Font weight and style

```css
strong {
  font-weight: bold;
}

.subtitle {
  font-weight: 300;
  font-style: italic;
}
```

`font-weight` accepts keywords (`normal`, `bold`) or numeric values
(100–900, where 400 is normal and 700 is bold). `font-style` accepts
`normal` or `italic`.

== Line height

```css
p {
  line-height: 1.6;
}
```

`line-height` controls the spacing between lines of text. A value
without a unit (like `1.6`) is a multiplier of the font size — `1.6`
means 1.6 times the font size. Values between 1.4 and 1.8 are generally
comfortable for body text.

= The Box Model

Every HTML element is treated as a rectangular box. The *box model*
describes the layers of space around the content inside that box:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Layer],
    text(size: 9pt, weight: "bold", fill: white)[What it is],
  ),
  [Content],  [The actual text or image inside the element.],
  [Padding],  [Space between the content and the border. Inside the
               background color.],
  [Border],   [An optional visible line around the element.],
  [Margin],   [Space outside the border, separating this element from
               its neighbors.],
)

// ── Box model diagram ─────────────────────────────────────────────────────────
#{
  // Colors for each layer
  let c-margin  = rgb("#D6E8F5")
  let c-border  = rgb("#F5C842")
  let c-padding = rgb("#B8DDB8")
  let c-content = rgb("#E8E8E8")

  let total-w = 340pt
  let total-h = 260pt
  let margin-inset  = 28pt
  let border-size   = 10pt
  let padding-inset = 28pt

  let border-x = margin-inset
  let border-y = margin-inset
  let border-w = total-w - 2 * margin-inset
  let border-h = total-h - 2 * margin-inset
  let padding-x = border-x + border-size
  let padding-y = border-y + border-size
  let padding-w = border-w - 2 * border-size
  let padding-h = border-h - 2 * border-size
  let content-x = padding-x + padding-inset
  let content-y = padding-y + padding-inset
  let content-w = padding-w - 2 * padding-inset
  let content-h = padding-h - 2 * padding-inset

  align(center,
    figure(
      block(width: total-w, height: total-h, {
        place(top + left, rect(width: total-w, height: total-h, fill: c-margin, stroke: none, radius: 3pt))
        place(top + left, dx: border-x, dy: border-y, rect(width: border-w, height: border-h, fill: c-border, stroke: none))
        place(top + left, dx: padding-x, dy: padding-y, rect(width: padding-w, height: padding-h, fill: c-padding, stroke: none))
        place(top + left, dx: content-x, dy: content-y, rect(width: content-w, height: content-h, fill: c-content, stroke: none, radius: 2pt))
        // Content label
        place(top + left, dx: content-x, dy: content-y,
          block(width: content-w, height: content-h,
            align(center + horizon, stack(spacing: 4pt,
              text(size: 10pt, weight: "bold", fill: rgb("#444444"))[Content],
              text(size: 8pt, fill: rgb("#888888"))[text, image, etc.],
            ))
          )
        )
        // Top labels
        place(top + left, dx: 0pt, dy: 0pt, block(width: total-w, height: margin-inset, align(center + horizon, text(size: 9pt, weight: "bold", fill: rgb("#1A4A6E"))[margin])))
        place(top + left, dx: border-x, dy: border-y, block(width: border-w, height: border-size, align(center + horizon, text(size: 7.5pt, weight: "bold", fill: rgb("#7A5A00"))[border])))
        place(top + left, dx: padding-x, dy: padding-y, block(width: padding-w, height: padding-inset, align(center + horizon, text(size: 9pt, weight: "bold", fill: rgb("#2E5E2E"))[padding])))
        // Left-side labels
        place(top + left, dx: 0pt, dy: margin-inset, block(width: margin-inset, height: total-h - 2 * margin-inset, align(center + horizon, rotate(-90deg, text(size: 9pt, weight: "bold", fill: rgb("#1A4A6E"))[margin]))))
        place(top + left, dx: border-x, dy: border-y + border-size, block(width: border-size, height: border-h - 2 * border-size, align(center + horizon, rotate(-90deg, text(size: 7pt, weight: "bold", fill: rgb("#7A5A00"))[border]))))
        place(top + left, dx: padding-x, dy: padding-y + padding-inset, block(width: padding-inset, height: padding-h - 2 * padding-inset, align(center + horizon, rotate(-90deg, text(size: 9pt, weight: "bold", fill: rgb("#2E5E2E"))[padding]))))
      }),
      caption: [The CSS box model — every HTML element is surrounded by padding, border, and margin.],
    )
  )
}


// ```css
// .card {
//   padding: 20px;
//   border: 1px solid #cccccc;
//   margin: 16px 0;
// }
// ```

== Shorthand values

Many CSS properties accept shorthand notation. For `margin` and `padding`,
you can specify one to four values:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Syntax],
    text(size: 9pt, weight: "bold", fill: white)[Meaning],
  ),
  [`margin: 16px`],           [Same on all four sides.],
  [`margin: 8px 16px`],       [8px top and bottom, 16px left and right.],
  [`margin: 8px 16px 12px`],  [Top, left+right, bottom.],
  [`margin: 8px 12px 16px 10px`], [Top, right, bottom, left (clockwise).],
)

#infobox(
  "Visualising the box model",
  [Open your page in a browser, right-click any element, and choose
   *Inspect* (or *Inspect Element*). In the browser developer tools,
   click on an element and look for the box model diagram — it shows
   the content, padding, border, and margin as colored rectangles.
   This is one of the most useful tools for understanding why elements
   are positioned where they are.],
)

= Placing an Image Next to Text

One of the first layout questions students ask is: "how do I put my
image next to the text instead of above or below it?" By default, images
are inline elements and sit in the flow of text, but a block-level
container like a `<div>` will push content below it.

The traditional CSS solution for this is `float`. It pulls an element
out of the normal flow and allows text to wrap around it:

```css
.profile-photo {
  float: left;
  margin: 0 20px 10px 0;
  width: 180px;
}
```

```html
<div>
  <img class="profile-photo"
       src="images/photo.jpg"
       alt="A photo of me">
  <p>I am a student at Gymnasium Muttenz. I enjoy music and hiking.
  The text here will wrap around the image to the right...</p>
</div>
```

`float: left` moves the image to the left and allows following content
to flow alongside it on the right. The `margin` on the right and bottom
creates comfortable spacing between the image and the text.

== Clearing a float

One quirk of float: if the text next to a floated element is shorter
than the image, the *next* element on the page can also wrap around it
unexpectedly. To prevent this, add `clear: both` to whatever comes
after the floated content:

```html
<div>
  <img class="profile-photo"
       src="images/photo.jpg"
       alt="A photo of me">
  <p>Some text that wraps alongside the image...</p>
</div>

<div class="next-section">
  <h2>My Interests</h2>
  <p>This section should start below the image, not beside it.</p>
</div>
```

```css
.next-section {
  clear: both;
}
```

`clear: both` tells the browser to start this element below any floats
above it, restoring the normal document flow.

#infobox(
  "Float is not the only way",
  [Float is the most straightforward approach for this specific
   situation and requires no new concepts beyond what we have covered.
   In Lesson 7 we will look at Flexbox, which is a more powerful and
   modern layout system. For now, float is the right tool for placing
   an image next to text.],
)

= Styling Your Page

Open `style.css` in your cs-intro repository and work through the
following. Commit after each significant change so your git history
shows the progression.

#steps(
  [Set a background color and a default text color on `body`. Choose
   a combination that is comfortable to read — high contrast but not
   necessarily pure black on white.],
  [Choose a font family for your body text and a different one for your
   headings. Apply them using `font-family` on `body` and on `h1, h2, h3`.],
  [Set a comfortable `font-size` and `line-height` on `body`.],
  [Give your `h1` a distinctive color — ideally one that becomes a
   consistent accent color across your page.],
  [Add `padding` to your main content area so text does not sit flush
   against the edge of the browser window.],
  [Add `margin` between your sections to create breathing room.],
  [If you have an image, float it left or right and add a margin so
   text flows neatly beside it.],
  [Use the browser inspector (*right-click → Inspect*) to check your
   box model and adjust spacing until it looks right.],
  [Commit your changes with a clear message. \
   Example: `Add typography and color styles to style.css`],
)

= Summary

By the end of this lesson you should have:

#checklist(
  [A `<link>` element in your HTML connecting `style.css` correctly.],
  [CSS rules using at least one element, one class, and one ID selector.],
  [A consistent color scheme applied to your page.],
  [Body text with a chosen font family, size, and line height.],
  [Spacing added using padding and margin.],
  [An image floated next to text (if your page includes a photo).],
  [Changes committed and pushed with clear commit messages.],
)
