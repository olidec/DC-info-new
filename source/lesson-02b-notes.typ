// ─────────────────────────────────────────────────────────────────────────────
// Lesson 2b — Learning to Help Yourself
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "High School"
#let term            = "[Term / Year]"
#let lesson-title    = "Learning to Help Yourself"
#let lesson-subtitle = "Finding answers independently"

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
  [Know where to look when you are stuck on a problem.],
  [Use VS Code's autocomplete to write code more efficiently.],
  [Find and read official documentation independently.],
  [Search effectively for examples and solutions online.],
  [Use AI assistants as a learning tool, not a shortcut.],
)

= Why This Matters

From the next lesson onwards, you will be building things. You will
get stuck. Something will not work and you will not know why. This is
not a sign that you are bad at programming — it is what programming
actually feels like, for everyone, at every level.

The difference between a student who makes progress and one who does
not is usually not intelligence. It is knowing where to look and being
willing to try things. This lesson is about building that habit.

#infobox(
  "A professional developer's typical day",
  [A working software developer spends a significant part of every day
   looking things up — in documentation, in old code, on forums, in
   their editor's autocomplete suggestions. Nobody memorises everything.
   The skill is knowing how to find what you need quickly and evaluate
   whether it is correct.],
)

= Trial and Error

The most underrated tool in programming is simply trying things. If you
are not sure whether something will work, try it. Save the file, refresh
the browser, and see what happens. You cannot break anything permanently —
and if something goes wrong, Git means you can always go back.

A few habits that make trial and error productive:

- *Change one thing at a time.* If you change three things at once and
  something breaks, you will not know which change caused it.
- *Look at the result carefully.* A broken page often tells you something
  if you look closely — an element in the wrong place, a missing image,
  an unexpected colour.
- *Read error messages.* Browsers, terminals, and editors all produce
  error messages. They can be cryptic at first, but they usually point
  to the right file and line number. Develop the habit of reading them
  rather than ignoring them.
- *Commit before experimenting.* If you are about to try something
  uncertain, make a commit first. Then you can experiment freely without
  fear of losing work you were happy with.

= VS Code Autocomplete and Emmet

VS Code watches what you type and offers suggestions. You have probably
already noticed this. These suggestions come from two sources:

*Autocomplete* is VS Code's built-in knowledge of the language you are
writing in. When you start typing an HTML tag, it will offer to complete
it. When you open a tag, it will often insert the matching closing tag
automatically. Use these suggestions — press Tab or Enter to accept them.

*Emmet* is a shorthand system built into VS Code for writing HTML (and
CSS) quickly. You type an abbreviation and press Tab, and VS Code expands
it into full markup. Here are a few useful ones:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[You type],
    text(size: 9pt, weight: "bold", fill: white)[VS Code produces],
  ),
  [`!`],
    [A complete valid HTML document skeleton — the entire boilerplate in
     one keystroke.],
  [`p`],         [`<p></p>` with the cursor placed between the tags.],
  [`h1`],        [`<h1></h1>`],
  [`ul>li*3`],   [A `<ul>` with three `<li>` elements inside.],
  [`div.intro`], [`<div class="intro"></div>` — useful once we reach CSS.],
)

#infobox(
  "How to trigger Emmet",
  [Type the abbreviation in an `.html` file, then press Tab. If nothing
   happens, make sure the file is saved with the `.html` extension and
   that you are not inside an existing tag. You can also press
   Ctrl+Space (Windows) or ⌘+Space (macOS) to open the suggestion list
   manually.],
)

= Reading Official Documentation

When you want to know exactly what an HTML element or CSS property does —
what attributes it accepts, what values are valid, how browsers handle
edge cases — the best source is *official documentation*.

There are two main references for web development:

== MDN Web Docs

*MDN Web Docs* (#link("https://developer.mozilla.org")) is maintained by
Mozilla and is considered the authoritative reference for HTML, CSS, and
JavaScript. It is detailed, accurate, and kept up to date. Every element,
attribute, and property has its own page with a description, syntax,
examples, and a note on browser compatibility.

MDN can feel dense at first. You do not need to read every word — learn
to scan for the parts you need: the syntax section and the examples are
usually enough.

== W3Schools

*W3Schools* (#link("https://www.w3schools.com")) is a tutorial site rather
than a reference. Its pages are shorter, more approachable, and include
interactive "try it yourself" examples that let you edit code and see the
result immediately. This makes it a good place to start when you encounter
something completely new.

The tradeoff is that W3Schools occasionally simplifies things or uses
slightly outdated practices. It is excellent for learning; for precise
technical details, check MDN.

#infobox(
  "A practical approach",
  [Use W3Schools when you encounter something new and want a quick,
   readable introduction. Use MDN when you need to know the exact
   behaviour of something — especially when something is not working
   as expected.],
)

= Searching for Solutions Online

When you have a specific problem — "my image is not showing up", "my
link does not work", "how do I make text bold in CSS" — a web search
will almost always find a relevant answer quickly.

== How to search effectively

The quality of what you find depends heavily on how you phrase the search.
A few principles:

- *Be specific.* "HTML image not showing" is better than "my page is
  broken". "HTML anchor link same page" is better than "HTML links".
- *Include the technology.* Always mention HTML, CSS, or JavaScript so
  you do not get results for unrelated languages.
- *Add "example" or "tutorial" if you want to learn.* Add "fix" or
  "not working" if you have a specific problem.

== Evaluating what you find

Not everything on the internet is correct or current. Web development
has changed a lot over the years and some tutorials teach outdated
practices. When you find a solution, ask yourself:

- Is this source reputable? (MDN, Stack Overflow, official framework
  docs are generally trustworthy. Random blogs less so.)
- When was this written? HTML and CSS advice from 2010 may not reflect
  how things are done today.
- Do I actually understand what this code does? If you cannot explain
  it, do not use it.

= Using AI Assistants

AI tools such as ChatGPT, GitHub Copilot, and others can be genuinely
useful when learning to code. They can explain concepts, suggest code,
point out errors, and answer follow-up questions in a conversational way
that documentation cannot. You are encouraged to use them.

However, there are important things to understand about how to use them
well.

== What AI assistants are good at

- Explaining what a piece of code does in plain language.
- Suggesting how to approach a problem.
- Pointing out syntax errors and explaining why they are wrong.
- Giving examples of how a specific element or property is used.
- Answering "how do I..." questions quickly.

== What to watch out for

*AI assistants make mistakes.* They can produce code that looks correct
but does not work, uses outdated techniques, or solves a slightly
different problem than the one you asked about. Always test the code
yourself and make sure you understand what it does before using it.

*Copy-paste without understanding is counterproductive.* If you paste
code you do not understand into your project, you will not be able to
maintain it, extend it, or explain it. More importantly, during your
Technical Discussion at the end of the course, you may be asked to
explain any part of your code in detail — including code that came from
an AI. If you cannot explain it, that is a problem.

*The goal is to learn.* Using an AI to avoid thinking is using it
wrong. Using an AI to check your understanding, get unstuck, or go
deeper on something you are curious about is using it right.

#infobox(
  "A useful question to ask an AI",
  [Instead of "write me the HTML for a navigation bar", try "I wrote
   this HTML for a navigation bar — can you explain what each part does
   and whether there is anything I should change?" This way you stay in
   control of your own learning.],
)

== Documenting AI use

Whenever you use an AI assistant to help with your project work, you
must document it in your `JOURNAL.md`. Note what you asked, what it
suggested, and — crucially — how you adapted or verified the result.
This is not a rule designed to catch you out. It is a habit that will
make you a better developer: reflecting on where your code came from
and whether you truly understand it.

= A Decision Tree for When You Are Stuck

The next time you do not know how to do something or something is not
working, work through these steps in order:

#steps(
  [*Try something.* Make a guess, apply it, and see what happens.
   You learn more from a failed attempt than from doing nothing.],
  [*Read the error message* (if there is one). Copy it into a search
   engine if you do not understand it.],
  [*Check the lesson notes* for this course. The answer may already
   be there.],
  [*Search online.* Use specific terms. Look at MDN or W3Schools first.],
  [*Ask an AI assistant.* Describe your problem clearly. Read and
   understand the response before applying it.],
  [*Ask a classmate.* Explaining a problem to someone else often reveals
   the solution.],
  [*Ask the teacher.* Always available — but try the steps above first.
   Being able to describe what you have already tried makes the
   conversation much more productive.],
)

= Summary

#checklist(
  [Understand that getting stuck is normal and expected.],
  [Know how to use VS Code autocomplete and at least one Emmet abbreviation.],
  [Know the difference between MDN Web Docs and W3Schools and when to use each.],
  [Can formulate a specific, effective web search for a coding problem.],
  [Understand how to use AI assistants as a learning tool rather than a shortcut.],
  [Know to document AI use in `JOURNAL.md`.],
)
