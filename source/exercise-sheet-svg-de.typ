// ─────────────────────────────────────────────────────────────────────────────
// Aufgabenblatt — SVG: Scalable Vector Graphics
// ─────────────────────────────────────────────────────────────────────────────

#let course      = "Informatik"
#let level       = "Gymnasium Muttenz"
#let term        = "2026-27"
#let lesson-num  = "SVG"
#let sheet-type  = "Aufgabenblatt"
#let sheet-title = "Scalable Vector Graphics"

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
  v(0.6em)
  text(size: 11pt, weight: "bold", fill: rgb("#111111"), it.body)
  v(0.2em)
}

// ── Import shared styles ───────────────────────────────────────────────────────
#import "../cs-style.typ": *

// ── Extra components ──────────────────────────────────────────────────────────

// A side-by-side code + preview scaffold
#let code-preview(code-content) = block(
  width: 100%,
  breakable: false,
  grid(
    columns: (1fr, 1fr),
    column-gutter: 12pt,
    block(
      fill: rgb("#F0F0F0"),
      width: 100%,
      inset: 10pt,
      radius: 2pt,
      text(size: 9.5pt, fill: rgb("#111111"), code-content)
    ),
    block(
      fill: rgb("#F5F5F5"),
      width: 100%,
      inset: 10pt,
      radius: 2pt,
      stroke: 0.5pt + rgb("#CCCCCC"),
      [
        #text(size: 9pt, fill: rgb("#999999"), style: "italic")[
          Skizzieren Sie hier Ihre erwartete Ausgabe:
        ]
        #v(5em)
      ]
    ),
  )
)

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT
// ─────────────────────────────────────────────────────────────────────────────

#tier-legend

#v(0.5em)

#text(size: 9pt, fill: rgb("#999999"))[
  Alle Programmieraufgaben werden in Ihrem `svg-art`-Repository bearbeitet.
  Öffnen Sie `index.html` in VS Code und im Browser nebeneinander.
  Nach jeder Aufgabe: Committen Sie Ihre Arbeit mit einer klaren Nachricht.
]

#v(0.5em)

// ─────────────────────────────────────────────────────────────────────────────
= Teil 1 — SVG-Code lesen #h(1fr) #tier-core

Skizzieren Sie für jeden Code-Ausschnitt, was Sie in der Vorschaubox rechts
erwarten. Gehen Sie davon aus, dass die `<svg>`-Leinwand 200 × 200 Pixel gross ist.

#v(0.4em)
#exercise(title: "Kreise")[
  #code-preview(raw(lang: "html", ```html
<svg width="200" height="200">
  <circle cx="60"  cy="100" r="50" fill="tomato" />
  <circle cx="140" cy="100" r="50" fill="steelblue"
          opacity="0.7" />
</svg>
```.text))
]

#exercise(title: "Rechteck und Linie")[
  #code-preview(raw(lang: "html", ```html
<svg width="200" height="200">
  <rect x="20" y="60" width="160" height="80"
        fill="none" stroke="black" stroke-width="3" rx="10" />
  <line x1="20" y1="100" x2="180" y2="100"
        stroke="red" stroke-width="2" />
</svg>
```.text))
]

#exercise(title: "Polygon")[
  #code-preview(raw(lang: "html", ```html
<svg width="200" height="200">
  <polygon
    points="100,20 180,170 20,170"
    fill="gold"
    stroke="darkorange"
    stroke-width="3"
  />
</svg>
```.text))

  Wie heisst diese Form? #answer-space(lines: 1)
]

// ─────────────────────────────────────────────────────────────────────────────
= Teil 2 — SVG-Code schreiben #h(1fr) #tier-core

Öffnen Sie `index.html` in Ihrem Repository. Jede Aufgabe unten verlangt, dass
Sie SVG zur Datei hinzufügen. Verwenden Sie das `<svg>`-Tag mit passenden
`width`- und `height`-Attributen für jedes Bild.

#exercise(title: "Berührende Kreise")[
  Zeichnen Sie drei Kreise nebeneinander, die sich berühren und von links nach
  rechts kleiner werden. Geben Sie jedem Kreis eine andere Füllfarbe.

  #hint[
    Wenn der grösste Kreis Radius $r_1$ hat und sein Mittelpunkt bei $(r_1,\, r_1)$
    liegt – wo muss der Mittelpunkt eines Kreises mit Radius $r_2$ liegen, damit
    sich die beiden Kreise genau berühren?
  ]
]

#exercise(title: "Zielscheibe")[
  Zeichnen Sie eine Zielscheibe: drei konzentrische Kreise mit abwechselnder
  roter und weisser Füllung. Alle Kreise haben denselben Mittelpunkt.
]

#exercise(title: "Ampel")[
  Zeichnen Sie eine Ampel mit SVG-Formen:
  - Ein dunkelgraues, abgerundetes Rechteck als Gehäuse.
  - Drei Kreise für die Lichter (rot, gelb, grün – von oben nach unten).

  Die Kreise sollen im Rechteck horizontal zentriert sein.
]

// ─────────────────────────────────────────────────────────────────────────────
= Teil 3 — Koordinaten und Geometrie #h(1fr) #tier-extension

#exercise(title: "Fünfzackiger Stern")[
  Zeichnen Sie einen regelmässigen fünfzackigen Stern mit einem `<polygon>`.

  #hint[
    Ein fünfzackiger Stern hat 10 Eckpunkte – 5 äussere Spitzen und 5 innere
    Punkte, abwechselnd. Für einen äusseren Punkt $k$ (mit $k = 0, 1, 2, 3, 4$)
    lauten die Koordinaten:
    $ x = c_x + R dot cos\( -pi/2 + (2pi k)/5 \), quad y = c_y + R dot sin\( -pi/2 + (2pi k)/5 \) $
    Für einen inneren Punkt $k$ verwenden Sie dieselbe Formel mit einem kleineren
    Radius $r approx 0{,}38 R$ und verschieben den Winkel um $pi/5$.
    Berechnen Sie die 10 Punkte mit einem Taschenrechner oder einer
    Tabellenkalkulation und tragen Sie sie in Ihr `points`-Attribut ein.
  ]
]

#exercise(title: "Regelmässiges Achteck")[
  Zeichnen Sie ein regelmässiges Achteck mit einem `<polygon>`. Zentrieren Sie
  es bei (150, 150) mit einem Umkreisradius von 100 px.

  Zeigen Sie Ihre Koordinatenberechnungen unten.

  #answer-space(lines: 4)
]

#exercise(title: "Fehler finden")[
  Das folgende SVG soll einen grünen Kreis mit einer dicken schwarzen Kontur
  zeichnen, aber es enthält einen Fehler. Finden und korrigieren Sie ihn.

  ```html
  <svg width="200" height="200">
    <circle cx="100" cy="100" r="60"
            fill="green"
            stroke-color="black"
            stroke-width="8" />
  </svg>
  ```

  Was ist der Fehler? #answer-space(lines: 1)

  Schreiben Sie das korrigierte Attribut unten: #answer-space(lines: 1)
]

// ─────────────────────────────────────────────────────────────────────────────
= Teil 4 — Gesichter und Szenen #h(1fr) #tier-extension

#exercise(title: "Smiley-Gesicht")[
  Erstellen Sie ein Smiley-Gesicht mit mindestens:
  - Einem grossen Kreis für den Kopf.
  - Zwei Kreisen für die Augen.
  - Einem `<path>` für das Lächeln.

  Verwenden Sie diesen Pfad als Ausgangspunkt für das Lächeln – passen Sie
  die Zahlen an Ihre Kopfgrösse an:

  ```html
  <path d="M 60,120 Q 100,160 140,120"
        stroke="black" stroke-width="3" fill="none" />
  ```

  Der Befehl `M` setzt den linken Mundwinkel, `Q` legt einen Kontrollpunkt
  unterhalb der Mitte fest, und die letzte Koordinate ist der rechte Mundwinkel.

  *Erweiterung:* Fügen Sie mit `<animate>` ein zwinkerndes Auge hinzu.
]

#exercise(title: "Mini-Szene")[
  Zeichnen Sie eine einfache Aussenszene mit mindestens:
  - Einem Himmel (Rechteck oder Hintergrundfüllung).
  - Einer Sonne oder einem Mond (Kreis oder Ellipse).
  - Mindestens zwei weiteren erkennbaren Elementen (Haus, Baum, Wolke, Vogel, …).

  Planen Sie Ihre Szene zuerst auf Papier – skizzieren Sie, was Sie zeichnen
  möchten, und beschriften Sie die ungefähren Koordinaten, bevor Sie Code schreiben.
]

// ─────────────────────────────────────────────────────────────────────────────
= Teil 5 — Animation #h(1fr) #tier-extension

#exercise(title: "Zwinkernder Smiley")[
  Kehren Sie zu Ihrem Smiley-Gesicht aus Aufgabe 7 zurück. Fügen Sie einem
  der Augen ein `<animate>`-Element hinzu, damit es «zwinkert» – das Auge
  wird vertikal zusammengedrückt und kehrt zu seiner ursprünglichen Grösse
  zurück, wiederholt alle 3 Sekunden.

  #hint[
    Animieren Sie das `ry`-Attribut einer `<ellipse>` zwischen seinem vollen
    Wert und einem sehr kleinen Wert (z.B. `2`).
  ]
]

#exercise(title: "Umlaufender Planet")[
  Verwenden Sie `<animateMotion>`, damit ein kleiner Kreis auf einer kreisförmigen
  oder elliptischen Umlaufbahn um einen grösseren Kreis kreist.

  #steps(
    [Zeichnen Sie einen grossen Kreis in der Mitte – die «Sonne».],
    [Zeichnen Sie die Umlaufbahn als `<path>` oder `<ellipse>` mit `fill="none"` und einer hellen Kontur.],
    [Zeichnen Sie einen kleinen Kreis – den «Planeten».],
    [Fügen Sie `<animateMotion>` innerhalb des Planetenkreises hinzu und setzen Sie
     `path` auf dieselben Pfaddaten wie die Umlaufbahn.],
  )
]

// ─────────────────────────────────────────────────────────────────────────────
= Teil 6 — Generative Art mit JavaScript #h(1fr) #tier-challenge

Öffnen Sie `script.js` in Ihrem Repository. In diesem Teil verwenden Sie
JavaScript, um SVG-Elemente im Code zu erstellen – Sie schreiben kein SVG
direkt in `index.html`. Die `index.html`-Vorlage enthält bereits ein leeres
`<svg id="canvas">`-Element, das auf Sie wartet.

#exercise(title: "Zufällige Kreise")[
  Schreiben Sie eine JavaScript-Funktion `drawCircles(n)`, die `n` Kreise an
  zufälligen Positionen innerhalb der Leinwand erstellt, jeder mit einem
  zufälligen Radius (zwischen 5 und 40 px) und einer zufälligen HSL-Füllfarbe.
  Rufen Sie sie mit `drawCircles(40)` auf.

  Denken Sie an den Namensraum:
  ```js
  const svgNS = "http://www.w3.org/2000/svg";
  const svg   = document.getElementById("canvas");
  ```

  #hint[
    `Math.random()` gibt eine Dezimalzahl zwischen 0 und 1 zurück. Um eine
    ganze Zahl zwischen `min` und `max` zu erhalten, verwenden Sie: \
    `Math.floor(Math.random() * (max - min + 1)) + min`
  ]
]

#exercise(title: "Rastermuster")[
  Schreiben Sie eine Funktion `drawGrid(cols, rows)`, die die Leinwand mit
  einem regelmässigen Raster aus Kreisen füllt. Alle Kreise sollen denselben
  Radius haben und gleichmässig verteilt sein. Wählen Sie ein Farbschema
  nach Ihrem Geschmack.

  *Erweiterung:* Lassen Sie die Füllfarbe von der Position des Kreises
  abhängen – variieren Sie zum Beispiel den Farbton je nach Spaltennummer.
]

#exercise(title: "Interaktive Leinwand")[
  Erweitern Sie Ihre `drawCircles`-Funktion so, dass jeder Kreis beim Anklicken
  eine neue zufällige Farbe erhält. Verwenden Sie `addEventListener("click", ...)`.

  Fügen Sie dann eine Schaltfläche in `index.html` mit der Beschriftung
  *«Neu zeichnen»* hinzu, die die Leinwand leert und `drawCircles(40)` erneut aufruft.

  #hint[
    Um alle Kindelemente aus der SVG-Leinwand zu entfernen:
    ```js
    while (svg.firstChild) {
      svg.removeChild(svg.firstChild);
    }
    ```
  ]
]

// ─────────────────────────────────────────────────────────────────────────────
= Teil 7 — Kreativprojekt #h(1fr) #tier-challenge

#exercise(title: "Ihr eigenes Kunstwerk")[
  Erstellen Sie ein originelles SVG-Kunstwerk oder eine Animation. Sie dürfen
  jede Kombination aus handgeschriebenem SVG, `<animate>` und JavaScript-
  Generierung verwenden. Die einzige Bedingung ist, dass das Werk *mindestens
  drei verschiedene SVG-Formtypen* enthält und visuell interessant ist.

  Ideen als Einstieg:
  - Ein generatives Muster (Spiralen, Parkettierungen, Fraktale).
  - Eine animierte Szene (Wetter, Weltall, Ozean).
  - Ein interaktives Zeichenwerkzeug, bei dem durch Klicken neue Formen entstehen.
  - Ein «Daten-Selbstporträt» – eine visuelle Darstellung von etwas über Sie
    selbst (Lieblingstahlen, Farben, ein Tagesplan).

  Sie werden Ihr Ergebnis am Ende der Stunde mit der Klasse teilen.

  #note(
    "Kontinuierlich committen",
    [Committen Sie nach jeder funktionierenden Funktion – nicht erst am Schluss.
     Eine klare Commit-Geschichte zeigt Ihren Prozess und gibt Ihnen einen
     sicheren Punkt, zu dem Sie zurückkehren können, falls etwas schiefgeht.],
  )
]
