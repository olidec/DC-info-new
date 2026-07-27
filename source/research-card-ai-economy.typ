// ─────────────────────────────────────────────────────────────────────────────
// Student Research & Discussion Card — AI & the Economy
// ─────────────────────────────────────────────────────────────────────────────

#let course     = "Computer Science"
#let level      = "Gymnasium Muttenz"
#let term       = "2026-27"
#let sheet-type = "Research Card"
#let sheet-title = "AI & the Economy"

// ── Page setup ────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    set text(size: 9pt, fill: rgb("#999999"))
    grid(
      columns: (1fr, 1fr),
      align(left,  [#sheet-type — #sheet-title]),
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
  v(0.8em)
  text(size: 11pt, weight: "bold", fill: rgb("#111111"), it.body)
  v(0.2em)
}

// ── Import shared styles ───────────────────────────────────────────────────────
#import "../cs-style.typ": *

// ── Topic card component ──────────────────────────────────────────────────────
// A self-contained topic block with number badge, title, context, seeds,
// and a writing area for the group's own questions.

#let topic(number, title, context-text, seeds) = {
  block(
    width: 100%,
    breakable: false,
    inset: 0pt,
    {
      // Header bar
      block(
        width: 100%,
        fill: rgb("#2E6DA4"),
        inset: (x: 14pt, y: 8pt),
        radius: (top-left: 3pt, top-right: 3pt),
        grid(
          columns: (auto, 1fr),
          column-gutter: 10pt,
          align(horizon,
            box(
              fill: white,
              inset: (x: 6pt, y: 3pt),
              radius: 2pt,
              text(size: 9pt, weight: "bold", fill: rgb("#2E6DA4"), [Topic #number])
            )
          ),
          align(horizon,
            text(size: 11pt, weight: "bold", fill: white, title)
          ),
        )
      )
      // Body
      block(
        width: 100%,
        stroke: (left: 1pt + rgb("#2E6DA4"), right: 0.4pt + rgb("#CCCCCC"),
                 bottom: 0.4pt + rgb("#CCCCCC")),
        inset: (x: 14pt, y: 12pt),
        radius: (bottom-left: 3pt, bottom-right: 3pt),
        {
          text(size: 10pt, context-text)
          v(0.8em)
          text(size: 9pt, weight: "bold", fill: rgb("#2E6DA4"))[Seed questions]
          v(0.3em)
          seeds
          v(0.8em)
          text(size: 9pt, weight: "bold", fill: rgb("#555555"))[
            Your group's questions for the class discussion:
          ]
          v(0.3em)
          for _ in range(3) {
            line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
            v(1.1em)
          }
        }
      )
    }
  )
  v(1.2em)
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

// ── Instructions block ────────────────────────────────────────────────────────
#block(
  width: 100%,
  fill: rgb("#F5F5F5"),
  inset: (x: 14pt, y: 12pt),
  radius: 3pt,
  {
    text(weight: "bold", fill: rgb("#2E6DA4"))[How this works]
    v(0.4em)
    grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      row-gutter: 6pt,
      box(fill: rgb("#2E6DA4"), inset: (x:5pt,y:2pt), radius:2pt,
        text(size:9pt,weight:"bold",fill:white)[1]),
      [*Choose one topic* as a group. Pick the one you find most interesting, surprising, or controversial — not necessarily the easiest one.],
      box(fill: rgb("#2E6DA4"), inset: (x:5pt,y:2pt), radius:2pt,
        text(size:9pt,weight:"bold",fill:white)[2]),
      [*Research for 30–40 minutes.* Use the seed questions as a starting point, but go beyond them. Try to find at least two sources with different perspectives. A source you disagree with is just as useful as one you agree with.],
      box(fill: rgb("#2E6DA4"), inset: (x:5pt,y:2pt), radius:2pt,
        text(size:9pt,weight:"bold",fill:white)[3]),
      [*Write 2–4 discussion questions* in the space provided. Good questions have no single right answer, open up genuine disagreement, and are specific enough that people can argue about them concretely.],
      box(fill: rgb("#2E6DA4"), inset: (x:5pt,y:2pt), radius:2pt,
        text(size:9pt,weight:"bold",fill:white)[4]),
      [*Be ready to present.* One group member briefly summarizes what you found (2 minutes), then the group poses its questions to the class. You do not need to have resolved the question — the point is to start a conversation.],
    )
    v(0.6em)
    text(size: 9pt, fill: rgb("#999999"))[
      *What makes a good discussion question?* It names something specific (a company, a policy, a person, a real event). It has at least two defensible answers. It matters — answering it would actually change something. \ \
      *What makes a weak discussion question?* It can be answered with a quick Google search. It only has one reasonable answer. It is so broad that nobody knows where to begin.
    ]
  }
)

#v(0.8em)

// ── Group info ────────────────────────────────────────────────────────────────
#grid(
  columns: (1fr, 1fr, auto),
  column-gutter: 12pt,
  {
    text(size: 9pt, fill: rgb("#999999"))[Group members]
    v(0.3em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
  },
  {
    text(size: 9pt, fill: rgb("#999999"))[Topic chosen]
    v(0.3em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
    text(size: 9pt, fill: rgb("#999999"))[Sources used (URLs or titles)]
    v(0.3em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
  },
  [],
)

#v(1em)

// ─────────────────────────────────────────────────────────────────────────────
= Topics
// ─────────────────────────────────────────────────────────────────────────────

#topic(
  "1",
  "Will AI take our jobs?",
  [
    Economists disagree sharply about whether AI will eliminate more jobs than
    it creates. Some argue that every previous wave of automation ultimately
    created more work than it destroyed — the industrial revolution, mechanized
    agriculture, and the computer all produced new industries and new kinds of
    jobs. Others argue that AI is different: it can do cognitive and creative
    work, not just routine physical tasks, so there is less reason to expect
    new roles to emerge for displaced workers.

    The debate is not just about the total number of jobs but about timing,
    distribution, and who bears the costs of transition. Even if new jobs
    eventually appear, that is of limited help to a 50-year-old factory
    worker or a junior graphic designer whose entry-level work has been
    automated away.
  ],
  list(
    [A 2023 Goldman Sachs report estimated that AI could automate 25% of
     work tasks in the US and Europe. A different analysis by the OECD
     put the share at around 14%. Why do estimates vary so much, and does
     it matter?],
    [Which kinds of workers are most at risk from AI automation, and which
     are least? Is the pattern different from previous automation waves?],
    [If new jobs do emerge, how long might the transition take — and what
     happens to workers in the meantime?],
    [Should governments slow down AI adoption to give workers more time to
     adjust, or would that just delay the benefits?],
  )
)

#topic(
  "2",
  "Who owns the training data?",
  [
    Large AI models — image generators, chatbots, coding assistants — are
    trained on vast quantities of human-produced content scraped from the
    internet: text, photographs, artworks, music, code. The people who
    created that content were not asked for permission, and were not paid.

    Companies developing AI argue that training on publicly available data
    is fair use — similar to how a human artist learns by looking at other
    artists' work. Critics, including many artists and writers, argue that
    there is a meaningful difference between a human learning and a
    corporation building a commercial product that directly competes with
    the people whose work it trained on.

    As of 2025, several lawsuits are working through courts in the US and
    Europe. The outcomes will shape the rules for AI development for years.
  ],
  list(
    [Is there a meaningful ethical difference between a human learning
     from others' work and an AI model being trained on it? Where does
     the analogy break down?],
    [If an AI image generator can produce an artwork in the style of a
     living artist, and people buy that instead of commissioning the
     artist, has something unfair happened — even if it is technically legal?],
    [Should AI companies be required to pay royalties to creators whose
     work was used in training? How would this even work in practice?],
    [Some artists have begun using tools to "poison" their work — adding
     invisible patterns that disrupt AI training. Is this a legitimate
     form of self-defense, or does it harm broader progress?],
  )
)

#topic(
  "3",
  "Concentration of power",
  [
    Training a frontier AI model currently requires billions of dollars,
    enormous quantities of specialized chips, and datasets that only
    a handful of organizations in the world can assemble. This has
    concentrated the development of the most capable AI systems in a
    small number of American companies — primarily OpenAI, Google, Meta,
    and Anthropic — with a few counterparts in China.

    This concentration has economic consequences: the gains from AI are
    flowing disproportionately to the owners and investors of these
    companies. It also has political consequences: a small number of
    private organizations are making decisions that will shape the
    future of work, communication, and knowledge for billions of people,
    with limited democratic oversight.
  ],
  list(
    [Is it a problem that the most powerful AI systems are controlled by
     a few private companies? What would the alternative look like?],
    [Some argue that AI should be developed as public infrastructure —
     like roads or the internet — rather than by private companies
     maximizing profit. What are the strongest arguments for and against this?],
    [The EU, the US, and China are taking very different regulatory
     approaches to AI. Does it matter which approach prevails? Is
     international coordination possible?],
    [A handful of people became extraordinarily wealthy from AI development
     very quickly. Does this raise ethical concerns, even if what they
     did was legal?],
  )
)

#topic(
  "4",
  "Universal basic income",
  [
    If AI eventually automates a large fraction of paid work, one proposed
    response is a *universal basic income* (UBI): a regular unconditional
    cash payment to every citizen, regardless of whether they work. The
    idea is not new — versions of it have been proposed by economists and
    philosophers for decades — but it has gained renewed attention as AI
    capabilities have grown.

    Supporters, including prominent technologists such as Sam Altman and
    Elon Musk, argue that UBI would provide economic security in a world
    where stable employment is no longer guaranteed. Critics across the
    political spectrum disagree about whether it is affordable, whether
    it would reduce work incentives, and whether it addresses the right
    problem.
  ],
  list(
    [Should a society guarantee a minimum income to everyone, regardless
     of whether they work? Does your answer change if AI is making many
     jobs obsolete?],
    [Who would pay for a universal basic income at a meaningful level?
     Is it realistic to fund it by taxing the companies and individuals
     who benefit most from AI?],
    [Some critics argue that UBI is a distraction — that the real issue
     is not income but meaningful work, dignity, and purpose. Do you
     think this is right?],
    [Pilots of basic income programs have been run in Finland, Kenya,
     Canada, and several US cities. What did they find, and how much
     can we learn from small-scale experiments?],
  )
)

#topic(
  "5",
  "AI in hiring",
  [
    Many large companies now use AI tools in recruitment — to screen
    résumés, rank candidates, conduct initial video interviews, and even
    predict job performance. Proponents argue this reduces human bias
    and speeds up a slow, expensive process. Critics argue that AI
    systems can encode and amplify historical biases, are opaque about
    how they make decisions, and remove the human judgment that
    candidates deserve.

    This topic connects to the broader question of algorithmic bias:
    a system trained on historical hiring data learns to prefer candidates
    who look like people who were previously hired — which can mean it
    learns to discriminate against women, ethnic minorities, or people
    from certain universities, even when the developer intended no such thing.
  ],
  list(
    [If a human interviewer is biased, at least the candidate knows
     they were assessed by a person. If an AI system is biased, should
     candidates have a right to know, to challenge the decision, and
     to have it reviewed by a human?],
    [Is AI hiring fairer or less fair than human hiring? Is this even
     the right question — should we be asking "fairer for whom"?],
    [Some countries are beginning to regulate automated hiring decisions.
     The EU's AI Act requires human oversight for AI systems used in
     employment. Is this enough?],
    [If you knew a company used an AI tool to screen your application,
     would it change how you applied? Would it change whether you
     wanted to work there?],
  )
)

#topic(
  "6",
  "AI and creative work",
  [
    AI systems can now generate images, music, text, and video that
    many people find compelling — sometimes indistinguishable from
    human-produced work. This raises both economic and philosophical
    questions.

    Economically, many creative professionals — illustrators, stock
    photographers, voice actors, junior copywriters, translators —
    are already seeing their income fall as clients use AI-generated
    alternatives instead. Some argue this is no different from any
    other displacement of skilled work by technology. Others argue
    that creative work is different in kind — that its value lies not
    just in the output but in the human expression behind it.

    Philosophically, it forces the question of what creativity actually
    is. If a machine can produce an image that evokes genuine emotion,
    is that art? Does it matter whether a human intended it?
  ],
  list(
    [If AI can generate a piece of music that moves you, does it matter
     that no human composed it? Does your answer change if you find
     out after the fact?],
    [Should creative work produced by AI be labeled as such? Should
     it be illegal not to disclose it?],
    [Some argue that AI will free human artists from routine and
     commercial work, letting them focus on deeper creative expression.
     Others argue it will simply eliminate livelihoods. Which do you
     think is more likely?],
    [Is there something that human creative work has that AI work
     cannot have — or is that just a story we tell ourselves because
     we are not used to it yet?],
  )
)
