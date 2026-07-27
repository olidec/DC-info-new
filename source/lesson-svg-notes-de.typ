// ─────────────────────────────────────────────────────────────────────────────
// Lektion — SVG: Scalable Vector Graphics
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Informatik"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "SVG — Scalable Vector Graphics"
#let lesson-subtitle = "Zeichnen mit Code"

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
  [Den Unterschied zwischen Rastergrafik und Vektorgrafik erklären.],
  [Ein `<svg>`-Element direkt in eine HTML-Seite einbetten.],
  [Grundformen zeichnen und gestalten: `<circle>`, `<rect>`, `<ellipse>`, `<line>`, `<polygon>`.],
  [Formen kombinieren, um eine erkennbare Szene oder Figur zu erstellen.],
  [Eine einfache `<animate>`-Animation zu einem SVG-Element hinzufügen.],
  [JavaScript verwenden, um SVG-Formen dynamisch zu erzeugen oder zu verändern.],
)

= Rastergrafik vs. Vektorgrafik #h(1fr) #tier-core

Fast jedes Bild, das Sie auf dem Bildschirm sehen, gehört zu einer von zwei Familien.

*Rastergrafiken* speichern ein Bild als Gitter farbiger Pixel. Wenn Sie weit genug
hineinzoomen, sehen Sie die einzelnen Quadrate. Dateiformate wie JPEG, PNG und GIF
sind alles Rasterformate. Fotografien sind typischerweise Rasterbilder.

*Vektorgrafiken* speichern ein Bild als Menge mathematischer Anweisungen:
„Zeichne einen Kreis mit Radius 40, Mittelpunkt (50, 50), gefüllt mit Rot." Der
Computer berechnet die Pixel bei Bedarf neu – unabhängig von Größe oder
Zoomstufe. Dadurch sind Vektorbilder *bei jeder Skalierung gestochen scharf* –
sie werden nie unscharf oder pixelig.

#infobox(
  "Warum ist das für das Web wichtig?",
  [Logos, Icons, Diagramme und Illustrationen sind ideale Kandidaten für
   Vektorgrafiken. Ein Firmenlogo im SVG-Format sieht auf einer kleinen
   Visitenkarte genauso scharf aus wie auf einem riesigen Plakat – und das
   mit derselben Datei. Ein PNG-Logo würde separate Versionen für jede
   Auflösung benötigen. SVG-Dateien sind zudem typischerweise sehr klein,
   da nur eine Beschreibung gespeichert wird und keine Millionen von Pixelwerten.],
)

= SVG in HTML #h(1fr) #tier-core

*Scalable Vector Graphics (SVG)* ist das standardisierte Vektorbildformat für
das Web. SVG ist in XML geschrieben – einer Auszeichnungssprache, die HTML sehr
ähnlich ist – und kann daher direkt in eine HTML-Datei eingebettet werden, wie
jedes andere Tag auch.

Hier ist das kleinstmögliche SVG – ein roter Kreis:

```html
<svg height="100" width="100">
  <circle cx="50" cy="50" r="50" fill="red" />
</svg>
```

Das `<svg>`-Tag fungiert als Leinwand. Die Attribute `width` und `height`
legen fest, wie viel Platz die Leinwand auf der Seite einnimmt, gemessen in Pixeln.

#warnbox(
  "⚠ Das Koordinatensystem",
  [SVG verwendet ein Koordinatensystem, bei dem (0, 0) die *obere linke* Ecke ist.
   Die x-Achse nimmt nach rechts zu, die y-Achse nimmt *nach unten* zu.
   Dies ist das Gegenteil der mathematischen Konvention und sorgt häufig für
   Verwirrung. Behalten Sie dies im Hinterkopf, wenn Sie Formen platzieren.],
)

== Gemeinsame visuelle Attribute

Diese Attribute können auf *jede* SVG-Form angewendet werden:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribut],
    text(size: 9pt, weight: "bold", fill: white)[Beschreibung],
  ),
  [`fill`],         [Die Füllfarbe der Form. Akzeptiert Farbnamen, Hex-Codes oder `"none"`.],
  [`stroke`],       [Die Farbe des Rahmens.],
  [`stroke-width`], [Die Stärke des Rahmens in Pixeln.],
  [`opacity`],      [Transparenz von `0` (unsichtbar) bis `1` (vollständig sichtbar).],
)

= Grundformen #h(1fr) #tier-core

== Kreise — `<circle>`

```html
<circle cx="50" cy="50" r="40" fill="yellow" stroke="green" stroke-width="4" />
```

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribut],
    text(size: 9pt, weight: "bold", fill: white)[Bedeutung],
  ),
  [`cx`], [x-Koordinate des Mittelpunkts.],
  [`cy`], [y-Koordinate des Mittelpunkts.],
  [`r`],  [Radius.],
)

== Rechtecke — `<rect>`

```html
<rect x="30" y="20" width="200" height="50" fill="blue" rx="8" />
```

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribut],
    text(size: 9pt, weight: "bold", fill: white)[Bedeutung],
  ),
  [`x`, `y`],         [Position der *oberen linken* Ecke.],
  [`width`, `height`],[Abmessungen des Rechtecks.],
  [`rx`, `ry`],       [Radien für abgerundete Ecken (optional; Standard 0 = scharfe Ecken).],
)

== Ellipsen — `<ellipse>`

Eine Ellipse ist wie ein Kreis, jedoch mit unabhängig einstellbaren horizontalen
und vertikalen Radien (in der Mathematik als grosse und kleine Halbachse bekannt):

```html
<ellipse cx="100" cy="60" rx="80" ry="40" fill="purple" />
```

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribut],
    text(size: 9pt, weight: "bold", fill: white)[Bedeutung],
  ),
  [`cx`, `cy`], [Koordinaten des Mittelpunkts.],
  [`rx`],       [Horizontaler Radius.],
  [`ry`],       [Vertikaler Radius.],
)

== Linien — `<line>`

Eine gerade Linie zwischen zwei Punkten. Da eine Linie kein Inneres hat, ist
`stroke` erforderlich – `fill` hat hier keine Wirkung.

```html
<line x1="10" y1="10" x2="200" y2="150" stroke="black" stroke-width="3" />
```

== Linienzüge — `<polyline>`

Eine Folge verbundener gerader Liniensegmente. Alle Punkte werden in einem
einzigen `points`-Attribut aufgeführt, getrennt durch Leerzeichen oder Kommas.
Standardmässig hat ein Linienzug eine Füllung – verwenden Sie `fill="none"`,
um diese zu unterdrücken:

```html
<polyline
  points="60,110 65,120 70,115 75,130 80,125 85,140"
  fill="none"
  stroke="red"
  stroke-width="2"
/>
```

== Polygone — `<polygon>`

Ein Polygon funktioniert genau wie ein Linienzug, mit dem Unterschied, dass der
Pfad automatisch geschlossen wird – der letzte Punkt wird mit dem ersten verbunden.
Dies macht es ideal für Dreiecke, Sterne und Sechsecke:

```html
<polygon points="200,10 250,190 160,210" fill="lime" stroke="purple" />
```

Die Koordinaten eines regelmässigen Polygons lassen sich mit Trigonometrie berechnen.
Für ein regelmässiges $n$-Eck mit Mittelpunkt $(c_x, c_y)$ und Radius $r$ befindet
sich der $k$-te Eckpunkt bei:

$ x_k = c_x + r dot cos((2 pi k) / n), quad y_k = c_y + r dot sin((2 pi k) / n) $

#infobox(
  "Tipp — Tabellenkalkulation verwenden",
  [Für regelmässige Polygone müssen Sie die Koordinaten nicht von Hand berechnen.
   Öffnen Sie eine Tabellenkalkulation, berechnen Sie $r dot cos(2 pi k / n)$ und
   $r dot sin(2 pi k / n)$ für jedes $k$, und kopieren Sie die Ergebnisse in Ihr
   `points`-Attribut.],
)

= Pfade — `<path>` #h(1fr) #tier-extension

Das `<path>`-Element ist die mächtigste Form in SVG. Es kann gerade Linien,
Kurven und beliebig komplexe Umrisse beschreiben – alles durch eine kompakte
Minisprache im `d`-Attribut.

Die häufigsten Befehle sind:

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Befehl],
    text(size: 9pt, weight: "bold", fill: white)[Name],
    text(size: 9pt, weight: "bold", fill: white)[Beschreibung],
  ),
  [`M x,y`],         [Bewegen],            [Stift anheben und ohne Zeichnen nach (x, y) setzen.],
  [`L x,y`],         [Linie],              [Eine gerade Linie nach (x, y) zeichnen.],
  [`H x`],           [Horizontale Linie],  [Eine horizontale Linie bis x zeichnen.],
  [`V y`],           [Vertikale Linie],    [Eine vertikale Linie bis y zeichnen.],
  [`Q cx,cy x,y`],   [Quadratische Kurve], [Eine glatte Kurve zum Kontrollpunkt (cx, cy), endend bei (x, y).],
  [`C cx1,cy1 cx2,cy2 x,y`], [Kubische Bézier-Kurve], [Eine glatte Kurve mit zwei Kontrollpunkten.],
  [`Z`],             [Pfad schliessen],    [Eine gerade Linie zurück zum Startpunkt zeichnen.],
)

Ein Lächeln lässt sich zum Beispiel mit einer quadratischen Kurve zeichnen:

```html
<path
  d="M 20,100 Q 60,140 100,100"
  fill="none"
  stroke="black"
  stroke-width="3"
/>
```

Hier setzt `M 20,100` den Stift an den linken Mundwinkel, `Q 60,140` legt einen
Kontrollpunkt unterhalb der Mitte fest (der die Kurve nach unten zieht), und
`100,100` ist der rechte Mundwinkel.

#note(
  "Weiterführendes",
  [Die vollständige Pfad-Spezifikation ist umfangreich. Das MDN-Web-Docs-Tutorial
   unter `developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths` ist die beste
   Referenz, wenn Sie Kurven genauer erkunden möchten.],
)

= Ebenen und Gruppen #h(1fr) #tier-extension

== Zeichenreihenfolge

SVG-Elemente werden in der Reihenfolge gezeichnet, in der sie im Code erscheinen.
Spätere Elemente erscheinen *über* früheren – genau wie gestapelte Papierblätter.
Wenn ein Kreis vor einem Rechteck erscheinen soll, schreiben Sie den Kreis nach
dem Rechteck.

== Gruppen — `<g>`

Das `<g>`-Element fasst mehrere Formen zusammen. Visuelle Attribute, die für die
Gruppe gesetzt werden, werden von allen Kindelementen übernommen, und die gesamte
Gruppe kann auf einmal verschoben oder gestaltet werden:

```html
<g fill="steelblue" stroke="navy" stroke-width="1">
  <circle cx="50" cy="50" r="30" />
  <rect x="80" y="30" width="40" height="40" />
</g>
```

Gruppen sind besonders nützlich, wenn Sie ein zusammengesetztes Objekt erstellen
möchten – etwa ein Gesicht aus Kreisen und Kurven – und es als Einheit behandeln wollen.

= Animation #h(1fr) #tier-extension

SVG unterstützt Animationen über das `<animate>`-Element. Platzieren Sie es
*innerhalb* der Form, die Sie animieren möchten. Es verändert kontinuierlich ein
Attribut des übergeordneten Elements über die Zeit:

```html
<ellipse cx="50" cy="50" rx="50" ry="50" fill="red">
  <animate
    attributeName="ry"
    values="50;25;50"
    dur="2s"
    repeatCount="indefinite"
  />
</ellipse>
```

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Attribut],
    text(size: 9pt, weight: "bold", fill: white)[Bedeutung],
  ),
  [`attributeName`],  [Das zu animierende SVG-Attribut (z.B. `"ry"`, `"fill"`, `"cx"`).],
  [`values`],         [Durch Semikolons getrennte Liste von Werten, die durchlaufen werden.],
  [`dur`],            [Dauer eines Zyklus (z.B. `"2s"`, `"500ms"`).],
  [`repeatCount`],    [`"indefinite"` wiederholt endlos; eine Zahl wiederholt entsprechend oft.],
)

== Bewegungsanimation — `<animateMotion>`

`<animateMotion>` bewegt eine Form entlang eines Pfades:

```html
<svg viewBox="0 0 200 100">
  <path fill="none" stroke="lightgrey"
    d="M20,50 C20,-50 180,150 180,50 C180,-50 20,150 20,50 z" />
  <circle r="6" fill="red">
    <animateMotion
      dur="4s"
      repeatCount="indefinite"
      path="M20,50 C20,-50 180,150 180,50 C180,-50 20,150 20,50 z"
    />
  </circle>
</svg>
```

Die Form folgt genau dem Pfad, der im `path`-Attribut definiert ist – nützlich
für Umlaufbahnen, Ladeanimationen und jede Animation, die einer festen Route folgt.

= SVG mit JavaScript erzeugen #h(1fr) #tier-challenge

Da SVG innerhalb des HTML-Dokuments liegt, kann JavaScript SVG-Elemente genauso
erstellen und verändern wie jedes andere DOM-Element. Dies eröffnet eine ganz
neue Dimension: *Generative Art* – Bilder, die durch Code entstehen anstatt
von Hand gezeichnet zu werden.

== SVG-Elemente in JavaScript erstellen

SVG-Elemente müssen mit `document.createElementNS` erstellt werden und nicht mit
`document.createElement`, da SVG einen anderen XML-Namensraum verwendet:

```js
const svgNS = "http://www.w3.org/2000/svg";
const svg   = document.getElementById("my-svg");

const circle = document.createElementNS(svgNS, "circle");
circle.setAttribute("cx", 100);
circle.setAttribute("cy", 100);
circle.setAttribute("r",  40);
circle.setAttribute("fill", "steelblue");

svg.appendChild(circle);
```

== Ein durchgearbeitetes Beispiel: zufällige Kreise

Der folgende Code zeichnet bei jedem Laden der Seite 30 Kreise an zufälligen
Positionen mit zufälligen Farben:

```js
const svgNS = "http://www.w3.org/2000/svg";
const svg   = document.getElementById("canvas");

function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

for (let i = 0; i < 30; i++) {
  const circle = document.createElementNS(svgNS, "circle");
  circle.setAttribute("cx",   randomInt(20, 580));
  circle.setAttribute("cy",   randomInt(20, 280));
  circle.setAttribute("r",    randomInt(5, 40));
  circle.setAttribute("fill", `hsl(${randomInt(0, 360)}, 70%, 60%)`);
  circle.setAttribute("opacity", "0.7");
  svg.appendChild(circle);
}
```

Beachten Sie `hsl(hue, saturation, lightness)` – ein Farbformat, mit dem sich
vielfältige, aber harmonische Farben leicht erzeugen lassen, indem nur der
Farbton zufällig gewählt wird.

#infobox(
  "HSL-Farben",
  [HSL steht für Hue–Saturation–Lightness (Farbton–Sättigung–Helligkeit).
   Der Farbton ist ein Winkel auf dem Farbkreis (0–360°): `hsl(0, 70%, 60%)`
   ist Rot, `hsl(120, 70%, 60%)` ist Grün und `hsl(240, 70%, 60%)` ist Blau.
   Indem Sättigung und Helligkeit konstant gehalten und nur der Farbton
   zufällig gewählt wird, erhalten Sie Farben, die immer gut zusammenpassen.],
)

== Auf Klicks reagieren

Sie können SVG-Formen auch als Reaktion auf Benutzereingaben verändern. Der
folgende Code fügt jedem Kreis einen Klick-Listener hinzu, der die Farbe bei
einem Klick ändert:

```js
circle.addEventListener("click", () => {
  circle.setAttribute("fill", `hsl(${randomInt(0, 360)}, 70%, 60%)`);
});
```

= Zusammenfassung #h(1fr) #tier-core

#checklist(
  [Sie können erklären, warum Vektorgrafiken besser skalieren als Rastergrafiken.],
  [Sie können `<svg>` in HTML einbetten und `width` sowie `height` setzen.],
  [Sie können `<circle>`, `<rect>`, `<ellipse>`, `<line>` und `<polygon>` zeichnen und gestalten.],
  [Sie wissen, dass (0, 0) die *obere linke* Ecke ist und y nach unten zunimmt.],
  [Sie können `<animate>` verwenden, um ein Shape-Attribut über die Zeit zu animieren.],
  [Sie können `document.createElementNS` verwenden, um SVG-Formen aus JavaScript zu erstellen.],
)
