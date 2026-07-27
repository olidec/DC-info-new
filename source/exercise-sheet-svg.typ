// ─────────────────────────────────────────────────────────────────────────────
// Exercise Sheet — SVG: Scalable Vector Graphics
// ─────────────────────────────────────────────────────────────────────────────

#let course      = "Computer Science"
#let level       = "Gymnasium Muttenz"
#let term        = "2026-27"
#let lesson-num  = "SVG"
#let sheet-type  = "Exercise Sheet"
#let sheet-title = "Scalable Vector Graphics"

// ── Page setup ────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: rgb("#999999"))
    grid(
      columns: (1fr, 1fr),
      align(left,  [#sheet-type — #sheet-title]),
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

// ── Import shared styles ───────────────────────────────────────────────────────
#import "../cs-style.typ": *

// ── Extra components ──────────────────────────────────────────────────────────

// A side-by-side code + preview scaffold
#let code-preview(code-content) = block(
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
      [
        #text(size: 9pt, fill: rgb("#999999"), style: "italic")[
          Sketch your expected output here:
        ]
        #v(5em)
      ]
    ),
  )
)

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

#tier-legend

#v(0.5em)

#text(size: 9pt, fill: rgb("#999999"))[
  All coding exercises are completed in your `svg-art` repository.
  Open `index.html` in VS Code and in your browser side by side.
  After each exercise: commit your work with a clear message.
]

#v(0.5em)

// ─────────────────────────────────────────────────────────────────────────────
= Part 1 — Reading SVG Code #h(1fr) #tier-core

For each code snippet, sketch what you expect to see in the preview box on
the right. Assume the `<svg>` canvas is 200 × 200 pixels.

#v(0.4em)
#exercise(title: "Circles")[
  #code-preview(raw(lang: "html", ```html
<svg width="200" height="200">
  <circle cx="60"  cy="100" r="50" fill="tomato" />
  <circle cx="140" cy="100" r="50" fill="steelblue"
          opacity="0.7" />
</svg>
```.text))
]

#exercise(title: "Rectangle and line")[
  #code-preview(raw(lang: "html", ```html
<svg width="200" height="200">
  <rect x="20" y="60" width="160" height="80"
        fill="none" stroke="black" stroke-width="3" rx="10" />
  <line x1="20" y1="100" x2="180" y2="100"
        stroke="red" stroke-width="2" />
</svg>
```.text))
]

#exercise(title: "Polygon")[
  #code-preview(raw(lang: "html", ```html
<svg width="200" height="200">
  <polygon
    points="100,20 180,170 20,170"
    fill="gold"
    stroke="darkorange"
    stroke-width="3"
  />
</svg>
```.text))

  What is the name of this shape? #answer-space(lines: 1)
]

// ─────────────────────────────────────────────────────────────────────────────
= Part 2 — Writing SVG Code #h(1fr) #tier-core

Open `index.html` in your repository. Each task below asks you to add SVG
to the file. Use the `<svg>` tag with appropriate `width` and `height`
attributes for each image.

#exercise(title: "Touching circles")[
  Draw three circles in a row that touch each other and get smaller from
  left to right. Give each circle a different fill color.

  #hint[
    If the largest circle has radius $r_1$ and center at $(r_1,\, r_1)$,
    where must the center of a circle with radius $r_2$ be so that the two
    circles just touch?
  ]
]

#exercise(title: "Bullseye")[
  Draw a bullseye (target) pattern: three concentric circles with
  alternating red and white fill. All circles share the same center.
]

#exercise(title: "Traffic light")[
  Draw a traffic light using SVG shapes:
  - A dark-grey rounded rectangle for the housing.
  - Three circles for the lights (red, yellow, green, top to bottom).

  The circles should be centered horizontally inside the rectangle.
]

// ─────────────────────────────────────────────────────────────────────────────
= Part 3 — Coordinates and Geometry #h(1fr) #tier-extension

#exercise(title: "Five-pointed star")[
  Draw a regular five-pointed star using a `<polygon>`.

  #hint[
    A five-pointed star has 10 vertices — 5 outer points and 5 inner points,
    alternating. For an outer point $k$ (with $k = 0, 1, 2, 3, 4$), the
    coordinates are:
    $ x = c_x + R dot cos\( -pi/2 + (2pi k)/5 \), quad y = c_y + R dot sin\( -pi/2 + (2pi k)/5 \) $
    For an inner point $k$, use the same formula with a smaller radius $r approx 0.38 R$
    and offset the angle by $pi/5$.
    Compute the 10 points with a calculator or spreadsheet, then list them
    in your `points` attribute.
  ]
]

#exercise(title: "Regular octagon")[
  Draw a regular octagon using a `<polygon>`. Center it at (150, 150)
  with a circumradius of 100 px.

  Show your coordinate calculations below.

  #answer-space(lines: 4)
]

#exercise(title: "Spot the error")[
  The SVG below is supposed to draw a green circle with a thick black
  outline, but something is wrong. Identify and fix the error.

  ```html
  <svg width="200" height="200">
    <circle cx="100" cy="100" r="60"
            fill="green"
            stroke-color="black"
            stroke-width="8" />
  </svg>
  ```

  What is the error? #answer-space(lines: 1)

  Write the corrected attribute below: #answer-space(lines: 1)
]

// ─────────────────────────────────────────────────────────────────────────────
= Part 4 — Faces and Scenes #h(1fr) #tier-extension

#exercise(title: "Smiley face")[
  Build a smiley face emoji using at least:
  - One large circle for the head.
  - Two circles for the eyes.
  - A `<path>` for the smile.

  Use this path as a starting point for the smile — adjust the numbers to
  fit your head size:

  ```html
  <path d="M 60,120 Q 100,160 140,120"
        stroke="black" stroke-width="3" fill="none" />
  ```

  The `M` command sets the left corner of the mouth, `Q` sets a control
  point below the center, and the last coordinate is the right corner.

  *Extension:* Add a winking eye using `<animate>` to make one eye blink.
]

#exercise(title: "Mini-scene")[
  Draw a simple outdoor scene that includes at least:
  - A sky (rectangle or background fill).
  - A sun or moon (circle or ellipse).
  - At least two other recognizable elements (a house, tree, cloud, bird, …).

  Plan your scene on paper first — sketch what you want to draw and label
  the approximate coordinates before you write any code.
]

// ─────────────────────────────────────────────────────────────────────────────
= Part 5 — Animation #h(1fr) #tier-extension

#exercise(title: "Winking smiley")[
  Return to your smiley face from Exercise 7. Add an `<animate>` element
  to one of the eyes so that it "winks" — the eye squishes vertically and
  returns to its original size, repeating every 3 seconds.

  #hint[
    Animate the `ry` attribute of an `<ellipse>` between its full value and
    a very small value (e.g., `2`).
  ]
]

#exercise(title: "Orbiting planet")[
  Use `<animateMotion>` to make a small circle travel along a circular or
  elliptical orbit around a larger circle.

  #steps(
    [Draw a large circle in the center — the "sun".],
    [Draw the orbital path as a `<path>` or `<ellipse>` with `fill="none"` and a light stroke.],
    [Draw a small circle — the "planet".],
    [Add `<animateMotion>` inside the planet circle, setting its `path` to
     the same path data as the orbit.],
  )
]

// ─────────────────────────────────────────────────────────────────────────────
= Part 6 — Generative Art with JavaScript #h(1fr) #tier-challenge

Open `script.js` in your repository. This part uses JavaScript to create
SVG elements in code — you will not write any SVG directly in `index.html`.
The `index.html` template already has an empty `<svg id="canvas">` element
waiting for you.

#exercise(title: "Random circles")[
  Write a JavaScript function `drawCircles(n)` that creates `n` circles at
  random positions within the canvas, each with a random radius (between 5
  and 40 px) and a random HSL fill color. Call it with `drawCircles(40)`.

  Remember the namespace:
  ```js
  const svgNS = "http://www.w3.org/2000/svg";
  const svg   = document.getElementById("canvas");
  ```

  #hint[
    `Math.random()` returns a decimal between 0 and 1. To get an integer
    between `min` and `max`, use: \
    `Math.floor(Math.random() * (max - min + 1)) + min`
  ]
]

#exercise(title: "Grid pattern")[
  Write a function `drawGrid(cols, rows)` that fills the canvas with a
  regular grid of circles. Each circle should have the same radius, and
  the circles should be evenly spaced. Choose a color scheme of your
  liking.

  *Extension:* Make the fill color depend on the circle's position —
  for example, vary the hue based on the column number.
]

#exercise(title: "Interactive canvas")[
  Extend your `drawCircles` function so that every circle, when clicked,
  changes to a new random color. Use `addEventListener("click", ...)`.

  Then add a button to `index.html` labeled *"Redraw"* that clears the
  canvas and calls `drawCircles(40)` again.

  #hint[
    To remove all child elements from the SVG canvas:
    ```js
    while (svg.firstChild) {
      svg.removeChild(svg.firstChild);
    }
    ```
  ]
]

// ─────────────────────────────────────────────────────────────────────────────
= Part 7 — Creative Project #h(1fr) #tier-challenge

#exercise(title: "Your own artwork")[
  Create an original SVG artwork or animation. You may use any combination
  of hand-coded SVG, `<animate>`, and JavaScript generation. The only
  constraint is that it must include *at least three different SVG shape
  types* and produce something visually interesting.

  Ideas to get you started:
  - A generative pattern (spirals, tessellations, fractals).
  - An animated scene (weather, space, ocean).
  - An interactive drawing tool where clicking adds new shapes.
  - A "data self-portrait" — a visual representation of something about
    yourself (favorite numbers, colors, a schedule).

  You will share your result with the class at the end of the lesson.

  #note(
    "Commit as you go",
    [Commit after every feature that works — not just at the end. A clear
     commit history shows your process and gives you a safe point to return
     to if something breaks.],
  )
]
