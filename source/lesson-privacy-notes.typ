// ─────────────────────────────────────────────────────────────────────────────
// Lesson — Privacy on the Web
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "Privacy on the Web"
#let lesson-subtitle = "What websites know about you — and how"

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
  [Explain what personal data is and give concrete examples.],
  [Describe how websites collect data using cookies, trackers, and forms.],
  [Read a browser's Network tab and identify what data is being sent where.],
  [Explain what a cookie is and distinguish first-party from third-party cookies.],
  [Describe the key ideas behind GDPR and what rights it gives users.],
  [Evaluate a website's data practices and identify areas for improvement.],
)

= Why Privacy Matters in Computing #h(1fr) #tier-core

When you built your website in this course, you thought mostly about what
the site *does* — its structure, its appearance, its interactivity. But
every website you visit as a user also collects data about you, often
silently, in the background.

This is not always malicious. Websites need to remember who you are,
what is in your shopping cart, or what language you prefer. But the same
mechanisms that make websites convenient can also be used to track your
behavior across the internet, build detailed profiles about you, and sell
that information to third parties.

Understanding how this works is not just a technical curiosity — it
affects your daily life. Every time you use a search engine, scroll
through social media, or shop online, decisions are being made about
what to show you based on data that has been collected about you.

#infobox(
  "Data is the product",
  [Many services you use every day — search engines, social networks,
   email providers — are free to use. But running these services costs
   enormous amounts of money. The business model that pays for them is
   *advertising*, and advertising works by targeting people with relevant
   content. The more a platform knows about you, the more it can charge
   advertisers for access to your attention. You are not the customer —
   you are the product.],
)

= What Is Personal Data? #h(1fr) #tier-core

*Personal data* is any information that can identify a specific person,
directly or indirectly. The definition is broader than most people expect.

== Obviously personal

Some data is obviously personal — it directly names or identifies you:

- Your full name, address, phone number, email address.
- Your national identification number, passport number, or date of birth.
- Your medical records or financial account details.

== Less obviously personal

Other data seems anonymous but can still identify you in context:

- Your IP address — the numerical label assigned to your device when it
  connects to the internet. It reveals your approximate location and your
  internet service provider.
- Your device's browser fingerprint — a combination of your browser
  version, screen resolution, installed fonts, and dozens of other
  technical details that, together, can uniquely identify your device
  even without any login.
- Location data — even a single GPS coordinate can reveal your home
  address if you are there regularly.
- Behavioral data — the sequence of pages you visit, what you click on,
  how long you spend reading something.

#warnbox(
  "⚠ Anonymization is harder than it looks",
  [Researchers have repeatedly shown that supposedly anonymous datasets
   can be re-identified. A 2013 MIT study found that just four
   location data points — places and times — were enough to uniquely
   identify 95% of individuals in a mobile dataset of 1.5 million people.
   "Anonymous" data is rarely truly anonymous.],
)

= How Websites Collect Data #h(1fr) #tier-core

You have already built the tools websites use to collect data — forms,
JavaScript, and HTTP requests. Let us look at how they are used in practice.

== Forms

The most direct collection method: you type information and submit it.
Every field in a login form, a checkout page, or a survey is a data
collection point. You are aware this is happening — or you should be.

== Cookies

A *cookie* is a small piece of text that a website stores in your browser.
When you visit a site, the server can set a cookie; your browser then
sends that cookie back with every subsequent request to the same site.
This is how websites remember you between visits.

```
HTTP Request:  GET /profile HTTP/1.1
               Host: example.com
               Cookie: session_id=abc123; theme=dark

HTTP Response: Set-Cookie: last_visit=2026-05-20; Path=/; Max-Age=2592000
```

Cookies have legitimate uses:

- *Session cookies* keep you logged in as you navigate a site. They
  expire when you close the browser.
- *Preference cookies* remember your language, theme, or other settings.

But cookies are also used for tracking:

- *Persistent cookies* stay in your browser for weeks or years, allowing
  a site to recognize you on your next visit.
- *Third-party cookies* are set not by the site you are visiting, but
  by a tracker embedded in that page — an advertising network, analytics
  service, or social media widget. If the same tracker is embedded in
  thousands of sites, it can follow you across the entire web.

#infobox(
  "First-party vs third-party cookies",
  [A *first-party cookie* is set by the site you are actually visiting.
   If you visit `shop.example.com`, a cookie from `shop.example.com`
   is first-party. A *third-party cookie* is set by a different domain —
   for example, an advertising script from `ads.tracker.com` embedded
   in the page. Because the same `ads.tracker.com` cookie appears on
   every site that includes their script, the advertiser can track your
   journey across thousands of websites. This is the mechanism behind
   ads that seem to "follow" you around the internet.],
)

== JavaScript trackers

Beyond cookies, websites embed JavaScript from third-party services —
analytics platforms, advertising networks, chat widgets, social media
buttons. When a page loads, these scripts run and can:

- Record which page you are on and how long you stay.
- Track which links and buttons you click.
- Capture what you type into forms, sometimes before you submit them
  (a practice called *session replay*).
- Detect your scroll depth, mouse movements, and whether you are looking
  at the page or another tab.

You have written JavaScript that interacts with the DOM. These trackers
do exactly the same thing — they just report what they find back to
a remote server.

== HTTP headers and fingerprinting

Every HTTP request your browser makes includes a set of *headers* —
metadata about the request. These include:

- `User-Agent` — your browser name and version.
- `Accept-Language` — your preferred languages.
- `Referer` — the URL of the page you came from.

Combined with your IP address, these headers form a partial fingerprint.
Sites can also run JavaScript to detect your screen resolution, installed
fonts, time zone, and more — building a *browser fingerprint* that can
identify you even if you delete all cookies.

= Seeing It for Yourself — The Network Tab #h(1fr) #tier-core

Your browser's developer tools let you see exactly what data your browser
is sending and receiving. Open DevTools (*right-click → Inspect*) and
click the *Network* tab, then reload the page. Every HTTP request appears
as a row — click any one to see its full headers, cookies, and response.

Try this on a major news or shopping site. You will typically see:

- Dozens or hundreds of requests — most not to the site's own domain,
  but to analytics services, advertising networks, and content delivery
  networks.
- Cookie headers being sent with every request.
- Scripts loading from domains you have never heard of.

This is the reality behind a typical webpage. The HTML, CSS, and
JavaScript you have been writing is only a small part of what loads.

= The Law: GDPR #h(1fr) #tier-extension

The *General Data Protection Regulation (GDPR)* is a European Union
law that came into force in 2018. It applies to any organization that
processes the personal data of people in the EU — regardless of where
the organization itself is based. This means it effectively applies to
most of the internet.

== Key principles

GDPR is built around a set of principles for how personal data must
be handled:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Principle],
    text(size: 9pt, weight: "bold", fill: white)[What it means in practice],
  ),
  [Lawfulness],
    [Data can only be collected if there is a legal basis — consent,
     a contract, a legal obligation, or legitimate interest.],
  [Purpose limitation],
    [Data collected for one purpose cannot be silently repurposed for another.],
  [Data minimization],
    [Only collect the data you actually need. Not everything you could collect.],
  [Accuracy],
    [Keep data up to date; allow users to correct errors.],
  [Storage limitation],
    [Do not keep data longer than necessary.],
  [Security],
    [Protect data against breaches, loss, and unauthorized access.],
  [Accountability],
    [Organizations must be able to demonstrate compliance — not just claim it.],
)

== Your rights as a user

GDPR gives individuals a set of enforceable rights over their own data:

- *Right of access* — you can request a copy of all data an organization
  holds about you.
- *Right to erasure* ("right to be forgotten") — you can ask for your
  data to be deleted under certain conditions.
- *Right to rectification* — you can have inaccurate data corrected.
- *Right to data portability* — you can request your data in a
  machine-readable format to transfer to another service.
- *Right to object* — you can object to processing based on legitimate
  interest, including profiling for direct marketing.

== Consent and cookie banners

You have seen cookie consent banners on almost every website. These exist
because GDPR requires *freely given, specific, informed, and unambiguous*
consent before non-essential cookies can be set.

In practice, many sites use *dark patterns* to manipulate users into
accepting more tracking than they intend — for example, by making the
"Accept all" button large and prominent while hiding the "Reject all"
option several clicks deep. The law technically prohibits this, but
enforcement is inconsistent.

#infobox(
  "Switzerland: nDSG",
  [Switzerland is not an EU member, but has its own equivalent law:
   the *revDSG* (revidiertes Datenschutzgesetz), often referred to in
   English as the nDSG (new Federal Act on Data Protection). It came
   into force in September 2023 and aligns closely with GDPR principles,
   including the requirements for consent, data minimization, and
   individual rights. Swiss organizations handling EU residents' data
   must also comply with GDPR directly.],
)

= Practical Defenses #h(1fr) #tier-extension

Knowing how tracking works allows you to make informed choices. A few
practical tools:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Tool / approach],
    text(size: 9pt, weight: "bold", fill: white)[What it does],
  ),
  [Browser extensions (uBlock Origin, Privacy Badger)],
    [Block third-party trackers and advertising scripts before they load.],
  [Firefox / Brave],
    [Browsers with stronger privacy defaults than Chrome, including
     third-party cookie blocking and fingerprint protection.],
  [Private / Incognito mode],
    [Does not save browsing history or cookies locally — but does *not*
     make you anonymous to websites or your internet provider.],
  [HTTPS everywhere],
    [Modern browsers default to HTTPS, which encrypts the content of
     requests. It does not hide which sites you visit from your provider,
     but it prevents others on your network from reading the content.],
  [Password managers],
    [Reduce reuse of passwords across services, limiting the damage if
     one service is breached.],
  [Separate email addresses],
    [Using a different email address per service limits cross-site
     tracking by email and contains the blast radius of a data breach.],
)

#warnbox(
  "⚠ No tool makes you fully anonymous",
  [Privacy tools reduce your exposure — they do not eliminate it.
   Complete anonymity on the internet is extremely difficult and
   beyond what most people need. The goal is not to disappear, but
   to be *intentional* about what you share and with whom.],
)

= Privacy in Your Own Code #h(1fr) #tier-challenge

You are now, at least in a small way, someone who builds for the web.
The decisions you make as a developer affect your users' privacy.

A few principles worth internalizing:

*Collect only what you need.* If your site does not need an email
address, do not ask for one. Every field in a form is a liability —
if your service is breached, that data can be exposed.

*Be honest about what you collect.* A privacy notice is not just
a legal checkbox. It is a commitment to your users about how you will
treat their information.

*Prefer privacy-preserving analytics.* If you want to know how many
people visit your site, tools like Plausible or Fathom provide basic
visitor counts without cookies, fingerprinting, or personal data.

*Default to less, not more.* It is easy to add a tracking script or
a social media widget to a page. Ask whether the benefit to the user
justifies the privacy cost. Often it does not.

= Summary

#checklist(
  [You can define personal data and give examples of data that is personal
   even when it does not look like it.],
  [You can explain what a cookie is, how it is set, and the difference between
   first-party and third-party cookies.],
  [You can open the Network tab in DevTools and identify third-party requests
   and cookies being sent by a webpage.],
  [You can name the key principles of GDPR and the rights it gives individuals.],
  [You can describe at least two practical steps a user can take to reduce
   online tracking.],
  [You can identify at least one way that your own choices as a developer
   affect the privacy of your users.],
)
