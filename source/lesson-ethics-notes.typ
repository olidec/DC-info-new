// ─────────────────────────────────────────────────────────────────────────────
// Lesson — Ethics in Computing
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "Ethics in Computing"
#let lesson-subtitle = "Who is responsible for what software does?"

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

#tier-legend

#v(0.5em)

#goals(
  [Explain why ethics is relevant to computing and software development.],
  [Identify the stakeholders affected by a technology and articulate their interests.],
  [Recognize common ethical problems in software: bias, dark patterns, and accessibility.],
  [Apply a simple ethical framework to reason through a real-world dilemma.],
  [Distinguish between individual responsibility and systemic responsibility.],
  [Form and defend a reasoned position on a contested technology question.],
)

= Why Should Engineers Think About Ethics? #h(1fr) #tier-core

A bridge engineer who builds a faulty bridge bears some responsibility
for the consequences. A pharmacist who dispenses the wrong medication
is liable. We accept that people who build physical things have an
obligation to consider the effects of their work.

Software engineers have been slower to adopt this view. For a long time,
the prevailing attitude in the industry was that code is neutral — a tool
that can be used for good or ill, but whose moral weight lies entirely
with the user. The programmer just builds the thing; what happens after
is someone else's problem.

This view has become harder to defend. Software is now embedded in
hiring decisions, criminal sentencing, medical diagnosis, financial
lending, and the information that billions of people see every day.
When code shapes outcomes for real people, the people who wrote it
are part of the causal chain — and with causation comes responsibility.

#infobox(
  "Scale changes the stakes",
  [A single human making biased decisions affects a limited number of
   people. An algorithm making biased decisions can affect millions,
   at a speed no human could match, with errors that are harder to
   detect and challenge. This is not an argument against automation —
   it is an argument for taking its design seriously. The scale that
   makes software powerful also amplifies the consequences of getting
   it wrong.],
)

= Stakeholder Thinking #h(1fr) #tier-core

A useful first step when evaluating a technology ethically is to ask:
*who is affected by this, and how?*

The people affected by a system are called its *stakeholders*. They
include people who use the system directly, but also people who are
affected by its outputs even if they never interact with it.

Consider a system that automatically reviews job applications and
ranks candidates:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Stakeholder],
    text(size: 9pt, weight: "bold", fill: white)[Their interest],
  ),
  [The company using the system],
    [Process applications quickly and cheaply; hire good candidates.],
  [Applicants who are ranked highly],
    [A fair review of their qualifications; to advance in the process.],
  [Applicants who are filtered out],
    [To know why; to have a chance to appeal; to not be disadvantaged
     by irrelevant factors.],
  [The developers who built it],
    [To build something that works well and does not cause harm.],
  [Society],
    [Fair employment practices; diverse workplaces; no discrimination.],
)

Stakeholder analysis does not resolve ethical questions by itself —
stakeholders can have conflicting interests — but it ensures you are
asking the right questions before making decisions.

= Common Ethical Problems in Software #h(1fr) #tier-core

== Algorithmic bias

*Bias* in a machine learning system means that the system makes
systematically worse predictions for certain groups of people.

The most common source is *biased training data*. A system learns
from historical data — and if the historical data reflects past
discrimination, the system learns to replicate it.

A well-documented example: in 2018, Amazon scrapped an internal
recruiting tool after discovering it penalized résumés that included
the word "women's" (as in "women's chess club") and downgraded
graduates of all-women's colleges. The system had been trained on
ten years of Amazon's own hiring decisions, which skewed heavily male.
It learned to prefer candidates who looked like previous successful
hires — which meant it learned to discriminate against women.

#warnbox(
  "⚠ Bias is not always intentional",
  [No one at Amazon sat down and decided to build a sexist tool.
   The bias emerged from the data — and the data reflected real
   historical inequalities. This is what makes algorithmic bias
   particularly insidious: a system can be discriminatory without
   anyone intending it to be, and without anyone noticing until
   the damage is done.],
)

Bias can also arise from the choice of what to optimize for.
Predictive policing systems, used in some cities to forecast where
crimes are likely to occur, have been shown to create feedback loops:
they direct police to historically over-policed neighborhoods, those
neighborhoods generate more arrests, and the data confirms the
original prediction. The outcome depends on what the system was
asked to maximize — not on any neutral reading of reality.

== Dark patterns

A *dark pattern* is a user interface design that deliberately tricks
or manipulates users into doing things they did not intend.

The term was coined by UX designer Harry Brignull in 2010. Common examples:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Pattern],
    text(size: 9pt, weight: "bold", fill: white)[How it works],
  ),
  [Roach motel],
    [Easy to sign up, very difficult to cancel — settings buried
     deep in menus, cancellation forms that require a phone call.],
  [Hidden costs],
    [Extra fees added at the last step of checkout, after the user
     has already committed mentally to the purchase.],
  [Confirmshaming],
    [Opt-out buttons phrased to make declining feel bad:
     "No thanks, I don't want to save money."],
  [Misleading defaults],
    [Pre-ticking boxes for newsletter subscriptions or data sharing
     that users must actively uncheck.],
  [Misdirection],
    [Drawing attention to one part of the interface while a critical
     action happens elsewhere — for example, a prominent "Skip"
     button next to a quietly pre-selected paid option.],
  [Privacy zuckering],
    [Confusing privacy settings designed so that users share more
     than they intended, named after Facebook founder Mark Zuckerberg.],
)

You have already built HTML forms and CSS layouts. You know how easy
it would be to make one button large and bright and the other small
and grey. Dark patterns are not a technical challenge — they are a
choice. A choice that the people who design and build an interface make.

== Accessibility

*Accessibility* means designing technology so that it can be used by
people with a wide range of abilities, including disabilities. On the web,
this includes people who are blind and use screen readers, people with
motor impairments who cannot use a mouse, people with color blindness,
or people with cognitive disabilities.

Many accessibility failures are simple to avoid:

- An image without an `alt` attribute is invisible to a screen reader
  — you have already learned that this is required.
- A color contrast ratio that is too low makes text unreadable for
  people with low vision.
- A form that cannot be completed using only a keyboard excludes users
  who cannot use a mouse.
- A video without captions excludes deaf users.

#infobox(
  "The curb-cut effect",
  [Curb cuts — the small ramps at pedestrian crossings — were introduced
   to help wheelchair users. But they also help people with pushchairs,
   delivery workers with trolleys, cyclists, and people with temporary
   injuries. Accessibility features almost always improve the experience
   for everyone. Captions help people watching in noisy environments.
   High contrast helps people in bright sunlight. Keyboard navigation
   helps power users who prefer not to move their hands to the mouse.
   Designing for accessibility is designing for everyone.],
)

= Ethical Frameworks #h(1fr) #tier-extension

When facing an ethical dilemma, it helps to have a structured way
to think through it. Philosophy offers several frameworks, each
emphasizing different things.

== Consequentialism

*Consequentialism* judges actions by their outcomes. The morally right
action is the one that produces the best overall consequences — the
greatest good for the greatest number of people.

Applied to technology: a consequentialist evaluation of a facial
recognition system would ask whether the total benefit (solving crimes,
finding missing persons) outweighs the total harm (wrongful identifications,
surveillance of innocent people, chilling effects on free assembly).

The difficulty: consequences are hard to predict, especially at scale.
And it can seem to justify harming a small group if the benefit to a
large group is big enough — a troubling conclusion.

== Deontology

*Deontology* judges actions by whether they follow certain rules or
duties, regardless of outcomes. The most famous deontological principle
is Kant's *categorical imperative*: act only according to rules you
would be willing to see universalized — applied to everyone, everywhere.

Applied to technology: a deontological view might hold that collecting
data without consent is wrong *regardless* of what the data is used for,
because it treats people as means to an end rather than as ends in
themselves.

The difficulty: different duties can conflict, and the framework does
not help when two valid rules point in opposite directions.

== Virtue ethics

*Virtue ethics* asks not "what is the right action?" but "what kind
of person should I be?" It focuses on character traits — honesty,
fairness, courage, compassion — and asks what a person of good character
would do in this situation.

Applied to technology: rather than evaluating each decision in isolation,
virtue ethics asks whether the culture of an organization reflects good
values. Does the company behave honestly with users? Does it act
with integrity under commercial pressure?

#infobox(
  "No framework is complete",
  [These frameworks are not competing answers to the same question —
   they are different lenses that illuminate different aspects of a
   situation. A thoughtful ethical analysis uses all of them. Consequentialist
   thinking forces you to consider real-world impact. Deontological thinking
   protects individual rights from being sacrificed for aggregate benefit.
   Virtue ethics reminds you that ethics is about who you are, not just
   what you calculate.],
)

= A Framework for Analyzing Ethical Dilemmas #h(1fr) #tier-extension

When working through an ethical problem, the following questions provide
a useful structure:

#steps(
  [*Who is affected?* Identify all stakeholders — not just the obvious ones.
   Include people who are affected indirectly, or who have no voice in
   the decision.],
  [*What are the competing interests?* Articulate what each stakeholder
   wants or needs. Note where interests align and where they conflict.],
  [*What are the likely consequences?* Think through what happens in the
   short and long term if this system is deployed. Who benefits? Who is
   harmed? What are the worst-case scenarios?],
  [*Are any rights or duties at stake?* Are there things that should
   not be done regardless of the outcome — promises that must be kept,
   rights that must be respected?],
  [*Who is responsible?* Identify who has the power to make decisions,
   and who bears the consequences. Are these the same people?],
  [*What would a person of good character do?* If you imagine someone
   you genuinely respect — someone honest, fair, and courageous — what
   would they decide in this situation?],
)

There is rarely a clean answer that satisfies every question perfectly.
The goal is not to find a formula — it is to make a *reasoned* decision
and be able to defend it honestly.

= Responsibility: Individual vs. Systemic #h(1fr) #tier-extension

A common response to ethical criticism of technology is to point to
individual bad actors: one engineer made a bad call, one executive
approved a harmful feature. Fix the individual, fix the problem.

This misses something important. Many harmful outcomes in technology
are not the result of any single bad decision — they are the product
of systems where each individual step seemed reasonable, but the
overall outcome was harmful.

Consider a social media feed algorithm optimized for *engagement* —
time spent on the platform. No single engineer decided to radicalize
users or spread misinformation. But a system that rewards content
provoking strong emotional reactions tends to surface outrage, fear,
and conflict, because those emotions keep people scrolling.
Everyone did their job. The harm emerged from the structure.

This means that individual ethics — choosing to do the right thing in
your own work — is necessary but not sufficient. Systemic problems
require systemic responses: regulation, professional standards,
organizational accountability, and a willingness to ask whether the
incentive structures around technology are pointing in good directions.

#warnbox(
  "\"I was just following orders\" is not a defense",
  [The history of the twentieth century contains many examples of people
   who caused serious harm while following instructions and believing they
   were doing their job. Computer scientists are not exempt from this
   lesson. Working within a system that produces harmful outcomes does not
   remove individual responsibility — particularly when you have the
   technical knowledge to recognize the harm. The question "is this
   technically possible?" is always distinct from "should we do this?"],
)

= Case Study: Content Moderation #h(1fr) #tier-challenge

Content moderation is one of the hardest problems in technology ethics.
Social media platforms must decide what content is allowed on their
services — and there is no neutral answer.

Remove too little: the platform becomes a venue for harassment,
misinformation, and incitement to violence. Real people are harmed.

Remove too much: the platform suppresses legitimate speech. Marginalized
communities often find their content removed at higher rates than others.
Governments pressure platforms to silence political opposition.

The platforms making these decisions are private companies, not
democratic institutions. They have commercial incentives that may not
align with the public interest. They operate globally across legal
systems with very different views on free expression. And they make
billions of moderation decisions per day — far too many for human review.

Questions worth considering:

- Who should decide what speech is acceptable online? The platform?
  Governments? Users? Independent bodies?
- How should moderation systems account for the fact that the same
  words can mean very different things in different cultural contexts?
- If an algorithm makes a moderation error, who is responsible —
  the engineer who built it, the manager who deployed it, or the
  company as a whole?
- Should platforms be treated as publishers (responsible for all content)
  or as neutral infrastructure (responsible for none of it)? What are
  the consequences of each answer?

There is no tidy resolution to these questions. That is the point. They
require ongoing democratic deliberation — which in turn requires citizens
who understand enough about how these systems work to participate
meaningfully in that deliberation.

= Summary

#checklist(
  [You can explain why software developers have ethical responsibilities,
   not just technical ones.],
  [You can identify the stakeholders in a technology scenario and articulate
   their interests.],
  [You can describe algorithmic bias, dark patterns, and accessibility failures,
   and give a concrete example of each.],
  [You can apply consequentialist, deontological, and virtue ethics reasoning
   to a technology question.],
  [You can distinguish between individual and systemic responsibility for harm.],
  [You can form and defend a reasoned position on a contested technology
   question, acknowledging the strongest arguments on the other side.],
)
