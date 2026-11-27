// ─────────────────────────────────────────────────────────────────────────────
// Lesson 9 — Data and Binary Numbers
// Session 1 of the Computer Basics unit (before the encoding/binary/gates test)
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "Data and Binary Numbers"
#let lesson-subtitle = "Bits, bytes, and counting in base 2"

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

// ── Local components ──────────────────────────────────────────────────────────

// "Check yourself" box — short self-test; answers are at the end of the notes
#let check-counter = counter("check")
#let check(body) = {
  check-counter.step()
  block(
    width: 100%,
    breakable: false,
    stroke: (left: 1.5pt + accent),
    inset: (left: 12pt, right: 0pt, top: 6pt, bottom: 6pt),
    [
      #text(size: 10pt, weight: "bold", fill: accent)[
        Check yourself #context check-counter.display()
      ]
      #v(0.2em)
      #body
    ],
  )
  v(0.6em)
}

// Standard table look (matches the other lesson notes)
#let stdtable(columns, header, ..cells) = table(
  columns: columns,
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  align: center,
  table.header(..header.map(h => text(size: 9pt, weight: "bold", fill: white, h))),
  ..cells,
)

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
  [Explain the difference between data and information.],
  [Explain why computers use binary.],
  [Define bit and byte and calculate how many values $n$ bits can store.],
  [Convert numbers from binary to decimal and from decimal to binary.],
  [Write numbers in a fixed number of bits and recognize when a number does not fit.],
)

= From Your Web Page to Bits #h(1fr) #tier-core

A few weeks ago you finished a web page. When someone opens it, the
browser shows text, colors, and images. But nothing travels through the
cables as letters or colors. Everything your page consists of is stored
on a disk, sent over the network, and processed by the computer as long
rows of *zeros and ones*.

In the next weeks we will answer one question step by step:

#align(center)[
  _How can a computer store text, numbers, colors, and pictures using
  only 0 and 1?_
]

#note(
  "Your guess",
  [Before we start: write down in two or three sentences what you think
   happens between typing the address of your page and seeing it in the
   browser. Keep this. We will come back to it at the end of the unit.
   #answer-space(lines: 4)],
)

= Data and Information #h(1fr) #tier-core

Two words are often used as if they meant the same thing. In computer
science we keep them apart:

- *Data* are the symbols that are stored or sent, for example the
  digits `01000001` or the numbers `21, 22, 35, 21`.
- *Information* is the meaning that someone gets out of the data when
  they *interpret* it.

A computer only ever handles data. The meaning comes from the rules we
use to read it. The same eight bits can mean completely different things:

#align(center,
  stdtable(
    (auto, auto),
    ([Interpreted as …], [The bits `01000001` mean …]),
    [a whole number], [65],
    [a letter (ASCII table)], [the letter A],
    [the brightness of a pixel (0 = black, 255 = white)], [a dark gray],
  )
)

#infobox(
  "Key idea",
  [Bits have no meaning on their own. To turn data into information,
   you need to know *how* the data was encoded. This is the central idea
   of the whole unit: every kind of data (numbers, text, colors, images)
   is just a different set of rules for reading bits.],
)

#check[
  A weather station stores the numbers `0, 2, 5, 3, 1`.
  + What is the data here?
  + Write down one piece of information someone could get from it, if
    they know that the numbers are rainfall in millimeters per day.
  + What could go wrong if someone does not know the unit?
]

= Why Binary? #h(1fr) #tier-core

Inside a computer, data is stored and processed electronically. Modern
processors contain billions of tiny switches called *transistors*. Each
one is either *on* or *off*: current flows or it does not, the voltage
is high or it is low.

Two states are very easy to tell apart, even when the signal is a bit
weak or noisy. "Clearly high" and "clearly low" are hard to confuse.
If a wire had to carry ten different voltage levels (one for each
decimal digit), a small disturbance could turn a 6 into a 7. With only
two levels, the computer works *reliably*.

So we write the two states as *1* and *0*. A number system that uses
only these two digits is called the *binary* system (base 2).

#infobox(
  "Analogy: a row of light switches",
  [Imagine a row of light switches, each either on (1) or off (0).
   One switch has 2 possible settings. Two switches have
   $2 dot 2 = 4$: off–off, off–on, on–off, on–on. Every additional
   switch *doubles* the number of possible settings.],
)

= Bits and Bytes #h(1fr) #tier-core

A single 0 or 1 is called a *bit* (short for "binary digit").
Bits are grouped into *bytes*:

#align(center)[*1 byte = 8 bits*]

With $n$ bits you can form $2^n$ different patterns:

#align(center,
  stdtable(
    (auto, auto, auto, auto, auto, auto, auto, auto, auto),
    ([Bits $n$], [1], [2], [3], [4], [5], [6], [7], [8]),
    [Patterns $2^n$], [2], [4], [8], [16], [32], [64], [128], [256],
  )
)

#v(0.3em)

So one byte can store $2^8 = 256$ different values, for example the
numbers 0 to 255.

== Larger units

#align(center,
  stdtable(
    (auto, auto, auto),
    ([Unit], [Symbol], [Size]),
    [kilobyte], [kB], [1~000 bytes],
    [megabyte], [MB], [1~000 kB = 1~000~000 bytes],
    [gigabyte], [GB], [1~000 MB],
    [terabyte], [TB], [1~000 GB],
  )
)

#warnbox(
  "⚠ 1000 or 1024?",
  [Because computers count in powers of 2, you will also see
   1 KiB (kibibyte) = $2^10$ = 1~024 bytes, 1 MiB = $2^20$ bytes, and
   so on. Operating systems and storage devices do not always agree on
   which one they mean, which is why a "500 GB" disk can show up as
   "465 GB" on your laptop. In this course we say which one we mean.],
)

#check[
  + How many different patterns can you form with 5 bits?
  + How many bits are in 3 bytes?
  + A file has a size of 4 kB. About how many bytes is that?
]

= Binary Numbers #h(1fr) #tier-core

== Place value: what you already know

In the decimal system, each position is worth ten times as much as the
position to its right:

$ 2026 = 2 dot 1000 + 0 dot 100 + 2 dot 10 + 6 dot 1 $

The positions are worth $10^0 = 1$, $10^1 = 10$, $10^2 = 100$,
$10^3 = 1000$, and so on.

The binary system works exactly the same way, but each position is
worth *two* times as much as the position to its right:

#align(center,
  stdtable(
    (auto,) * 9,
    ([Position value], [$2^7$], [$2^6$], [$2^5$], [$2^4$], [$2^3$], [$2^2$], [$2^1$], [$2^0$]),
    [], [128], [64], [32], [16], [8], [4], [2], [1],
  )
)

#v(0.3em)

#infobox(
  "Learn these by heart",
  [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024. These are the powers
   of 2 from $2^0$ to $2^10$. You will need them all the time.],
)

To make clear which system a number is written in, we add the base as a
small subscript: $101_2$ is a binary number, $101_(10)$ a decimal one.

== Binary to decimal

Write the position values above the bits. Then add up the values of
all positions where there is a *1*.

*Example:* $10110_2$

#align(center,
  stdtable(
    (auto,) * 6,
    ([Position value], [16], [8], [4], [2], [1]),
    [Bit], [1], [0], [1], [1], [0],
  )
)

#v(0.3em)

$ 10110_2 = 16 + 4 + 2 = 22 $

*Example:* $01101001_2$

$ 01101001_2 = 64 + 32 + 8 + 1 = 105 $

#check[
  Convert to decimal: #h(1em) $111_2$ #h(1em) $1001_2$ #h(1em)
  $11010_2$ #h(1em) $10000001_2$
]

== Decimal to binary — Method 1: subtract powers of 2

Start with the largest power of 2 that fits into the number. Write a 1
in that position and subtract. Then go down position by position: if
the power fits into what is left, write 1 and subtract; if not, write 0.

*Example:* 45

#align(center,
  stdtable(
    (auto, auto, auto, auto),
    ([Position value], [Fits into …?], [Bit], [Left over]),
    [32], [45: yes], [1], [45 − 32 = 13],
    [16], [13: no],  [0], [13],
    [8],  [13: yes], [1], [13 − 8 = 5],
    [4],  [5: yes],  [1], [5 − 4 = 1],
    [2],  [1: no],   [0], [1],
    [1],  [1: yes],  [1], [1 − 1 = 0],
  )
)

#v(0.3em)

Reading the bit column from top to bottom: $45 = 101101_2$.

== Decimal to binary — Method 2: divide by 2

Divide the number by 2 and write down the remainder (0 or 1). Repeat
with the result until you reach 0. The remainders, read from *bottom
to top*, are the binary number.

*Example:* 45

#align(center,
  stdtable(
    (auto, auto, auto),
    ([Division], [Result], [Remainder]),
    [45 : 2], [22], [1],
    [22 : 2], [11], [0],
    [11 : 2], [5],  [1],
    [5 : 2],  [2],  [1],
    [2 : 2],  [1],  [0],
    [1 : 2],  [0],  [1],
  )
)

#v(0.3em)

Remainders from bottom to top: $45 = 101101_2$. Both methods give the
same result, of course. Use the one you prefer.

#warnbox(
  "⚠ Check your result",
  [The most common mistake with Method 2 is reading the remainders in
   the wrong order. Always check by converting your answer back to
   decimal: $101101_2 = 32 + 8 + 4 + 1 = 45$ #sym.checkmark],
)

#check[
  Convert to binary: #h(1em) 12 #h(1em) 33 #h(1em) 70 #h(1em) 150
]

= Fixed Width #h(1fr) #tier-core

A computer does not store numbers with "as many bits as needed". It
reserves a *fixed number of bits* for each number, for example 8 bits
(one byte). Unused positions on the left are filled with *leading
zeros*:

$ 19 = 10011_2 = 00010011_2 #h(1em) "(8-bit)" $

Leading zeros do not change the value, just as 0019 is still nineteen.

With $n$ bits, the smallest number is 0 (all zeros) and the largest is
$2^n - 1$ (all ones). For 8 bits this is $11111111_2 = 255$.

#warnbox(
  "⚠ It does not always fit",
  [The number 300 needs 9 bits ($100101100_2$). It *cannot* be stored
   in a single byte. What a computer does in this situation, and why
   that can cause real bugs, is part of the next lesson.],
)

#check[
  + What is the largest number you can store with 5 bits? Write it in
    binary and in decimal.
  + Write 21 as an 8-bit binary number.
  + Can the number 70 be stored with 6 bits? Explain.
]

= Patterns in Binary #h(1fr) #tier-extension

Counting in binary works just like counting in decimal: when a position
is "full" (a 1 in binary, a 9 in decimal), it goes back to 0 and the
next position to the left goes up by one.

#align(center,
  stdtable(
    (auto,) * 8,
    ([Decimal], [0], [1], [2], [3], [4], [5], [6]),
    [Binary], [0000], [0001], [0010], [0011], [0100], [0101], [0110],
  )
)

#v(0.3em)

Look closely at your conversions and see whether you can explain these
patterns:

- Every *odd* number ends in 1, every *even* number ends in 0.
- Adding a 0 at the right end *doubles* the number:
  $101_2 = 5$, $1010_2 = 10$, $10100_2 = 20$.
- A 1 followed by $n$ zeros is $2^n$. A row of $n$ ones is $2^n - 1$.

= Counting on Your Fingers #h(1fr) #tier-challenge

Each finger is one bit: finger up = 1, finger down = 0. Your thumb is
worth 1, your index finger 2, your middle finger 4, and so on.

+ What is the largest number you can show with one hand? With two?
+ Show the number 19 on one hand. (Careful with the people next to you.)
+ Explain why Method 2 (dividing by 2) works. _Hint:_ What does the
  remainder of a division by 2 tell you about the last bit?

= Summary

By the end of this lesson you should be able to:

#checklist(
  [Explain the difference between data and information with an example.],
  [Explain why computers use two states instead of ten.],
  [State how many bits are in a byte and how many values $n$ bits can store.],
  [Convert binary numbers to decimal.],
  [Convert decimal numbers to binary with at least one method.],
  [Write a number in 8-bit notation and say whether it fits.],
)

#pagebreak()

= Check Your Answers

*Check yourself 1*
+ The numbers `0, 2, 5, 3, 1`.
+ For example: "The third day was the wettest" or "In total it rained
  11 mm." Many answers are possible.
+ Someone could read the numbers as centimeters or as temperatures and
  draw completely wrong conclusions. Without the encoding rule, data
  has no reliable meaning.

*Check yourself 2*
+ $2^5 = 32$
+ $3 dot 8 = 24$ bits
+ About 4~000 bytes (or 4~096 bytes if 1 KiB = 1~024 bytes is meant).

*Check yourself 3*
#h(1em) $111_2 = 7$ #h(2em) $1001_2 = 9$ #h(2em) $11010_2 = 26$ #h(2em)
$10000001_2 = 129$

*Check yourself 4*
#h(1em) $12 = 1100_2$ #h(2em) $33 = 100001_2$ #h(2em)
$70 = 1000110_2$ #h(2em) $150 = 10010110_2$

*Check yourself 5*
+ $11111_2 = 31$ (that is, $2^5 - 1$).
+ $21 = 00010101_2$
+ No. The largest 6-bit number is $2^6 - 1 = 63$, and $70 > 63$.
  70 needs 7 bits ($1000110_2$).
