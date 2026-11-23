#!/usr/bin/env python3
"""
autograde.py - collect rubric evidence from the cs-project web-development repos.

    python3 autograde.py project-repos_2026-11-17_1529
    python3 autograde.py project-repos_2026-11-17_1529 --deadline 2026-12-18T23:59 --start 2026-11-23

It does NOT assign grades. For every repo it writes a report of OK / WARN / FAIL / info
findings grouped by rubric criterion (with three suggested discussion lines for the oral defense),
plus summary.csv, similarity.csv, one combined all-reports.pdf for the whole class and
oral-defense-sheets.pdf (one printable page per student: discussion lines, notes, grading table).
The root commit (the Classroom "Initial commit") is always treated as starter code.
Anything that needs human judgment (Oral Defense, quality of the plan, whether a journal
entry shows real engagement) is only flagged, never decided.

Standard library only (Python 3.8+). If `node` is on the PATH, script.js is also
syntax-checked.
"""
import argparse
import csv
import datetime as dt
import os
import posixpath
import re
import shutil
import subprocess
import sys
from collections import Counter, defaultdict
from html.parser import HTMLParser
from urllib.parse import unquote

# ─────────────────────────────────────────────────────────────────────────────
# Settings - tune these to your taste
# ─────────────────────────────────────────────────────────────────────────────
REPO_PREFIX = "cs-project-2627-"
REQUIRED_FILES = ["index.html", "style.css", "script.js", "JOURNAL.md"]
CODE_FILES = {"index.html", "style.css", "script.js"}

MIN_TAGS = 10            # distinct content tags (html/head/body/meta/title/link/script/style don't count)
MIN_CSS_PROPS = 5        # distinct CSS properties
MIN_INTERACTIONS = 1     # event listeners / handlers in script.js

MIN_COMMITS_OK = 10      # fewer -> WARN
MIN_COMMITS_FAIL = 3     # fewer -> FAIL ("a single commit, or nearly so")
MIN_ACTIVE_DAYS = 4      # days on which at least one commit was made
DUMP_LINES = 150         # a single commit adding at least this many lines = "dump" commit
BIG_SHARE = 0.4          # one commit holds more than this share of all added lines -> WARN
CODE_START_LINES = 20    # "coding has started" once this many lines are in the three code files
PLAN_LATE_LINES = 100    # plan first committed after this many code lines -> FAIL
MIN_ENTRY_WORDS = 60     # journal entry shorter than this is flagged as thin
SIMILARITY_FLAG = 0.5    # Jaccard similarity of 5-word shingles between two repos
MAX_FILE_MB = 3

CRITERIA = ["Planning", "Process", "Implementation", "Content", "Submission"]

KNOWN_TAGS = set("""a abbr address area article aside audio b base bdi bdo blockquote body br button canvas
caption cite code col colgroup data datalist dd del details dfn dialog div dl dt em embed fieldset figcaption
figure footer form h1 h2 h3 h4 h5 h6 head header hgroup hr html i iframe img input ins kbd label legend li link
main map mark menu meta meter nav noscript object ol optgroup option output p param picture pre progress q rp rt
ruby s samp script search section select slot small source span strong style sub summary sup svg table tbody td
template textarea tfoot th thead time title tr track u ul var video wbr path circle rect line polygon polyline g
defs use text ellipse""".split())
SKELETON_TAGS = {"html", "head", "body", "meta", "title", "link", "script", "style", "base"}
SEMANTIC_TAGS = {"header", "nav", "main", "section", "article", "aside", "footer", "figure"}
DEPRECATED_TAGS = set("center font marquee blink big strike tt frame frameset acronym applet basefont dir nobr".split())
PRES_ATTRS = {"align", "bgcolor", "valign", "cellpadding", "cellspacing", "background", "face", "hspace", "vspace"}
VOID = set("area base br col embed hr img input link meta param source track wbr".split())
OPTIONAL_END = set("p li dt dd tr td th thead tbody tfoot option optgroup colgroup caption rt rp html head body".split())
REF_ATTRS = {"img": "src", "script": "src", "link": "href", "a": "href", "source": "src",
             "video": "src", "audio": "src", "iframe": "src", "embed": "src"}

KNOWN_PROPS = set("""align-content align-items align-self all animation animation-delay animation-direction
animation-duration animation-fill-mode animation-iteration-count animation-name animation-play-state
animation-timing-function appearance aspect-ratio backdrop-filter backface-visibility background
background-attachment background-blend-mode background-clip background-color background-image background-origin
background-position background-repeat background-size border border-bottom border-bottom-color
border-bottom-left-radius border-bottom-right-radius border-bottom-style border-bottom-width border-collapse
border-color border-image border-left border-left-color border-left-style border-left-width border-radius
border-right border-right-color border-right-style border-right-width border-spacing border-style border-top
border-top-color border-top-left-radius border-top-right-radius border-top-style border-top-width border-width
bottom box-shadow box-sizing caption-side caret-color clear clip clip-path color column-count column-gap
column-rule columns content counter-increment counter-reset cursor direction display empty-cells fill filter
flex flex-basis flex-direction flex-flow flex-grow flex-shrink flex-wrap float font font-display
font-family font-feature-settings font-kerning font-size font-size-adjust font-stretch font-style font-variant
font-weight gap grid grid-area grid-auto-columns grid-auto-flow grid-auto-rows grid-column grid-column-end
grid-column-start grid-gap grid-row grid-row-end grid-row-start grid-template grid-template-areas
grid-template-columns grid-template-rows height hyphens image-rendering inset inset-block inset-inline
isolation justify-content justify-items justify-self left letter-spacing line-height list-style
list-style-image list-style-position list-style-type margin margin-block margin-block-end margin-block-start
margin-bottom margin-inline margin-inline-end margin-inline-start margin-left margin-right margin-top mask
max-height max-width min-height min-width mix-blend-mode object-fit object-position opacity order outline
outline-color outline-offset outline-style outline-width overflow overflow-wrap overflow-x overflow-y
overscroll-behavior padding padding-block padding-block-end padding-block-start padding-bottom padding-inline
padding-inline-end padding-inline-start padding-left padding-right padding-top page-break-after
page-break-before page-break-inside perspective place-content place-items place-self pointer-events position
quotes resize right rotate row-gap scale scroll-behavior scroll-margin scroll-padding scroll-snap-align
scroll-snap-type size src stroke stroke-width table-layout text-align text-align-last text-decoration
text-decoration-color text-decoration-line text-decoration-style text-decoration-thickness text-indent
text-justify text-overflow text-shadow text-transform text-underline-offset text-wrap top touch-action
transform transform-origin transform-style transition transition-delay transition-duration
transition-property transition-timing-function translate unicode-bidi unicode-range user-select
vertical-align visibility white-space width will-change word-break word-spacing word-wrap writing-mode
z-index zoom accent-color color-scheme container-type container-name""".split())

PARTS = {  # four required parts of a journal entry -> crude keyword test (a human must still read it)
    "goal": re.compile(r"\b(trying|tried|wanted|goal|aim|needed|task|want to|versuch|wollte|ziel)", re.I),
    "source": re.compile(r"(chatgpt|gpt|claude|gemini|copilot|\bai\b|stack ?overflow|mdn|w3schools|youtube|"
                         r"tutorial|website|google|friend|parent|teacher|dad|mom|mother|father|brother|"
                         r"sister|found|lehrer|quelle)", re.I),
    "learned": re.compile(r"\b(learn|understood|understand|realiz|realis|turns out|works because|means that|"
                          r"explain|gelernt|verstanden)", re.I),
    "adapted": re.compile(r"\b(adapt|changed|modif|customi[sz]|my (own )?(site|project|page|website)|"
                          r"instead|tweak|renamed|replaced|angepasst|geändert)", re.I),
}

GENERIC = re.compile(
    r"(?:(?:update|updated|create|created|delete|deleted|rename|renamed|upload|uploaded|add|added|fix|fixed|"
    r"change|changed|edit|edited)(?: files?)?(?: via upload)?(?: [\w-]+\.\w+)?"
    r"|updates|fixes|changes|commit|test|testing|stuff|wip|final|finished|done|misc|save|asdf\w*|\.+)", re.I)


# ─────────────────────────────────────────────────────────────────────────────
# Small helpers
# ─────────────────────────────────────────────────────────────────────────────
class Report:
    def __init__(self, name):
        self.name = name
        self.findings = []   # (criterion, level, message)
        self.metrics = {}
        self.commit_rows = []
        self.texts = {}
        self.paths = {}              # required file name -> path actually used (may be in a subfolder)
        self.commit_info = {}        # short hash -> commit dict
        self.starter_hashes = set()
        self.oral = []               # suggested discussion lines

    def add(self, crit, level, msg):
        self.findings.append((crit, level, msg))

    def status(self, crit):
        levels = [l for c, l, _ in self.findings if c == crit]
        return "FAIL" if "FAIL" in levels else "WARN" if "WARN" in levels else "OK"

    def count(self, level):
        return sum(1 for _, l, _ in self.findings if l == level)


def git(repo, *args):
    r = subprocess.run(["git", "-c", "core.quotepath=false", "-C", repo] + list(args),
                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, errors="replace")
    return r.stdout


def read(repo, rel):
    try:
        with open(os.path.join(repo, rel), encoding="utf-8", errors="replace") as fh:
            return fh.read()
    except OSError:
        return None


def parse_local(s):
    if not s:
        return None
    d = dt.datetime.fromisoformat(s)
    return d.astimezone() if d.tzinfo is None else d


def fmt(d):
    return d.astimezone().strftime("%Y-%m-%d %H:%M")


def short(items, n=4):
    items = list(items)
    return ", ".join(items[:n]) + (" ... (+%d more)" % (len(items) - n) if len(items) > n else "")


def is_external(ref):
    return bool(re.match(r"^(https?:)?//", ref.strip(), re.I))


def normalize_local(ref):
    p = unquote(re.split(r"[?#]", ref.strip())[0])
    return posixpath.normpath(p)


# ─────────────────────────────────────────────────────────────────────────────
# HTML
# ─────────────────────────────────────────────────────────────────────────────
class Page(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.tags = Counter()
        self.ids, self.classes = [], set()
        self.inline_styles = self.handlers = self.style_blocks = self.inline_scripts = 0
        self.pres_attrs = self.alt_missing = self.nbsp = self.words = 0
        self.refs, self.stylesheets, self.scripts = [], [], []   # scripts: (src, in_head, deferred)
        self.doctype = None
        self.charset = self.lang = False
        self.title = ""
        self.stack, self.problems, self.headings = [], [], []
        self.in_head = False
        self._raw = None
        self._buf = []
        self._in_title = False

    def handle_decl(self, decl):
        self.doctype = decl.strip().lower()

    def handle_starttag(self, tag, attrs):
        a = dict((k, v or "") for k, v in attrs)
        self.tags[tag] += 1
        if tag == "head":
            self.in_head = True
        elif tag == "body":
            self.in_head = False
        if "id" in a:
            self.ids.append(a["id"])
        if "class" in a:
            self.classes.update(a["class"].split())
        if "style" in a:
            self.inline_styles += 1
        self.handlers += sum(1 for k in a if k.startswith("on"))
        self.pres_attrs += sum(1 for k in a if k in PRES_ATTRS)
        if tag == "meta" and ("charset" in a or a.get("http-equiv", "").lower() == "content-type"):
            self.charset = True
        if tag == "html" and a.get("lang"):
            self.lang = True
        if tag == "img" and "alt" not in a:
            self.alt_missing += 1
        if re.fullmatch(r"h[1-6]", tag):
            self.headings.append(int(tag[1]))
        if tag == "link" and "stylesheet" in a.get("rel", "").lower().split():
            self.stylesheets.append(a.get("href", ""))
        if tag == "script":
            src = a.get("src")
            if src:
                self.scripts.append((src, self.in_head, "defer" in a or "async" in a or a.get("type") == "module"))
            self._raw, self._buf = ("script", bool(src)), []
        elif tag == "style":
            self._raw, self._buf = ("style", False), []
        elif tag == "title":
            self._in_title = True
        if tag in REF_ATTRS and a.get(REF_ATTRS[tag]):
            self.refs.append((tag, a[REF_ATTRS[tag]]))
        if tag not in VOID:
            self.stack.append((tag, self.getpos()[0]))

    def handle_endtag(self, tag):
        if tag in VOID:
            return
        if self._raw and tag in ("script", "style"):
            kind, has_src = self._raw
            content = "".join(self._buf).strip()
            self._raw = None
            if kind == "script" and not has_src and content:
                self.inline_scripts += 1
            if kind == "style" and content:
                self.style_blocks += 1
        if tag == "title":
            self._in_title = False
        line = self.getpos()[0]
        if self.stack and self.stack[-1][0] == tag:
            self.stack.pop()
        elif tag in [t for t, _ in self.stack]:
            while self.stack[-1][0] != tag:
                t, l = self.stack.pop()
                if t not in OPTIONAL_END:
                    self.problems.append("<%s> opened on line %d is not closed before </%s> (line %d)" % (t, l, tag, line))
            self.stack.pop()
        elif tag not in OPTIONAL_END:
            self.problems.append("stray </%s> on line %d" % (tag, line))

    def handle_data(self, data):
        if self._raw:
            self._buf.append(data)
        elif self._in_title:
            self.title += data
        else:
            self.words += len(data.split())
            self.nbsp += data.count("\xa0")

    def finish(self):
        self.close()
        for t, l in self.stack:
            if t not in OPTIONAL_END:
                self.problems.append("<%s> opened on line %d is never closed" % (t, l))


# ─────────────────────────────────────────────────────────────────────────────
# CSS (small tolerant parser - good enough for student projects)
# ─────────────────────────────────────────────────────────────────────────────
def parse_decls(body):
    out = []
    for part in re.split(r";(?![^(]*\))", body):
        if ":" in part:
            p, v = part.split(":", 1)
            if p.strip():
                out.append((p.strip().lower(), " ".join(v.split())))
    return out


def parse_css(css):
    css = re.sub(r"/\*.*?\*/", "", css, flags=re.S)
    imports = re.findall(r"@import\s+[^;]+;", css)
    css = re.sub(r"@(?:import|charset|namespace)\s[^;]*;", "", css)
    rules, stack, buf = [], [], []
    for ch in css:
        if ch == "{":
            stack.append("".join(buf).strip())
            buf = []
        elif ch == "}":
            body, buf = "".join(buf), []
            if not stack:
                continue
            prelude = stack.pop()
            if prelude.startswith("@") and not prelude.lower().startswith(("@font-face", "@page")):
                continue   # group rule such as @media - its inner rules were already emitted
            ctx = " ".join(s for s in stack if s.startswith("@"))
            rules.append({"sel": " ".join(prelude.split()), "ctx": ctx, "decls": parse_decls(body),
                          "at": prelude.startswith("@")})
        else:
            buf.append(ch)
    return rules, imports


def sel_tokens(sel):
    s = re.sub(r"\[[^\]]*\]", "", sel)
    s = re.sub(r"::?[\w-]+(\([^)]*\))?", "", s)
    classes = re.findall(r"\.([A-Za-z_][\w-]*)", s)
    ids = re.findall(r"#([A-Za-z_][\w-]*)", s)
    rest = re.sub(r"[.#][A-Za-z_][\w-]*", " ", s)
    tags = [t.lower() for t in re.findall(r"(?<![\w-])[A-Za-z][A-Za-z0-9]*", rest)]
    return tags, classes, ids


# ─────────────────────────────────────────────────────────────────────────────
# Checks
# ─────────────────────────────────────────────────────────────────────────────
def locate(tracked, name):
    """The file itself in the repo root, else the shallowest file with that name in a subfolder (any case)."""
    if name in tracked:
        return name
    cands = [t for t in tracked if posixpath.basename(t).lower() == name.lower()]
    return min(cands, key=lambda t: (t.count("/"), t.lower())) if cands else None


def resolve(base, ref):
    """Path of a local reference, relative to the file (base) that contains it."""
    return posixpath.normpath(posixpath.join(posixpath.dirname(base), normalize_local(ref)))


def check_files(rep, repo, tracked):
    missing, moved = [], []
    for f in REQUIRED_FILES:
        p = rep.paths.get(f)
        crit = "Content" if f == "JOURNAL.md" else "Implementation"
        if p is None:
            missing.append(f)
            rep.add(crit, "FAIL", "%s is missing" % f)
        elif p != f:
            moved.append(p)
            rep.add(crit, "WARN", "%s is not in the repo root - checking %s instead" % (f, p))
    idx = rep.paths.get("index.html")
    if idx is None:
        rep.add("Submission", "FAIL", "no index.html anywhere - nothing to run")
    elif idx != "index.html":
        rep.add("Submission", "WARN", "no index.html in the repo root - the site starts at %s (check that it opens)" % idx)
    rep.metrics["files_missing"] = ";".join(missing)
    rep.metrics["files_moved"] = ";".join(moved)
    for f in sorted(CODE_FILES):
        p = rep.paths.get(f)
        if p and len([l for l in (rep.texts.get(f) or "").splitlines() if l.strip()]) < 3:
            rep.add("Implementation", "FAIL", "%s is (nearly) empty - starter file untouched?" % p)
    junk = [t for t in tracked if re.search(r"(^|/)(\.DS_Store|Thumbs\.db|node_modules/|\.vscode/|\.idea/|__pycache__/)", t)]
    if junk:
        rep.add("Implementation", "WARN", "junk files committed (%d): %s - a .gitignore would help" % (len(junk), short(junk)))
    big = [t for t in tracked if os.path.exists(os.path.join(repo, t))
           and os.path.getsize(os.path.join(repo, t)) > MAX_FILE_MB * 1024 * 1024]
    if big:
        rep.add("Implementation", "INFO", "files over %d MB: %s" % (MAX_FILE_MB, short(big)))


def check_html(rep, page):
    if page is None:
        return
    known = {t for t in page.tags if t in KNOWN_TAGS}
    unknown = sorted(t for t in page.tags if t not in KNOWN_TAGS and t not in DEPRECATED_TAGS)
    content = sorted(known - SKELETON_TAGS)
    rep.metrics["html_tags"] = len(content)
    lvl = "OK" if len(content) >= MIN_TAGS else "FAIL"
    rep.add("Implementation", lvl, "%d distinct content tags (minimum %d): %s" % (len(content), MIN_TAGS, short(content, 14)))
    if unknown:
        rep.add("Implementation", "WARN", "unknown tags (typos?): %s" % short(unknown))
    dep = sorted(t for t in page.tags if t in DEPRECATED_TAGS)
    if dep:
        rep.add("Implementation", "WARN", "deprecated tags: %s" % ", ".join(dep))
    missing = []
    if not page.doctype or "html" not in page.doctype:
        missing.append("<!DOCTYPE html>")
    for t in ("html", "head", "body", "title"):
        if t not in page.tags:
            missing.append("<%s>" % t)
    if not page.charset:
        missing.append("<meta charset>")
    if "title" in page.tags and not page.title.strip():
        missing.append("non-empty <title>")
    rep.add("Implementation", "WARN" if missing else "OK",
            "document structure incomplete: missing " + ", ".join(missing) if missing else "document structure complete")
    # separation of HTML / CSS / JS
    sep = []
    if page.inline_styles:
        sep.append("%d inline style attribute(s)" % page.inline_styles)
    if page.style_blocks:
        sep.append("%d <style> block(s)" % page.style_blocks)
    if page.inline_scripts:
        sep.append("%d embedded <script> block(s)" % page.inline_scripts)
    if page.handlers:
        sep.append("%d inline on...= handler(s)" % page.handlers)
    if page.pres_attrs:
        sep.append("%d presentational attribute(s) (align, bgcolor ...)" % page.pres_attrs)
    rep.metrics["inline_styles"] = page.inline_styles
    rep.metrics["embedded"] = page.style_blocks + page.inline_scripts + page.handlers
    rep.add("Implementation", "WARN" if sep else "OK",
            "HTML/CSS/JS not cleanly separated: " + "; ".join(sep) if sep else "no inline styles, embedded scripts or inline handlers")
    if page.problems:
        rep.add("Implementation", "WARN", "%d tag nesting problem(s): %s" % (len(page.problems), short(page.problems, 3)))
    dup = sorted(i for i, n in Counter(page.ids).items() if n > 1)
    if dup:
        rep.add("Implementation", "WARN", "duplicate ids: %s" % short(dup))
    sloppy = []
    if page.tags.get("br", 0) >= 10:
        sloppy.append("%d <br> tags" % page.tags["br"])
    if page.nbsp >= 10:
        sloppy.append("%d non-breaking spaces" % page.nbsp)
    if sloppy:
        rep.add("Implementation", "WARN", "layout by whitespace hacks? " + ", ".join(sloppy))
    if page.headings.count(1) > 1:
        rep.add("Implementation", "INFO", "%d <h1> headings (one is usual)" % page.headings.count(1))
    if any(b - a > 1 for a, b in zip(page.headings, page.headings[1:])):
        rep.add("Implementation", "INFO", "heading levels skip (e.g. h1 -> h3)")
    if not (known & SEMANTIC_TAGS):
        rep.add("Implementation", "INFO", "no semantic tags (header/nav/main/section/footer ...)")
    if page.alt_missing:
        rep.add("Implementation", "INFO", "%d <img> without alt text" % page.alt_missing)
    if page.words < 40:
        rep.add("Content", "WARN", "very little visible text on the page (%d words)" % page.words)
    else:
        rep.add("Content", "INFO", "%d words of visible text on the page" % page.words)


def check_links(rep, repo, page, tracked, extra_code):
    """Links between files, broken/absolute/case-mismatched references (Submission: 'works after a fresh clone')."""
    if page is None:
        return
    tracked_set = set(tracked)
    lower = {t.lower(): t for t in tracked}
    base = rep.paths["index.html"]
    css_p, js_p = rep.paths.get("style.css"), rep.paths.get("script.js")
    css_links = [resolve(base, h) for h in page.stylesheets if not is_external(h)]
    js_links = [resolve(base, s) for s, _, _ in page.scripts if not is_external(s)]
    if css_p and css_p not in css_links:
        rep.add("Implementation", "FAIL", "%s exists but %s does not link it" % (css_p, base))
    if js_p and js_p not in js_links:
        rep.add("Implementation", "FAIL", "%s exists but %s does not load it" % (js_p, base))
    problems = []
    for tag, ref in page.refs:
        issue = check_ref(ref, base, tracked_set, lower)
        if issue:
            problems.append(issue)
    css_text = rep.texts.get("style.css") or ""
    for ref in re.findall(r"url\(\s*['\"]?([^'\")]+)", css_text):
        issue = check_ref(ref, css_p, tracked_set, lower)
        if issue:
            problems.append(issue)
    hard = [p for p in problems if p[0] != "root-absolute"]
    rep.metrics["broken_refs"] = len(problems)
    if hard:
        rep.add("Submission", "FAIL", "%d reference(s) that break on a fresh clone: %s" %
                (len(hard), short(["%s '%s'" % (k, r) for k, r, *_ in hard], 5)))
    soft = [p for p in problems if p[0] == "root-absolute"]
    if soft:
        rep.add("Submission", "WARN", "root-absolute paths (work only on some servers): %s" % short([p[1] for p in soft]))
    if not problems:
        rep.add("Submission", "OK", "all local file references resolve (exact case)")
    hosts = set()
    for tag, ref in page.refs:
        if tag in ("link", "script", "img") and is_external(ref):
            hosts.add(re.sub(r"^(https?:)?//([^/]+).*", r"\2", ref.strip()))
    ext = sorted(hosts)
    if ext:
        rep.add("Implementation", "INFO", "external resources from: %s (libraries? hotlinked images?)" % short(ext, 5))
    referenced = {resolve(base, r) for _, r in page.refs if not is_external(r)}
    for other in [t for t in tracked if t.lower().endswith((".html", ".htm")) and t != base]:
        sub = Page()                                    # multi-page sites: links from the other pages count too
        sub.feed(read(repo, other) or "")
        referenced |= {resolve(other, r) for _, r in sub.refs if not is_external(r)}
    for f in extra_code:
        if f in referenced:
            rep.add("Implementation", "INFO", "extra linked file: %s" % f)
        else:
            rep.add("Implementation", "WARN", "unused leftover file: %s" % f)


def check_ref(ref, base, tracked, lower):
    r = ref.strip()
    if not r or r.startswith("#") or re.match(r"^(https?:|//|mailto:|tel:|data:|javascript:|sms:)", r, re.I):
        return None
    if re.match(r"^(file:|[A-Za-z]:[\\/])", r) or r.startswith(("/Users", "/home")):
        return ("absolute", r)
    if r.startswith("/"):
        return ("root-absolute", r)
    if "\\" in r:
        return ("backslash", r)
    path = unquote(re.split(r"[?#]", r)[0])
    if not path:
        return None
    full = posixpath.normpath(posixpath.join(posixpath.dirname(base), path))
    if full in tracked or any(t.startswith(full + "/") for t in tracked):
        return None
    if full.lower() in lower:
        return ("case-mismatch", r, lower[full.lower()])
    return ("missing", r)


def check_css(rep, css_text, page, js_text):
    if css_text is None:
        return
    rules, imports = parse_css(css_text)
    props = {p for r in rules for p, _ in r["decls"] if not p.startswith("-")}
    rep.metrics["css_props"] = len(props)
    rep.add("Implementation", "OK" if len(props) >= MIN_CSS_PROPS else "FAIL",
            "%d distinct CSS properties (minimum %d): %s" % (len(props), MIN_CSS_PROPS, short(sorted(props), 12)))
    unknown = sorted(p for p in props if p not in KNOWN_PROPS)
    if unknown:
        rep.add("Implementation", "INFO", "unrecognized property names (typos?): %s" % short(unknown))
    plain = [r for r in rules if not r["at"] and "@keyframes" not in r["ctx"]]
    # duplicates
    seen = defaultdict(int)
    for r in plain:
        seen[(r["ctx"], r["sel"].lower())] += 1
    dup_sel = sorted({k[1] for k, n in seen.items() if n > 1})
    redecl = []
    for r in plain:
        c = Counter(p for p, _ in r["decls"])
        again = [p for p, n in c.items() if n > 1]
        if again:
            redecl.append("%s {%s}" % (r["sel"], ", ".join(again)))
    blocks = defaultdict(set)
    for r in plain:
        if len(r["decls"]) >= 2:
            blocks[(r["ctx"], frozenset(r["decls"]))].add(r["sel"].lower())
    same_block = [sorted(s) for s in blocks.values() if len(s) > 1]
    rep.metrics["css_dupes"] = len(dup_sel) + len(redecl) + len(same_block)
    if dup_sel:
        rep.add("Implementation", "WARN", "selector defined in several rules (merge them): %s" % short(dup_sel))
    if redecl:
        rep.add("Implementation", "WARN", "property declared twice in one rule: %s" % short(redecl, 3))
    if same_block:
        rep.add("Implementation", "WARN", "different selectors with identical declarations (group them): %s" %
                short([" + ".join(s) for s in same_block], 3))
    reuse = Counter()
    for r in plain:
        for d in set(r["decls"]):
            reuse[d] += 1
    repeated = ["%s: %s (x%d)" % (p, v, n) for (p, v), n in reuse.most_common() if n >= 4]
    if repeated:
        rep.add("Implementation", "INFO", "same declaration repeated in many rules (inherit/class/variable?): %s" % short(repeated, 3))
    if not (dup_sel or redecl or same_block):
        rep.add("Implementation", "OK", "no duplicate selectors, declarations or identical rule blocks")
    empty = [r["sel"] for r in plain if not r["decls"]]
    if empty:
        rep.add("Implementation", "INFO", "empty rules: %s" % short(empty))
    imp = css_text.count("!important")
    if imp >= 3:
        rep.add("Implementation", "WARN", "!important used %d times" % imp)
    # unused selectors
    if page is not None:
        js = js_text or ""
        unused = []
        for r in plain:
            for part in r["sel"].split(","):
                tags, classes, ids = sel_tokens(part)
                bad = [t for t in tags if t not in page.tags] \
                    + [".%s" % c for c in classes if c not in page.classes and c not in js] \
                    + ["#%s" % i for i in ids if i not in page.ids and i not in js]
                if bad:
                    unused.append(part.strip())
        rep.metrics["css_unused"] = len(unused)
        if unused:
            rep.add("Implementation", "WARN" if len(unused) >= 3 else "INFO",
                    "%d selector(s) match nothing in index.html: %s" % (len(unused), short(unused, 5)))
        else:
            rep.add("Implementation", "OK", "every CSS selector matches something in index.html")
    ext = [i for i in imports if "http" in i]
    if ext:
        rep.add("Implementation", "INFO", "@import from external source: %s" % short(ext, 2))


def check_js(rep, repo, js_text, page):
    if js_text is None:
        return
    code = re.sub(r"/\*.*?\*/", "", js_text, flags=re.S)
    code = re.sub(r"(?<![:\"'])//[^\n]*", "", code)
    listeners = re.findall(r"addEventListener\s*\(\s*['\"](\w+)['\"]", code)
    onprops = re.findall(r"\.on(click|change|input|submit|keydown|keyup|keypress|mouseover|mouseout|mouseenter|"
                         r"mouseleave|load|scroll|resize|focus|blur|dblclick)\s*=(?!=)", code)
    inline = page.handlers if page else 0
    n = len(listeners) + len(onprops) + inline
    rep.metrics["interactions"] = n
    dom = len(re.findall(r"\.(textContent|innerHTML|innerText|classList|style|setAttribute|appendChild|append|"
                         r"remove|value|src|href|hidden|toggle)\b", code))
    loc = len([l for l in code.splitlines() if l.strip()])
    if n < MIN_INTERACTIONS:
        rep.add("Implementation", "FAIL", "no event listeners/handlers found in script.js (%d lines of code)" % loc)
    elif dom == 0:
        rep.add("Implementation", "WARN", "%d event hook(s) but nothing that changes the page (textContent/classList/style ...)" % n)
    else:
        rep.add("Implementation", "OK", "%d event hook(s) (%s), %d DOM-changing statement(s), %d lines of code" %
                (n, short(sorted(set(listeners + onprops)), 5) or "inline", dom, loc))
    if page is not None:
        miss = [i for i in re.findall(r"getElementById\s*\(\s*['\"]([^'\"]+)['\"]", code) if i not in page.ids]
        for q in re.findall(r"querySelector(?:All)?\s*\(\s*['\"]([^'\"]+)['\"]", code):
            tags, classes, ids = sel_tokens(q)
            miss += ["#%s" % i for i in ids if i not in page.ids]
            miss += [".%s" % c for c in classes if c not in page.classes]
            miss += [t for t in tags if t not in page.tags]
        if miss:
            rep.add("Implementation", "WARN", "script.js looks for elements not in index.html (fine only if created by "
                    "the script): %s" % short(sorted(set(miss))))
        for src, in_head, deferred in page.scripts:
            if resolve(rep.paths["index.html"], src) == rep.paths.get("script.js") and in_head and not deferred \
                    and "DOMContentLoaded" not in code and re.search(r"getElementById|querySelector", code):
                rep.add("Implementation", "WARN", "script.js loads in <head> without defer and queries the DOM at "
                        "top level - elements may not exist yet")
    js_path = os.path.join(repo, rep.paths.get("script.js") or "script.js")
    if shutil.which("node") and os.path.exists(js_path):
        r = subprocess.run(["node", "--check", js_path], stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE, universal_newlines=True)
        if r.returncode != 0:
            msg = [re.sub(r"^.*?script\.js", "script.js", l).strip() for l in r.stderr.splitlines()
                   if l.strip() and not set(l.strip()) <= set("^~ ")]
            rep.add("Submission", "FAIL", "script.js has a syntax error: %s" % short(msg[:2], 2))
            rep.add("Implementation", "FAIL", "script.js has a syntax error")
        else:
            rep.add("Submission", "OK", "script.js passes a syntax check (node --check)")
    else:
        rep.add("Submission", "INFO", "no syntax check of script.js (node not installed)")
    if len(re.findall(r"console\.log", code)) >= 5:
        rep.add("Implementation", "INFO", "%d console.log calls left in script.js" % len(re.findall(r"console\.log", code)))


def parse_journal(text):
    heads = [(m.start(), m.end(), len(m.group(1)), m.group(2)) for m in re.finditer(r"^(#{1,6})\s+(.*?)\s*$", text, re.M)]
    entries, near = [], []
    for i, (s, e, lvl, title) in enumerate(heads):
        m = re.match(r"\[\s*(html|css|js|javascript)\s*\]", title, re.I)
        if not m:
            if re.search(r"\b(html|css|js|javascript)\b", title, re.I):
                near.append(title)
            continue
        end = next((s2 for s2, _, l2, _t in heads[i + 1:] if l2 <= lvl), len(text))
        body = text[e:end]
        tag = "JS" if m.group(1).upper() == "JAVASCRIPT" else m.group(1).upper()
        entries.append({"tag": tag, "title": title, "words": len(body.split()),
                        "hits": [p for p, rx in PARTS.items() if rx.search(body)]})
    return entries, near


def check_journal(rep, text, journal_commits):
    if text is None:
        rep.metrics["journal_tags"], rep.metrics["journal_ok"] = "", 0
        return
    entries, near = parse_journal(text)
    tags_found = sorted({e["tag"] for e in entries})
    ok = 0
    for tag in ("HTML", "CSS", "JS"):
        mine = [e for e in entries if e["tag"] == tag]
        if not mine:
            rep.add("Content", "FAIL", "no [%s] entry (a missing/malformed tag counts as no entry)" % tag)
            continue
        best = max(mine, key=lambda e: (len(e["hits"]), e["words"]))
        absent = [p for p in PARTS if p not in best["hits"]]
        if not absent and best["words"] >= MIN_ENTRY_WORDS:
            ok += 1
            rep.add("Content", "OK", "[%s] entry looks complete (%d words) - still read it" % (tag, best["words"]))
        else:
            why = []
            if absent:
                why.append("no keyword hit for: " + ", ".join(absent))
            if best["words"] < MIN_ENTRY_WORDS:
                why.append("only %d words" % best["words"])
            rep.add("Content", "WARN", "[%s] entry needs a closer look (%s)" % (tag, "; ".join(why)))
    if len(tags_found) < 3 and near:
        rep.add("Content", "INFO", "headings that mention a language but are not tagged like [CSS]: %s" % short(near, 3))
    rep.metrics["journal_tags"] = ",".join(tags_found)
    rep.metrics["journal_ok"] = ok
    if len(journal_commits) == 1:
        rep.add("Content", "WARN", "JOURNAL.md was written in a single commit - entries added all at the end?")
    elif journal_commits:
        rep.add("Content", "INFO", "JOURNAL.md touched in %d commits (%s to %s)" %
                (len(journal_commits), fmt(journal_commits[0]["adate"]), fmt(journal_commits[-1]["adate"])))


# ─────────────────────────────────────────────────────────────────────────────
# Git history
# ─────────────────────────────────────────────────────────────────────────────
def load_commits(repo):
    fmt_str = "@@@%H%x1f%an%x1f%ae%x1f%aI%x1f%cI%x1f%s"
    out = git(repo, "log", "--no-merges", "--numstat", "--format=" + fmt_str)
    commits, cur = [], None
    for line in out.splitlines():
        if line.startswith("@@@"):
            h, an, ae, ad, cd, subj = line[3:].split("\x1f", 5)
            cur = {"hash": h[:7], "author": an, "email": ae, "adate": dt.datetime.fromisoformat(ad),
                   "cdate": dt.datetime.fromisoformat(cd), "msg": subj, "added": 0, "deleted": 0, "files": []}
            commits.append(cur)
        elif line.strip() and cur is not None and line.count("\t") >= 2:
            a, d, path = line.split("\t", 2)
            a = int(a) if a.isdigit() else 0
            d = int(d) if d.isdigit() else 0
            cur["added"] += a
            cur["deleted"] += d
            cur["files"].append((path, a, d))
    commits.sort(key=lambda c: c["adate"])
    return commits


def generic_msg(m):
    s = m.strip()
    return len(s) < 6 or bool(GENERIC.fullmatch(s))


def plan_file_names(tracked):
    out = set()
    for t in tracked:
        base = os.path.basename(t).lower()
        if t.lower() == "readme.md" or re.search(r"plan|worksheet|brainstorm|retro", base) or base.endswith(".pdf"):
            out.add(t)
    return out


def check_git(rep, repo, tracked, args):
    commits = load_commits(repo)
    starter_re = re.compile(args.ignore_authors, re.I)
    # The root commit is the Classroom template copy ("Initial commit"), even when it carries the student's name.
    roots = {h[:7] for h in git(repo, "rev-list", "--max-parents=0", "HEAD").split()}

    def is_starter(c):
        return (c["hash"] in roots or bool(starter_re.search(c["author"] + " " + c["email"]))
                or bool(args.start and c["adate"] < args.start))

    stud = [c for c in commits if not is_starter(c)]
    now = dt.datetime.now(dt.timezone.utc)
    rep.commit_info = {c["hash"]: c for c in commits}
    rep.starter_hashes = {c["hash"] for c in commits if is_starter(c)}
    n = len(stud)
    total_add = sum(c["added"] for c in stud)
    total_del = sum(c["deleted"] for c in stud)
    days = sorted({c["adate"].astimezone().date() for c in stud})
    span = (days[-1] - days[0]).days + 1 if days else 0
    dumps = [c for c in stud if c["added"] >= DUMP_LINES]
    generic = [c for c in stud if generic_msg(c["msg"])]
    biggest = max(stud, key=lambda c: c["added"]) if stud else None
    rep.metrics.update({"commits": n, "active_days": len(days), "span_days": span, "lines_added": total_add,
                        "lines_deleted": total_del, "max_commit_added": biggest["added"] if biggest else 0,
                        "dump_commits": len(dumps), "generic_msgs": len(generic)})
    for c in commits:
        flags = []
        if is_starter(c):
            flags.append("starter")
        if c["added"] >= DUMP_LINES:
            flags.append("DUMP")
        if generic_msg(c["msg"]):
            flags.append("generic msg")
        rep.commit_rows.append((fmt(c["adate"]), c["hash"], c["added"], c["deleted"], len(c["files"]),
                                c["msg"][:70], ", ".join(flags)))

    # ── Process ──
    if n < MIN_COMMITS_FAIL:
        rep.add("Process", "FAIL", "only %d student commit(s)" % n)
    elif n < MIN_COMMITS_OK:
        rep.add("Process", "WARN", "%d student commits (expected about %d or more)" % (n, MIN_COMMITS_OK))
    else:
        rep.add("Process", "OK", "%d student commits, +%d / -%d lines" % (n, total_add, total_del))
    if n and len(days) < MIN_ACTIVE_DAYS:
        rep.add("Process", "WARN", "commits on only %d different day(s) (span %d days)" % (len(days), span))
    elif n:
        rep.add("Process", "OK", "commits on %d different days over %d days" % (len(days), span))
    if dumps:
        rep.add("Process", "WARN", "%d dump commit(s) of %d+ added lines: %s" %
                (len(dumps), DUMP_LINES, short(["%s (+%d)" % (c["hash"], c["added"]) for c in dumps])))
    if biggest and n >= 3 and total_add and biggest["added"] / total_add > BIG_SHARE:
        rep.add("Process", "WARN", "commit %s holds %d%% of all added lines" % (biggest["hash"], 100 * biggest["added"] // total_add))
    if n and len(generic) / n > 0.5:
        rep.add("Process", "WARN", "%d of %d commit messages are generic, e.g. %s" %
                (len(generic), n, short(['"%s"' % c["msg"] for c in generic], 3)))
    elif generic:
        rep.add("Process", "INFO", "%d generic commit message(s), e.g. %s" % (len(generic), short(['"%s"' % c["msg"] for c in generic], 3)))
    authors = Counter("%s <%s>" % (c["author"], c["email"]) for c in stud)
    if len(authors) > 1:
        rep.add("Process", "INFO", "several author identities: %s" % short(["%s x%d" % kv for kv in authors.most_common()], 4))
    skew = [c for c in stud if abs(c["adate"] - c["cdate"]) > dt.timedelta(days=1)]
    if skew:
        rep.add("Process", "INFO", "%d commit(s) where author date and commit date differ by >1 day (rebase/amend/--date)" % len(skew))
    future = [c for c in stud if c["adate"] > now + dt.timedelta(hours=1)]
    if future:
        rep.add("Process", "WARN", "%d commit(s) dated in the future" % len(future))

    # ── Submission: deadline ──
    if args.deadline and stud:
        late = [c for c in stud if c["adate"] > args.deadline]
        rep.metrics["late_commits"] = len(late)
        if late:
            rep.add("Submission", "WARN", "%d commit(s) after the deadline (last: %s). Dates are author dates and can be "
                    "faked; check pushes on GitHub." % (len(late), fmt(late[-1]["adate"])))
        else:
            rep.add("Submission", "OK", "last commit %s is before the deadline" % fmt(stud[-1]["adate"]))

    # ── Planning ──
    code_paths = {p for f, p in rep.paths.items() if f in CODE_FILES and p}
    plans = plan_file_names(tracked)
    plan_c, code_before, cum, code_c, plan_touches = None, 0, 0, None, []
    for c in stud:
        touched = any(f in plans for f, _, _ in c["files"])
        if touched:
            plan_touches.append(c)
            if plan_c is None:
                plan_c, code_before = c, cum
        cum += sum(a for f, a, _ in c["files"] if f in code_paths)
        if code_c is None and cum >= CODE_START_LINES:
            code_c = c
    rep.metrics["plan_before_code"] = ""
    if not plans:
        rep.add("Planning", "FAIL", "no plan found (README.md, worksheet PDF/photo)")
    elif plan_c is None:
        rep.add("Planning", "WARN", "plan files exist (%s) but no student commit touches them" % short(sorted(plans)))
    else:
        late_lines = code_before
        rep.metrics["plan_before_code"] = "yes" if late_lines <= CODE_START_LINES else "NO"
        lvl = "OK" if late_lines <= CODE_START_LINES else "FAIL" if late_lines > PLAN_LATE_LINES else "WARN"
        rep.add("Planning", lvl, "plan first committed %s (commit %s) after %d lines of code; first real code commit: %s" %
                (fmt(plan_c["adate"]), plan_c["hash"], late_lines, fmt(code_c["adate"]) if code_c else "none"))
        if len(plan_touches) == 1:
            rep.add("Planning", "WARN", "plan files were touched in only one commit - Part C (retrospective) probably missing")
        else:
            rep.add("Planning", "INFO", "plan files touched in %d commits (last: %s) - read Part C" %
                    (len(plan_touches), fmt(plan_touches[-1]["adate"])))
    readme = (rep.texts.get("README.md") or "").lower()
    if readme:
        hits = [k for k in ("brainstorm", "core", "extension", "challenge", "week", "retrospective") if k in readme]
        rep.add("Planning", "INFO", "README.md mentions: %s" % (", ".join(hits) or "none of brainstorm/core/extension/challenge/week/retrospective"))
    if any(p.lower().endswith(".pdf") for p in plans):
        rep.add("Planning", "INFO", "a PDF is present - content (3 ideas, Part C) must be read by hand")
    journal = rep.paths.get("JOURNAL.md")
    return [c for c in stud if journal in [f for f, _, _ in c["files"]]]


# ─────────────────────────────────────────────────────────────────────────────
# Per repo, similarity, output
# ─────────────────────────────────────────────────────────────────────────────
# ─────────────────────────────────────────────────────────────────────────────
# Oral defense: three lines of code worth discussing
#   Lines that still come from the starter commit are skipped. Lines are scored by how much
#   there is to explain (loops, branches, callbacks, flex/grid, media queries ...), with a
#   bonus for lines that arrived in a dump commit. Prefers one JS and one CSS line.
# ─────────────────────────────────────────────────────────────────────────────
JS_RULES = [  # (category, regex, weight)
    ("loop", re.compile(r"\b(for|while)\s*\("), 4),
    ("branch", re.compile(r"\b(if|switch)\b\s*\(|\belse\b|\?[^?.].*:"), 3),
    ("array", re.compile(r"\.(map|filter|forEach|reduce|find|some|every|sort|includes|push|pop|splice|slice|join|split)\("), 3),
    ("state", re.compile(r"Math\.|setTimeout|setInterval|localStorage|sessionStorage|fetch\(|JSON\.|new Date|Date\.now|"
                         r"parseInt|parseFloat|Number\("), 3),
    ("template", re.compile(r"`[^`]*\$\{"), 3),
    ("event", re.compile(r"addEventListener|\.on[a-z]+\s*=(?!=)"), 2),
    ("function", re.compile(r"\bfunction\b|=>"), 2),
    ("dom", re.compile(r"\.(innerHTML|textContent|innerText|classList|style\b|setAttribute|appendChild|createElement|value\b)"), 1),
]
CSS_RULES = [
    ("responsive", re.compile(r"@media|@supports"), 4),
    ("flex", re.compile(r"display\s*:\s*(inline-)?(flex|grid)|grid-template|justify-content|align-items|flex-(direction|wrap|grow)|\bgap\b"), 3),
    ("position", re.compile(r"position\s*:\s*(absolute|fixed|sticky|relative)|z-index|float\s*:"), 3),
    ("motion", re.compile(r"transition|animation|@keyframes"), 3),
    ("transform", re.compile(r"(?<![\w-])transform\s*:|translate[XYZ3d]*\(|rotate\(|scale[XY]?\("), 2),
    ("calc", re.compile(r"calc\(|var\(|clamp\(|--[\w-]+\s*:"), 3),
    ("selector", re.compile(r":(hover|focus|active|nth-[\w-]+|not|first-child|last-child)\b|::(before|after)"), 2),
    ("specificity", re.compile(r"!important"), 2),
    ("unit", re.compile(r"\d(%|vw|vh|rem|em)\b"), 1),
]
HTML_RX = re.compile(r"<(form|input|select|textarea|table|iframe|video|audio|label)\b|name=\"viewport\"", re.I)
ASK = {  # category -> (explain, what-if)
    "loop": ("How many times does this loop run, and what changes on each pass?",
             "What happens if the condition is off by one, or the list is empty?"),
    "branch": ("When is each branch taken? Give an example input for each.",
               "What changes if the condition is reversed, or an else-branch is added?"),
    "array": ("What does this return, and what does the callback receive?",
              "How would you write the same thing with a plain loop?"),
    "state": ("Where does this value come from and where does it go? What happens on a page reload?",
              "What breaks if the value is missing or has the wrong type?"),
    "template": ("What does ${...} do here, and what ends up in the page?",
                 "What would happen if the inserted text contained HTML?"),
    "event": ("Which event triggers this, and exactly what runs when it fires?",
              "What happens if the element does not exist, or the script runs before the page has loaded?"),
    "function": ("What are the inputs and the result? Where is it called?",
                 "What if you rename a parameter or call it with no arguments?"),
    "dom": ("Which element is changed here, and which property exactly?",
            "Could the same effect be done with a CSS class instead? Why or why not?"),
    "responsive": ("When does this rule apply, and what does it override?",
                   "What if two rules conflict - which one wins, and why?"),
    "flex": ("What does this do to the child elements, and in which direction?",
             "What changes if you switch the value (row/column, center/space-between ...)?"),
    "position": ("Relative to what is the element positioned? What happens to its neighbors?",
                 "What changes if the parent has no position, or on a narrow screen?"),
    "motion": ("What triggers this, and what exactly is animated?",
               "How would you make it slower or run in the other direction?"),
    "transform": ("What does this transform do to the element? Does it move its neighbors too?",
                  "What happens if you change the values or remove the line?"),
    "calc": ("What does this evaluate to? Where is the value defined?",
             "What changes if you edit the value in one place?"),
    "selector": ("Which elements does this selector match, exactly?",
                 "Which rule wins if another selector also matches, and why (specificity, order)?"),
    "specificity": ("Why was !important needed here? What was it overriding?",
                    "How could you avoid it?"),
    "unit": ("Why this unit instead of px?", "What happens when the window is resized?"),
    "html": ("What is this element or attribute for, and what does the browser do with it?",
             "What would happen without it, or what could you use instead?"),
    "other": ("Explain this line in your own words.", "What would happen if you deleted it?"),
}


def score_line(rules, s):
    hits = [(cat, w) for cat, rx, w in rules if rx.search(s)]
    if not hits:
        return 0, "other"
    return sum(w for _, w in hits), max(hits, key=lambda h: h[1])[0]


def blame_map(repo, fname):
    out = git(repo, "blame", "--line-porcelain", "-w", fname)
    m = {}
    for line in out.splitlines():
        mt = re.match(r"^([0-9a-f]{40}) \d+ (\d+)", line)
        if mt:
            m[int(mt.group(2))] = mt.group(1)[:7]
    return m


def pick_oral(repo, rep):
    cands, fallback = [], []
    for role, kind in (("script.js", "js"), ("style.css", "css"), ("index.html", "html")):
        text, fname = rep.texts.get(role), rep.paths.get(role)
        if not text or not fname:
            continue
        blame = blame_map(repo, fname)
        ctx = ""
        for i, raw in enumerate(text.splitlines(), 1):
            s = raw.strip()
            if kind == "css" and s.endswith("{"):
                ctx = re.sub(r"\s*\{$", "", s)
            if len(s) < 8 or s.startswith(("//", "/*", "*/", "<!--", "}")) or set(s) <= set("{}();,"):
                continue
            h = blame.get(i)
            if h and h in rep.starter_hashes:
                continue                      # teacher's starter code
            score, cat, display = 0, "other", [s[:110]]
            if kind == "js":
                score, cat = score_line(JS_RULES, s)
                if re.search(r"&&|\|\||===|!==", s):
                    score += 1
                score += min(len(s) // 30, 2)
                if "console.log" in s:
                    score -= 3
            elif kind == "css":
                is_decl = bool(re.match(r"^[\w-]+\s*:", s)) and not s.endswith("{")
                score, cat = score_line(CSS_RULES, s)
                if is_decl and ctx:
                    display = [ctx[:100] + " {", "    " + s[:100], "}"]
            elif HTML_RX.search(s):
                score, cat = 2, "html"
            info = rep.commit_info.get(h)
            origin = ""
            if info:
                origin = 'commit %s (%s, "%s", +%d lines)' % (h, fmt(info["adate"]), info["msg"][:50], info["added"])
                if info["added"] >= DUMP_LINES:
                    score += 2
                    origin += " - dump commit"
            item = {"file": fname, "role": role, "line": i, "lang": kind, "display": display, "cat": cat, "origin": origin,
                    "score": score, "text": s}
            (cands if score >= 2 else fallback).append(item)
    cands.sort(key=lambda c: (-c["score"], -len(c["text"]), c["line"]))
    chosen = []

    def take(c):
        if c not in chosen and c["text"] not in [x["text"] for x in chosen]:
            chosen.append(c)

    for f in ("script.js", "style.css"):                 # one JS and one CSS line if possible
        for c in cands:
            if c["role"] == f:
                take(c)
                break
    if not any(c["role"] == "style.css" for c in chosen):     # plain CSS: take the most substantial line
        plain = sorted([c for c in fallback if c["role"] == "style.css"], key=lambda c: (-c["score"], -len(c["text"])))
        if plain:
            take(plain[0])

    def near(c):
        return any(x["file"] == c["file"] and abs(x["line"] - c["line"]) <= 2 for x in chosen)

    for c in cands:                                      # then new categories, away from lines already chosen
        if len(chosen) < 3 and c["cat"] not in [x["cat"] for x in chosen] and not near(c):
            take(c)
    for strict in (True, False):
        for c in cands:
            if len(chosen) < 3 and not (strict and near(c)):
                take(c)
    fallback.sort(key=lambda c: (c["role"] != "script.js", -len(c["text"])))
    for c in fallback:                                   # nothing stood out: longest lines
        if len(chosen) < 3 and len(c["text"]) >= 15:
            take(c)
    for c in chosen[:3]:
        c["ask"], c["whatif"] = ASK[c["cat"]]
    rep.oral = chosen[:3]


def analyze_repo(path, args):
    name = os.path.basename(path.rstrip("/"))
    rep = Report(name)
    tracked = [t for t in git(path, "ls-files").splitlines() if t]
    rep.paths = {f: locate(tracked, f) for f in REQUIRED_FILES + ["README.md"]}
    for f, p in rep.paths.items():
        rep.texts[f] = read(path, p) if p else None
    check_files(rep, path, tracked)
    page = None
    if rep.texts["index.html"]:
        page = Page()
        page.feed(rep.texts["index.html"])
        page.finish()
    code_paths = {p for f, p in rep.paths.items() if f in CODE_FILES and p}
    extra = sorted(t for t in tracked if os.path.splitext(t)[1].lower() in (".html", ".css", ".js") and t not in code_paths)
    check_html(rep, page)
    check_links(rep, path, page, tracked, extra)
    check_css(rep, rep.texts["style.css"], page, rep.texts["script.js"])
    check_js(rep, path, rep.texts["script.js"], page)
    journal_commits = check_git(rep, path, tracked, args)
    check_journal(rep, rep.texts["JOURNAL.md"], journal_commits)
    pick_oral(path, rep)
    return rep


def shingles(text, k=5):
    t = re.findall(r"\w+|[^\w\s]", (text or "").lower())
    return {" ".join(t[i:i + k]) for i in range(max(0, len(t) - k + 1))}


def similarity(reports):
    kinds = {"HTML": "index.html", "CSS": "style.css", "JS": "script.js", "JOURNAL": "JOURNAL.md"}
    out = []
    for kind, fname in kinds.items():
        sets = {r.name: shingles(r.texts.get(fname)) for r in reports}
        if len(reports) >= 6:   # drop boilerplate shared by more than half of the class
            df = Counter(s for v in sets.values() for s in v)
            common = {s for s, c in df.items() if c > len(reports) / 2}
            sets = {k: v - common for k, v in sets.items()}
        names = sorted(sets)
        for i, a in enumerate(names):
            for b in names[i + 1:]:
                sa, sb = sets[a], sets[b]
                if min(len(sa), len(sb)) < 15:
                    continue
                shared = len(sa & sb)
                j = shared / len(sa | sb)
                if j >= SIMILARITY_FLAG:
                    out.append((a, b, fname, round(j, 2), shared))
    return sorted(out, key=lambda r: -r[3])


COLUMNS = ["repo", "student", "files_missing", "files_moved", "commits", "active_days", "span_days", "lines_added", "lines_deleted",
           "max_commit_added", "dump_commits", "generic_msgs", "late_commits", "plan_before_code", "html_tags",
           "css_props", "css_dupes", "css_unused", "interactions", "inline_styles", "embedded", "broken_refs",
           "journal_tags", "journal_ok", "similar_to"] + CRITERIA + ["FAIL", "WARN"]
MARK = {"OK": "OK", "WARN": "**WARN**", "FAIL": "**FAIL**", "INFO": "info"}


def write_report(path, rep):
    L = ["# %s" % rep.name, "", "| Criterion | Status | FAIL | WARN |", "|---|---|---|---|"]
    for c in CRITERIA:
        L.append("| %s | %s | %d | %d |" % (c, rep.status(c), sum(1 for x, l, _ in rep.findings if x == c and l == "FAIL"),
                                           sum(1 for x, l, _ in rep.findings if x == c and l == "WARN")))
    L += ["", "*Oral Defense (multiplier) is not assessed here.*", ""]
    order = {"FAIL": 0, "WARN": 1, "OK": 2, "INFO": 3}
    for c in CRITERIA:
        L += ["## %s" % c, ""]
        for _, lvl, msg in sorted([f for f in rep.findings if f[0] == c], key=lambda f: order[f[1]]):
            L.append("- %s: %s" % (MARK[lvl], msg))
        L.append("")
    if rep.oral:
        L += ["## Oral defense: suggested discussion lines", ""]
        for n, o in enumerate(rep.oral, 1):
            L.append("**%d. %s, line %d**" % (n, o["file"], o["line"]) + (" - " + o["origin"] if o["origin"] else ""))
            L += ["", "```" + o["lang"]] + o["display"] + ["```", "",
                  "- Ask: " + o["ask"], "- What if: " + o["whatif"],
                  "- Also: Where did this line come from (own idea, AI, tutorial, friend)? What did you change?", ""]
    L += ["## Commit log (author dates, local time)", "", "| Date | Hash | + | - | Files | Message | Flags |", "|---|---|---|---|---|---|---|"]
    for row in rep.commit_rows:
        L.append("| " + " | ".join(str(x).replace("|", "/") for x in row) + " |")
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(L) + "\n")


# ─────────────────────────────────────────────────────────────────────────────
# Combined PDF - a tiny built-in PDF writer (standard fonts only, no libraries needed)
# ─────────────────────────────────────────────────────────────────────────────
PAGE_W, PAGE_H, MARGIN = 595.28, 841.89, 48.0
CONTENT_W = PAGE_W - 2 * MARGIN
HELV = ([278, 278, 355, 556, 556, 889, 667, 191, 333, 333, 389, 584, 278, 333, 278, 278] + [556] * 10 +
        [278, 278, 584, 584, 584, 556, 1015] +
        [667, 667, 722, 722, 667, 611, 778, 722, 278, 500, 667, 556, 833, 722, 778, 667, 778, 722, 667, 611, 722, 667, 944, 667, 667, 611] +
        [278, 278, 278, 469, 556, 333] +
        [556, 556, 500, 556, 556, 278, 556, 556, 222, 222, 500, 222, 833, 556, 556, 556, 556, 333, 500, 278, 556, 500, 722, 500, 500, 500] +
        [334, 260, 334, 584])   # Helvetica widths for ASCII 32..126
COLORS = {"FAIL": (0.75, 0.22, 0.17), "WARN": (0.78, 0.47, 0.0), "OK": (0.12, 0.52, 0.29), "INFO": (0.45, 0.45, 0.45)}
BLACK, GRAY = (0, 0, 0), (0.4, 0.4, 0.4)


class Pdf:
    def __init__(self, title):
        self.title, self.pages, self.outline, self.y = title, [], [], 0
        self.new_page()

    def new_page(self):
        self.pages.append([])
        self.y = PAGE_H - MARGIN

    def need(self, h):
        if self.y - h < MARGIN + 10:
            self.new_page()

    @staticmethod
    def width(s, size, bold=False, mono=False):
        if mono:
            return 0.6 * size * len(s)
        w = sum(HELV[ord(c) - 32] if 32 <= ord(c) < 127 else 556 for c in s) * size / 1000.0
        return w * 1.07 if bold else w

    def wrap(self, s, maxw, size, bold=False, mono=False):
        s = s.replace("\t", "    ")
        lines = []
        if mono:
            n = max(1, int(maxw / (0.6 * size)))
            for para in s.split("\n"):
                lines += [para[i:i + n] for i in range(0, max(len(para), 1), n)]
            return lines
        for para in s.split("\n"):
            cur = ""
            for word in para.split(" "):
                trial = word if not cur else cur + " " + word
                if self.width(trial, size, bold) <= maxw:
                    cur = trial
                    continue
                if cur:
                    lines.append(cur)
                while self.width(word, size, bold) > maxw and len(word) > 1:
                    k = len(word)
                    while k > 1 and self.width(word[:k], size, bold) > maxw:
                        k -= 1
                    lines.append(word[:k])
                    word = word[k:]
                cur = word
            lines.append(cur)
        return lines

    def put(self, x, y, s, font, size, color=BLACK, page=-1):
        data = s.replace("\t", "    ").encode("cp1252", "replace")
        data = data.replace(b"\\", b"\\\\").replace(b"(", b"\\(").replace(b")", b"\\)")
        head = ("BT %.3f %.3f %.3f rg /%s %.2f Tf %.2f %.2f Td (" % (tuple(color) + (font, size, x, y))).encode("ascii")
        self.pages[page].append(head + data + b") Tj ET")

    def para(self, s, size=9, bold=False, mono=False, color=BLACK, indent=0, gap=3):
        lead = size * 1.3
        font = "F3" if mono else ("F2" if bold else "F1")
        for line in self.wrap(s, CONTENT_W - indent, size, bold, mono):
            self.need(lead)
            self.y -= lead
            self.put(MARGIN + indent, self.y, line, font, size, color)
        self.y -= gap

    def labeled(self, label, color, s, size=9, lw=38.0, indent=0):
        lead = size * 1.3
        for i, line in enumerate(self.wrap(s, CONTENT_W - indent - lw, size)):
            self.need(lead)
            self.y -= lead
            if i == 0:
                self.put(MARGIN + indent, self.y, label, "F2", size, color)
            self.put(MARGIN + indent + lw, self.y, line, "F1", size)
        self.y -= 2

    def rule(self):
        self.pages[-1].append(b"0.75 G 0.5 w %.2f %.2f m %.2f %.2f l S" % (MARGIN, self.y, PAGE_W - MARGIN, self.y))

    def heading(self, s, level=1, outline=None):
        size = {0: 20, 1: 15, 2: 11}[level]
        self.y -= size * 0.5
        self.need(size * 2.5)
        self.y -= size * 1.1
        self.put(MARGIN, self.y, s, "F2", size)
        if outline:
            self.outline.append((outline, len(self.pages) - 1, self.y + size))
        self.y -= size * 0.35
        if level <= 1:
            self.rule()
            self.y -= 4
        self.y -= 2

    def fit(self, s, w, size, bold=False):
        s = str(s)
        if self.width(s, size, bold) <= w:
            return s
        while s and self.width(s + "...", size, bold) > w:
            s = s[:-1]
        return s + "..."

    def table(self, rows, widths, size=7.5):
        lead = size * 1.7
        for ri, row in enumerate(rows):
            self.need(lead)
            top, bold = self.y, ri == 0
            if bold:
                self.pages[-1].append(b"0.90 g %.2f %.2f %.2f %.2f re f" % (MARGIN, top - lead, sum(widths), lead))
            x = MARGIN
            for cell, w in zip(row, widths):
                text, color = cell if isinstance(cell, tuple) else (cell, BLACK)
                self.put(x + 2, top - size * 1.2, self.fit(text, w - 4, size, bold), "F2" if bold or color != BLACK else "F1", size, color)
                x += w
            self.y -= lead
            self.pages[-1].append(b"0.85 G 0.3 w %.2f %.2f m %.2f %.2f l S" % (MARGIN, self.y, MARGIN + sum(widths), self.y))
        self.y -= 4

    def rect(self, x, y, w, h, fill=None, stroke=(0.6, 0.6, 0.6), lw=0.5):
        if fill:
            self.pages[-1].append(b"%.3f %.3f %.3f rg %.2f %.2f %.2f %.2f re f" % (tuple(fill) + (x, y, w, h)))
        if stroke:
            self.pages[-1].append(b"%.3f %.3f %.3f RG %.2f w %.2f %.2f %.2f %.2f re S" % (tuple(stroke) + (lw, x, y, w, h)))

    def hline(self, x1, x2, y, gray=0.75, lw=0.4):
        self.pages[-1].append(b"%.2f G %.2f w %.2f %.2f m %.2f %.2f l S" % (gray, lw, x1, y, x2, y))

    def center(self, x, w, y, s, font, size, color=BLACK):
        tw = self.width(s, size, font == "F2", font == "F3")
        self.put(x + (w - tw) / 2, y, s, font, size, color)

    def save(self, path):
        n = len(self.pages)
        for i in range(n):
            self.put(MARGIN, 26, "%s  -  page %d of %d" % (self.title, i + 1, n), "F1", 7, GRAY, page=i)
        fonts = [b"Helvetica", b"Helvetica-Bold", b"Courier"]
        objs = {1: b"<< /Type /Catalog /Pages 2 0 R /PageMode /UseOutlines /Outlines %d 0 R >>" % (6 + 2 * n),
                2: b"<< /Type /Pages /Kids [" + b" ".join(b"%d 0 R" % (6 + 2 * i) for i in range(n)) +
                   b"] /Count %d >>" % n}
        for k, f in enumerate(fonts):
            objs[3 + k] = b"<< /Type /Font /Subtype /Type1 /BaseFont /" + f + b" /Encoding /WinAnsiEncoding >>"
        for i, ops in enumerate(self.pages):
            stream = b"\n".join(ops)
            objs[6 + 2 * i] = (b"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 %.2f %.2f] /Resources << /Font << /F1 3 0 R "
                               b"/F2 4 0 R /F3 5 0 R >> >> /Contents %d 0 R >>" % (PAGE_W, PAGE_H, 7 + 2 * i))
            objs[7 + 2 * i] = b"<< /Length %d >>\nstream\n" % len(stream) + stream + b"\nendstream"
        root, k = 6 + 2 * n, len(self.outline)
        objs[root] = (b"<< /Type /Outlines /First %d 0 R /Last %d 0 R /Count %d >>" % (root + 1, root + k, k)
                      if k else b"<< /Type /Outlines /Count 0 >>")
        for j, (title, pg, y) in enumerate(self.outline):
            t = title.encode("cp1252", "replace").replace(b"\\", b"\\\\").replace(b"(", b"\\(").replace(b")", b"\\)")
            body = b"<< /Title (" + t + b") /Parent %d 0 R /Dest [%d 0 R /XYZ 0 %.2f 0]" % (root, 6 + 2 * pg, y)
            if j > 0:
                body += b" /Prev %d 0 R" % (root + j)
            if j < k - 1:
                body += b" /Next %d 0 R" % (root + j + 2)
            objs[root + 1 + j] = body + b" >>"
        out, offsets = bytearray(b"%PDF-1.4\n%\xe2\xe3\xcf\xd3\n"), {}
        for oid in sorted(objs):
            offsets[oid] = len(out)
            out += b"%d 0 obj\n" % oid + objs[oid] + b"\nendobj\n"
        xref, size = len(out), max(objs) + 1
        out += b"xref\n0 %d\n0000000000 65535 f \n" % size
        for oid in range(1, size):
            out += b"%010d 00000 n \n" % offsets[oid]
        out += b"trailer\n<< /Size %d /Root 1 0 R >>\nstartxref\n%d\n%%%%EOF\n" % (size, xref)
        with open(path, "wb") as fh:
            fh.write(bytes(out))


def render_pdf(path, reports, sims, args):
    pdf = Pdf("Autograder evidence report")
    pdf.heading("Autograder evidence report", 0, outline="Overview")
    info = "Generated %s. %d repositories." % (dt.datetime.now().strftime("%Y-%m-%d %H:%M"), len(reports))
    if args.deadline:
        info += " Deadline: %s." % fmt(args.deadline)
    if args.start:
        info += " Project start: %s." % fmt(args.start)
    pdf.para(info, size=9)
    pdf.para("Evidence only - no grades are assigned and the Oral Defense multiplier is not assessed. FAIL = a minimum is not "
             "met or something breaks; WARN = worth a look; OK = no problem found; info = context. Journal and plan checks are "
             "keyword heuristics: read the texts yourself.", size=8.5, color=GRAY)
    rows = [["Student", "Commits", "FAIL", "WARN", "Plan", "Process", "Impl.", "Content", "Submit"]]
    for r in reports:
        rows.append([r.name[len(REPO_PREFIX):] if r.name.startswith(REPO_PREFIX) else r.name, str(r.metrics.get("commits", 0)),
                     str(r.count("FAIL")), str(r.count("WARN"))] + [(r.status(c), COLORS[r.status(c)]) for c in CRITERIA])
    pdf.table(rows, [150, 44, 34, 34] + [47] * 5, size=8)

    for r in reports:
        pdf.new_page()
        pdf.heading(r.name[len(REPO_PREFIX):] if r.name.startswith(REPO_PREFIX) else r.name, 1, outline=r.name)
        rows = [["Criterion", "Status", "FAIL", "WARN"]]
        for c in CRITERIA:
            rows.append([c, (r.status(c), COLORS[r.status(c)]), str(sum(1 for x, l, _ in r.findings if x == c and l == "FAIL")),
                         str(sum(1 for x, l, _ in r.findings if x == c and l == "WARN"))])
        pdf.table(rows, [140, 60, 40, 40], size=8)
        order = {"FAIL": 0, "WARN": 1, "OK": 2, "INFO": 3}
        for c in CRITERIA:
            pdf.heading(c, 2)
            for _, lvl, msg in sorted([f for f in r.findings if f[0] == c], key=lambda f: order[f[1]]):
                pdf.labeled("info" if lvl == "INFO" else lvl, COLORS[lvl], msg)
        if r.oral:
            pdf.heading("Oral defense: suggested discussion lines", 2)
            for n, o in enumerate(r.oral, 1):
                pdf.need(70)
                pdf.para("%d. %s, line %d" % (n, o["file"], o["line"]), size=9, bold=True, gap=1)
                if o["origin"]:
                    pdf.para("Origin: " + o["origin"], size=7.5, color=GRAY, indent=10, gap=2)
                for dl in o["display"]:
                    pdf.para(dl, size=8.5, mono=True, indent=10, gap=0)
                pdf.y -= 3
                pdf.labeled("Ask", BLACK, o["ask"], size=8.5, lw=44, indent=10)
                pdf.labeled("What if", BLACK, o["whatif"], size=8.5, lw=44, indent=10)
                pdf.labeled("Also", BLACK, "Where did this line come from (own idea, AI, tutorial, friend)? What did you change?",
                            size=8.5, lw=44, indent=10)
                pdf.y -= 4
        pdf.heading("Commit log (author dates, local time)", 2)
        pdf.table([["Date", "Hash", "+", "-", "Files", "Message", "Flags"]] + [[str(x) for x in row] for row in r.commit_rows],
                  [78, 44, 28, 28, 30, 200, 80], size=7)

    pdf.new_page()
    pdf.heading("Similar files between students", 1, outline="Similarity")
    if sims:
        pdf.table([["Student A", "Student B", "File", "Similarity", "Shared"]] +
                  [[a[len(REPO_PREFIX):], b[len(REPO_PREFIX):], f, "%d%%" % round(j * 100), str(s)] for a, b, f, j, s in sims],
                  [120, 120, 90, 60, 60], size=8)
    else:
        pdf.para("No pair of repositories is above the similarity threshold (%d%%)." % round(SIMILARITY_FLAG * 100))
    pdf.save(path)


# ─────────────────────────────────────────────────────────────────────────────
# Oral defense sheets - one A4 page per student, to print and fill in by hand
# ─────────────────────────────────────────────────────────────────────────────
def student_name(repo):
    return repo[len(REPO_PREFIX):] if repo.startswith(REPO_PREFIX) else repo


def mono_fit(s, w, size):
    n = max(4, int(w / (0.6 * size)))
    return s if len(s) <= n else s[:n - 3] + "..."


def oral_sheet(pdf, r):
    """Name, the suggested code lines, blank space for notes, and one row of level checkboxes."""
    L, W = MARGIN, CONTENT_W
    # ── name ──
    pdf.y = PAGE_H - MARGIN - 14
    pdf.put(L, pdf.y, "Oral Defense: " + student_name(r.name), "F2", 16)
    pdf.put(L + W - pdf.width(r.name, 7.5), pdf.y, r.name, "F1", 7.5, GRAY)
    pdf.y -= 7
    pdf.hline(L, L + W, pdf.y, gray=0.3, lw=0.8)
    pdf.y -= 8
    # ── code lines ──
    for o in r.oral:
        h = 12 * len(o["display"]) + 8
        pdf.y -= 16
        pdf.put(L, pdf.y + 3, "%s, line %d" % (o["file"], o["line"]), "F1", 8, GRAY)
        pdf.rect(L, pdf.y - h, W, h, fill=(0.94, 0.94, 0.94), stroke=None)
        for dl in o["display"]:
            pdf.y -= 12
            pdf.put(L + 8, pdf.y + 1, mono_fit(dl, W - 16, 9.5), "F3", 9.5)
        pdf.y -= 8
    # ── checkboxes (the space above them stays blank for notes) ──
    y, box, x = MARGIN + 4, 11, L
    for lvl in ("++", "+", "+/-", "-", "--"):
        pdf.rect(x, y - 2, box, box, stroke=(0.2, 0.2, 0.2), lw=0.7)
        pdf.put(x + box + 6, y, lvl, "F2", 11)
        x += box + 6 + pdf.width(lvl, 11, True) + 34


def render_sheets(path, reports):
    pdf = Pdf("Oral defense sheets")
    for i, r in enumerate(reports):
        if i:
            pdf.new_page()
        oral_sheet(pdf, r)
    pdf.save(path)


def main():
    ap = argparse.ArgumentParser(description="Collect rubric evidence from cloned student repos.")
    ap.add_argument("root", help="directory containing the cloned repos (one sub-directory each)")
    ap.add_argument("--out", help="output directory (default: grading-report_<root name>)")
    ap.add_argument("--deadline", help="e.g. 2026-12-18T23:59 (local time)")
    ap.add_argument("--start", help="project start, e.g. 2026-11-23; earlier commits count as starter code")
    ap.add_argument("--ignore-authors", default=r"classroom|\[bot\]", help="regex for starter/bot authors (default: %(default)s)")
    ap.add_argument("--delimiter", default=",", help="CSV delimiter; use ';' for German-locale Excel")
    ap.add_argument("--no-pdf", action="store_true", help="skip all-reports.pdf and oral-defense-sheets.pdf")
    args = ap.parse_args()
    args.deadline, args.start = parse_local(args.deadline), parse_local(args.start)

    repos = sorted((os.path.join(args.root, d) for d in os.listdir(args.root)
                    if os.path.isdir(os.path.join(args.root, d, ".git"))), key=lambda p: os.path.basename(p).lower())
    if not repos:
        sys.exit("No git repositories found in %s" % args.root)
    out = args.out or "grading-report_%s" % os.path.basename(os.path.abspath(args.root))
    os.makedirs(out, exist_ok=True)

    reports = []
    for p in repos:
        print("Analyzing %s ..." % os.path.basename(p))
        reports.append(analyze_repo(p, args))

    sims = similarity(reports)
    by_name = {r.name: r for r in reports}
    for a, b, f, j, shared in sims:
        for me, other in ((a, b), (b, a)):
            crit = "Content" if f == "JOURNAL.md" else "Implementation"
            by_name[me].add(crit, "WARN", "%s is %d%% similar to %s (%d shared 5-word shingles) - compare; could be shared "
                            "template, pair work or copying" % (f, round(j * 100), other[len(REPO_PREFIX):] or other, shared))
            prev = by_name[me].metrics.get("similar_to", "")
            by_name[me].metrics["similar_to"] = (prev + "; " if prev else "") + "%s:%s %.2f" % (f, other[len(REPO_PREFIX):] or other, j)

    with open(os.path.join(out, "summary.csv"), "w", newline="", encoding="utf-8-sig") as fh:
        w = csv.DictWriter(fh, fieldnames=COLUMNS, extrasaction="ignore", delimiter=args.delimiter)
        w.writeheader()
        for r in reports:
            row = dict(r.metrics)
            row.update({"repo": r.name, "student": r.name[len(REPO_PREFIX):] if r.name.startswith(REPO_PREFIX) else r.name,
                        "FAIL": r.count("FAIL"), "WARN": r.count("WARN")})
            row.update({c: r.status(c) for c in CRITERIA})
            w.writerow(row)
    with open(os.path.join(out, "similarity.csv"), "w", newline="", encoding="utf-8-sig") as fh:
        w = csv.writer(fh, delimiter=args.delimiter)
        w.writerow(["repo_a", "repo_b", "file", "jaccard", "shared_shingles"])
        w.writerows(sims)
    for r in reports:
        write_report(os.path.join(out, r.name + ".md"), r)
    if not args.no_pdf:
        render_pdf(os.path.join(out, "all-reports.pdf"), reports, sims, args)
        render_sheets(os.path.join(out, "oral-defense-sheets.pdf"), reports)

    print("\n%-34s %7s %5s %5s   %s" % ("repo", "commits", "FAIL", "WARN", " ".join(c[:4] for c in CRITERIA)))
    for r in reports:
        print("%-34s %7s %5d %5d   %s" % (r.name[:34], r.metrics.get("commits", 0), r.count("FAIL"), r.count("WARN"),
                                         " ".join("%-4s" % r.status(c) for c in CRITERIA)))
    print("\nWrote %d reports, summary.csv, similarity.csv%s to %s/" %
          (len(reports), "" if args.no_pdf else ", all-reports.pdf and oral-defense-sheets.pdf", out))


if __name__ == "__main__":
    main()