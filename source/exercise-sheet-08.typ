// ─────────────────────────────────────────────────────────────────────────────
// Exercise Sheet — Lesson 8: JavaScript II
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-num = "8"
#let sheet-type = "Exercise Sheet"
#let sheet-title = "JavaScript II"

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
  #text(weight: "bold")[1. What does `return` do inside a function?]

  #mc-option("A", [It stops the function and sends a value back to the caller.])
  #mc-option("B", [It restarts the function from the beginning.])
  #mc-option("C", [It prints a value to the console.])
  #mc-option("D", [It only works inside loops.])

  #v(0.5em)
  #text(weight: "bold")[2. In `function add(a, b) { return a + b; }`, what are `a` and `b` called?]

  #mc-option("A", [Return values])
  #mc-option("B", [Parameters])
  #mc-option("C", [Loops])
  #mc-option("D", [Conditions])

  #v(0.5em)
  #text(weight: "bold")[3. Why should you use `===` instead of `==` in JavaScript?]

  #mc-option("A", [`===` is shorter to type.])
  #mc-option("B", [`==` does automatic type conversion and can give surprising results.])
  #mc-option("C", [`==` does not exist in JavaScript.])
  #mc-option("D", [There is no real difference.])

  #v(0.5em)
  #text(weight: "bold")[4. What happens if the condition of a `while` loop never becomes false?]

  #mc-option("A", [The loop runs exactly once.])
  #mc-option("B", [JavaScript automatically stops it after 100 iterations.])
  #mc-option("C", [The loop runs forever and can freeze the browser.])
  #mc-option("D", [Nothing — `while` loops cannot have this problem.])

  #v(0.5em)
  #text(weight: "bold")[5. In `for (let i = 0; i < 5; i++)`, what does `i++` do?]

  #mc-option("A", [Checks whether `i` is less than 5.])
  #mc-option("B", [Sets `i` back to 0.])
  #mc-option("C", [Adds 1 to `i` after each loop iteration.])
  #mc-option("D", [Stops the loop immediately.])

  #v(0.5em)
  #text(weight: "bold")[6. What does `array.length` give you?]

  #mc-option("A", [The last item in the array.])
  #mc-option("B", [The number of items in the array.])
  #mc-option("C", [The type of the array.])
  #mc-option("D", [Whether the array is empty (true/false).])
]

#block(breakable: false)[
= Part 2 — Functions #h(1fr) #tier-core

#exercise(title: "Trace the output")[
  For each function call, write down exactly what value is returned or
  printed. Assume each function is defined as shown.

  ```js
  function double(n) {
    return n * 2;
  }

  function shout(word) {
    return word.toUpperCase() + "!";
  }
  ```

  #v(0.3em)
  #text(weight: "bold")[a)] `double(6)` #h(1fr) returns:
  #answer-space(lines: 1)

  #text(weight: "bold")[b)] `double(double(3))` #h(1fr) returns:
  #answer-space(lines: 1)

  #text(weight: "bold")[c)] `shout("hello")` #h(1fr) returns:
  #answer-space(lines: 1)
]
]

#exercise(title: "Write a function", points: 3)[
  Write a function called `isEven` that takes one number as a parameter
  and returns `true` if it is even, and `false` otherwise.

  #hint[A number is even if `number % 2 === 0`. The `%` operator gives
    the remainder of a division.]

  #answer-space(lines: 5)
]

#block(breakable: false)[
= Part 3 — Conditionals #h(1fr) #tier-core

#exercise(title: "Trace the branches")[
  Given this function:

  ```js
  function classify(temp) {
    if (temp < 0) {
      return "freezing";
    } else if (temp < 15) {
      return "cold";
    } else if (temp < 25) {
      return "mild";
    } else {
      return "hot";
    }
  }
  ```

  What does each call return?

  #v(0.3em)
  #text(weight: "bold")[a)] `classify(-5)` #h(1fr)
  #answer-space(lines: 1)

  #text(weight: "bold")[b)] `classify(18)` #h(1fr)
  #answer-space(lines: 1)

  #text(weight: "bold")[c)] `classify(25)` #h(1fr)
  #answer-space(lines: 1)

  #hint[Look carefully at whether the comparison uses `<` or `<=` for
    the boundary case in part c).]
]
]

#block(breakable: false)[
= Part 4 — Loops #h(1fr) #tier-extension

#exercise(title: "Fill in the blank")[
  Complete this loop so it prints the numbers 1 to 5 (not 0 to 4).

  #fitb[
    for (let i = #blank(width: 3em); i #blank(width: 4em) 5; i++) \{ \
    #h(2em) console.log(i); \
    \}
  ]
]
]

#exercise(title: "What does this loop do?", points: 3)[
  ```js
  const names = ["Anna", "Ben", "Cem"];
  let result = "";

  for (let i = 0; i < names.length; i++) {
    result = result + names[i] + " ";
  }
  ```

  #text(weight: "bold")[a)] What is the value of `result` after this
  loop finishes? #answer-space(lines: 1)

  #text(weight: "bold")[b)] What would change if `i < names.length` was
  written as `i <= names.length` instead? #answer-space(lines: 2)
]

#block(breakable: false)[
= Part 5 — Putting It Together #h(1fr) #tier-extension

#exercise(title: "Spot the bug", points: 4)[
  This function is supposed to check three answers and return how many
  were correct, but it always returns `0`. Find the bug and explain the
  fix.

  ```js
  function countCorrect(answers, correct) {
    let score = 0;
    for (let i = 0; i < answers.length; i++) {
      if (answers[i] = correct[i]) {
        score++;
      }
    }
    return score;
  }
  ```

  #answer-space(lines: 4)

  #hint[Compare this line very closely to how you check equality
    elsewhere in your own code.]
]
]

#block(breakable: false)[
= Part 6 — Build It #h(1fr) #tier-challenge

This part is completed on your computer, in your cs-intro repository.

== The task

Extend the quiz from the lesson notes (or build your own from scratch)
so it does at least *two* of the following:

#steps(
  [Add at least two more questions to the `questions` array — the code
   should handle this automatically since it uses `questions.length`.],
  [Use `else if` to show a different final message depending on the
   score (e.g. "Perfect!", "Good job", "Keep practicing").],
  [Add a function with a parameter that computes something — for
   example, a `percentage(score, total)` function that returns the
   score as a percentage, used when displaying the result.],
  [Style the quiz with CSS so it visually fits the rest of your page.],
)

#note(
  "Document what you built",
  [Add a `[JS]` tagged entry to your `JOURNAL.md` describing which of
   these you added and how you adapted the code from the lesson notes
   to fit your own quiz topic.],
)
]
