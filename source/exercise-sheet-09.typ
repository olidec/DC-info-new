// ─────────────────────────────────────────────────────────────────────────────
// Exercise Sheet — Lesson 9: Data and Binary Numbers
//
// The answer key on the last pages is included by default so students can
// check their own work. To compile a version without it:
//   typst compile source/exercise-sheet-09.typ pdf/exercise-sheet-09-no-answers.pdf --root . --input answers=false
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-num = "9"
#let sheet-type = "Exercise Sheet"
#let sheet-title = "Data and Binary Numbers"

#let show-answers = sys.inputs.at("answers", default: "true") != "false"

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

// Two-column grid of short conversion tasks
#let tasks(..items) = grid(
  columns: (1fr, 1fr),
  column-gutter: 16pt,
  row-gutter: 1.1em,
  ..items.pos(),
)

// Standard table look
#let stdtable(columns, header, ..cells) = table(
  columns: columns,
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  align: center,
  table.header(..header.map(h => text(size: 9pt, weight: "bold", fill: white, h))),
  ..cells,
)

// Table with visible cells to write in
#let writetable(columns, header, ..cells) = table(
  columns: columns,
  stroke: 0.5pt + rgb("#CCCCCC"),
  inset: 8pt,
  align: center,
  table.header(..header.map(h => text(size: 9pt, weight: "bold", h))),
  ..cells,
)

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

#{
  text(size: 18pt, weight: "bold", fill: primary)[#sheet-title]
  v(0.1em)
  text(size: 11pt, fill: muted)[#sheet-type — Lesson #lesson-num]
  v(0.3em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.8em)
}

#tier-legend

#v(0.5em)

#note(
  "How to use this sheet",
  [Work by hand first. Check every conversion by converting it back.
   The answers are at the end of the sheet. Only look them up once you
   have finished a whole exercise, and mark what you got wrong so you
   know what to practice before the test.],
)

= Part 1 — Concepts #h(1fr) #tier-core

#exercise(title: "Multiple choice", breakable: true)[
  Circle the letter of the correct answer.

  #v(0.4em)
  #text(weight: "bold")[1. Why do computers use binary?]

  #mc-option("A", [Binary uses less electricity than any other number system.])
  #mc-option("B", [Two states can be told apart reliably, even when the signal is weak or noisy.])
  #mc-option("C", [Binary numbers are shorter than decimal numbers.])
  #mc-option("D", [The first programmers did not know the decimal system.])

  #v(0.5em)
  #text(weight: "bold")[2. How many different patterns can you form with 4 bits?]

  #mc-option("A", [4])
  #mc-option("B", [8])
  #mc-option("C", [32])
  #mc-option("D", [16])

  #v(0.5em)
  #text(weight: "bold")[3. A computer has stored the byte `01000001`. What does it mean?]

  #mc-option("A", [It always means the number 65.])
  #mc-option("B", [It always means the letter A.])
  #mc-option("C", [That depends on how the data is interpreted.])
  #mc-option("D", [Nothing. A byte always needs 16 bits.])

  #v(0.5em)
  #text(weight: "bold")[4. How many bits are in one byte?]

  #mc-option("A", [8])
  #mc-option("B", [10])
  #mc-option("C", [2])
  #mc-option("D", [4])

  #v(0.5em)
  #text(weight: "bold")[5. What is the largest number you can store with 8 bits?]

  #mc-option("A", [256])
  #mc-option("B", [255])
  #mc-option("C", [128])
  #mc-option("D", [8])
]

#exercise(title: "Data and information")[
  A thermometer in the classroom records the temperature every hour.
  The stored values are `19, 20, 21, 27, 21`.

  #text(weight: "bold")[a)] What is the data here?
  #answer-space(lines: 1)

  #text(weight: "bold")[b)] Write down one piece of information a person could
  get from this data.
  #answer-space(lines: 2)

  #text(weight: "bold")[c)] Give one reason why the same data could lead
  two people to different conclusions.
  #answer-space(lines: 2)
]

#block(breakable: false)[
= Part 2 — Binary to Decimal #h(1fr) #tier-core

#exercise(title: "Convert to decimal")[
  Convert each binary number to decimal. Show your working for at least
  the last three.

  #v(0.4em)
  #tasks(
    [*a)* $101_2$ = #blank(width: 5em)],
    [*b)* $1101_2$ = #blank(width: 5em)],
    [*c)* $10000_2$ = #blank(width: 5em)],
    [*d)* $11111_2$ = #blank(width: 5em)],
    [*e)* $101010_2$ = #blank(width: 5em)],
    [*f)* $1100100_2$ = #blank(width: 5em)],
    [*g)* $10000000_2$ = #blank(width: 5em)],
    [*h)* $11111111_2$ = #blank(width: 5em)],
    [*i)* $10110111_2$ = #blank(width: 5em)],
    [*j)* $1111101000_2$ = #blank(width: 5em)],
  )
  #answer-space(lines: 4)
]
]

#block(breakable: false)[
= Part 3 — Decimal to Binary #h(1fr) #tier-core

#exercise(title: "Convert to binary")[
  Convert each decimal number to binary. Use either method from the
  lesson notes, and check each answer by converting it back.

  #v(0.4em)
  #tasks(
    [*a)* 6 = #blank(width: 8em)],
    [*b)* 9 = #blank(width: 8em)],
    [*c)* 17 = #blank(width: 8em)],
    [*d)* 25 = #blank(width: 8em)],
    [*e)* 50 = #blank(width: 8em)],
    [*f)* 64 = #blank(width: 8em)],
    [*g)* 99 = #blank(width: 8em)],
    [*h)* 127 = #blank(width: 8em)],
    [*i)* 200 = #blank(width: 8em)],
    [*j)* 2026 = #blank(width: 8em)],
  )
  #answer-space(lines: 6)

  #hint[For j), start with the largest power of 2 that fits into 2026.
    $2^10 = 1024$, $2^11 = 2048$.]
]
]

#block(breakable: false)[
= Part 4 — Counting and Fixed Width #h(1fr) #tier-core

#exercise(title: "Count in binary")[
  Complete the table. Use 4 bits for every number.

  #v(0.4em)
  #align(center,
    writetable(
      (auto,) * 9,
      ([Decimal], [0], [1], [2], [3], [4], [5], [6], [7]),
      [Binary], [0000], [0001], [], [], [], [], [], [],
    )
  )
  #v(0.4em)
  #align(center,
    writetable(
      (auto,) * 9,
      ([Decimal], [8], [9], [10], [11], [12], [13], [14], [15]),
      [Binary], [], [], [], [], [], [], [], [],
    )
  )
]
]

#exercise(title: "How much fits?")[
  #text(weight: "bold")[a)] Complete the table.

  #v(0.3em)
  #align(center,
    writetable(
      (auto, 6em, 6em, 6em, 6em, 6em),
      ([Number of bits], [1], [4], [6], [8], [16]),
      [Number of patterns], [], [], [], [], [],
      [Largest number], [], [], [], [], [],
    )
  )

  #v(0.5em)
  #text(weight: "bold")[b)] Write each number as an 8-bit binary number.

  #v(0.3em)
  #tasks(
    [5 = #blank(width: 9em)],
    [19 = #blank(width: 9em)],
    [100 = #blank(width: 9em)],
    [255 = #blank(width: 9em)],
  )

  #v(0.5em)
  #text(weight: "bold")[c)] Which of these numbers can be stored with
  6 bits: 13, 40, 63, 64, 100? Write those that fit as 6-bit binary
  numbers. For the others, explain why they do not fit.
  #answer-space(lines: 3)
]

#block(breakable: false)[
= Part 5 — Patterns #h(1fr) #tier-extension

#exercise(title: "Spot the pattern")[
  #text(weight: "bold")[a)] Convert $101_2$, $1010_2$ and $10100_2$ to decimal.
  What happens to the value when you add a 0 at the right end? Explain why.
  #answer-space(lines: 2)

  #text(weight: "bold")[b)] How can you tell from the binary number alone
  whether a number is even or odd?
  #answer-space(lines: 1)

  #text(weight: "bold")[c)] Write $2^5$ and $2^5 - 1$ in binary. What do you
  notice?
  #answer-space(lines: 2)

  #text(weight: "bold")[d)] Without converting to decimal: which number is
  larger, $1001111_2$ or $1010000_2$? Explain how you can tell.
  #answer-space(lines: 2)
]
]

#block(breakable: false)[
= Part 6 — Thinking Further #h(1fr) #tier-challenge

#exercise(title: "How many bits do you need?")[
  #text(weight: "bold")[a)] A school has 900 students. Each student gets a
  number stored in binary, and no two students may have the same number.
  What is the smallest number of bits that is enough?
  #answer-space(lines: 2)

  #text(weight: "bold")[b)] Roughly 8 billion people live on Earth. How many
  bits would you need to give every person their own number?
  #answer-space(lines: 2)

  #text(weight: "bold")[c)] How many bits are in 1 kB (1000 bytes)? How many
  are in 1 KiB (1024 bytes)?
  #answer-space(lines: 1)

  #text(weight: "bold")[d)] Using your fingers as bits, what is the largest
  number you can show with both hands?
  #answer-space(lines: 1)
]
]

#note(
  "Check with Python",
  [Once Python is installed (in your next CS lab), you can check your
   conversions yourself: `bin(42)` gives `'0b101010'` and
   `int("101010", 2)` gives `42`. The `0b` at the start just means
   "this is a binary number". But practice by hand first: there is no
   Python in the test.],
)

// ─────────────────────────────────────────────────────────────────────────────
// ANSWER KEY
// ─────────────────────────────────────────────────────────────────────────────

#if show-answers [
#pagebreak()

= Answers

== Part 1 — Concepts

*Multiple choice:* 1 B #h(1.5em) 2 D #h(1.5em) 3 C #h(1.5em) 4 A
#h(1.5em) 5 B

*Data and information*
+ The numbers `19, 20, 21, 27, 21`.
+ For example: "At the fourth measurement it was much warmer than at the
  others" or "The temperature was usually around 20 °C." Many answers
  are possible.
+ For example: someone who does not know the unit could read the
  numbers as °F. Or one person thinks 27 °C is a measuring error,
  another thinks the sun was shining on the thermometer. The meaning
  depends on the context and on how the data is interpreted.

== Part 2 — Binary to Decimal

#stdtable(
  (auto,) * 5,
  ([a)], [b)], [c)], [d)], [e)]),
  [5], [13], [16], [31], [42],
)
#v(0.3em)
#stdtable(
  (auto,) * 5,
  ([f)], [g)], [h)], [i)], [j)]),
  [100], [128], [255], [183], [1000],
)

#v(0.3em)
Working for i): $128 + 32 + 16 + 4 + 2 + 1 = 183$. \
Working for j): $512 + 256 + 128 + 64 + 32 + 8 = 1000$.

== Part 3 — Decimal to Binary

#tasks(
  [*a)* $6 = 110_2$],
  [*b)* $9 = 1001_2$],
  [*c)* $17 = 10001_2$],
  [*d)* $25 = 11001_2$],
  [*e)* $50 = 110010_2$],
  [*f)* $64 = 1000000_2$],
  [*g)* $99 = 1100011_2$],
  [*h)* $127 = 1111111_2$],
  [*i)* $200 = 11001000_2$],
  [*j)* $2026 = 11111101010_2$],
)

#v(0.3em)
Check for j): $1024 + 512 + 256 + 128 + 64 + 32 + 8 + 2 = 2026$.

== Part 4 — Counting and Fixed Width

*Count in binary:* 0000, 0001, 0010, 0011, 0100, 0101, 0110, 0111,
1000, 1001, 1010, 1011, 1100, 1101, 1110, 1111.

*How much fits?*

a)
#stdtable(
  (auto,) * 6,
  ([Number of bits], [1], [4], [6], [8], [16]),
  [Number of patterns], [2], [16], [64], [256], [65~536],
  [Largest number], [1], [15], [63], [255], [65~535],
)

#v(0.3em)
b) $5 = 00000101_2$ #h(1.5em) $19 = 00010011_2$ #h(1.5em)
$100 = 01100100_2$ #h(1.5em) $255 = 11111111_2$

c) The largest 6-bit number is $2^6 - 1 = 63$.
$13 = 001101_2$, $40 = 101000_2$, $63 = 111111_2$.
64 and 100 do not fit: they are larger than 63 and need 7 bits
($64 = 1000000_2$, $100 = 1100100_2$).

== Part 5 — Patterns

+ 5, 10, 20. Adding a 0 at the right end *doubles* the value: every
  bit moves one position to the left, and each position is worth
  twice as much as the one before. (In decimal, adding a 0 multiplies
  by 10.)
+ The last bit is worth 1, all other positions are even. So the
  number is odd if the last bit is 1 and even if it is 0.
+ $2^5 = 100000_2$ and $2^5 - 1 = 11111_2$. A power of 2 is a 1
  followed by zeros; one less than that is a row of ones.
+ $1010000_2$ is larger (it is 80, the other is 79). Both have the same
  number of bits, so compare from the left: the first position where
  they differ is the third bit, and there $1010000_2$ has the 1.

== Part 6 — Thinking Further

+ 10 bits. $2^9 = 512$ is not enough, $2^10 = 1024$ is.
+ 33 bits. $2^32 approx 4.3$ billion is not enough,
  $2^33 approx 8.6$ billion is.
+ $1000 dot 8 = 8000$ bits and $1024 dot 8 = 8192$ bits.
+ 10 fingers are 10 bits, so $2^10 - 1 = 1023$.
]
