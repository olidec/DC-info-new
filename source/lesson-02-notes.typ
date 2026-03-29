// ─────────────────────────────────────────────────────────────────────────────
// Lesson 2 — Git & GitHub
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "Git & GitHub"
#let lesson-subtitle = "Tracking your work and sharing it"

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
  [Understand what Git is and why version control matters.],
  [Know the key concepts: repository, staging area, commit, push, pull.],
  [Create a GitHub account and accept a GitHub Classroom assignment.],
  [Complete the full workflow: clone → edit → stage → commit → push.],
)

= What is Version Control?

Imagine you are writing an essay. You save it as `essay.docx`. Then you make
changes and save again. A week later you realise the earlier version was better
— but it is gone. So you start saving copies: `essay_v2.docx`,
`essay_final.docx`, `essay_final_REAL.docx`. This gets messy quickly.

*Version control* solves this problem. Instead of keeping multiple copies of
files, you keep one copy and let a tool record every change you make, along
with a description of what changed and when. You can go back to any point in
the history at any time.

*Git* is the most widely used version control system in the world. It was
created in 2005 by Linus Torvalds — the same person who created the Linux
operating system — specifically to manage large, complex software projects.
Today it is used by virtually every professional software team on the planet.

#infobox(
  "Version control is not just for code",
  [Git works with any plain text file — including the Typst notes you started
   writing in Lesson 1. Your entire `cs-course` folder, notes and code
   together, can be tracked by Git. This means your learning log is version
   controlled too.],
)

= Key Concepts

Before we start using Git, we need to understand a handful of terms.
These will come up constantly, so it is worth being clear about them now.

#block(breakable: false)[
== Repository

A *repository* (often shortened to *repo*) is a folder that Git is tracking.
It looks like a normal folder on your computer, but it contains a hidden
folder called `.git` that stores the entire history of every change ever made.

When you create a repository, you are telling Git: "watch this folder and
remember everything that happens here."
]

== Commit

A *commit* is a saved snapshot of your files at a specific point in time.
Think of it like a photograph: it captures exactly what every tracked file
looks like at the moment you take it.

Every commit has two parts:
- The *changes* — what was added, removed, or modified since the last commit.
- A *commit message* — a short description you write explaining what changed
  and why.

Good commit messages are important. "fixed stuff" tells you nothing. "Add
navigation bar to index.html" tells you exactly what to expect.

#infobox(
  "Commit often, in small steps",
  [A common mistake is to work for a long time and then make one large commit
   at the end. This makes the history hard to read and makes it difficult to
   go back to a specific point. Instead, commit every time you finish a small,
   logical piece of work — after adding a new section, fixing a specific
   problem, or completing a single feature.],
)

== The Staging Area

Before a change becomes part of a commit, it passes through the *staging area*
(also called the *index*). This is a waiting room where you collect the
changes you want to include in your next commit.

This two-step process — stage, then commit — gives you fine-grained control.
If you have changed three files but only two of them are ready, you can stage
just those two and commit them, leaving the third for later.

In VS Code, staging a file is as simple as clicking a `+` button next to it
in the Source Control panel. We will see this in a moment.

== Local and Remote Repositories

So far we have only talked about a repository on your own computer. This is
called the *local* repository.

Git also lets you link your local repository to a copy stored on a server
somewhere on the internet. This is called the *remote* repository. In this
course, the remote is always on *GitHub*.

The two main operations that move changes between local and remote are:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Operation],
    text(size: 9pt, weight: "bold", fill: white)[What it does],
  ),
  [*Push*],
    [Sends your local commits to the remote repository on GitHub.
     Your teacher can see your work after you push.],
  [*Pull*],
    [Downloads any changes from the remote repository to your local copy.
     Used when the remote has changes you do not have locally yet.],
  [*Clone*],
    [Creates a local copy of a remote repository for the first time.
     This is how you get a GitHub Classroom assignment onto your computer.],
)

#infobox(
  "The golden rule",
  [*Push* early and often. A commit that only exists on your local machine
   is invisible to your teacher and is lost if your computer breaks.
   Every commit should be followed by a push.],
)

= GitHub and GitHub Classroom

*GitHub* is a website that hosts Git repositories. It is free to use and
is the most popular platform of its kind. Beyond storage, it provides
tools for collaboration, issue tracking, and code review — all things you
will encounter if you continue with software development.

*GitHub Classroom* is a feature of GitHub designed for education. It lets
your teacher distribute assignment repositories to the whole class at once.
Each student gets their own private copy of the assignment repository, which
only they and the teacher can see.

== Creating a GitHub account

If you do not already have a GitHub account, create one now.

#steps(
  [Go to #link("https://github.com") and click *Sign up*.],
  [Choose a username. This will be visible to your teacher and potentially
   to others. Use something sensible — your name or initials is fine.
   Avoid usernames that are hard to read or identify.],
  [Enter your email address and choose a password.],
  [Complete the verification steps and confirm your email address.],
)

#warnbox(
  "⚠ Use an email address you can access",
  [GitHub will send a confirmation email. If you use a school email address,
   make sure you can actually receive mail on it. If not, use a personal
   address. You will need access to this account throughout the year.],
)

= Your First GitHub Classroom Assignment

Your teacher will post a link to the first GitHub Classroom assignment.
This link is how you accept the assignment and get your own copy of the
starter repository.

== Accepting the assignment

#steps(
  [Click the assignment link provided by your teacher.],
  [If prompted, sign in to GitHub.],
  [Click *Accept this assignment*. GitHub will create a private repository
   for you — this may take a few seconds.],
  [Once it is ready, GitHub will show you a link to your new repository.
   Click it and take a look around. You will see the starter files:
   `index.html`, `style.css`, `script.js`, `README.md`, and `JOURNAL.md`.],
)

== Cloning the repository in VS Code

*Cloning* means downloading the repository from GitHub to your computer so
you can work on it. You will do this inside VS Code.

#steps(
  [On your repository page on GitHub, click the green *Code* button.
   Make sure *HTTPS* is selected, then copy the URL shown.
   It will look something like:
   `https://github.com/your-classroom/assignment-yourname`],
  [Open VS Code.],
  [Open the Command Palette via *View → Command Palette*.],
  [Type `Git: Clone` and select it from the list.],
  [Paste the URL you copied from GitHub and press Enter.],
  [VS Code will ask you where to save the repository. Navigate to your
   `Documents/cs-course` folder and click *Select as Repository Destination*.],
  [When VS Code asks if you want to open the cloned repository, click
   *Open*. You should now see the assignment files in the Explorer panel.],
)

#warnbox(
  "⚠ Save inside cs-course, not inside lesson-01",
  [The cloned repository is its own folder. Save it directly inside
   `cs-course`, not inside `lesson-01`. Your structure should look like:
   ```
   cs-course/
   ├── lesson-01/
   │   └── notes.typ
   └── cs-intro/       ← the cloned assignment repo
       ├── index.html
       ├── style.css
       └── ...
   ```],
)

= Making Your First Commit

Now that you have the repository on your computer, let us make a change,
stage it, commit it, and push it to GitHub.

== Edit the README

#steps(
  [In VS Code, open the file `README.md` from the Explorer panel.],
  [You will see some placeholder text. Find the line that asks for your
   name and replace it with your actual name.],
  [Save the file with *File → Save*.],
)

== Stage the change

#steps(
  [Click the *Source Control* icon in the Activity Bar on the left
   (it looks like a branching tree). You will see `README.md` listed
   under *Changes*.],
  [Hover over `README.md` and click the *+* icon that appears to the right
   of it. This *stages* the file — it moves it from Changes to
   *Staged Changes*, ready to be committed.],
)

#block(breakable: false)[
== Write a commit message and commit

#steps(
  [At the top of the Source Control panel, you will see a text field
   labelled *Message*. Click it and type a commit message:
   ```
   Add my name to README
   ```],
  [Click the *Commit* button (the blue button with a checkmark).
   Your change is now saved as a commit in your local repository.],
)
]

== Push to GitHub

#steps(
  [After committing, VS Code will show a *Sync Changes* button
   (or a cloud icon with an arrow). Click it.],
  [VS Code may ask you to sign in to GitHub. Follow the prompts —
   you will be redirected to a browser window to authorise VS Code.],
  [Once the push is complete, go back to your repository page on GitHub
   and refresh it. You should see your name in the README.],
)

#infobox(
  "Congratulations — you just used Git professionally",
  [The workflow you just completed — edit, stage, commit, push — is
   exactly what professional developers do dozens of times a day.
   The tools get more complex, but the core loop never changes.],
)

= The Source Control Panel at a Glance

You will use the VS Code Source Control panel constantly. Here is a
quick reference for the most important parts:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Element],
    text(size: 9pt, weight: "bold", fill: white)[What it does],
  ),
  [Changes],
    [Files that have been modified since the last commit but not yet staged.],
  [Staged Changes],
    [Files that are ready to be included in the next commit.],
  [+ button],
    [Stages a single file (hover over a file to see it).],
  [Message field],
    [Where you type your commit message before committing.],
  [Commit button],
    [Creates the commit with the staged changes and your message.],
  [Sync Changes],
    [Pushes local commits to GitHub and pulls any remote changes down.],
  [U / M / D badges],
    [File status: *U* = untracked (new file), *M* = modified, *D* = deleted.],
)

= Summary

By the end of this lesson you should have:

#checklist(
  [A GitHub account that you can log into.],
  [Accepted the GitHub Classroom assignment and opened the repo in VS Code.],
  [Edited `README.md` with your name.],
  [Made your first commit with a clear commit message.],
  [Pushed your commit to GitHub and verified it appears online.],
)

If anything on this list is not yet done, complete it before the next lesson.
From Lesson 3 onwards, all your work lives in this repository — you will
need it set up and working.
