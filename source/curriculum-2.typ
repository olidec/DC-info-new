// ─────────────────────────────────────────────────────────────────────────────
// CS Curriculum Overview — Computer Basics Unit
// Teacher planning reference. Not for distribution to students.
// ─────────────────────────────────────────────────────────────────────────────

#let course = "Computer Science"
#let level  = "Gymnasium Muttenz"
#let term   = "2026-27"

// ── Palette (matches lesson notes and exercise sheets) ────────────────────────
#let primary = rgb("#111111")
#let accent  = rgb("#2E6DA4")
#let light   = rgb("#F5F5F5")
#let muted   = rgb("#999999")
#let warn    = rgb("#555555")
#let holiday = rgb("#E8E8E8")

// ── Page ─────────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: muted)
    grid(
      columns: (1fr, 1fr),
      align(left,  [Curriculum Overview — Computer Basics]),
      align(right, [#course — #level]),
    )
    line(length: 100%, stroke: 0.4pt + muted)
  },
  footer: context {
    set text(size: 9pt, fill: muted)
    align(center, counter(page).display("1"))
  },
)

// ── Typography ────────────────────────────────────────────────────────────────
#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.75em)

#show heading.where(level: 1): it => {
  v(1.4em)
  text(size: 11pt, weight: "bold", fill: primary, upper(it.body))
  v(0.15em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.6em)
}

#show heading.where(level: 2): it => {
  v(0.8em)
  text(size: 10pt, weight: "bold", fill: accent, upper(it.body))
  v(0.3em)
}

// ── Tier pills ────────────────────────────────────────────────────────────────
#let core      = box(fill: rgb("#2E6DA4"), inset: (x: 5pt, y: 2pt), radius: 2pt,
                   text(size: 8pt, weight: "bold", fill: white)[★ Core])
#let extension = box(fill: rgb("#5A8A3C"), inset: (x: 5pt, y: 2pt), radius: 2pt,
                   text(size: 8pt, weight: "bold", fill: white)[◆ Ext.])
#let challenge = box(fill: rgb("#B05C3A"), inset: (x: 5pt, y: 2pt), radius: 2pt,
                   text(size: 8pt, weight: "bold", fill: white)[▲ Chal.])

// ── Lesson block ──────────────────────────────────────────────────────────────
#let lesson(number, theme, content, goals, notes: none) = {
  block(
    width: 100%,
    breakable: false,
    {
      block(
        fill: primary,
        width: 100%,
        inset: (x: 12pt, y: 7pt),
        radius: (top: 3pt),
        grid(
          columns: (auto, 1fr),
          column-gutter: 12pt,
          align(horizon,
            text(size: 9pt, weight: "bold", fill: accent)[LESSON #number]
          ),
          align(horizon,
            text(size: 11pt, weight: "bold", fill: white)[#theme]
          ),
        )
      )
      block(
        fill: light,
        width: 100%,
        inset: (x: 14pt, y: 11pt),
        radius: (bottom: 3pt),
        {
          grid(
            columns: (9em, 1fr),
            column-gutter: 8pt,
            rows: auto,
            row-gutter: 8pt,
            text(size: 9pt, weight: "bold", fill: muted, upper[Content]),
            text(size: 10pt, content),
            text(size: 9pt, weight: "bold", fill: muted, upper[Learning Goals]),
            text(size: 10pt, goals),
            if notes != none {
              text(size: 9pt, weight: "bold", fill: muted, upper[Notes])
            } else { [] },
            if notes != none {
              text(size: 10pt, fill: warn, notes)
            } else { [] },
          )
        }
      )
    }
  )
  v(0.8em)
}

// ─────────────────────────────────────────────────────────────────────────────
// TITLE BLOCK
// ─────────────────────────────────────────────────────────────────────────────
#{
  text(size: 9pt, fill: muted)[#course #sym.bar.v #level #sym.bar.v #term]
  v(0.15em)
  text(size: 20pt, weight: "bold", fill: primary)[Computer Basics]
  v(0.05em)
  text(size: 12pt, fill: muted)[Curriculum Overview — Unit 2 (Lessons 9–18)]
  v(0.3em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.3em)
  text(size: 9pt, fill: muted)[
    Teacher planning document. Lessons 9–18, continuing from the Web Development
    unit. Each lesson is one 90-minute session. Lessons may be combined or split
    as pacing requires.
  ]
  v(1em)
}

// ─────────────────────────────────────────────────────────────────────────────
// UNIT RATIONALE
// ─────────────────────────────────────────────────────────────────────────────

= Unit Rationale

Students arrive at this unit having already built and published a working
webpage — they have used a computer as a creative tool. This unit asks:
how does that tool actually work? The sequence moves from the physical machine
(hardware) through the logic it executes (binary, gates) to the meaning it
handles (encoding) and finally to the global infrastructure it connects to
(networks).

The HTML cold open in Lesson 9 anchors abstract content in something students
already understand: a webpage request is a real, traceable event involving
hardware, software, binary signals, encoded text, and a network. That thread —
"how did this page get here?" — runs through all ten lessons and gives students
a unifying question to return to at the end.

// ─────────────────────────────────────────────────────────────────────────────
// AT A GLANCE
// ─────────────────────────────────────────────────────────────────────────────

= At a Glance

#table(
  columns: (4em, 9em, 1fr, 7em),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Lesson],
    text(size: 9pt, weight: "bold", fill: white)[Chapter],
    text(size: 9pt, weight: "bold", fill: white)[Theme],
    text(size: 9pt, weight: "bold", fill: white)[Key deliverable],
  ),
  [9],  [Cold Open],        [The journey of a webpage request],         [Class mind map],
  [10], [Hardware],         [Components, CPU, memory, EVA principle],   [Hardware matching exercise],
  [11], [Software],         [OS, applications, web apps, layers],       [Layered-model diagram],
  [12], [Binary I],         [Why binary, bits and bytes, conversion],   [Conversion exercise sheet],
  [13], [Binary II],        [Negatives, fractions, hex, overflow],      [2's complement worksheet],
  [14], [Data Encoding I],  [Analog vs. digital; text: ASCII, Unicode], [ASCII encoding exercise],
  [15], [Data Encoding II], [Images, audio, video representation],      [Pixel / color exercise],
  [16], [Logic Gates],      [NOT, AND, OR, XOR, NAND, NOR; truth tables],[Gate truth table sheet],
  [17], [Circuits],         [Half-adder, full adder, flip-flop],        [Circuit analysis exercise],
  [18], [Networks],         [LAN/WAN, IP, DNS, packets, HTTP, the Web], [Packet-trace discussion],
)

#v(0.5em)
#text(size: 9pt, fill: muted)[
  *Assessment:* short written test after Lesson 15 (binary + encoding);
  gate/circuit test after Lesson 17; networks addressed in end-of-unit oral
  discussion or combined written exam. Adjust to your school calendar.
]

// ─────────────────────────────────────────────────────────────────────────────
// LESSON-BY-LESSON DETAIL
// ─────────────────────────────────────────────────────────────────────────────

= Lesson-by-Lesson Plan

#lesson(
  "9",
  "Cold Open — The Journey of a Webpage",
  [
    A webpage the students built in Unit 1 is loaded live in class. The question
    is posed: what actually happened between pressing Enter and seeing the page?
    Working backwards from the rendered result, the class maps out — at a high
    level — every step: browser sends a request, DNS resolves the address,
    packets travel over cables and through routers, a server reads a file from
    disk, binary data is transmitted, decoded as text, rendered on screen by
    software running on hardware. Concepts are named but not yet explained;
    this lesson is pure orientation and curiosity-setting.

    *Activities:* whole-class discussion; annotated diagram built collaboratively
    on the board; students write a short "what I think happens" paragraph
    to revisit and correct at the end of Lesson 18.
  ],
  list(
    [Describe — roughly — the chain of events behind loading a webpage.],
    [Identify the questions this unit will answer.],
    [Connect hardware, software, binary, encoding, and networks as one system.],
  ),
  notes: [Keep this session light and generative — the goal is curiosity, not
          completeness. Student misconceptions surfaced here are valuable: note
          them down and return to them explicitly in later lessons.],
)

#lesson(
  "10",
  "Hardware — Physical Components of a Computer",
  [
    Definition of hardware as all physical components. The layered model:
    hardware → OS → applications → user. The motherboard as the backbone
    connecting all components.

    *Key components:*
    - *CPU* ("Central Processing Unit"): executes instructions; processing speed
      measured in GHz (e.g. 3.4 GHz = 3.4 billion operations per second);
      often called the "brain" of the computer.
    - *GPU* ("Graphics Processing Unit"): specialized for graphics calculations;
      integrated (embedded alongside CPU) vs. discrete (separate card);
      increasingly used for AI workloads.
    - *RAM* ("Random Access Memory"): volatile, fast temporary storage; works
      closely with the CPU; lost when power is cut.
    - *ROM* ("Read-Only Memory"): non-volatile; stores firmware such as the BIOS;
      cannot be modified by the user.
    - *HDD / SSD*: persistent storage; HDD uses spinning magnetic platters;
      SSD uses flash memory — faster, no moving parts, more expensive per GB.
    - *Motherboard*: connects all components; controls communication between them.
    - *Power supply unit (PSU)*: converts mains electricity to the voltages the
      components need.

    *The EVA principle* (Eingabe – Verarbeitung – Ausgabe / Input – Processing –
    Output) as a framework for classifying hardware. Input devices: keyboard,
    mouse, microphone, scanner, camera. Processing: CPU, GPU.
    Output devices: monitor, speakers, printer. Storage: HDD, SSD, ROM.

    *Analogy — desk and bookshelves:* the student at the desk (CPU) can only
    work with what is on the desk surface (RAM, limited space); books on the
    shelf (HDD/SSD) must be fetched when needed; the room itself is the case;
    the light switch is the PSU; the floor connecting everything is the
    motherboard.

    *Multi-core processors:* a quad-core CPU is like four students working at
    separate desks simultaneously. More cores help parallelizable tasks; some
    tasks are inherently sequential and do not benefit. A faster single core
    can outperform more slower cores for sequential work.
  ],
  list(
    [Name and describe the function of each main hardware component.],
    [Explain the role of the motherboard.],
    [Distinguish volatile (RAM) from non-volatile (HDD, SSD, ROM) storage.],
    [Classify hardware components using the EVA principle.],
    [Explain the desk-and-bookshelves analogy and identify its limits.],
    [#extension Argue whether a multi-core CPU is always faster than a single-core one.],
  ),
)

#lesson(
  "11",
  "Software — Operating Systems and Applications",
  [
    Software defined as all non-physical components: programs, data, operating
    systems. Neither hardware nor software is useful without the other.

    *The layered model revisited:* hardware → firmware/BIOS → operating system
    → application software → user. The OS as intermediary — it manages hardware
    access so applications do not need to address hardware directly.

    *The OS as a secretary analogy:* the boss (application) hands a file to the
    secretary (OS) to file away; the boss does not need to know how the filing
    cabinet is organized, only that the secretary can retrieve the file on request.

    *Three major OS families for desktop computers:*
    Windows (Microsoft, proprietary, paid); macOS (Apple, proprietary, paid,
    hardware-locked); Linux (open-source, community-developed, mostly free).
    Each exists in multiple versions because hardware and software evolve.
    Most desktop applications exist in three builds (Windows, Mac, Linux).

    *Application software:* programs installed by the user (Word processor,
    browser, game). Historically, installed applications required administrator
    privileges and gained deep system access. Contrast with smartphone apps,
    where individual permissions (camera, location, microphone) can be granted
    or denied separately.

    *Web applications:* run inside the browser, implemented in HTML, CSS, and
    JavaScript (the languages from Unit 1). No installation required;
    cross-platform by nature; require a network connection and a capable browser.

    *EVA applied to software:* every program transforms input data into output
    data according to its instructions, mediated by the OS.
  ],
  list(
    [Define software and explain how it depends on hardware.],
    [Describe the role of the OS in the layered model.],
    [Compare Windows, macOS, and Linux on cost, openness, and availability.],
    [Distinguish installed application software from web applications.],
    [Explain why the boundary between application and OS matters for security.],
  ),
)

#lesson(
  "12",
  "Binary I — Numbers in a Computer",
  [
    *Why binary?* Engineering argument: a transistor has two reliable states
    (conducting / not conducting; high voltage / low voltage). Two states map
    naturally to 1 and 0. Early computers experimented with decimal but binary
    proved far more practical to build reliably.

    *Bits and bytes:*
    One bit (binary digit) = one 0 or 1.
    8 bits = 1 byte.
    Storage prefixes: kilobyte (2¹⁰ = 1 024 B), megabyte (2²⁰ ≈ 1 million B),
    gigabyte (2³⁰ ≈ 1 billion B), terabyte (2⁴⁰).
    Why 1 024 and not 1 000: we are working in powers of 2, and 2¹⁰ is the
    power of 2 closest to 1 000. (Note: the IEC standard distinguishes
    kibibyte = 1 024 B from kilobyte = 1 000 B; both conventions appear in practice.)

    *Binary → decimal:* each bit position represents a power of 2, read right
    to left starting at 2⁰. Sum only the powers where a 1 appears.
    Example: 10011₂ = 2⁴ + 2¹ + 2⁰ = 16 + 2 + 1 = 19.

    *Decimal → binary:* repeated division by 2; collect remainders in reverse.
    Example: 19 ÷ 2 = 9 r 1; 9 ÷ 2 = 4 r 1; 4 ÷ 2 = 2 r 0; 2 ÷ 2 = 1 r 0;
    1 ÷ 2 = 0 r 1 → read upward: 10011₂.

    *Fixed-width notation:* numbers padded with leading zeros to a fixed bit
    count (e.g. 8-bit: 00010011 for 19). Essential for memory layout and
    for 2's complement in Lesson 13.

    *Exercises (from existing materials):*
    Binary → decimal: 10101, 1110, 1000001, 1100110011.
    Decimal → binary: 42, 122, 2022, 15.
    Write as 6-bit: 13, 1, 25, 65 (65 cannot be represented in 6 bits — a
    useful point about fixed-width limits).
    How many bits in a megabyte? (Answer: 8 x 2²⁰ = 8 388 608.)
  ],
  list(
    [Explain why computers use binary rather than decimal.],
    [Define bit and byte; state the storage prefixes up to terabyte.],
    [Convert between binary and decimal in both directions.],
    [Write numbers in fixed-width binary notation.],
    [State why fixed-width notation is necessary.],
  ),
  notes: [The kibibyte / kilobyte distinction is a genuine ambiguity in everyday
          usage — acknowledge it briefly but do not let it derail the lesson.
          Both 1 024 and 1 000 definitions appear on device spec sheets.],
)

#lesson(
  "13",
  "Binary II — Negative Numbers, Fractions, and Other Bases",
  [
    *Negative numbers — 2's complement:*
    To subtract we add the negative: 7 − 2 = 7 + (−2). If we can represent
    −2 in binary, ordinary addition gives us subtraction for free.
    The 2's complement procedure (for a fixed bit width):
    (1) write the positive value with leading zeros to fill the width;
    (2) invert every bit (0→1, 1→0);
    (3) add 1.
    Example (4-bit): 1 = 0001; invert → 1110; add 1 → 1111 = −1. ✓
    Note: the leading bit acts as a sign bit (1 = negative).
    Exercises: compute 7 − 5 and 5 − 5 in 4-bit 2's complement.

    *Overflow:* if a result exceeds the available bit width, the high bits are
    discarded and the stored value wraps around. Real consequences: early video
    game score counters rolling from maximum back to zero; the Y2K problem
    (two-digit year overflowing at 99→00); integer overflow bugs in software.

    *Fractions — binary point:* digits to the right of the point represent
    negative powers of 2 (2⁻¹ = 0.5, 2⁻² = 0.25, …).
    Example: 11.11₂ = 2 + 1 + 0.5 + 0.25 = 3.75.
    Some fractions have no finite binary representation (e.g. 1/3 = 0.010101…₂,
    0.2 = 0.001100110011…₂). This is why floating-point arithmetic sometimes
    gives unexpected results in programs.

    *Other bases:*
    The base of a number system indicates which power each position represents.
    Decimal: base 10 (powers of 10). Binary: base 2 (powers of 2).
    Hexadecimal: base 16 (digits 0–9 and A–F). One hex digit encodes exactly
    4 bits; two hex digits encode one byte. Hex is used for CSS color codes,
    memory addresses, and Unicode code points — all of which students have
    already encountered.
    Subscript notation: 11100₂ = 1C₁₆ = 28₁₀.
    Brief mention that any positive integer can serve as a base.
  ],
  list(
    [Use 2's complement to represent negative integers in a fixed bit width.],
    [Perform binary addition and verify subtraction via 2's complement.],
    [Explain what overflow is and give a real-world example of its consequences.],
    [Convert simple decimal fractions to binary.],
    [Explain why some fractions cannot be stored exactly in binary.],
    [#extension Convert numbers between binary, decimal, and hexadecimal.],
    [#extension Verify a subtraction using 2's complement from first principles.],
  ),
)

#lesson(
  "14",
  "Data Encoding I — Text and the Analog–Digital Divide",
  [
    *Analog vs. digital:*
    Natural processes are continuous — in theory, temperature, voltage, and
    position can be measured with infinite precision. Computers are finite and
    discrete: every value must be stored in a fixed number of bits.
    Discretization is the process of mapping a continuous value to the nearest
    representable digital value — essentially rounding.
    Example: a mercury thermometer reading 24.999°C and one reading 25.321°C
    both stored as 25°C. For everyday purposes this is sufficient; for scientific
    instruments or audio, the precision of the discretization matters.

    *Representing text — the need for a character set:*
    To store text, every character (letter, digit, punctuation, space, newline,
    tab) must be assigned a number. A character set is the table that defines
    this mapping. The computer stores the numbers; to display text it looks
    up the corresponding glyphs.

    *ASCII* (American Standard Code for Information Interchange):
    7-bit encoding → 128 entries. Covers uppercase and lowercase Latin letters,
    digits, punctuation, and control characters. Sufficient for plain English;
    inadequate for accented letters, other scripts, or emoji.
    Students read from the ASCII table: encoding a word into decimal values
    and into hexadecimal; decoding a given sequence back to text.

    *Unicode:*
    International standard currently defining over 143 000 characters, covering
    virtually all the world's writing systems plus emoji, mathematical symbols,
    and more. Backwards-compatible with ASCII: the first 128 code points are
    identical. UTF-8 is the dominant encoding on the web: it uses 1–4 bytes per
    character, encoding ASCII characters in a single byte for efficiency.
    Emoji are Unicode characters (e.g. 😀 = U+1F600).

    *Exercises:* encode a short message using the ASCII table (decimal and hex);
    decode a given sequence; estimate how many bytes are needed to store a
    novel (~500 pages x ~250 words x ~5 characters/word x 1 byte/character).
  ],
  list(
    [Explain the difference between analog and digital information.],
    [Describe what a character set is and why computers need one.],
    [Use an ASCII table to encode and decode short text strings.],
    [Explain what Unicode is and how it extends ASCII.],
    [Describe what UTF-8 is and why it is efficient for English text.],
    [Estimate storage requirements for plain text data.],
  ),
  notes: [The Unicode explainer video (youtu.be/MijmeoH9LT4) works well as a
          10-minute in-class watch before discussion. The ASCII table works best
          as a printed handout students can annotate.],
)

#lesson(
  "15",
  "Data Encoding II — Images, Audio, and Video",
  [
    *Images — pixels and resolution:*
    A digital image is a rectangular grid of pixels (picture elements), each
    storing a single color value. Resolution = width x height in pixels
    (e.g. 1920 x 1080 = 2 073 600 pixels).

    *Color depth:*
    — Monochrome: 1 bit per pixel (black or white).
    — Grayscale: 8 bits per pixel = 256 shades.
    — True color (RGB): 3 channels x 8 bits = 24 bits per pixel ≈ 16.7 million colors.
    — RGBA: 32 bits per pixel, with an 8-bit alpha channel encoding transparency.
    Connection to Unit 1: CSS hex color codes are two hex digits per channel
    (e.g. \#2E6DA4 = R:0x2E, G:0x6D, B:0xA4 = R:46, G:109, B:164).

    *Uncompressed file size:* width x height x bits per pixel.
    Example: a 1920x1080, 24-bit image = ~6.2 MB uncompressed.
    Compression: JPEG (lossy — discards some data to achieve small files);
    PNG (lossless — perfect reconstruction, larger than JPEG). Why compression
    is essential in practice.

    *Audio — sampling and quantization:*
    A sound wave is a continuous analog signal (varying air pressure over time).
    Sampling: the amplitude is measured at regular intervals — the sample rate
    (e.g. 44 100 Hz = 44 100 measurements per second for CD quality).
    Quantization: each measurement is rounded to the nearest of 2ⁿ levels,
    where n is the bit depth (e.g. 16-bit = 65 536 levels).
    Higher sample rate and bit depth → better quality → larger file.

    *Video:*
    A sequence of still images (frames) displayed rapidly to create the illusion
    of motion, synchronized with audio. Typical frame rates: 24 fps (cinema),
    30 fps (standard video), 60 fps (gaming, sports). A raw 1080p, 24-bit,
    30 fps video = ~1.5 GB per second — compression (H.264, H.265) is
    essential; modern codecs achieve compression ratios of 100:1 or more.
  ],
  list(
    [Define pixel and resolution; interpret a resolution specification.],
    [Calculate the uncompressed storage size of an image.],
    [Describe how color is stored in bits, including the alpha channel.],
    [Connect CSS hex color codes to their RGB bit representation.],
    [Explain sampling rate and bit depth for digital audio.],
    [Explain why video requires compression and give an example codec.],
    [#challenge Calculate the uncompressed size of a 10-second 1080p, 30fps video
      and compare to a real compressed file.],
  ),
)

#lesson(
  "16",
  "Logic Gates — The Building Blocks of Computation",
  [
    *Motivation:* a computer is ultimately an electronic device — it manipulates
    ones and zeros using transistors. A logic gate is a circuit element that
    takes one or more binary inputs and produces a single binary output.
    Gates are the atomic building blocks from which all computation is assembled.

    *Three representations used throughout:*
    — *Logic diagram:* standardized graphical symbol (IEEE notation used here).
    — *Truth table:* lists all possible input combinations and the resulting output.
    — *Boolean algebra:* algebraic notation for logic: ¬ (NOT), ∧ (AND), ∨ (OR), ⊕ (XOR).

    *The six fundamental gates:*
    - *NOT*: inverts its single input. $Y = ¬A$.
    - *AND*: output is 1 only when both A and B are 1. $Y = A ∧ B$.
    - *OR*: output is 1 when at least one input is 1. $Y = A ∨ B$.
    - *XOR* (exclusive or): output is 1 when the inputs differ. $Y = A ⊕ B$.
    - *NAND*: inverse of AND (NOT AND). $Y = ¬(A ∧ B)$.
    - *NOR*: inverse of OR (NOT OR). $Y = ¬(A ∨ B)$.

    For each gate: draw the symbol, complete the full truth table, write the
    Boolean expression. NAND and NOR are "universal gates": any other gate —
    and therefore any circuit — can be constructed from NAND gates alone
    (or from NOR gates alone). This has major engineering implications.

    *Boolean algebra basics:* identity laws (A ∧ 1 = A; A ∨ 0 = A);
    complement laws (A ∧ ¬A = 0; A ∨ ¬A = 1); De Morgan's theorems stated
    conceptually (¬(A ∧ B) = ¬A ∨ ¬B; ¬(A ∨ B) = ¬A ∧ ¬B).
  ],
  list(
    [Explain what a logic gate is and why computers are built from them.],
    [Draw and label the diagram symbols for all six gates.],
    [Complete truth tables for all six gates from memory.],
    [Write the Boolean expression for each gate.],
    [Explain what it means for NAND to be a universal gate.],
    [#extension State De Morgan's theorems and verify one with a truth table.],
  ),
)

#lesson(
  "17",
  "Circuits — Combining Gates to Compute",
  [
    *From gates to circuits:* a circuit connects the output of one or more gates
    to the inputs of other gates, building up more complex logical functions.
    The output of a circuit is determined entirely by its current inputs
    (for combinational circuits) or by its inputs and stored state (for
    sequential circuits such as flip-flops).

    *The half-adder:*
    Adds two single bits. Outputs: sum S and carry C.
    S = A ⊕ B (XOR gate); C = A ∧ B (AND gate).
    Truth table: four rows, two output columns. Connection to binary addition:
    1₂ + 1₂ = 10₂ means sum = 0, carry = 1.

    *The full adder:*
    Extends the half-adder to accept a carry-in bit Cᵢₙ, producing sum S
    and carry-out Cₒᵤₜ. Built from two half-adders and one OR gate.
    By chaining N full adders, an N-bit adder is constructed — this is
    the core of the ALU (Arithmetic Logic Unit) inside every CPU.

    *The SR flip-flop:*
    A sequential circuit that stores one bit of information. Built from two
    cross-coupled NOR gates with inputs S (Set) and R (Reset) and outputs Q
    and Q'. Setting S=1 stores a 1; setting R=1 clears it. The output
    persists after the inputs return to 0 — this is memory. Many flip-flops
    together form a register; many registers form RAM.
    The clocked (synchronous) variant adds a clock signal to coordinate
    state changes across the circuit.
  ],
  list(
    [Explain what a combinational circuit is.],
    [Construct the half-adder circuit and verify its truth table.],
    [Explain the role of the carry bit in multi-bit addition.],
    [#extension Describe how two half-adders form a full adder.],
    [#extension Explain how a flip-flop stores one bit and connects to the idea of RAM.],
    [#challenge Construct a NOT gate from a single NAND gate.],
  ),
  notes: [Circuit diagrams are the most visually demanding part of this unit.
          Build the half-adder slowly on the board before students work
          independently. Physical logic gate kits — if available — make
          excellent hands-on material here.],
)

#lesson(
  "18",
  "Networks and the Internet",
  [
    *What is a network?*
    A network is a set of devices (nodes) connected to share data and resources.
    Networks scale from two computers linked by a cable to a global system
    of billions of devices.

    *LAN and WAN:*
    LAN (Local Area Network) — devices in a single physical location (home,
    school, office). WAN (Wide Area Network) — networks spanning large
    distances, typically connecting multiple LANs. The internet is the
    largest WAN.

    *Physical infrastructure:*
    Wired: Ethernet cables (copper), fiber-optic cables (light pulses —
    faster, longer range). Wireless: Wi-Fi (radio waves, short range),
    mobile data (4G/5G, longer range). Switches connect devices within a
    LAN. Routers connect different networks and direct traffic between them.

    *IP addresses:*
    Every device on a network needs a unique address. IPv4: four 8-bit
    decimal values separated by dots (e.g. 192.168.1.1), yielding ~4.3
    billion addresses — now exhausted. IPv6: 128-bit addresses (e.g.
    2001:0db8::1), providing a practically unlimited supply. Private
    addresses (192.168.x.x, 10.x.x.x) are used inside LANs; NAT
    (Network Address Translation) lets multiple devices share one public IP.

    *DNS — the Domain Name System:*
    Humans use domain names (e.g. example.com); computers use IP addresses.
    DNS is the distributed "phone book" that translates one to the other.
    The lookup chain: local cache → recursive resolver (your ISP or 1.1.1.1)
    → root nameserver → top-level domain nameserver (.com, .ch, …)
    → authoritative nameserver for the domain. The result is cached at each
    level to reduce future lookup time.

    *Packets and packet switching:*
    Data is broken into small, fixed-size packets. Each packet carries a
    header with source IP, destination IP, and sequence number. Packets
    from the same message may travel via different routes and arrive out
    of order; the destination reassembles them. Routers inspect each
    packet's destination address and forward it toward the destination
    using a routing table. Packet switching (vs. circuit switching used in
    old telephone networks) makes the network resilient: a failed link
    simply causes packets to be routed around it — the original design
    goal of ARPANET (1969, the precursor to the internet).

    *Protocols:*
    A protocol is a precise, agreed set of rules for how devices communicate.
    — *IP* (Internet Protocol): addressing and routing of packets.
    — *TCP* (Transmission Control Protocol): reliable, ordered delivery —
      every packet is acknowledged; missing packets are retransmitted.
      Used where completeness matters: web pages, email, file downloads.
    — *UDP* (User Datagram Protocol): fast, connectionless, no acknowledgement.
      A lost packet is simply skipped. Used where speed matters more than
      completeness: video calls, live streaming, online gaming.
    TCP/IP together form the foundation of internet communication.

    *HTTP and HTTPS:*
    HTTP (HyperText Transfer Protocol): the application-layer protocol
    browsers use to request and receive webpages. A browser sends an
    HTTP GET request to the server's IP address on port 80; the server
    responds with the requested HTML, CSS, JavaScript, and images.
    HTTPS adds TLS (Transport Layer Security) encryption: the data is
    encrypted between browser and server so that routers and ISPs cannot
    read the content. Indicated by the padlock icon; port 443.
    Connection to Unit 1: every page students published is served over HTTP
    or HTTPS; every `fetch()` call in JavaScript uses this protocol.

    *The internet vs. the World Wide Web:*
    The internet is the infrastructure: physical cables, wireless links,
    routers, IP addressing, and the TCP/IP protocol stack.
    The World Wide Web is one service that runs on top of it: a collection
    of hyperlinked documents accessed via HTTP. Other internet services
    include email (SMTP, IMAP), file transfer (FTP), video calls (WebRTC,
    which uses UDP), and DNS itself.

    *Cold-open call-back:*
    Return to the Lesson 9 mind map and annotate it with correct terminology.
    Trace the full journey of a webpage request step by step:
    (1) user presses Enter — browser has a domain name;
    (2) DNS lookup → IP address obtained;
    (3) TCP connection established (three-way handshake);
    (4) browser sends HTTP GET request;
    (5) server reads the file from disk (HDD/SSD — Lesson 10);
    (6) server sends HTTP response — HTML as bytes;
    (7) bytes are binary data (Lesson 12), encoding ASCII/UTF-8 text (Lesson 14);
    (8) browser parses HTML using software (Lesson 11) running on hardware
        (Lesson 10) and renders the page on screen.

    *Live demonstration:* run `traceroute gymnasium-muttenz.ch` (or `tracert`
    on Windows) in class to show packet hops across real routers.
  ],
  list(
    [Define network, LAN, and WAN with examples.],
    [Explain what an IP address is and why every networked device needs one.],
    [Describe what DNS does and why domain names exist.],
    [Explain packet switching and why it makes networks resilient.],
    [Distinguish TCP and UDP and give a suitable use case for each.],
    [Describe the HTTP request–response cycle.],
    [Explain what HTTPS adds to HTTP and why it matters.],
    [Distinguish the internet from the World Wide Web.],
    [#extension Trace a complete webpage request end-to-end, naming every protocol and layer.],
  ),
  notes: [The cold-open call-back at the end of this lesson is the payoff for
          the whole unit — students who have worked through all ten lessons will
          now be able to answer the Lesson 9 question properly. Reserve at least
          10–15 minutes for it. The `traceroute` demonstration is brief and
          memorable — highly recommended.],
)

// ─────────────────────────────────────────────────────────────────────────────
// ASSESSMENT
// ─────────────────────────────────────────────────────────────────────────────

= Assessment

== Binary and Encoding Test (after Lesson 15)

Covers Lessons 12–15. Recommended as a 45-minute written test.

#table(
  columns: (1fr, auto),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Topic],
    text(size: 9pt, weight: "bold", fill: white)[Approx. weight],
  ),
  [Binary ↔ decimal conversion (both directions)], [25%],
  [Fixed-width notation and overflow], [15%],
  [2's complement — represent a negative number; verify a subtraction], [20%],
  [ASCII / Unicode — encode and decode short text], [20%],
  [Image representation — pixels, color depth, file size calculation], [15%],
  [Audio — sampling rate and bit depth concepts], [5%],
)

== Gates and Circuits Test (after Lesson 17)

Covers Lessons 16–17. Can be merged with the binary test if scheduling
is tight; keep it separate if possible to avoid overloading students.

#table(
  columns: (1fr, auto),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Topic],
    text(size: 9pt, weight: "bold", fill: white)[Approx. weight],
  ),
  [Identify gates from their diagram symbols], [20%],
  [Complete truth tables for given gates or simple circuits], [40%],
  [Write Boolean expressions for gates and circuits], [20%],
  [Explain the half-adder (truth table and purpose)], [20%],
)

== End-of-Unit Oral Discussion (after Lesson 18)

The cold-open question — "What happens when you type a URL and press Enter?" —
makes an excellent five-minute oral prompt for individual or small-group
assessment. A student who can answer it fluently, correctly naming hardware
components, binary representation, character encoding, and network protocols,
has understood the full unit. The annotated mind-map from Lesson 9, corrected
and elaborated over the course of the unit, can serve as a portfolio artifact.
