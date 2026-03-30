// ─────────────────────────────────────────────────────────────────────────────
// Lesson 8 — JavaScript II
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "High School"
#let term            = "[Term / Year]"
#let lesson-title    = "JavaScript II"
#let lesson-subtitle = "Functions, conditions, and loops"

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
  [Write functions that accept parameters and return values.],
  [Use `if`/`else` to make decisions in code.],
  [Use `for` and `while` loops to repeat actions.],
  [Build a simple interactive quiz using all three concepts.],
)

= Functions with Parameters and Return Values

In Lesson 5 you wrote functions that took no input and changed the page
directly. Functions become much more powerful when they can accept
*parameters* — values passed in when the function is called — and
*return* a result back to the caller.

== Parameters

A parameter is a variable that receives a value when the function is
called. You declare parameters inside the parentheses of the function:

```js
function greet(name) {
  const message = document.getElementById("output");
  message.textContent = "Hello, " + name + "!";
}
```

To call this function and pass a value:

```js
greet("Anna");    // displays: Hello, Anna!
greet("Ben");     // displays: Hello, Ben!
```

The same function now works for any name. Without parameters, you would
need a separate function for each person.

You can have multiple parameters, separated by commas:

```js
function add(a, b) {
  console.log(a + b);
}

add(3, 5);   // prints 8 to the console
add(10, 2);  // prints 12
```

== Return values

A function can send a value *back* to whoever called it using `return`:

```js
function multiply(a, b) {
  return a * b;
}

const result = multiply(4, 6);
console.log(result);   // 24
```

`return` does two things: it sends the value back, and it immediately
stops the function. Any code after `return` in the same function does
not run.

Return values are useful when you want to *compute* something and use
the result elsewhere, rather than changing the page directly inside
the function.

#infobox(
  "Separation of concerns in functions",
  [A function that computes something and returns a result is easier
   to reuse and test than one that computes *and* updates the page at
   the same time. A common pattern is to write one function that
   calculates a result, and another that uses that result to update
   the DOM. This keeps each function focused on a single job.],
)

= Conditionals: if / else

A conditional runs different code depending on whether a condition is
true or false. You have already seen a simple version of this in the
show/hide toggle. Here is the full structure:

```js
if (condition) {
  // runs if condition is true
} else {
  // runs if condition is false
}
```

The condition is any expression that evaluates to `true` or `false`.
Common comparisons:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Operator],
    text(size: 9pt, weight: "bold", fill: white)[Meaning],
  ),
  [`===`], [Strictly equal — same value *and* same type.],
  [`!==`], [Not equal.],
  [`>`],   [Greater than.],
  [`<`],   [Less than.],
  [`>=`],  [Greater than or equal to.],
  [`<=`],  [Less than or equal to.],
)

#warnbox(
  "⚠ Use === not ==",
  [JavaScript has two equality operators: `==` and `===`. Always use
   `===`. The double-equals version does automatic type conversion and
   can produce surprising results — for example, `"5" == 5` is `true`
   in JavaScript. `===` requires both the value and the type to match,
   which is almost always what you want.],
)

== Example: checking an answer

```js
function checkAnswer(userAnswer, correctAnswer) {
  if (userAnswer === correctAnswer) {
    return true;
  } else {
    return false;
  }
}
```

This can be simplified — since the condition itself is already `true`
or `false`, you can return it directly:

```js
function checkAnswer(userAnswer, correctAnswer) {
  return userAnswer === correctAnswer;
}
```

== else if

For more than two possibilities, chain `else if`:

```js
function grade(score) {
  if (score >= 90) {
    return "Excellent";
  } else if (score >= 70) {
    return "Good";
  } else if (score >= 50) {
    return "Pass";
  } else {
    return "Not yet";
  }
}
```

The conditions are checked in order. The first one that is true runs,
and the rest are skipped.

= Loops

A loop repeats a block of code multiple times. Instead of writing the
same code ten times, you write it once and tell JavaScript how many
times to run it.

== The for loop

A `for` loop runs a set number of times. It has three parts: an
initializer, a condition, and an updater:

```js
for (let i = 0; i < 5; i++) {
  console.log(i);
}
// prints: 0, 1, 2, 3, 4
```

- `let i = 0` — creates a counter variable starting at 0.
- `i < 5` — the loop keeps running as long as this is true.
- `i++` — adds 1 to `i` after each iteration (`i++` is shorthand
  for `i = i + 1`).

A common use is looping through an array — a list of values:

```js
const colors = ["red", "green", "blue"];

for (let i = 0; i < colors.length; i++) {
  console.log(colors[i]);
}
// prints: red, green, blue
```

`colors.length` gives the number of items in the array. `colors[i]`
accesses the item at position `i` (arrays are zero-indexed — the
first item is at position 0).

== The while loop

A `while` loop keeps running as long as its condition is true. Use it
when you do not know in advance how many times you need to loop:

```js
let attempts = 0;

while (attempts < 3) {
  console.log("Attempt " + (attempts + 1));
  attempts++;
}
```

#warnbox(
  "⚠ Infinite loops",
  [If the condition of a `while` loop never becomes false, the loop
   runs forever and freezes the browser. Always make sure something
   inside the loop moves it towards the exit condition. If your page
   freezes, an infinite loop is the likely cause — close the tab and
   check your code.],
)

= A Worked Example: Simple Quiz

We will now build a three-question quiz that uses everything from this
lesson. The complete code is shown below, followed by a line-by-line
explanation.

== The HTML

```html
<div id="quiz">
  <div id="question-box">
    <p id="question-text"></p>
    <input type="text" id="answer-input"
           placeholder="Type your answer here">
    <button onclick="submitAnswer()">Submit</button>
    <p id="feedback"></p>
  </div>
  <div id="result-box" style="display: none">
    <p id="final-score"></p>
    <button onclick="restartQuiz()">Try again</button>
  </div>
</div>
```

== The JavaScript

```js
const questions = [
  { question: "What language structures a webpage?", answer: "html" },
  { question: "What language styles a webpage?",     answer: "css"  },
  { question: "What language adds interactivity?",   answer: "javascript" },
];

let currentQuestion = 0;
let score = 0;

function loadQuestion() {
  const q = questions[currentQuestion];
  document.getElementById("question-text").textContent = q.question;
  document.getElementById("answer-input").value = "";
  document.getElementById("feedback").textContent = "";
}

function submitAnswer() {
  const input = document.getElementById("answer-input");
  const userAnswer = input.value.toLowerCase().trim();
  const correctAnswer = questions[currentQuestion].answer;

  if (checkAnswer(userAnswer, correctAnswer)) {
    score++;
    document.getElementById("feedback").textContent = "Correct!";
  } else {
    document.getElementById("feedback").textContent =
      "Not quite. The answer was: " + correctAnswer;
  }

  currentQuestion++;

  if (currentQuestion < questions.length) {
    setTimeout(loadQuestion, 1200);
  } else {
    setTimeout(showResult, 1200);
  }
}

function checkAnswer(userAnswer, correctAnswer) {
  return userAnswer === correctAnswer;
}

function showResult() {
  document.getElementById("question-box").style.display = "none";
  document.getElementById("result-box").style.display = "block";
  document.getElementById("final-score").textContent =
    "You scored " + score + " out of " + questions.length + ".";
}

function restartQuiz() {
  currentQuestion = 0;
  score = 0;
  document.getElementById("question-box").style.display = "block";
  document.getElementById("result-box").style.display = "none";
  loadQuestion();
}

loadQuestion();
```

== How it works

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Concept],
    text(size: 9pt, weight: "bold", fill: white)[Where it appears],
  ),
  [Array],
    [`questions` is an array of objects. Each object has a `question`
     and an `answer` property.],
  [Parameters],
    [`checkAnswer(userAnswer, correctAnswer)` takes two values and
     returns `true` or `false`.],
  [Conditionals],
    [`if (checkAnswer(...))` runs different code based on whether
     the answer is correct. A second `if` decides whether to load
     the next question or show the final score.],
  [`.toLowerCase().trim()`],
    [Makes the comparison case-insensitive and removes accidental
     spaces — so "HTML", "html", and " html " all match.],
  [`setTimeout`],
    [Waits 1200 milliseconds (1.2 seconds) before moving to the next
     question, giving the student time to read the feedback.],
  [`loadQuestion()`],
    [Called once at the end of the script to display the first
     question as soon as the page loads.],
)

#infobox(
  "Objects and arrays",
  [An *array* is an ordered list: `["red", "green", "blue"]`. An
   *object* is a collection of named properties:
   `{ question: "...", answer: "..." }`. Together they are the
   foundation of how data is structured in JavaScript. You will use
   both constantly as you go further.],
)

= Adapting the Quiz for Your Project

The quiz above is a starting point, not a finished product. For your
project, adapt it to fit your page:

- Change the questions to match your topic.
- Add more questions — the code handles any number automatically
  because it uses `questions.length` rather than a hardcoded number.
- Style the quiz with CSS to match your page's visual design.
- Consider showing a different message depending on the score — use
  `else if` to give different feedback for different score ranges.

Once your quiz is working, commit it with a clear message and push.

= Summary

By the end of this lesson you should have:

#checklist(
  [Written at least one function that accepts parameters.],
  [Written at least one function that returns a value.],
  [Used `if`/`else` to branch based on a condition.],
  [Used a `for` or `while` loop in your code.],
  [Built a working quiz or interactive feature in your cs-intro repo.],
  [Committed and pushed your changes with clear commit messages.],
)
