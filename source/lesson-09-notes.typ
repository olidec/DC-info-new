// ─────────────────────────────────────────────────────────────────────────────
// Lesson 9 — How Did This Page Get Here? (Unit 2 cold open)
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "How Did This Page Get Here?"
#let lesson-subtitle = "A first look at the journey of a webpage"

// Website used for all demonstrations in this lesson.
// Check before class that it loads and that `nslookup` returns an address.
#let demo-url    = "https://www.gym-muttenz.ch"
#let demo-domain = "www.gym-muttenz.ch"

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

// ── Images ────────────────────────────────────────────────────────────────────
// Fill in `file` with a path relative to the project root (e.g.
// "/images/network-tab.png", compiled with --root .) and `credit` with the
// attribution required by the image license (none for your own screenshots).
// While `file` is none, a placeholder box is shown instead.
#let lesson-images = (
  server-room:     (file: "images/server-room.jpg", credit: "Eclipse55, CC BY-SA 4.0, via Wikimedia Commons"),
  network-tab:     (file: "images/network-tab.png", credit: none),
  network-headers: (file: "images/network-headers.png", credit: none),
  nslookup-output: (file: "images/nslookup.png", credit: none),
)

#let image-slot(key, caption, width: 100%, height: 4cm) = {
  let entry = lesson-images.at(key)
  let picture = if entry.file == none {
    block(
      width: width, height: height,
      stroke: (paint: muted, thickness: 0.8pt, dash: "dashed"), radius: 3pt,
      align(center + horizon, text(size: 8pt, fill: muted)[
        Image: #caption \ (#raw(key))
      ]),
    )
  } else {
    // Fit the image inside the width × height box, keeping its proportions.
    image(entry.file, width: width, height: height, fit: "contain")
  }
  figure(
    picture,
    caption: if entry.credit == none { caption } else {
      [#caption #text(size: 7pt, fill: muted)[(#entry.credit)]]
    },
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
  [Explain the difference between opening a file on your laptop and
   loading a page over the internet.],
  [Describe, in your own words, what you think happens when you load
   a webpage.],
  [Use the *Network* tab of the developer tools to see which files a
   page is made of.],
  [Name the big questions this unit will answer.],
)

= Two Pages, Two Journeys #h(1fr) #tier-core

You have spent the last few weeks building a webpage. Today we ask a
question that sounds simple: *how does a page get onto your screen?*
We start with an experiment.

#steps(
  [Open your project folder and double-click `index.html`. Your page
   opens in the browser.],
  [Open a new tab and go to #link(demo-url)[#raw(demo-domain)].],
  [Look closely at the address bar in both tabs. Copy the first few
   characters of each address into the table below.],
  [Switch off Wi-Fi on your laptop. Reload both tabs. What happens?],
  [Switch Wi-Fi back on.],
)

#table(
  columns: (1fr, 9.5em, 9.5em),
  rows: (auto, 2.4em, 2.4em, 3.2em),
  stroke: 0.5pt + muted,
  inset: 8pt,
  table.header([], [*Your project page*], [*School website*]),
  [Beginning of the address],                  [], [],
  [Loads without Wi-Fi? (yes / no)],           [], [],
  [Where is the file stored, do you think?],   [], [],
)

#warnbox(
  "Saved copies",
  [Your browser keeps copies of pages you visited recently. If the school
   website still appears without Wi-Fi, click a link on it that you have
   not opened before.],
)

One of the two pages needs the internet and the other one does not. So
the second page must come from somewhere else — and travel to you. This
unit is about that journey, and about the machines at both ends of it.

#image-slot("server-room", [Where many websites live: a room full of servers.],
  height: 4.5cm)

= Your Prediction #h(1fr) #tier-core

#exercise(title: "What happens when you press Enter?")[
  Write down, in your own words, what you think happens between the
  moment you press Enter and the moment the school website appears on
  your screen. Write at least five sentences. Use any words you know,
  even if you are not sure exactly what they mean.

  #answer-space(lines: 8)
]

#infobox(
  "There are no wrong answers today",
  [You are not expected to know this yet. Write what you *think*. Keep
   this page: at the end of the unit you will read your prediction again
   and correct it.],
)

= Building the Map Together #h(1fr) #tier-core

As a class, we will collect the steps on the board. Copy the class map
into the boxes below. If we find more steps than there are boxes, add
them in the margin.

#{
  let step-box(body) = block(
    width: 85pt, height: 52pt,
    fill: rgb("#F0F4F8"), stroke: 1pt + accent, radius: 3pt,
    align(center + horizon, text(size: 9pt, weight: "bold", fill: primary, body)),
  )
  let empty-box = block(
    width: 85pt, height: 52pt,
    stroke: (paint: accent, thickness: 1pt, dash: "dashed"), radius: 3pt,
  )
  let arrow(dir) = align(center + horizon, text(size: 14pt, fill: accent, dir))

  align(center,
    figure(
      grid(
        columns: (85pt, 18pt, 85pt, 18pt, 85pt, 18pt, 85pt),
        row-gutter: 6pt,
        // Row 1 — left to right
        step-box[You press Enter], arrow(sym.arrow.r),
        empty-box, arrow(sym.arrow.r),
        empty-box, arrow(sym.arrow.r),
        empty-box,
        // Turn
        [], [], [], [], [], [], arrow(sym.arrow.b),
        // Row 2 — right to left
        step-box[The page appears], arrow(sym.arrow.l),
        empty-box, arrow(sym.arrow.l),
        empty-box, arrow(sym.arrow.l),
        empty-box,
      ),
      caption: [The journey of a webpage — class map. Read the second row
        from right to left.],
    )
  )
}

These words will come up while we build the map. For each one, mark
whether you have heard of it and whether you could explain it to a
classmate.

#{
  let terms = (
    "browser", "server", "URL", "request", "Wi-Fi", "router",
    "packet", "IP address", "DNS",
    "HTTP / HTTPS", "byte", "binary", "character encoding", "CPU",
    "RAM", "SSD", "operating system", "cache",
  )
  let term-table(items) = table(
    columns: (1fr, auto, auto),
    stroke: none,
    inset: (x: 6pt, y: 5pt),
    fill: (_, row) => if row == 0 { light } else { none },
    table.header(
      text(size: 9pt, weight: "bold")[Term],
      text(size: 9pt, weight: "bold")[Heard of it],
      text(size: 9pt, weight: "bold")[Could explain it],
    ),
    ..items.map(t => ([#t], align(center, tick), align(center, tick))).flatten(),
  )
  grid(
    columns: (1fr, 1fr),
    column-gutter: 16pt,
    term-table(terms.slice(0, 9)),
    term-table(terms.slice(9)),
  )
}

= Looking Under the Hood #h(1fr) #tier-core

Your browser can show you every file it fetches. You may already have
used the developer tools to read the output of `console.log`. Today we
use a different tab: *Network*.

#steps(
  [Go to the tab with the school website.],
  [Open the developer tools: `F12` or `Ctrl+Shift+I` on Windows,
   `Cmd+Option+I` on a Mac.],
  [Click the *Network* tab.],
  [Reload the page and watch the list fill up.],
)

#image-slot("network-tab", [The Network tab after reloading the page.],
  height: 5.5cm)

#hint[Using Safari? First go to *Safari → Settings → Advanced* and turn on
  *Show features for web developers* (in older versions: *Show Develop menu
  in menu bar*). The Network tab looks slightly different in every browser,
  but the information is the same.]

#image-slot("network-headers",
  [The *Headers* of a single request. Click a line in the list to see them.],
  height: 5cm)

#v(0.5em)

#exercise(title: "What did the browser fetch?")[
  + How many requests did the browser make? Look at the bar at the
    bottom of the Network tab. #blank(width: 5em)
  + Look at the very first line in the list. What is its name, and what
    type is it? Why do you think it comes first?
    #answer-space(lines: 2)
  + Find at least one image in the list. What is its file name?
    #blank(width: 12em)
  + Click the first line and open *Headers*. Find the *status code* and
    write it down: #blank(width: 4em) \
    Find the line *Remote Address* (Chrome, Edge) or *Address* (Firefox)
    and copy it: #blank(width: 12em)
  + Now open *Response*. What do you see? Does it look familiar?
    #answer-space(lines: 2)
]

#infobox(
  "Remember these",
  [The status code and the address you just found will come back later
   in this unit. For now, notice that the page did not arrive as one
   piece: the browser asked for many separate files.],
)

= The Page Is Just Text #h(1fr) #tier-extension

Right-click anywhere on the school website and choose *View Page Source*
(`Ctrl+U` on Windows, `Cmd+Option+U` on a Mac). This is the HTML file the
server sent you — the same kind of file you wrote for your project.

#exercise(title: "Reading someone else's HTML")[
  + Find three HTML tags that you also used in your project.
    #answer-space(lines: 1)
  + Find one tag you have never seen before.
    #blank(width: 10em)
  + Find an `<img>` tag. Where does its `src` attribute point? Can you
    find that file in the Network tab?
    #answer-space(lines: 2)
  + The page arrived as text. But a computer only stores 0s and 1s. How
    could text be made of 0s and 1s? Write down your guess.
    #answer-space(lines: 2)
]

= Asking for the Address Yourself #h(1fr) #tier-challenge

Websites have names like #raw(demo-domain), but the browser needs a
number to find the server. You can ask for that number yourself. Open a
terminal and type:

#raw("nslookup " + demo-domain, block: true, lang: "bash")

The first two lines of the answer describe _who answered your question_.
The address of the website comes after the line starting with `Name:`.

#image-slot("nslookup-output", [Typical output of `nslookup`.],
  width: 90%, height: 4.5cm)

#exercise(title: "Comparing addresses")[
  + Copy the address `nslookup` gives you.
    #blank(width: 14em)
  + Compare it with the address you found in the Network tab. Are they
    the same?
  + If they are not the same, or if `nslookup` gives you several
    addresses: why might one website have more than one address?
    #answer-space(lines: 3)
]

= The Questions Ahead #h(1fr) #tier-core

Every box on the class map hides a question. Over the next lessons we
will open them one by one.

#table(
  columns: (8em, 1fr),
  stroke: none,
  inset: 8pt,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Topic],
    text(size: 9pt, weight: "bold", fill: white)[The question it answers],
  ),
  [Hardware], [What machines are involved, and what is inside them?],
  [Software], [Which programs work together to show you a page?],
  [Binary],   [How can a computer store anything using only 0 and 1?],
  [Encoding], [How are letters, pictures, and sound turned into numbers?],
  [Logic],    [How can a machine built from tiny switches calculate?],
  [Networks], [How does a request find its way across the world and back?],
)

#exercise(title: "Your own question")[
  Write down one question about today's experiments that you would like
  this unit to answer.

  #answer-space(lines: 2)
]

= Summary

By the end of this lesson you should have:

#checklist(
  [Compared a page opened from your laptop with a page loaded over the
   internet.],
  [Written your prediction — keep this page for the end of the unit.],
  [Copied the class map.],
  [Used the Network tab to see the files a page is made of.],
  [Written down one question of your own.],
)
