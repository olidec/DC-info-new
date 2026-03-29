// ─────────────────────────────────────────────────────────────────────────────
// Lesson 3 — HTML Basics
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "High School"
#let term            = "[Term / Year]"
#let lesson-title    = "HTML Basics"
#let lesson-subtitle = "Building the structure of a webpage"

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
  [Understand what HTML is and how browsers use it.],
  [Write a valid HTML document structure from memory.],
  [Use semantic layout elements to organize a page.],
  [Add text content, links, and images to a webpage.],
  [Build the HTML structure of your personal page in the cs-intro repo.],
)

= What is HTML?

Every webpage you have ever seen starts as a plain text file. The browser
reads that file and turns it into the visual page you see on screen. The
language that makes this possible is *HTML* — HyperText Markup Language.

HTML does not describe how a page looks. It describes what a page *is*:
which parts are headings, which are paragraphs, which are navigation links,
which are images. Appearance comes later, with CSS. This separation is
important and we will return to it in Lesson 4.

#infobox(
  "HTML is not a programming language",
  [HTML has no logic, no variables, no conditions. It is a *markup language*
   — a way of annotating text to give it meaning. A paragraph tag does not
   do anything; it simply tells the browser "this piece of text is a
   paragraph." The browser decides how to display it.],
)

= The Anatomy of an HTML Tag

Everything in HTML is made of *tags*. A tag is a keyword wrapped in angle
brackets. Most tags come in pairs: an *opening tag* and a *closing tag*,
with content in between.

```html
<p>This is a paragraph.</p>
```

The opening tag is `<p>`. The closing tag is `</p>` — note the forward
slash. The content sits between them. Together, the opening tag, content,
and closing tag form an *element*.

Some elements have no content and no closing tag — they are called *void
elements*. An image is a common example:

```html
<img src="photo.jpg" alt="A description of the photo">
```

== A note on special characters

Before you start typing HTML, you need to be able to find a handful of
characters that are not always easy to locate on a keyboard. Their position
varies by operating system, keyboard layout, and even the brand of computer.

#table(
  columns: (auto, auto, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Character],
    text(size: 9pt, weight: "bold", fill: white)[Windows (CH/DE)],
    text(size: 9pt, weight: "bold", fill: white)[macOS (CH/DE)],
    text(size: 9pt, weight: "bold", fill: white)[Used for],
  ),
  [`<`],  [Shift + ,  or  Alt + Shift + ,], [⌥ + Shift + ,  or  ⌥ + <], [Opening tags],
  [`>`],  [Shift + .  or  Alt + Shift + .], [⌥ + Shift + .  or  ⌥ + >], [Closing tags],
  [`/`],  [Shift + 7], [Shift + 7], [Closing tags],
  [`"`],  [Shift + 2], [Shift + 2], [Attribute values],
  [`=`],  [Shift + 0], [Shift + 0], [Attributes],
  [`!`],  [Shift + 1], [Shift + 1], [`<!DOCTYPE html>`],
)

#warnbox(
  "⚠ Keyboard layouts vary",
  [The shortcuts above are for Swiss German (CH) and German (DE) keyboard
   layouts, which are the most common in this class. If your keyboard is
   different — US, French, Italian, or another layout — the positions may
   vary. If you cannot find a character, ask the teacher or search for
   "[character name] [your keyboard layout]". \
   \
   *Tip:* VS Code's auto-complete will often insert matching closing tags
   and quote pairs for you automatically — pay attention to what it suggests
   before typing everything manually.],
)



Tags can carry extra information called *attributes*. An attribute is a
name-value pair written inside the opening tag:

```html
<a href="https://example.com">Click here</a>
```

Here, `href` is the attribute name and `"https://example.com"` is its value.
The `<a>` tag creates a link; the `href` attribute tells the browser where
the link goes.

== Nesting

Elements can contain other elements. This is called *nesting*. The inner
element must be fully closed before the outer element closes:

```html
<p>You can make text <strong>bold</strong> inside a paragraph.</p>
```

Correct nesting is important. Browsers are forgiving about some mistakes,
but badly nested HTML can cause unexpected behavior.

= A Valid HTML Document

A valid HTML document always has the same basic structure. Here is the
minimum a browser expects:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Page Title</title>
  </head>
  <body>
    <!-- Page content goes here -->
  </body>
</html>
```

Let us look at each part:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Line],
    text(size: 9pt, weight: "bold", fill: white)[What it does],
  ),
  [`<!DOCTYPE html>`],
    [Tells the browser this is a modern HTML document. Always the first line.],
  [`<html lang="en">`],
    [The root element — everything else lives inside it. The `lang` attribute
     declares the language, which helps search engines and screen readers.],
  [`<head>`],
    [Contains information *about* the page — not visible content, but metadata
     that the browser and search engines use.],
  [`<meta charset="UTF-8">`],
    [Tells the browser to use the UTF-8 character encoding, which supports
     accented characters, symbols, and most of the world's scripts.],
  [`<title>`],
    [The text that appears in the browser tab and in search engine results.],
  [`<body>`],
    [Everything visible on the page goes here.],
  [`<!-- ... -->`],
    [A comment — ignored by the browser, useful for notes to yourself.],
)

#infobox(
  "The skeleton in your cs-intro repo",
  [Open `index.html` in your cs-intro repository. You will see that this
   structure is already there. Your job from now on is to fill in the
   `<body>` with real content — the skeleton is provided so you can focus
   on learning HTML rather than memorizing boilerplate.],
)

= Structuring a Page with div and span

HTML has two general-purpose container elements that you will see everywhere:
`<div>` and `<span>`. Unlike semantic elements such as `<header>` or
`<section>`, these carry no meaning of their own — they are purely structural
tools for grouping content so that CSS can target it.

== div

`<div>` is a *block-level* container. It starts on a new line and takes up
the full width available. Use it to group larger chunks of content that
belong together:

```html
<div>
  <h2>About Me</h2>
  <p>I am a student at Gymnasium Muttenz.</p>
  <p>I enjoy music and hiking.</p>
</div>
```

On its own, a `<div>` is invisible — it has no color, no border, no spacing.
Its purpose is to give CSS something to grab onto. You will use it constantly
once we start styling in Lesson 4.

== span

`<span>` is an *inline* container. It sits inside a line of text without
breaking it. Use it to mark up a word or phrase within a paragraph:

```html
<p>My favorite color is <span>deep blue</span>.</p>
```

Again, by itself `<span>` does nothing visible. Its value comes when CSS
applies a color, font, or other style to just that piece of text.

#infobox(
  "Block vs inline",
  [This distinction — block elements start on a new line and take full width,
   inline elements flow within text — applies to many HTML elements, not just
   `<div>` and `<span>`. Headings and paragraphs are block-level. Links and
   images are inline. It becomes important when we start laying out pages
   with CSS.],
)



= Text Elements

Inside your sections, you will use text elements to mark up your content.

== Headings

HTML has six heading levels, `<h1>` through `<h6>`. Use them in order —
do not skip from `<h1>` to `<h3>`. Think of them like the outline of a
document: `<h1>` is the title, `<h2>` is a chapter, `<h3>` is a subsection.

```html
<h1>Anna Müller</h1>
<h2>About Me</h2>
<h3>Where I grew up</h3>
```

#infobox(
  "One h1 per page",
  [There should only be one `<h1>` element on a page — it is the main
   title. Using multiple `<h1>` tags is not wrong, but it is considered
   poor practice and can confuse search engines.],
)

== Paragraphs

```html
<p>I am a student at Gymnasium Muttenz. I enjoy music and hiking.</p>
```

Each `<p>` element is its own paragraph. Browsers add a small gap between
paragraphs automatically.

== Lists

Use `<ul>` for unordered (bulleted) lists and `<ol>` for ordered (numbered)
lists. Each item is wrapped in `<li>`:

```html
<ul>
  <li>Photography</li>
  <li>Cooking</li>
  <li>Reading</li>
</ul>

<ol>
  <li>Wake up</li>
  <li>Make coffee</li>
  <li>Open VS Code</li>
</ol>
```

= Links and Images

== Links

The `<a>` tag (anchor) creates a hyperlink. The `href` attribute specifies
the destination:

```html
<a href="https://www.example.com">Visit Example</a>
```

You can also link to a different section of the same page using an `id`:

```html
<!-- The link -->
<a href="#interests">Jump to my interests</a>

<!-- The target (somewhere else on the page) -->
<section id="interests">
  <h2>My Interests</h2>
</section>
```

This is called an *anchor link* and is how the navigation in your about-me
page will work.

== Images

The `<img>` tag embeds an image. It is a void element — no closing tag.
The two most important attributes are `src` (the path to the image file)
and `alt` (a text description for screen readers and when the image fails
to load):

```html
<img src="images/photo.jpg" alt="A photo of me at the beach">
```

#warnbox(
  "⚠ Always write an alt attribute",
  [The `alt` attribute is not optional — it is required for accessibility.
   A page without `alt` attributes on its images fails basic accessibility
   standards. Write a genuine description of what the image shows, not just
   "image" or the filename.],
)

To use an image in your project, copy the image file into your cs-intro
repository folder (you could create a subfolder called `images/`), then
reference it with a relative path:

```html
<img src="images/photo.jpg" alt="Description">
```

= Building Your Page

You now have everything you need to build the HTML structure of your
personal page. Open `index.html` in your cs-intro repository and work
through the following:

#steps(
  [Give your page a proper `<title>` in the `<head>` — your name works well.],
  [Inside `<body>`, add an `<h1>` with your name, followed by a short
   introductory paragraph about yourself.],
  [Add at least two more sections of content, each with an `<h2>` heading.
   Use `<div>` elements to group each section.],
  [Add at least one unordered or ordered list somewhere appropriate.],
  [Add at least one image with a proper `alt` attribute. Create an `images/`
   subfolder in your repo and place the image file there.],
  [Add at least one external link relevant to your content.],
  [Save the file and open it in a browser to check it looks right.
   In VS Code, right-click `index.html` in the Explorer panel and choose
   *Reveal in File Explorer* (Windows) or *Reveal in Finder* (macOS).
   Then double-click the file to open it in your default browser.],
  [Commit your work with a clear message, then push. \
   Example: `Add HTML structure and content to index.html`],
)

= Summary

By the end of this lesson you should have:

#checklist(
  [A valid HTML document structure in `index.html` (DOCTYPE, html, head, body).],
  [An `<h1>` heading, at least two `<h2>` headings, and paragraphs.],
  [At least one list (`<ul>` or `<ol>`).],
  [At least one `<div>` grouping a section of content.],
  [At least one link and one image with an `alt` attribute.],
  [Changes committed and pushed to GitHub with a clear commit message.],
)
