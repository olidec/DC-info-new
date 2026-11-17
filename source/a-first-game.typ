// ─────────────────────────────────────────────────────────────────────────────
// Self-Study Sheet — A First Game
// Adapted from coding.tex, Section 9 ("A First Game")
//
// Set show-solutions to false to compile a student version without the
// solutions appendix.
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "A First Game"
#let lesson-subtitle = "Self-study: three small browser games in HTML, CSS and JavaScript"

#let show-solutions  = true
#let materials       = "Teams"   // where students find the resources and PDFs

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

// ── Import shared styles and components ───────────────────────────────────────
#import "../cs-style.typ": *

// ── Extra components ──────────────────────────────────────────────────────────

// Checkpoint — what students should see before moving on
#let checkpoint(body) = block(
  stroke: (left: 2pt + accent),
  inset: (left: 10pt, right: 0pt, top: 4pt, bottom: 4pt),
  width: 100%,
  [#text(size: 9pt, fill: accent, weight: "bold")[✓ Checkpoint] \ #body],
)

// Two-column reference table in the house style
#let ref-table(head-a, head-b, ..rows) = table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white, head-a),
    text(size: 9pt, weight: "bold", fill: white, head-b),
  ),
  ..rows,
)

// Solution entry — only used in the appendix
#let sol(title, body) = block(width: 100%, breakable: true)[
  #text(size: 10pt, weight: "bold", fill: accent, title)
  #v(0.2em)
  #body
  #v(0.6em)
]

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
  [Read unfamiliar JavaScript and explain what each part does.],
  [Use timers (`setInterval`, `setTimeout`) and events (click, mouse, keyboard) to make a page interactive.],
  [Split a single-file web page into separate HTML, CSS and JavaScript files.],
  [Change existing code on purpose and predict what the change will do.],
)

= How to Work Through This Sheet

You will work through this sheet on your own. There are three games:

#ref-table([Game], [How you get the code],
  [1. Pop the Balloon], [Already split into three files. You *copy* it from this sheet.],
  [2. Tennis], [Printed as a picture in `tennis.pdf`. You *type* it yourself and split it into three files.],
  [3. Catch the Apple], [Printed as a picture in `catch.pdf`. You *type* it yourself and split it into three files.],
)

#v(0.5em)

#steps(
  [Work through the sections *in order*. Each game builds on the one before.],
  [Create a file `answers.md` in your `games` folder. Write your answers to
   all questions there, numbered by exercise (e.g. `## Exercise 3` and
   then `1.`, `2.`, …).],
  [Whenever a question asks "What happens if …?", *write down your
   prediction first*, then try it out. Note whether you were right.],
  [After every change: save, look at the browser, and check that the game
   still works. If it breaks, undo the change (`Ctrl+Z` / `Cmd+Z`) and
   try again.],
  [Only look at the solutions at the end of the sheet *after* you have
   tried an exercise yourself.],
)

= Setup #h(1fr) #tier-core

#exercise(title: "Prepare your folder")[
  #steps(
    [In your CS folder, create a new folder called `games`.],
    [Inside `games`, create a folder called `res` (short for _resources_).],
    [Download the resources zip file from #materials and unzip it.],
    [Move the unzipped images and sounds into your `res` folder. Only
     the files themselves — not the zip, and not an extra folder around them.],
    [Open VS Code and use *File → Open Folder…* to open the `games`
     folder itself. In the Explorer on the left, you should see the `res`
     folder.],
  )

  #checkpoint[Your Explorer looks like this: a folder `GAMES` at the top,
    and inside it a folder `res` containing the image files (for example
    `b1.png`).]
]

= Game 1: Pop the Balloon #h(1fr) #tier-core

A balloon jumps to a new random position every second. Click it before it
moves to score a point. After 20 jumps the game is over.

== Get it running

#exercise(title: "Copy and play")[
  #steps(
    [In your `games` folder, create the three files `pop.html`, `pop.css`
     and `pop.js`.],
    [Copy the code below into the matching files and save all three.],
    [If the indentation looks messy after copying, right-click in the
     file and choose *Format Document*.],
    [Right-click `pop.html` and choose *Open with Live Server*. Play the
     game.],
  )
]

*`pop.html`*
```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="pop.js" defer></script>
    <link rel="stylesheet" href="pop.css" />
    <title>Pop the Balloon</title>
  </head>
  <body>
    <h1 id="scoreBox"></h1>
    <img src="res/b1.png" alt="balloon" id="balloon" />
  </body>
</html>
```

*`pop.css`*
```css
#balloon {
  position: absolute;
  -webkit-transition: all 0.2s;
  transition: all 0.2s;
  height: 160px;
}
```

*`pop.js`*
```js
balloon.addEventListener("click", clickedIt);
let score = 0;
let count = 0;
function clickedIt() {
  score++;
  scoreBox.innerHTML = "score:" + score;
  balloon.style.height = "1px";
}
function moveIt() {
  balloon.style.height = "160px";
  balloon.style.left = Math.random() * 800 + "px";
  balloon.style.top = Math.random() * 600 + "px";
  count++;
  if (count == 20) {
    alert("game over!");
    clearInterval(timer);
  }
}
let timer = setInterval(moveIt, 1000);
```

#checkpoint[A balloon appears and jumps around once per second. When you
  click it, it shrinks and the score at the top goes up. After about 20
  seconds a "game over!" message appears.]

#note("Line numbers", [When a question below mentions a line number, it
  means the line number shown on the left in VS Code. If your file looks
  different from the code above (for example an extra empty line at the
  top), the numbers will not match — fix your file first.])

== New ideas in this game

Read this table carefully. You will need these ideas in all three games.

#ref-table([Code], [What it does],
  [`setInterval(moveIt, 1000)`],
    [Calls the function `moveIt` again and again, every 1000
     milliseconds (= 1 second). It returns a number that identifies this
     timer, which we store in the variable `timer`.],
  [`clearInterval(timer)`],
    [Stops the timer with that number. `moveIt` is no longer called.],
  [`balloon.addEventListener("click", clickedIt)`],
    [Tells the browser: "whenever someone clicks the balloon, call the
     function `clickedIt`." This does the same job as an `onclick`
     attribute in the HTML.],
  [`Math.random() * 800`],
    [A random decimal number between 0 and 800 (see the turtle chapter).],
  [`balloon.style.left = … + "px"`],
    [Changes the CSS property `left` of the balloon. CSS needs a unit,
     so we glue `"px"` onto the number.],
  [`position: absolute;`],
    [In CSS: the element can be placed anywhere on the page using
     `left` and `top`, measured from the top-left corner.],
  [`transition: all 0.2s;`],
    [In CSS: whenever a property changes, the browser animates the change
     over 0.2 seconds instead of jumping instantly. (The `-webkit-` line
     is the same thing for older browsers.)],
  [`defer`],
    [In the `<script>` tag: wait until the whole HTML page has loaded
     before running the script. Otherwise the balloon would not exist yet
     when the script looks for it.],
)

#infobox("Where do the variables balloon and scoreBox come from?", [
  `pop.js` uses `balloon` and `scoreBox` without ever creating them with
  `let` or `const`. This works because browsers automatically create a
  variable for every element that has an `id`. It is a handy shortcut,
  but it is considered bad practice: it is easy to lose track of where a
  variable comes from. The clean way is the one you already know:
  `const balloon = document.getElementById("balloon");`
  You will fix this in Exercise 5.
])

== Investigate

#exercise(title: "Read and explain", breakable: true)[
  Answer in your `answers.md`. Predict before you try anything out.

  + In `pop.html` on line 12: why is the `<h1>` tag empty? Where is its
    content created?
  + Which lines of code do you have to change to make the balloon larger
    or smaller? (There are two places, in two different files.) Try it
    and check that everything still works.
  + Explain in your own words what the function `clickedIt` does.
  + Change the message that appears at the end of the game.
  + What happens if you change the value `1000` to `2000` in `pop.js`?
  + What happens if you change `0.2s` to `6s` in `pop.css`? Does the game
    get easier or harder? Why?
  + How long does one game last? Change the code so the game lasts longer.
  + How does the balloon move around the page? Make the balloon use more
    of the screen. Then change the code so the balloon only appears in
    the bottom-right part of the area (`left` between 400 and 800, `top`
    between 300 and 600).

  #hint[For question 8: `Math.random() * 400` gives numbers between 0 and
    400. What do you need to add to move that range to 400–800?]
]

== Improve the game

#exercise(title: "Show the score from the start")[
  At the beginning of the game the score is not shown at all — it only
  appears after your first click. Add *one line* to `pop.js` so that
  `score:0` is shown as soon as the page loads.
]

#exercise(title: "Use getElementById")[
  #tier-extension #h(0.5em) Add two lines at the top of `pop.js` that
  create the variables `balloon` and `scoreBox` properly with
  `document.getElementById(…)`. The game should work exactly as before.
]

#exercise(title: "Cheaters never win")[
  #tier-challenge #h(0.5em) There are two ways to cheat in this game:

  - Click the balloon several times very quickly while it is shrinking.
  - Keep clicking the (tiny) balloon after "game over!".

  Try both. Then change `clickedIt` so that each balloon can only give
  one point, and so that clicking after the game has ended gives no
  points.

  #hint[After a click, `balloon.style.height` is `"1px"`. An `if` at the
    start of `clickedIt` can check this and stop the function early with
    `return;`. For the second problem: what could you do to the balloon
    when the game ends?]
]

= Splitting a Game into Three Files #h(1fr) #tier-core

The next two games come from a book. In the book, everything is in *one
single HTML file*: the CSS sits inside a `<style>` tag and the JavaScript
inside a `<script>` tag. That works, but it breaks our best practices.
You will type the code yourself and split it into three files, exactly
like the Pop the Balloon game.

#ref-table([In the book], [Where it goes in your project],
  [Everything between `<style>` and `</style>`],
    [Into the `.css` file — *without* the `<style>` tags themselves.],
  [Everything between `<script>` and `</script>`],
    [Into the `.js` file — *without* the `<script>` tags themselves.],
  [`style='…'` written directly on an HTML tag],
    [Give the tag an `id`, then write a CSS rule for that `id` in the
     `.css` file. Remove the `style` attribute from the HTML.],
  [Everything else (the `<div>`s, `<canvas>`, `<img>`, …)],
    [Into the `<body>` of the `.html` file.],
)

#v(0.5em)

Your `.html` file needs a proper document structure with a `<head>`. Use
`pop.html` as a model: it shows how to link the CSS file with `<link>`
and the JavaScript file with `<script src="…" defer>`.

#warnbox("Type it — do not search for a copy", [
  The code for these games is deliberately given as a picture. Typing it
  yourself forces you to read every line, and you will make (and fix)
  typing mistakes — that is exactly how you learn to read code. Copying
  a version from the internet skips the part of the exercise that
  actually matters.
])

== Typing tips

- Type in small chunks. After every few lines, save and check the browser.
- JavaScript is case-sensitive: `getContext` is not the same as
  `getcontext`.
- Every `(` needs a `)`, every `{` needs a `}`, every `"` and `'` needs a
  partner. VS Code highlights the matching bracket when your cursor is
  next to one.
- Follow our best practices while you type: one CSS property per line,
  spaces around operators (`x = x + speedX;` instead of `x=x+speedX;`),
  and correct indentation. You may use `let` instead of `var`.
- If nothing happens, open the browser's *developer console*
  (`F12`, or `Cmd+Option+I` on a Mac, then the *Console* tab). Red error
  messages tell you the file and line number where JavaScript got stuck.

= Game 2: Tennis #h(1fr) #tier-core

Move the mouse left and right to control a blue bat. Keep the bouncing
yellow ball from falling past the bat.

#exercise(title: "Read before you type")[
  Open `tennis.pdf` (#materials). Before typing anything, read the code
  and answer these questions in `answers.md`:

  + Which lines would go into `tennis.css`, which into `tennis.js` and
    which into `tennis.html`?
  + Line 15 contains `onmousemove="moveBat(event)"`. When do you think
    the function `moveBat` is called?
  + The variables `x` and `y` are the position of the ball. What do you
    think `speedX` and `speedY` are?
  + Look at lines 33–35. What happens to the ball when it reaches the
    right, left or top edge?
]

#exercise(title: "Type, split and play")[
  #steps(
    [In your `games` folder, create `tennis.html`, `tennis.css` and
     `tennis.js`.],
    [Type the code from `tennis.pdf` into the correct files, as explained
     in Section 4.],
    [Open `tennis.html` with Live Server and play.],
  )

  #checkpoint[A green board, a blue bat that follows your mouse and a
    yellow ball that bounces off the walls and off the bat. If the ball
    falls past the bat, "game over!" appears.]

  #hint[The `onmousemove="moveBat(event)"` attribute stays on the `<body>`
    tag in the HTML file — it is HTML, not JavaScript.]
]

#exercise(title: "Investigate and modify", breakable: true)[
  + Change the colors of the board, the ball and the bat.
  + What is the starting position of the ball? Where in the code is it
    set?
  + Where does the bat start before you move the mouse?
  + Change the `border-radius` of the ball to a smaller value. What
    happens? Why is `24px` exactly the right value for a round ball?
  + Make the ball move faster.
  + Make the game board larger. Remember that the JavaScript also
    "knows" where the edges of the board are.
  + Add a score: every time the ball hits the bat, the score goes up by
    one and is shown on the page.

  #hint[Question 5: the number `2` appears in several places. If you
    only change it in one place, the ball slows down again after the
    first bounce. How could a variable help here? (Think of the DRY
    principle: don't repeat yourself.)]

  #hint[Question 7: you can reuse a lot from Pop the Balloon. Put the
    `<h1 id="scoreBox">` *after* the three `<div>`s in the HTML, and give
    it `position: absolute;` and a `left` value in CSS so it appears next
    to the board instead of on top of it.]
]

#exercise(title: "Fair play")[
  #tier-challenge #h(0.5em) The bat follows the mouse with its *left
  edge*, not its middle, which feels strange. Change `moveBat` so the
  middle of the bat is under the mouse pointer. Then check whether the
  bat still catches the ball in the right places — the `if` on line 36
  may need adjusting too.
]

= Game 3: Catch the Apple #h(1fr) #tier-extension

Apples fall from the sky. Steer the monster left and right with the
keyboard to catch as many as you can in 30 seconds.

This game draws on a `<canvas>` — an area of the page that JavaScript can
paint on like a picture, instead of moving HTML elements around.

== Before you type

#exercise(title: "Read about the canvas")[
  Read the introduction to the canvas at
  #link("https://www.w3schools.com/html/html5_canvas.asp")[w3schools.com/html/html5_canvas.asp].
  Then open `catch.pdf` (#materials) and find the lines that:

  + get the "drawing context" `ctx`, which you use to paint on the canvas,
  + erase the whole canvas,
  + write the score,
  + draw the apple and the monster.
]

#exercise(title: "Keyboard input")[
  + Read the function `keyPressed`. What does it do?
  + Which keys do you need to press to play? Use the key code table
    below to find out.
  + `setTimeout` on line 39 is similar to `setInterval`, but different in
    one important way. Look it up and explain the difference.
]

#figure(
  image("images/keycodes.png", width: 100%),
  caption: [Key codes. Every key on the keyboard has a number
    (`e.keyCode`). Avoid the colored keys: their numbers differ between
    browsers or keyboards.],
)

== Type, split and play

#exercise(title: "Type, split and play")[
  #steps(
    [Create `catch.html`, `catch.css` and `catch.js` in your `games`
     folder.],
    [Type the code from `catch.pdf` and split it into the three files.],
    [The book loads the images from a website (`https://maxw.com/…`).
     Use the images from your `res` folder instead, for example
     `src="res/apple.png"`.],
    [Open `catch.html` with Live Server and play.],
  )

  #hint[This game has no `<style>` block. Its CSS is written in
    `style='…'` attributes on the two `<div>`s. Give each `<div>` an `id`
    (for example `game-area` and `images`), move the CSS into
    `catch.css`, and delete the `style` attributes.]

  #checkpoint[A blue area with a score in the top-left corner. An apple
    falls from the top; the monster at the bottom moves when you press
    the arrow keys. After 30 seconds, "Game Over!" is written across the
    canvas.]
]

== Investigate and modify

#exercise(title: "Change the game", breakable: true)[
  + Change `dodgerblue` to another color.
  + Make the apple fall faster.
  + Make the monster move faster.
  + Change the code so that each apple is worth 5 points.
  + Make the game work with different keys, for example `A` and `D`.
  + Make the game last 1 minute instead of 30 seconds.
  + Look at `checkForHits`. Explain in your own words when an apple
    counts as "caught". What is the meaning of the number `400`?
]

#exercise(title: "Better controls")[
  #tier-challenge
  #v(0.2em)
  + At the moment the monster never stops moving. Write a function that
    is called when a key is *released* (use `document.onkeyup`) and
    sets the monster's speed to zero.
  + The monster can drive off the edge of the canvas and disappear.
    Add an `if` so that it stops at the left and right edges.
  + `e.keyCode` is an old way of reading keys. Find out what `e.key`
    gives you instead, and rewrite `keyPressed` using `e.key`.
]

= Summary

By the end of this sheet you should have:

#checklist(
  [Three working games in your `games` folder, each split into an `.html`,
   a `.css` and a `.js` file.],
  [Answers to all Core exercises in `answers.md`.],
  [Typed the Tennis code yourself and fixed your own typing mistakes using
   the browser console.],
  [Explained `setInterval`, `clearInterval` and `setTimeout` in your own
   words.],
  [Changed at least one game so that it behaves differently from the
   original.],
)

// ─────────────────────────────────────────────────────────────────────────────
// SOLUTIONS
// ─────────────────────────────────────────────────────────────────────────────

#if show-solutions [
  #pagebreak()
  #text(size: 11pt, weight: "bold", fill: primary, upper[Solutions])
  #v(0.15em)
  #line(length: 100%, stroke: 1pt + accent)
  #v(0.5em)

  Line numbers refer to the files exactly as given in this sheet
  (`pop.*`) or in the PDFs (`tennis.pdf`, `catch.pdf`). In your own split
  files the numbers will be different.

  #sol("Exercise 3 — Pop the Balloon: Read and explain")[
    + It starts empty because there is no score yet. The text is written
      by JavaScript: `pop.js`, line 6 (`scoreBox.innerHTML = …`).
    + `pop.css`, line 5 (`height: 160px;`) sets the starting size, and
      `pop.js`, line 10 sets the size each time the balloon moves. Change
      both to the same value. (Only the height is set; the browser
      scales the width automatically.)
    + It adds 1 to the score, writes the new score into the `<h1>`, and
      shrinks the balloon to 1 px so it "pops".
    + Change the text in `alert(…)` on line 15 of `pop.js`.
    + The balloon only moves every 2 seconds instead of every second. The
      game gets easier and lasts twice as long.
    + Popping and moving now take 6 seconds. The balloon slides slowly
      across the screen instead of jumping, so it is much easier to hit.
    + `moveIt` runs once per second and the game stops when `count`
      reaches 20 (line 14), so it lasts about 20 seconds. Increase the 20
      to make it longer.
    + Lines 11 and 12 choose a random `left` between 0 and 800 px and a
      random `top` between 0 and 600 px. Larger numbers use more of the
      screen. Bottom-right only:
      ```js
      balloon.style.left = Math.random() * 400 + 400 + "px";
      balloon.style.top = Math.random() * 300 + 300 + "px";
      ```
  ]

  #sol("Exercise 4 — Show the score from the start")[
    Add this line, for example after line 3:
    ```js
    scoreBox.innerHTML = "score:" + score;
    ```
  ]

  #sol("Exercise 5 — Use getElementById")[
    ```js
    const balloon = document.getElementById("balloon");
    const scoreBox = document.getElementById("scoreBox");
    ```
  ]

  #sol("Exercise 6 — Cheaters never win")[
    One possible solution: stop early if the balloon is already popped,
    and hide the balloon when the game ends.
    ```js
    function clickedIt() {
      if (balloon.style.height === "1px") {
        return;
      }
      score++;
      scoreBox.innerHTML = "score:" + score;
      balloon.style.height = "1px";
    }
    ```
    and inside the `if (count == 20)` block of `moveIt`:
    ```js
    balloon.style.display = "none";
    ```
  ]

  #sol("Exercise 7 — Tennis: Read before you type")[
    + Lines 4–13 (without the `<style>` tags) → `tennis.css`.
      Lines 21–43 (without the `<script>` tags) → `tennis.js`.
      Lines 15–19 → the `<body>` of `tennis.html`.
    + Every time the mouse moves anywhere on the page.
    + How far the ball moves per step, horizontally (`speedX`) and
      vertically (`speedY`). A negative value means left or up.
    + It bounces: the matching speed is flipped to the opposite direction.
  ]

  #sol("Exercise 8 — Tennis: Type, split and play")[
    `tennis.html`:
    ```html
    <!doctype html>
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <script src="tennis.js" defer></script>
        <link rel="stylesheet" href="tennis.css" />
        <title>Tennis</title>
      </head>
      <body onmousemove="moveBat(event)">
        <div id="board"></div>
        <div id="bat"></div>
        <div id="ball"></div>
      </body>
    </html>
    ```
    `tennis.css` contains the three rules `#board`, `#bat` and `#ball`
    with one property per line; `tennis.js` contains lines 21–43.
  ]

  #sol("Exercise 9 — Tennis: Investigate and modify")[
    + Change the `background-color` values in `tennis.css`.
    + At `x = 100`, `y = 100` (line 21).
    + 420 px from the top (CSS `top: 420px`) at the left edge of the page,
      because no `left` value is set until the mouse moves.
    + The corners become less rounded and the ball looks like a square
      with rounded corners. A radius of half the width (48 / 2 = 24)
      makes a perfect circle.
    + The `2` appears on lines 21 and 33–36. Change all of them — or better,
      create a variable such as `let speed = 4;` and use `speed` and
      `-speed` everywhere. Making the interval on line 43 shorter (e.g.
      `5` instead of `10`) also speeds up the game.
    + Change `width` and `height` of `#board` in the CSS, then adjust the
      matching numbers in JavaScript: `530` (right edge), `372` and the
      bat's `top: 420px` (bat height), and `450` (bottom edge).
    + Add `let score = 0;` at the top of `tennis.js`, an
      `<h1 id="scoreBox"></h1>` to the HTML (styled with
      `position: absolute; left: 580px;`), and change line 36 to:
      ```js
      if (y > 372 && Math.abs(batX - x) < 60) {
        speedY = -2;
        score++;
        scoreBox.innerHTML = "score:" + score;
      }
      ```
  ]

  #sol("Exercise 10 — Tennis: Fair play")[
    The bat is 80 px wide, so shift it left by 40 px:
    ```js
    bat.style.left = batX - 40 + "px";
    ```
    Now `batX` is the middle of the bat. The middle of the ball is at
    `x + 24`, so a hit means the two middles are less than
    40 + 24 = 64 px apart:
    ```js
    if (y > 372 && Math.abs(batX - (x + 24)) < 64) { … }
    ```
  ]

  #sol("Exercise 11 — Catch: Read about the canvas")[
    + Line 11: `ctx = gameCanvas.getContext("2d")`.
    + Line 16: `ctx.clearRect(0, 0, 640, 480)`.
    + Lines 17–18: set the font, then `ctx.fillText(…)`.
    + Line 19 (apple) and line 22 (monster): `ctx.drawImage(…)`.
  ]

  #sol("Exercise 12 — Catch: Keyboard input")[
    + Whenever a key is pressed, it reads the key's number. If it is the
      left arrow, the monster starts moving left (`changeX = -2`); if it
      is the right arrow, it starts moving right (`changeX = 2`).
    + Left arrow (37) and right arrow (39).
    + `setInterval` calls a function again and again; `setTimeout` calls
      it *once*, after the given time (here: after 30 000 ms = 30 s).
  ]

  #sol("Exercise 13 — Catch: Type, split and play")[
    The `<body>` of `catch.html` contains the two `<div>`s with ids
    instead of `style` attributes, and `catch.css` contains:
    ```css
    #game-area {
      background-color: dodgerblue;
      width: 640px;
    }

    #images {
      display: none;
    }
    ```
    The images are hidden because they are only needed as "stamps" for
    `drawImage` — they should not appear on the page themselves.
  ]

  #sol("Exercise 14 — Catch: Change the game")[
    + In `catch.css`.
    + Line 20: increase the `3` in `y += 3`.
    + Lines 29 and 30: use larger values, e.g. `-5` and `5`.
    + Line 35: `score += 5;`
    + Use 65 (`A`) and 68 (`D`) instead of 37 and 39 on lines 29 and 30.
    + Line 39: `setTimeout(gameOver, 60000);`
    + The monster is always drawn at `y = 400`. An apple counts as
      caught when it is less than 60 px away from the monster both
      vertically (`Math.abs(400 - y) < 60`) and horizontally
      (`Math.abs(monsterX - x) < 60`). The apple then jumps back to the
      top at a random position.
  ]

  #sol("Exercise 15 — Catch: Better controls")[
    ```js
    document.onkeyup = keyReleased;
    function keyReleased(e) {
      changeX = 0;
    }
    ```
    Keep the monster on the canvas (canvas width 640, monster width 80),
    for example in `mainLoop` after `monsterX += changeX;`:
    ```js
    if (monsterX < 0) {
      monsterX = 0;
    }
    if (monsterX > 560) {
      monsterX = 560;
    }
    ```
    With `e.key` the keys are named instead of numbered:
    ```js
    function keyPressed(e) {
      if (e.key === "ArrowLeft") {
        changeX = -2;
      }
      if (e.key === "ArrowRight") {
        changeX = 2;
      }
    }
    ```
  ]
]
