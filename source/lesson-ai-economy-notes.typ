// ─────────────────────────────────────────────────────────────────────────────
// Lesson — AI & the Economy: Ethics and Consequences
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "AI & the Economy"
#let lesson-subtitle = "Ethics, work, and who benefits when machines get smarter"

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

// ── Import shared styles ───────────────────────────────────────────────────────
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

#tier-legend

#v(0.5em)

#goals(
  [Explain the historical pattern of how technology affects labor markets.],
  [Describe how AI differs from previous waves of automation.],
  [Identify who currently benefits economically from AI and why.],
  [Research a specific AI-and-economy topic and find credible sources.],
  [Formulate questions that open up genuine disagreement and discussion.],
  [Participate in a structured group discussion, listening and responding to others.],
)

= Background: Technology and Work #h(1fr) #tier-core

Every major wave of technology has changed what work looks like —
and sparked anxiety about whether there would be enough of it to go around.

When mechanical looms were introduced in early nineteenth-century England,
weavers who had spent years mastering their craft found their skills
suddenly worthless. Some of them, the *Luddites*, responded by destroying
the machines. They were not opposed to technology in the abstract —
they were opposed to technology being used to cut their wages and eliminate
their livelihoods without any share of the gains going to them.

The word "Luddite" is now used as an insult, meaning someone who
irrationally fears new technology. This is a distortion of the history.
The Luddites were raising a legitimate question that we are still
asking today: *when technology makes production more efficient, who
gets the benefit?*

In the twentieth century, agricultural mechanization eliminated most
farm labor in wealthy countries, but those workers eventually found
work in factories and services. Factory automation then eliminated
many manufacturing jobs, but the service sector expanded to absorb
many of those workers too. Economists call this pattern *labor market
adjustment* — the idea that workers displaced from one sector
eventually find new roles in others.

Whether this pattern will hold for AI is one of the most contested
questions in economics today.

#infobox(
  "The lump of labor fallacy — and its limits",
  [One common argument against job-loss fears is the *lump of labor
   fallacy*: the idea that there is not a fixed amount of work to be
   done in an economy. New technology creates new industries and new
   kinds of work that did not exist before. Nobody in 1900 had a job
   as a web developer or a social media manager. This argument has
   been correct, historically. But it does not answer two harder
   questions: how long does adjustment take, and what happens to
   the people whose skills become obsolete during the transition?
   A worker aged 50 whose skills are no longer needed has little
   time to retrain. "The economy will adjust eventually" is cold
   comfort if you need to pay rent next month.],
)

= What Makes AI Different #h(1fr) #tier-core

Previous automation waves mostly replaced *physical* or *routine*
labor — the kind of work that follows predictable rules. A machine
that stamps metal parts does not need to think; it just repeats the
same motion. White-collar, cognitive, creative, and social work was
assumed to be safe — these tasks required judgment, flexibility,
and human understanding that machines could not replicate.

AI, and particularly the large language models and image generators
that became widely available from 2022 onwards, has changed this.
For the first time, machines can perform convincingly at tasks that
previously required education, creativity, and sophisticated judgment:

- Writing and editing text
- Generating images, music, and video
- Writing and reviewing software code
- Summarizing and analyzing legal and medical documents
- Answering complex customer queries
- Translating languages at near-human quality

These are not low-wage manual jobs. Many are the kinds of jobs that
university graduates were told to pursue because they would be
automation-proof. The disruption, if it comes, will be distributed
very differently from previous waves.

#warnbox(
  "⚠ Prediction is hard",
  [Economists and technologists have a poor track record of predicting
   how technology affects jobs. In the early days of every automation
   wave, predictions have swung between catastrophe and utopia, and
   the reality has usually been messier and more uneven than either.
   Treat confident predictions — including optimistic ones — with
   skepticism. What matters more than the prediction is understanding
   the mechanisms: who has power, who bears risk, and what choices
   are being made by whom.],
)

= Who Benefits? #h(1fr) #tier-core

When AI makes a business more productive, the value created flows
somewhere. Understanding where is central to any ethical analysis.

== Capital and labor

In economics, production combines *capital* (machines, software,
buildings, money) and *labor* (human work). When technology
increases productivity, the gains can go to capital owners
(as profit) or to labor (as higher wages, shorter hours, or cheaper
goods). Which way the gains flow depends on bargaining power,
market structure, regulation, and political choices — not just
on economics.

Historically, the introduction of labor-saving technology has tended
to benefit capital owners more than workers, particularly in the
short run and particularly when workers have weak bargaining power.
There is no automatic mechanism that distributes productivity gains
to the workers displaced by them.

== Concentration of ownership

AI development is currently dominated by a small number of very large
companies — primarily American. Training a frontier AI model requires
computing resources and datasets that only a handful of organizations
in the world can afford. This concentration of capability has
concentrated the economic gains as well.

A small group of people who invested in or founded these companies
have seen their wealth increase by amounts that would have been
considered fantastical a decade ago. Meanwhile, the workers whose
jobs are displaced by the technology have no automatic share in those gains.

== The data question

Large AI models are trained on vast quantities of human-generated
content: books, articles, artworks, code, photographs, music.
The people who created that content were not paid for it and were
not asked for permission. Writers, artists, programmers, and
musicians have begun arguing — with some success in court — that
training a commercial AI system on their work without compensation
is a form of theft.

This is not yet a settled legal or ethical question. But it is a
real one: if the economic value of an AI model derives partly from
the creative work of millions of people, do those people have a
claim on some of that value?

#infobox(
  "The training data lawsuits",
  [As of 2025, several major lawsuits are working through courts in
   the US and Europe over AI training data. The New York Times sued
   OpenAI and Microsoft, alleging that their models were trained on
   Times articles without permission. Getty Images sued Stability AI
   for training on its photo library. A group of authors including
   well-known novelists sued multiple AI companies. The outcomes will
   shape the legal framework for AI training data for years to come —
   but even if the companies win every case, the ethical question of
   whether what they did was fair remains open.],
)

= The Policy Landscape #h(1fr) #tier-extension

Societies have several tools available to shape how the gains from AI
are distributed. None of them are simple.

*Taxation* — if AI displaces workers and concentrates wealth, one
response is to tax the gains more heavily and redistribute them.
Proposals for a "robot tax" — a levy on companies that use automation
to replace workers — have been discussed in several countries.
Critics argue this would slow adoption of beneficial technology.

*Regulation* — governments can require companies to give workers
notice before automated layoffs, to retrain displaced workers, or
to justify automated hiring and promotion decisions. The EU's AI Act,
which came into force in 2024, requires transparency and human oversight
for AI systems used in high-stakes decisions about employment,
credit, and education.

*Universal basic income* — some economists and technologists
(including prominent figures in Silicon Valley) argue that if AI
eventually eliminates enough work, the right response is a universal
basic income: a regular unconditional payment to every citizen,
funded by taxing AI-generated profits. This is genuinely controversial
across the political spectrum.

*Collective bargaining* — workers have historically used unions to
negotiate over how productivity gains are shared. Several major
unions — including Hollywood writers and actors in 2023 — have
begun negotiating explicit AI provisions into their contracts,
covering when and how AI can be used and what protections workers
have.

= Lesson Plan #h(1fr) #tier-core

This lesson runs for 90 minutes and is organized in three phases.

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Time],
    text(size: 9pt, weight: "bold", fill: white)[Phase],
    text(size: 9pt, weight: "bold", fill: white)[Activity],
  ),
  [0–15 min],   [Introduction],  [Whole-class: teacher-led framing using sections 1–3 above. Goal: give students enough context to research productively. Keep it punchy — the point is to provoke questions, not answer them.],
  [15–50 min],  [Research],      [Groups of 3 receive the research card. Each group picks one topic, researches it, and writes 2–4 discussion questions. Teacher circulates.],
  [50–90 min],  [Discussion],    [Groups present their questions and facilitate a 5–8 minute class discussion on their topic. Not all groups need to present — groups choose based on what they find most engaging.],
)

== Facilitation notes

*Forming groups:* Let students choose their own groups where possible —
self-selected groups tend to be more motivated. If groups are struggling
to pick a topic after a few minutes, assign one rather than letting them
stall.

*During research:* The research card lists seed questions and starting
points for each topic, but students should go beyond them. Encourage them
to find a source they disagree with, not just one that confirms what they
already think. If groups are finding only one side of the argument,
prompt them: "What would someone who disagrees with this say?"

*Discussion format:* One group member briefly summarizes what they found
(2 minutes maximum), then poses their questions to the class. The teacher's
role during discussion is to keep the conversation moving, draw in quieter
students, and resist the urge to give the "right answer" — these questions
do not have one.

*Selecting which groups present:* Ask groups to raise their hand if they
found something surprising, something they strongly agree or disagree with,
or something that generated the most argument within their group. These
are usually the best discussions. With five or six groups in 40 minutes,
you can realistically do three to four topics in depth rather than
skimming all of them.

*Closing:* The lesson does not need a tidy conclusion. A good sign is
if students are still arguing when the bell rings. If you want a brief
closing, ask each group to name one thing they changed their mind about,
or one question they are leaving with that they did not have at the start.

== Topics on the research card

The student research card contains six topics. A brief note on each
for the teacher:

*Topic 1 — Job displacement* is the most accessible and generates
strong reactions. Students often start with strong opinions ("AI will
take all the jobs" or "people will always find new work") and the
research tends to complicate both views productively.

*Topic 2 — The training data question* connects directly to things
students have encountered (image generators, chatbots) and has a
pleasing concreteness: there are real court cases, real artists
affected, real companies defending their practices. It also links
to copyright concepts many students have a vague familiarity with.

*Topic 3 — Concentration of power* tends to attract students with
an interest in politics or economics. It can generate the most
sophisticated discussion but also the most abstract one — keep nudging
groups toward specific examples.

*Topic 4 — Universal basic income* is politically the most provocative
and reliably produces lively disagreement across political lines.
Students may have pre-formed strong opinions here; the research phase
is valuable because it forces them to engage with the strongest
version of the opposing argument.

*Topic 5 — AI in hiring* is the most personally relevant topic for
students who will be entering the job market in a few years. It also
connects cleanly to the bias content from the Ethics lesson, if that
has already been taught.

*Topic 6 — Creative work and AI* works well for students with interests
in art, music, or writing. The question of what creativity is — and
whether it can be automated — tends to generate genuine philosophical
engagement rather than just policy debate.

= Summary

#checklist(
  [You can explain why AI automation may affect different workers differently from previous waves.],
  [You can identify who currently captures most of the economic gains from AI development.],
  [You can describe the training data question and why it is ethically contested.],
  [You found at least two credible sources on your research topic and can summarize their arguments.],
  [Your group produced 2–4 discussion questions that open up genuine disagreement.],
  [You participated in at least one class discussion, building on what someone else said.],
)
