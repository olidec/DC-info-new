// ─────────────────────────────────────────────────────────────────────────────
// Lesson — SVG: Scalable Vector Graphics
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "SVG — Scalable Vector Graphics"
#let lesson-subtitle = "Drawing with code"

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

// ── Import shared styles ───────────────────────────────────────────────────────
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
  [Explain the difference between raster graphics and vector graphics.],
  [Embed an `<svg>` element directly inside an HTML page.],
  [Draw and style basic shapes: `<circle>`, `<rect>`, `<ellipse>`, `<line>`, `<polygon>`.],
  [Combine shapes to build a recognizable scene or figure.],
  [Add a simple `<animate>` animation to an SVG element.],
  [Use JavaScript to generate or modify SVG shapes dynamically.],
)

= Raster vs. Vector Graphics #h(1fr) #tier-core

Almost every image you see on screen belongs to one of two families.

*Raster graphics* store an image as a grid of colored pixels. When you zoom
in far enough, you can see the individual squares. File formats like JPEG,
PNG, and GIF are all raster formats. Photographs are typically raster images.

*Vector graphics* store an image as a set of mathematical instructions:
"draw a circle of radius 40 centered at (50, 50), filled red." The computer
recalculates the pixels on demand at whatever size or zoom level you need.
This means vector images are *perfectly sharp at any scale* — they never
blur or pixelate.

#infobox(
  "Why does this matter for the web?",
  [Logos, icons, diagrams, and illustrations are all ideal candidates for
   vector graphics. A company logo stored as SVG looks crisp on a small
   business card and on a giant billboard — with the same file. A PNG logo
   would need separate versions for each resolution. SVG files are also
   typically very small in size, since you are storing a description rather
   than millions of pixel values.],
)

= SVG in HTML #h(1fr) #tier-core

*Scalable Vector Graphics (SVG)* is the standard vector image format for
the web. SVG is written in XML — a markup language very similar to HTML —
so it can be embedded directly inside an HTML file, just like any other tag.

Here is the smallest possible SVG — a red circle:

```html
<svg height="100" width="100">
  <circle cx="50" cy="50" r="50" fill="red" />
</svg>
```

The `<svg>` tag acts as a canvas. The `width` and `height` attributes
define how much space the canvas occupies on the page, measured in pixels.

#warnbox(
  "⚠ The coordinate system",
  [SVG uses a coordinate system where (0, 0) is the *top-left* corner.
   The x-axis increases to the right, and the y-axis increases *downward*.
   This is the opposite of the standard mathematical convention, and it
   catches many people out. Keep it in mind when you place shapes.],
)

== Shared visual attributes

These attributes can be applied to *any* SVG shape:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribute],
    text(size: 9pt, weight: "bold", fill: white)[Description],
  ),
  [`fill`],         [The interior color of the shape. Accepts color names, hex codes, or `"none"`.],
  [`stroke`],       [The color of the outline.],
  [`stroke-width`], [The thickness of the outline in pixels.],
  [`opacity`],      [Transparency from `0` (invisible) to `1` (fully opaque).],
)

= Basic Shapes #h(1fr) #tier-core

== Circles — `<circle>`

```html
<circle cx="50" cy="50" r="40" fill="yellow" stroke="green" stroke-width="4" />
```

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribute],
    text(size: 9pt, weight: "bold", fill: white)[Meaning],
  ),
  [`cx`], [x-coordinate of the center.],
  [`cy`], [y-coordinate of the center.],
  [`r`],  [Radius.],
)

== Rectangles — `<rect>`

```html
<rect x="30" y="20" width="200" height="50" fill="blue" rx="8" />
```

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribute],
    text(size: 9pt, weight: "bold", fill: white)[Meaning],
  ),
  [`x`, `y`],         [Position of the *top-left* corner.],
  [`width`, `height`],[Dimensions of the rectangle.],
  [`rx`, `ry`],       [Corner rounding radii (optional; default 0 = sharp corners).],
)

== Ellipses — `<ellipse>`

An ellipse is like a circle but with independently settable horizontal and
vertical radii (the semimajor and semiminor axes in mathematics):

```html
<ellipse cx="100" cy="60" rx="80" ry="40" fill="purple" />
```

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribute],
    text(size: 9pt, weight: "bold", fill: white)[Meaning],
  ),
  [`cx`, `cy`], [Center coordinates.],
  [`rx`],       [Horizontal radius.],
  [`ry`],       [Vertical radius.],
)

== Lines — `<line>`

A straight line between two points. Because a line has no interior, `stroke`
is required — `fill` does nothing here.

```html
<line x1="10" y1="10" x2="200" y2="150" stroke="black" stroke-width="3" />
```

== Polylines — `<polyline>`

A sequence of connected straight-line segments. All points are listed in a
single `points` attribute, separated by spaces or commas. Note that by default
a polyline has a fill — use `fill="none"` to suppress it:

```html
<polyline
  points="60,110 65,120 70,115 75,130 80,125 85,140"
  fill="none"
  stroke="red"
  stroke-width="2"
/>
```

== Polygons — `<polygon>`

A polygon works exactly like a polyline, except that the path automatically
closes — the last point is connected back to the first. This makes it ideal
for drawing shapes such as triangles, stars, and hexagons:

```html
<polygon points="200,10 250,190 160,210" fill="lime" stroke="purple" />
```

The coordinates for a regular polygon can be calculated with trigonometry.
For a regular $n$-gon centered at $(c_x, c_y)$ with radius $r$, the $k$-th
vertex is at:

$ x_k = c_x + r dot cos((2 pi k) / n), quad y_k = c_y + r dot sin((2 pi k) / n) $

#infobox(
  "Tip — use a spreadsheet",
  [For regular polygons you do not need to calculate coordinates by hand.
   Open a spreadsheet, compute $r dot cos(2\pi k / n)$ and $r dot sin(2 pi k / n)$
   for each $k$, and copy the results into your `points` attribute.],
)

= Paths — `<path>` #h(1fr) #tier-extension

The `<path>` element is the most powerful shape in SVG. It can describe
straight lines, curves, and arbitrarily complex outlines — all through a
compact mini-language in the `d` attribute.

The most common commands are:

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Command],
    text(size: 9pt, weight: "bold", fill: white)[Name],
    text(size: 9pt, weight: "bold", fill: white)[Description],
  ),
  [`M x,y`],         [Move to],          [Lift the pen and place it at (x, y) without drawing.],
  [`L x,y`],         [Line to],          [Draw a straight line to (x, y).],
  [`H x`],           [Horizontal line],  [Draw a horizontal line to x.],
  [`V y`],           [Vertical line],    [Draw a vertical line to y.],
  [`Q cx,cy x,y`],   [Quadratic curve],  [A smooth curve toward control point (cx, cy), ending at (x, y).],
  [`C cx1,cy1 cx2,cy2 x,y`], [Cubic Bézier], [A smooth curve with two control points.],
  [`Z`],             [Close path],       [Draw a straight line back to the start of the path.],
)

A smile, for example, can be drawn with a quadratic curve:

```html
<path
  d="M 20,100 Q 60,140 100,100"
  fill="none"
  stroke="black"
  stroke-width="3"
/>
```

Here `M 20,100` places the pen at the left corner of the mouth, `Q 60,140`
sets a control point below the center (pulling the curve downward), and
`100,100` is the right corner.

#note(
  "Going further",
  [The full path specification is extensive. The MDN Web Docs tutorial at
   `developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths` is the
   best reference if you want to explore curves in more detail.],
)

= Layering and Grouping #h(1fr) #tier-extension

== Drawing order

SVG elements are drawn in the order they appear in the code. Later elements
appear *on top of* earlier ones — just like stacking sheets of paper. If you
want a circle to appear in front of a rectangle, write the circle after the
rectangle.

== Groups — `<g>`

The `<g>` element groups several shapes together. Visual attributes set on
the group are inherited by all children, and the whole group can be moved or
styled at once:

```html
<g fill="steelblue" stroke="navy" stroke-width="1">
  <circle cx="50" cy="50" r="30" />
  <rect x="80" y="30" width="40" height="40" />
</g>
```

Groups are especially useful when you want to build a composite object —
such as a face made of circles and curves — and treat it as a single unit.

= Animation #h(1fr) #tier-extension

SVG supports animation through the `<animate>` element. Place it *inside*
the shape you want to animate. It continuously changes one attribute of
the parent element over time:

```html
<ellipse cx="50" cy="50" rx="50" ry="50" fill="red">
  <animate
    attributeName="ry"
    values="50;25;50"
    dur="2s"
    repeatCount="indefinite"
  />
</ellipse>
```

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribute],
    text(size: 9pt, weight: "bold", fill: white)[Meaning],
  ),
  [`attributeName`],  [The SVG attribute to animate (e.g., `"ry"`, `"fill"`, `"cx"`).],
  [`values`],         [Semicolon-separated list of values to cycle through.],
  [`dur`],            [Duration of one cycle (e.g., `"2s"`, `"500ms"`).],
  [`repeatCount`],    [`"indefinite"` loops forever; a number repeats that many times.],
)

== Animated motion — `<animateMotion>`

`<animateMotion>` moves a shape along a path:

```html
<svg viewBox="0 0 200 100">
  <path fill="none" stroke="lightgrey"
    d="M20,50 C20,-50 180,150 180,50 C180,-50 20,150 20,50 z" />
  <circle r="6" fill="red">
    <animateMotion
      dur="4s"
      repeatCount="indefinite"
      path="M20,50 C20,-50 180,150 180,50 C180,-50 20,150 20,50 z"
    />
  </circle>
</svg>
```

The shape traces the exact path defined in the `path` attribute — useful
for orbits, loaders, and any animation that follows a fixed route.

= Generating SVG with JavaScript #h(1fr) #tier-challenge

Because SVG lives inside the HTML document, JavaScript can create and
modify SVG elements exactly as it would any other DOM element. This opens
up a whole new dimension: *generative art* — images produced by code
rather than drawn by hand.

== Creating SVG elements in JavaScript

SVG elements must be created with `document.createElementNS` rather than
`document.createElement`, because SVG uses a different XML namespace:

```js
const svgNS = "http://www.w3.org/2000/svg";
const svg   = document.getElementById("my-svg");

const circle = document.createElementNS(svgNS, "circle");
circle.setAttribute("cx", 100);
circle.setAttribute("cy", 100);
circle.setAttribute("r",  40);
circle.setAttribute("fill", "steelblue");

svg.appendChild(circle);
```

== A worked example: random circles

The code below draws 30 circles at random positions with random colors
each time the page loads:

```js
const svgNS = "http://www.w3.org/2000/svg";
const svg   = document.getElementById("canvas");

function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

for (let i = 0; i < 30; i++) {
  const circle = document.createElementNS(svgNS, "circle");
  circle.setAttribute("cx",   randomInt(20, 580));
  circle.setAttribute("cy",   randomInt(20, 280));
  circle.setAttribute("r",    randomInt(5, 40));
  circle.setAttribute("fill", `hsl(${randomInt(0, 360)}, 70%, 60%)`);
  circle.setAttribute("opacity", "0.7");
  svg.appendChild(circle);
}
```

Notice `hsl(hue, saturation, lightness)` — a color format that makes it
easy to generate varied but harmonious colors by randomizing the hue alone.

#infobox(
  "HSL colors",
  [HSL stands for Hue–Saturation–Lightness. Hue is an angle on the color
   wheel (0–360°), so `hsl(0, 70%, 60%)` is red, `hsl(120, 70%, 60%)` is
   green, and `hsl(240, 70%, 60%)` is blue. By keeping saturation and
   lightness fixed and only randomizing hue, you get colors that always
   look good together.],
)

== Reacting to clicks

You can also modify SVG shapes in response to user interaction. The
following adds a click listener to every circle so that it changes color
when clicked:

```js
circle.addEventListener("click", () => {
  circle.setAttribute("fill", `hsl(${randomInt(0, 360)}, 70%, 60%)`);
});
```

= Summary #h(1fr) #tier-core

#checklist(
  [You can explain why vector graphics scale better than raster graphics.],
  [You can embed `<svg>` inside HTML and set its `width` and `height`.],
  [You can draw and style `<circle>`, `<rect>`, `<ellipse>`, `<line>`, and `<polygon>`.],
  [You remember that (0, 0) is the *top-left* corner and y increases downward.],
  [You can use `<animate>` to animate a shape attribute over time.],
  [You can use `document.createElementNS` to create SVG shapes from JavaScript.],
)
