// ─────────────────────────────────────────────────────────────────────────────
// Lesson 10 — Hardware
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "Hardware"
#let lesson-subtitle = "What is inside a computer, and what each part does"

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

// ── Local helpers ─────────────────────────────────────────────────────────────
#let tick = box(width: 0.9em, height: 0.9em, stroke: 0.8pt + muted, radius: 1pt)

#let flow-box(label, sublabel) = block(
  width: 105pt, height: 52pt,
  fill: rgb("#F0F4F8"), stroke: 1pt + accent, radius: 3pt,
  align(center + horizon, stack(spacing: 3pt,
    text(size: 10pt, weight: "bold", fill: primary, label),
    text(size: 8pt, fill: rgb("#666666"), sublabel),
  ))
)

#let arrow(dir) = align(center + horizon, text(size: 16pt, fill: accent, dir))

// ── Component images ──────────────────────────────────────────────────────────
// Fill in `file` with a path relative to the project root (e.g.
// "/images/cpu.jpg", compiled with --root .) and `credit` with the
// attribution required by the image license. While `file` is none, a
// placeholder box is shown instead.
#let hw-images = (
  motherboard: (file: "images/motherboard.jpg", credit: "Marcin Wieclaw (pcsite.co.uk), CC BY-SA 4.0, via Wikimedia Commons"),
  cpu:         (file: "images/cpu.jpg", credit: "Poooow, Public domain, via Wikimedia Commons"),
  gpu:         (file: "images/gpu.jpg", credit: "Mickael Courtiade, CC BY 2.0, via Wikimedia Commons"),
  ram:         (file: "images/ram.jpg", credit: "An-d, CC BY-SA 3.0, via Wikimedia Commons"),
  hdd:         (file: "images/hdd.jpg", credit: "Evan-Amos, CC BY-SA 3.0, via Wikimedia Commons"),
  ssd:         (file: "images/ssd.jpg", credit: "User5515, CC0, via Wikimedia Commons"),
  firmware:    (file: "images/firmware.jpg", credit: "Raimond Spekking, CC BY-SA 4.0, via Wikimedia Commons"),
  psu:         (file: "images/psu.jpg", credit: "public domain"),
)

#let hw-figure(key, label) = {
  let entry = hw-images.at(key)
  let picture = if entry.file == none {
    block(
      width: 100%, height: 3.2cm,
      stroke: (paint: muted, thickness: 0.8pt, dash: "dashed"), radius: 3pt,
      align(center + horizon, text(size: 8pt, fill: muted)[
        Image: #label \ (#raw(key))
      ]),
    )
  } else {
    // Fit the image inside the same box as the placeholder, keeping its proportions.
    image(entry.file, width: 100%, height: 3.2cm, fit: "contain")
  }
  block(width: 100%, breakable: false, {
    picture
    v(0.2em)
    align(center, text(size: 8pt, fill: muted, label))
    if entry.credit != none {
      v(-0.4em)
      align(center, text(size: 7pt, fill: muted, entry.credit))
    }
  })
}

// Text on the left, one or more images stacked on the right.
// Usage: #component(("cpu", [CPU]))[text] — several images: pass several pairs.
#let component(..args) = {
  let pos  = args.pos()
  let body = pos.last()
  let figs = pos.slice(0, -1)
  grid(
    columns: (1fr, 4.2cm),
    column-gutter: 14pt,
    body,
    stack(spacing: 0.8em, ..figs.map(f => hw-figure(f.at(0), f.at(1)))),
  )
}

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
  [Name the main hardware components of a computer and describe what
   each one does.],
  [Classify devices using the IPO model (input, processing, output,
   storage).],
  [Explain the difference between volatile and non-volatile memory.],
  [Find the key hardware specifications of your own laptop.],
  [Use the desk analogy to explain how CPU, RAM, and storage work
   together — and say where the analogy breaks down.],
)

= What Is Hardware? #h(1fr) #tier-core

On the class map from Lesson 9, two machines appeared again and again:
*your laptop* and the *server* that sent you the school website. Both
are computers, and both are built from the same kinds of parts. Today
we open the case and look inside.

*Hardware* is every physical part of a computer — everything you could,
in principle, touch: the keyboard, the screen, the chips, the cables.
*Software* is the programs and data that run on it. Neither is useful
without the other: hardware without software does nothing, and software
without hardware has nowhere to run. Software is the topic of the next
lesson.

#infobox(
  "A rule of thumb",
  [If you can drop it on the floor, it is hardware. If you can download
   it, it is software.],
)

= The IPO Model #h(1fr) #tier-core

Every computer, from a smartwatch to a server, does the same three
things: it takes something in, works on it, and gives something back.
This is the *IPO model*: *Input → Processing → Output*. In German
it is called the *EVA principle* (Eingabe, Verarbeitung, Ausgabe).
A fourth part keeps things for later: *storage*.

#align(center,
  figure(
    grid(
      columns: (105pt, 28pt, 105pt, 28pt, 105pt),
      row-gutter: 4pt,
      flow-box([Input], [keyboard, mouse, microphone]),
      arrow(sym.arrow.r),
      flow-box([Processing], [CPU, GPU]),
      arrow(sym.arrow.r),
      flow-box([Output], [screen, speakers]),
      [], [], arrow(sym.arrow.t.b), [], [],
      [], [], flow-box([Storage], [SSD, hard disk]), [], [],
    ),
    caption: [The IPO model. Storage exchanges data with processing in
      both directions.],
  )
)

#exercise(title: "Input, processing, output, or storage?")[
  Tick the correct column for each device. Some devices belong in more
  than one column.

  #v(0.3em)
  #{
    let devices = (
      "Keyboard", "Microphone", "Webcam", "Monitor", "Speaker",
      "Printer", "CPU", "GPU", "SSD", "USB stick",
      "Touchscreen", "Headset with microphone",
    )
    table(
      columns: (1fr, 4em, 6em, 4em, 4.5em),
      stroke: none,
      inset: (x: 6pt, y: 5pt),
      fill: (_, row) => if row == 0 { light } else { none },
      align: (left, center, center, center, center),
      table.header(
        text(size: 9pt, weight: "bold")[Device],
        text(size: 9pt, weight: "bold")[Input],
        text(size: 9pt, weight: "bold")[Processing],
        text(size: 9pt, weight: "bold")[Output],
        text(size: 9pt, weight: "bold")[Storage],
      ),
      ..devices.map(d => ([#d], tick, tick, tick, tick)).flatten(),
    )
  }

  Which device was the hardest to classify? Why?
  #answer-space(lines: 2)
]

= Inside the Computer #h(1fr) #tier-core

== The motherboard

#component(("motherboard", [Motherboard]))[
  The *motherboard* is the large circuit board that everything else plugs
  into. It does not compute anything itself. Its job is to connect the
  other components and carry data and power between them. You can think
  of it as the road network of the computer.
]

== The CPU

#component(("cpu", [CPU]))[
  The *CPU* (Central Processing Unit) carries out the instructions of
  every program. It is often called the "brain" of the computer, although
  it does not think — it follows instructions extremely quickly and
  extremely precisely.

  The CPU works in steps that follow the beat of a clock. Its speed is
  given in *gigahertz* (GHz): a CPU running at 3.4 GHz performs 3.4 billion
  clock cycles per second.

  Most modern CPUs contain several *cores*. Each core is a complete
  processor of its own, so a quad-core CPU can work on four things at the
  same time.
]

== The GPU

#component(("gpu", [Graphics card]))[
  The *GPU* (Graphics Processing Unit) is a processor specialized in
  graphics: it calculates the color of millions of pixels many times per
  second. It does this by running thousands of small, simple calculations
  in parallel. That same skill makes GPUs very good at training and
  running AI models.

  A GPU can be *integrated* (built into the same chip as the CPU — typical
  for laptops) or *dedicated* (a separate graphics card — typical for
  gaming computers).
]

== RAM

#component(("ram", [RAM module]))[
  *RAM* (Random Access Memory) is the computer's working memory. Every
  program you have open, and every file you are working on, sits in RAM
  while you use it. RAM is very fast, so the CPU can get what it needs
  almost instantly.

  RAM has one important weakness: it is *volatile*. When the power goes
  off, everything in RAM is lost.
]

== Storage: SSD and hard disk

#component(("hdd", [Hard disk, opened]), ("ssd", [SSD]))[
  *Storage* keeps your files, programs, and the operating system when the
  computer is switched off. It is *non-volatile*.

  - A *hard disk drive* (HDD) stores data magnetically on spinning metal
    disks. A small arm moves over the disk to read and write. HDDs are
    cheap per gigabyte, but slow, and they can break if dropped.
  - A *solid-state drive* (SSD) stores data in flash memory chips with no
    moving parts. SSDs are much faster and more robust, but cost more per
    gigabyte. Almost all new laptops use an SSD.
]

== Firmware

#component(("firmware", [Firmware chip]))[
  When you press the power button, RAM is empty and the CPU does not yet
  know how to load anything from the SSD. A small chip on the motherboard
  holds the *firmware* (on PCs often called the *BIOS* or *UEFI*): the
  very first program that runs, checks the hardware, and starts the
  operating system. Traditionally this chip was *ROM* (Read-Only Memory).
  Today it is usually flash memory that can be updated — but only rarely,
  and carefully.
]

== The power supply

#component(("psu", [Power supply unit]))[
  The *power supply unit* (PSU) converts electricity from the wall socket
  into the low, steady voltages the components need. In a laptop, part of
  this job is done by the charger and part by the battery.
]

#infobox(
  "Volatile or non-volatile?",
  [*Volatile* memory loses its content when the power is cut (RAM).
   *Non-volatile* memory keeps it (SSD, hard disk, USB stick, firmware
   chip). This is why you lose unsaved work in a power failure: it was
   only in RAM.],
)

#warnbox(
  "Memory or storage?",
  [Advertisements often mix up the two. A phone with "256 GB memory"
   usually has 256 GB of *storage* and perhaps 8 GB of *RAM*. When you
   compare devices, check which one is meant.],
)

#exercise(title: "Match the component")[
  Write the letter of the matching description next to each component.

  #grid(
    columns: (10em, 1fr),
    row-gutter: 0.7em,
    column-gutter: 1em,
    [CPU #h(1fr) #blank(width: 2em)],         [A. Connects all components and carries data between them.],
    [GPU #h(1fr) #blank(width: 2em)],         [B. Fast working memory, emptied when the power goes off.],
    [RAM #h(1fr) #blank(width: 2em)],         [C. Keeps files when the computer is off; no moving parts.],
    [SSD #h(1fr) #blank(width: 2em)],         [D. Carries out the instructions of every program.],
    [Motherboard #h(1fr) #blank(width: 2em)], [E. Runs first when you switch on and starts the operating system.],
    [Firmware #h(1fr) #blank(width: 2em)],    [F. Converts mains electricity into the voltages the parts need.],
    [PSU #h(1fr) #blank(width: 2em)],         [G. Runs thousands of small calculations in parallel, e.g. for graphics.],
  )
]

= Your Own Laptop #h(1fr) #tier-core

Your laptop can tell you what it is made of. Find the information and
fill in the table.

#steps(
  [*Mac:* Apple menu → *About This Mac*. For the number of cores, click
   *More Info…* → *System Report* → *Hardware*. Storage is under
   *System Settings → General → Storage*.],
  [*Windows:* *Settings → System → About* shows the processor and the
   installed RAM. Storage is under *Settings → System → Storage*. For the
   number of cores, open the *Task Manager* (`Ctrl+Shift+Esc`) →
   *Performance* → *CPU*.],
)

#table(
  columns: (1fr, 14em),
  rows: (auto, 2.2em, 2.2em, 2.2em, 2.2em, 2.2em),
  stroke: 0.5pt + muted,
  inset: 8pt,
  table.header([*Specification*], [*My laptop*]),
  [Processor (name)],                  [],
  [Number of cores],                   [],
  [RAM (in GB)],                       [],
  [Storage (in GB or TB)],             [],
  [Storage type (SSD or HDD)],         [],
)

#exercise(title: "Comparing specs")[
  + Compare your table with two classmates. Whose laptop has the most
    RAM? The most storage?
  + Your laptop probably has much more storage than RAM. Why does that
    make sense? Think about what each one is for.
    #answer-space(lines: 3)
]

#hint[On many recent laptops — including all Macs with an Apple chip —
  the CPU, GPU, and RAM sit together on a single chip. This makes them
  fast and energy-efficient, but it also means the RAM can never be
  upgraded later.]

= The Desk Analogy #h(1fr) #tier-core

A useful way to picture how the parts work together: imagine a student
doing homework in a study room.

- The *student* does all the actual work, one step after another.
- The *desk* holds only what the student is working on right now. It is
  within reach, but there is limited space.
- The *bookshelves* hold everything else. There is plenty of room, but
  fetching a book takes time.
- Every evening, a cleaner clears the desk completely. Whatever was not
  put back on the shelf is gone.
- The *hallways* connect the room to everything else in the building.
- The *electricity* makes the light work, so the student can see at all.

#exercise(title: "Completing the analogy")[
  Which hardware component does each part of the analogy stand for?

  #table(
    columns: (1fr, 12em),
    rows: (auto, 2em, 2em, 2em, 2em, 2em, 2em),
    stroke: 0.5pt + muted,
    inset: 8pt,
    table.header([*In the study room*], [*In the computer*]),
    [the student],                         [],
    [the desk],                            [],
    [the bookshelves],                     [],
    [the cleaner clearing the desk],       [],
    [the hallways],                        [],
    [the electricity],                     [],
  )
]

#exercise(title: "Where the analogy breaks down")[
  #tier-extension #h(0.5em) Every analogy has limits. Name at least two
  ways in which a real computer is *not* like the study room.

  #answer-space(lines: 4)
]

= More Cores, More Speed? #h(1fr) #tier-extension

A quad-core CPU is like four students in the same room, each at a
separate desk. For some tasks, four students finish four times as fast.
For others, they do not help at all.

- *Grading 100 exam papers:* each student takes 25 papers. The papers do
  not depend on each other, so the work can be shared out.
- *Writing one story where every sentence follows from the previous
  one:* the second student cannot start until the first has finished.
  Only one student can work at a time.

Tasks of the first kind are called *parallel*. Tasks of the second kind
are *sequential*.

#exercise(title: "Parallel or sequential?")[
  + Decide for each task whether more cores would help. Explain briefly.
    - Converting 200 photos to black and white.
    - Calculating the balance of a savings account year by year, where
      each year's interest depends on the previous year's balance.
    - Searching 1 000 documents for a particular word.
    #answer-space(lines: 4)
  + Laptop A has 4 cores at 3.5 GHz. Laptop B has 8 cores at 2.0 GHz.
    Which one would you expect to finish a single sequential task first?
    Which one might win at the photo task? Explain.
    #answer-space(lines: 3)
]

#hint[Real comparisons are more complicated than this: two CPUs at the
  same GHz can differ a lot in how much work they do per clock cycle.
  GHz and core counts are a rough guide, not the whole story.]

= How Fast Is Fast? #h(1fr) #tier-challenge

Computers are so fast that the numbers are hard to imagine. One trick is
to slow everything down: pretend that a single CPU clock cycle takes
*one second* instead of about 0.3 nanoseconds. Everything else slows
down by the same factor.

#exercise(title: "Slowing down time")[
  Complete the table. The real times are rough, typical values.

  #table(
    columns: (1fr, 7em, 9em),
    rows: (auto, 2.2em, 2.2em, 2.2em, 2.2em, 2.2em),
    stroke: 0.5pt + muted,
    inset: 8pt,
    table.header([*Event*], [*Real time*], [*If one cycle took 1 s*]),
    [One CPU clock cycle],                        [0.3 ns],   [1 second],
    [Reading a value from RAM],                   [100 ns],   [about 5 minutes],
    [Reading a small block from an SSD],          [100 µs],   [],
    [Reading a small block from a hard disk],     [10 ms],    [],
    [A request to a server in the USA and back],  [100 ms],   [],
  )

  What does the last row tell you about the journey of a webpage from
  Lesson 9?
  #answer-space(lines: 3)
]

#hint[1 ms = 1 000 µs, 1 µs = 1 000 ns. Divide the real time by 0.3 ns
  to find how many cycles fit into it.]

= Summary

By the end of this lesson you should have:

#checklist(
  [Classified devices as input, processing, output, or storage.],
  [Matched the main components to their jobs.],
  [Explained the difference between volatile and non-volatile memory.],
  [Filled in the hardware specifications of your own laptop.],
  [Completed the desk analogy.],
)
