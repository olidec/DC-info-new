// ─────────────────────────────────────────────────────────────────────────────
// Lesson 1 — Setup & Software Installation
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "Setup & Software Installation"
#let lesson-subtitle = "Getting your tools ready"

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
  [Install Visual Studio Code and Git on your personal device.],
  [Verify that both tools are working from the VS Code terminal.],
  [Install the Tinymist extension and write your first Typst document.],
)

= The Tools We Will Use This Year

This course uses three tools that professional developers use every day.
You will use them constantly — not just in this unit, but throughout the year.
It is worth taking the time now to set them up properly.

- *Visual Studio Code* (VS Code) is the program we write code in. It is a
  text editor with a built-in terminal, a file browser, and extensions that
  understand different programming languages.

- *Git* is a version control system. It tracks every change you make to
  your files and lets you go back to any previous version. It also lets you
  share your work with others — and with your teacher.

- *GitHub* is a website that stores your Git repositories online. We will use
  it through a system called GitHub Classroom, which is how you will receive
  and submit your work.

#infobox(
  "These tools are industry standard",
  [VS Code is used by millions of developers worldwide. Git is used by
   virtually every software team on the planet. Learning them now means you
   are building skills that will be useful far beyond this classroom.],
)

= Installing Visual Studio Code

VS Code is a free text editor made by Microsoft. It runs on Windows and macOS.

#block(breakable: false)[
== Download and install

#steps(
  [Open a browser and go to #link("https://code.visualstudio.com").
   The website will detect your operating system automatically.],
  [Click the large *Download* button. The installer will download to your
   Downloads folder.],
  [Open the downloaded file and follow the installer.
   *Windows:* accept all default options. When you see the option
   "Add to PATH", make sure it is checked. \
   *macOS:* drag the VS Code icon into your Applications folder.],
  [Open VS Code. You should see a welcome screen with some tips and
   recent files. You can close this tab.],
)
]

#warnbox(
  "⚠ Blocked by the school network?",
  [If the download does not start or is blocked, let the teacher know.
   An offline installer is available. Do not try to work around the
   network block yourself.],
)

== A quick tour of the interface

When VS Code opens, you will see several areas. You do not need to know
all of them today, but it helps to know where things are:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Area],
    text(size: 9pt, weight: "bold", fill: white)[What it is],
  ),
  [Activity Bar],
    [The column of icons on the far left. Used to switch between the file
     explorer, search, source control, and extensions.],
  [Explorer],
    [The file and folder panel that opens when you click the top icon in
     the Activity Bar. This is where you navigate your project files.],
  [Editor],
    [The large central area where you write code. You can have multiple
     files open as tabs.],
  [Terminal],
    [A panel at the bottom of the window where you can type commands
     directly to your computer. We will open this in a moment.],
)

= Understanding the File System

Before we install Git and start working with files, we need to talk about
something that causes a lot of confusion: *where files actually live on
your computer*.

You are probably used to finding files through search, or by clicking
recent documents in an application. That works fine for everyday use.
But when writing code, you need to know *exactly* where a file is — its
precise location in the folder structure of your computer. Git, the
terminal, and VS Code all depend on this.

#block(breakable: false)[
== The folder tree

Every file on your computer lives inside a folder. That folder lives inside
another folder. That folder lives inside another, and so on, all the way
up to the very top of your storage drive. This structure is called the
*file system*, and it looks like a tree with many branches.
]

On *Windows*, the top of the tree is usually your C: drive:

```
C:\
└── Users\
    └── yourname\
        ├── Desktop\
        ├── Documents\
        ├── Downloads\
        └── ...
```

On *macOS*, the top of the tree is simply `/` (called the "root"):

```
/
└── Users/
    └── yourname/
        ├── Desktop/
        ├── Documents/
        ├── Downloads/
        └── ...
```

The full address of a file — from the top of the tree down to the file
itself — is called its *path*. For example:

- Windows: `C:\Users\yourname\Documents\cs-course\notes.typ`
- macOS: `/Users/yourname/Documents/cs-course/notes.typ`

When you open the terminal, it always starts somewhere in this tree.
The command `pwd` (*print working directory*) tells you exactly where you are.

== The OneDrive problem on Windows

This is the most common source of confusion for Windows users, so read
this carefully.

Windows computers that are signed into a Microsoft account often have
*two* versions of common folders:

#block(breakable: false)[
#table(
  columns: (1fr, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Local folder],
    text(size: 9pt, weight: "bold", fill: white)[OneDrive folder],
  ),
  [`C:\Users\you\Documents`],        [`C:\Users\you\OneDrive\Documents`],
  [`C:\Users\you\Desktop`],          [`C:\Users\you\OneDrive\Desktop`],
)
]

Both appear as "Documents" and "Desktop" in File Explorer. They look
identical. But they are *different locations*. If you save a file in one
and look for it in the other, it will not be there.

#warnbox(
  "⚠ Our recommendation: stay local",
  [For this course, always save your work in the *local* folder —
   not the OneDrive one. OneDrive can interfere with Git in unexpected
   ways, and files syncing to the cloud mid-commit can cause errors that
   are very difficult to diagnose. \
   \
   *How to tell them apart:* in File Explorer, right-click on the Documents
   or Desktop folder and choose *Properties*. The *Location* tab shows the
   full path. If the path contains `OneDrive`, it is the cloud-synced
   version. Use the one that does not.],
)

== Where to keep your course files

We will keep all course files in a single folder that you create now.
This avoids the confusion of having files scattered across multiple locations.

#steps(
  [Open File Explorer (Windows) or Finder (macOS).],
  [Navigate to your *local* Documents folder.
   *Windows:* make sure the path does NOT contain `OneDrive`. \
   *macOS:* the standard Documents folder is always local unless you have
   explicitly enabled iCloud Drive syncing for it.],
  [Create a new folder called `cs-course` inside Documents. \
   This is where everything for this course will live.],
  [Inside `cs-course`, create a folder called `lesson-01`. \
   As the year progresses, you will create a new folder for each lesson
   or project.],
)

Your file structure should now look like this:

```
Documents/
└── cs-course/
    └── lesson-01/
```

#infobox(
  "Keep this structure tidy",
  [A well-organised file system is a habit, not an accident. Every time
   you start something new in this course, create a folder for it with a
   clear name. Never save course files to the Desktop or Downloads folder
   — those are temporary locations, not permanent ones.],
)

= Installing Git

Git is a separate program from VS Code. We install it on its own and then
VS Code connects to it automatically.

== Windows

#steps(
  [Go to #link("https://git-scm.com/download/win").
   The download should start automatically.],
  [Run the installer. Most options can be left at their defaults.
   When asked to choose a default editor, select *Use Visual Studio Code
   as Git's default editor*.],
  [When asked to adjust your PATH environment, choose
   *Git from the command line and also from 3rd-party software*.
   Leave everything else at the default.],
  [Click through the remaining screens and finish the installation.],
)

== macOS

#steps(
  [Open the *Terminal* app. You can find it by pressing
   #box(fill: light, inset: (x:4pt, y:2pt), radius: 2pt)[⌘ Space]
   and typing "Terminal".],
  [Type the following command and press Return:
   ```
   git --version
   ```],
  [If Git is not installed, macOS will offer to install the
   *Xcode Command Line Tools*. Click *Install* and wait for it to finish.
   This may take a few minutes.],
  [Once it is done, run `git --version` again to confirm the installation.],
)

#infobox(
  "Why do we install Git separately?",
  [VS Code is an editor — it does not include Git itself. The two programs
   work together: VS Code provides a graphical interface for Git operations,
   but Git does the actual work underneath. You need both.],
)

= Verifying Your Installation

Once both programs are installed, let us check that everything is working.
We will do this from the *integrated terminal* inside VS Code — a terminal
window that opens directly inside the editor.

== Opening the terminal in VS Code

#steps(
  [Open VS Code.],
  [Open the terminal panel via the menu: *Terminal → New Terminal*. \
   A panel will appear at the bottom of the window with a command prompt.],
)

== Running the checks

Type each of the following commands and press Enter after each one.
You are looking for a version number in response — any version is fine.

```
git --version
```

You should see something like: `git version 2.44.0`

```
code --version
```

You should see something like: `1.89.0`

#warnbox(
  "⚠ Seeing an error instead?",
  [If you see `command not found` or similar, the program either did not
   install correctly, or it was not added to your PATH. Let the teacher
   know which command failed and what the error message says.],
)

If both commands print a version number, your setup is complete.

== Configuring Git

Before you can make your first commit, Git needs to know who you are.
This is a one-time setup — you only need to do it once per computer.

Type the following two commands in the terminal, replacing the placeholder
text with your own name and email address. Press Enter after each one.

```
git config --global user.name "Your Name"
```

```
git config --global user.email "your@email.com"
```

#infobox(
  "Which email address should I use?",
  [Use the same email address you plan to sign up to GitHub with in
   Lesson 2. If you are not sure yet, use your regular personal email.
   You can always change it later with the same commands. \
   \
   This information is used by Git internally to label your commits.
   It is not shared with or distributed to any third party.],
)

To verify that Git has saved your details, run:

```
git config --global --list
```

You should see your name and email printed in the terminal.
You are now ready to move on.

= Installing Tinymist and Writing Your First Typst Document

The last tool we set up today is *Tinymist* — a VS Code extension for a
document language called *Typst*. You will use Typst throughout this course
to write notes and reflect on your learning.

#infobox(
  "What is Typst?",
  [Typst is a way of writing formatted documents using plain text — similar
   in idea to LaTeX, but much simpler to learn. You write text with some
   simple markup, and Typst turns it into a clean PDF. Because Typst files
   are plain text, they work perfectly with Git: every change to your notes
   is tracked automatically alongside your code.],
)

== Installing the Tinymist extension

#steps(
  [In VS Code, open the Extensions panel via *View → Extensions*, or click
   the *Extensions* icon in the Activity Bar on the left (it looks like
   four squares with one detached).],
  [In the search box, type *Tinymist*.],
  [Click *Install* on the extension called *Tinymist Typst*.
   Wait for the installation to finish.],
)

== Creating your first Typst file

#steps(
  [In VS Code, open the Explorer panel (top icon in the Activity Bar).],
  [Open the `cs-course/lesson-01` folder you created earlier using
   *File → Open Folder* and navigating to it.],
  [Inside this folder, create a new file called `notes.typ`. Click the
   *New File* icon in the Explorer panel (hover over the panel to reveal it),
   type `notes.typ`, and press Enter.],
  [Click the *preview* button that appears in the top-right corner of the
   editor when a `.typ` file is open (it looks like a split screen). A
   live preview panel will open on the right.],
)

== The basics of Typst markup

Typst files are plain text. Here is the minimum you need to know today:

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[You write],
    text(size: 9pt, weight: "bold", fill: white)[You get],
    text(size: 9pt, weight: "bold", fill: white)[Notes],
  ),
  [`= Heading`],      [A large section heading],   [One `=` for level 1],
  [`== Subheading`],  [A smaller subheading],       [Two `==` for level 2],
  [`*bold text*`],    [*Bold text*],                [Wrap in asterisks],
  [`_italic text_`],  [_Italic text_],              [Wrap in underscores],
  [#raw("`code`")],   [`inline code`],              [Wrap in backticks],
  [blank line],       [New paragraph],              [Just leave a blank line],
)

== Your first notes entry

Copy the following into your `notes.typ` file and watch the preview update
as you type. Then replace the placeholder text with your own words.

```typst
= Lesson 1 — Setup & Software Installation

== What I installed today

Today I installed *Visual Studio Code* and *Git* on my computer.
VS Code is the editor I will write all my code in.
Git is a tool that tracks changes to my files.

I also installed the _Tinymist_ extension, which lets me write
Typst documents like this one directly in VS Code.

== What I found difficult

// Replace this with something honest — what actually gave you trouble?

== What I am still unsure about

// Replace this with a genuine question you still have.
```

#infobox(
  "The learning log habit",
  [From now on, you will add a short entry to your notes at the end of
   every lesson. It does not need to be long — three or four honest
   sentences is enough. The goal is to get into the habit of reflecting
   on what you have learned, not to produce a perfect document.],
)

= Summary

By the end of this lesson you should have:

#checklist(
  [VS Code installed and open on your machine.],
  [Git installed and confirmed with `git --version` in the VS Code terminal.],
  [Git configured with your name and email (`git config --global --list`).],
  [Tinymist installed and a `notes.typ` file created with your first entry.],
)

If anything on this list is not yet done, finish it before the next lesson.
*Lesson 2 builds directly on this setup* — you will need Git and VS Code
working in order to participate.
