// ─────────────────────────────────────────────────────────────────────────────
// Recherchekarte für Schülerinnen und Schüler — KI & die Wirtschaft
// ─────────────────────────────────────────────────────────────────────────────

#let course      = "Informatik"
#let level       = "Gymnasium Muttenz"
#let term        = "2026-27"
#let sheet-type  = "Recherchekarte"
#let sheet-title = "KI & die Wirtschaft"

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
              text(size: 9pt, weight: "bold", fill: rgb("#2E6DA4"), [Thema #number])
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
          text(size: 9pt, weight: "bold", fill: rgb("#2E6DA4"))[Ausgangsfragen]
          v(0.3em)
          seeds
          v(0.8em)
          text(size: 9pt, weight: "bold", fill: rgb("#555555"))[
            Fragen Ihrer Gruppe für die Klassendiskussion:
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
// INHALT
// ─────────────────────────────────────────────────────────────────────────────

// ── Anweisungsblock ───────────────────────────────────────────────────────────
#block(
  width: 100%,
  fill: rgb("#F5F5F5"),
  inset: (x: 14pt, y: 12pt),
  radius: 3pt,
  {
    text(weight: "bold", fill: rgb("#2E6DA4"))[So funktioniert es]
    v(0.4em)
    grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      row-gutter: 6pt,
      box(fill: rgb("#2E6DA4"), inset: (x:5pt,y:2pt), radius:2pt,
        text(size:9pt,weight:"bold",fill:white)[1]),
      [*Wählen Sie als Gruppe ein Thema.* Nehmen Sie das, das Sie am interessantesten, überraschendsten oder kontroversesten finden — nicht unbedingt das einfachste.],
      box(fill: rgb("#2E6DA4"), inset: (x:5pt,y:2pt), radius:2pt,
        text(size:9pt,weight:"bold",fill:white)[2]),
      [*Recherchieren Sie 30–40 Minuten.* Nutzen Sie die Ausgangsfragen als Einstieg, gehen Sie aber darüber hinaus. Versuchen Sie, mindestens zwei Quellen mit unterschiedlichen Perspektiven zu finden. Eine Quelle, der Sie widersprechen, ist genauso nützlich wie eine, der Sie zustimmen.],
      box(fill: rgb("#2E6DA4"), inset: (x:5pt,y:2pt), radius:2pt,
        text(size:9pt,weight:"bold",fill:white)[3]),
      [*Schreiben Sie 2–4 Diskussionsfragen* in den vorgesehenen Platz. Gute Fragen haben keine einzige richtige Antwort, eröffnen echte Meinungsverschiedenheiten und sind konkret genug, damit man darüber streiten kann.],
      box(fill: rgb("#2E6DA4"), inset: (x:5pt,y:2pt), radius:2pt,
        text(size:9pt,weight:"bold",fill:white)[4]),
      [*Seien Sie bereit zu präsentieren.* Eine Gruppenvertreterin oder ein Gruppenvertreter fasst kurz zusammen, was Sie gefunden haben (2 Minuten), dann stellt die Gruppe ihre Fragen an die Klasse. Sie müssen die Frage nicht gelöst haben — es geht darum, ein Gespräch zu starten.],
    )
    v(0.6em)
    text(size: 9pt, fill: rgb("#999999"))[
      *Was macht eine gute Diskussionsfrage aus?* Sie nennt etwas Konkretes (ein Unternehmen, eine Politik, eine Person, ein reales Ereignis). Sie hat mindestens zwei vertretbare Antworten. Sie ist relevant — ihre Beantwortung würde tatsächlich etwas verändern. \ \
      *Was macht eine schwache Diskussionsfrage aus?* Sie lässt sich mit einer kurzen Google-Suche beantworten. Sie hat nur eine vernünftige Antwort. Sie ist so breit, dass niemand weiss, wo man anfangen soll.
    ]
  }
)

#v(0.8em)

// ── Gruppeninfo ───────────────────────────────────────────────────────────────
#grid(
  columns: (1fr, 1fr, auto),
  column-gutter: 12pt,
  {
    text(size: 9pt, fill: rgb("#999999"))[Gruppenmitglieder]
    v(0.3em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
  },
  {
    text(size: 9pt, fill: rgb("#999999"))[Gewähltes Thema]
    v(0.3em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
    text(size: 9pt, fill: rgb("#999999"))[Verwendete Quellen (URLs oder Titel)]
    v(0.3em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
    v(0.9em)
    line(length: 100%, stroke: 0.4pt + rgb("#CCCCCC"))
  },
  [],
)

#v(1em)

// ─────────────────────────────────────────────────────────────────────────────
= Themen
// ─────────────────────────────────────────────────────────────────────────────

#topic(
  "1",
  "Nimmt uns KI die Jobs weg?",
  [
    Wirtschaftswissenschaftlerinnen und -wissenschaftler sind sich uneins
    darüber, ob KI mehr Arbeitsplätze vernichten oder schaffen wird. Einige
    argumentieren, dass jede frühere Automatisierungswelle letztlich mehr
    Arbeit geschaffen als zerstört hat — die industrielle Revolution,
    die mechanisierte Landwirtschaft und der Computer haben alle neue
    Branchen und neue Arten von Arbeitsplätzen hervorgebracht. Andere
    argumentieren, dass KI anders ist: Sie kann kognitive und kreative
    Arbeit übernehmen, nicht nur Routineaufgaben, weshalb es weniger Grund
    gibt, neue Rollen für verdrängte Arbeitnehmende zu erwarten.

    Die Debatte dreht sich nicht nur um die Gesamtzahl der Arbeitsplätze,
    sondern um Zeitpunkt, Verteilung und darum, wer die Kosten des Übergangs
    trägt. Selbst wenn neue Jobs entstehen, hilft das einer 50-jährigen
    Fabrikarbeiterin oder einem Nachwuchs-Grafikdesigner, dessen
    Einstiegsarbeit automatisiert wurde, nur wenig.
  ],
  list(
    [Ein Goldman-Sachs-Bericht von 2023 schätzte, dass KI 25 % der
     Arbeitsaufgaben in den USA und Europa automatisieren könnte. Eine
     andere Analyse der OECD bezifferte den Anteil auf rund 14 %.
     Warum variieren die Schätzungen so stark, und spielt das eine Rolle?],
    [Welche Arbeitnehmenden sind am stärksten von KI-Automatisierung
     bedroht und welche am wenigsten? Unterscheidet sich das Muster
     von früheren Automatisierungswellen?],
    [Wenn neue Jobs entstehen — wie lange könnte der Übergang dauern,
     und was passiert mit den Arbeitnehmenden in der Zwischenzeit?],
    [Sollten Regierungen die KI-Einführung verlangsamen, um Arbeitnehmenden
     mehr Zeit zur Anpassung zu geben, oder würde das nur die Vorteile
     verzögern?],
  )
)

#topic(
  "2",
  "Wem gehören die Trainingsdaten?",
  [
    Grosse KI-Modelle — Bildgeneratoren, Chatbots, Coding-Assistenten —
    werden auf riesigen Mengen menschlich produzierter Inhalte trainiert,
    die aus dem Internet gesammelt wurden: Texte, Fotos, Kunstwerke,
    Musik, Code. Die Menschen, die diese Inhalte erstellt haben, wurden
    weder um Erlaubnis gefragt noch bezahlt.

    Unternehmen, die KI entwickeln, argumentieren, dass das Training
    auf öffentlich verfügbaren Daten eine faire Nutzung («Fair Use»)
    darstellt — ähnlich wie eine menschliche Künstlerin lernt, indem
    sie die Werke anderer Künstlerinnen betrachtet. Kritikerinnen und
    Kritiker — darunter viele Künstlerinnen und Schriftstellerinnen —
    argumentieren, dass es einen bedeutsamen Unterschied gibt zwischen
    einem Menschen, der lernt, und einem Unternehmen, das ein kommerzielles
    Produkt aufbaut, das direkt mit den Menschen konkurriert, deren
    Werke es genutzt hat.

    Seit 2025 werden mehrere Klagen vor Gerichten in den USA und Europa
    verhandelt. Die Ergebnisse werden die Regeln für die KI-Entwicklung
    auf Jahre hinaus prägen.
  ],
  list(
    [Gibt es einen bedeutsamen ethischen Unterschied zwischen einem
     Menschen, der aus den Werken anderer lernt, und einem KI-Modell,
     das darauf trainiert wird? Wo bricht die Analogie zusammen?],
    [Wenn ein KI-Bildgenerator ein Kunstwerk im Stil einer lebenden
     Künstlerin erstellen kann und Menschen das kaufen, anstatt die
     Künstlerin direkt zu beauftragen — ist dann etwas Unfaires
     passiert, auch wenn es technisch legal ist?],
    [Sollten KI-Unternehmen verpflichtet werden, Urheberrechtsgebühren
     an Kreative zu zahlen, deren Werke beim Training verwendet wurden?
     Wie würde das in der Praxis überhaupt funktionieren?],
    [Einige Künstlerinnen und Künstler haben begonnen, Werkzeuge zu
     verwenden, um ihre Werke zu «vergiften» — unsichtbare Muster
     einzufügen, die das KI-Training stören. Ist das eine legitime
     Form der Selbstverteidigung, oder schadet es dem Fortschritt?],
  )
)

#topic(
  "3",
  "Machtkonzentration",
  [
    Das Training eines Frontier-KI-Modells erfordert derzeit Milliarden
    von Franken, riesige Mengen spezialisierter Chips und Datensätze, die
    nur eine Handvoll Organisationen weltweit zusammenstellen kann. Dadurch
    hat sich die Entwicklung der leistungsfähigsten KI-Systeme in einer
    kleinen Anzahl amerikanischer Unternehmen konzentriert — hauptsächlich
    OpenAI, Google, Meta und Anthropic — mit einigen Gegenstücken in China.

    Diese Konzentration hat wirtschaftliche Konsequenzen: Die Gewinne
    aus KI fliessen überproportional an die Eigentümer und Investoren
    dieser Unternehmen. Sie hat auch politische Konsequenzen: Eine kleine
    Anzahl privater Organisationen trifft Entscheidungen, die die Zukunft
    von Arbeit, Kommunikation und Wissen für Milliarden von Menschen
    prägen werden — mit begrenzter demokratischer Kontrolle.
  ],
  list(
    [Ist es ein Problem, dass die mächtigsten KI-Systeme von wenigen
     privaten Unternehmen kontrolliert werden? Wie würde die Alternative
     aussehen?],
    [Einige argumentieren, KI sollte als öffentliche Infrastruktur
     entwickelt werden — wie Strassen oder das Internet — und nicht
     von gewinnorientierten Privatunternehmen. Was sind die stärksten
     Argumente dafür und dagegen?],
    [Die EU, die USA und China verfolgen sehr unterschiedliche regulatorische
     Ansätze bei KI. Spielt es eine Rolle, welcher Ansatz sich durchsetzt?
     Ist internationale Koordination möglich?],
    [Eine Handvoll Menschen ist durch die KI-Entwicklung sehr schnell
     ausserordentlich reich geworden. Wirft das ethische Bedenken auf,
     auch wenn ihr Handeln legal war?],
  )
)

#topic(
  "4",
  "Bedingungsloses Grundeinkommen",
  [
    Wenn KI schliesslich einen grossen Teil der bezahlten Arbeit
    automatisiert, ist eine vorgeschlagene Reaktion ein *bedingungsloses
    Grundeinkommen* (BGE): eine regelmässige, bedingungslose Geldzahlung
    an alle Bürgerinnen und Bürger, unabhängig davon, ob sie arbeiten.
    Die Idee ist nicht neu — Versionen davon wurden von Wirtschaftswissenschaftlerinnen
    und Philosophen seit Jahrzehnten vorgeschlagen — aber sie hat mit
    dem Wachstum der KI-Fähigkeiten erneute Aufmerksamkeit erlangt.

    Befürworter — darunter prominente Technologen wie Sam Altman und
    Elon Musk — argumentieren, dass ein BGE wirtschaftliche Sicherheit
    in einer Welt bieten würde, in der stabile Beschäftigung nicht mehr
    garantiert ist. Kritikerinnen und Kritiker aus dem gesamten politischen
    Spektrum sind sich uneins darüber, ob es erschwinglich wäre, ob es
    Arbeitsanreize verringern würde und ob es das richtige Problem angeht.
  ],
  list(
    [Sollte eine Gesellschaft allen Menschen ein Mindesteinkommen
     garantieren, unabhängig davon, ob sie arbeiten? Ändert sich
     Ihre Antwort, wenn KI viele Jobs obsolet macht?],
    [Wer würde für ein bedingungsloses Grundeinkommen auf einem
     bedeutsamen Niveau aufkommen? Ist es realistisch, es durch die
     Besteuerung der Unternehmen und Einzelpersonen zu finanzieren,
     die am meisten von KI profitieren?],
    [Einige Kritikerinnen und Kritiker argumentieren, das BGE sei
     eine Ablenkung — das eigentliche Problem sei nicht das Einkommen,
     sondern sinnvolle Arbeit, Würde und Zweck. Finden Sie das richtig?],
    [Pilotprogramme für ein Grundeinkommen wurden in Finnland, Kenia,
     Kanada und mehreren US-Städten durchgeführt. Was haben sie
     herausgefunden, und wie viel können wir aus kleinen Experimenten lernen?],
  )
)

#topic(
  "5",
  "KI bei der Stellenbesetzung",
  [
    Viele grosse Unternehmen nutzen heute KI-Tools bei der Personalgewinnung
    — um Bewerbungsunterlagen zu sichten, Kandidierende zu bewerten,
    erste Videointerviews zu führen und sogar die berufliche Leistung
    vorherzusagen. Befürworterinnen argumentieren, dies reduziere menschliche
    Vorurteile und beschleunige einen langsamen, teuren Prozess. Kritikerinnen
    und Kritiker argumentieren, dass KI-Systeme historische Vorurteile
    einprogrammieren und verstärken können, undurchsichtig in ihren
    Entscheidungen sind und das menschliche Urteil entfernen, das
    Kandidatinnen und Kandidaten verdienen.

    Dieses Thema steht im Zusammenhang mit der grösseren Frage des
    algorithmischen Bias: Ein System, das auf historischen Einstellungsdaten
    trainiert wurde, lernt, Kandidierende zu bevorzugen, die wie früher
    eingestellte Personen aussehen — was bedeuten kann, dass es lernt,
    gegen Frauen, ethnische Minderheiten oder Personen von bestimmten
    Universitäten zu diskriminieren, auch wenn die Entwickelnden nichts
    dergleichen beabsichtigt haben.
  ],
  list(
    [Wenn eine menschliche interviewende Person voreingenommen ist,
     weiss die Kandidatin zumindest, dass sie von einem Menschen
     beurteilt wurde. Wenn ein KI-System voreingenommen ist, sollten
     Kandidierende dann das Recht haben zu erfahren, die Entscheidung
     anzufechten und von einem Menschen überprüfen zu lassen?],
    [Ist KI-gestützte Einstellung fairer oder unfairer als menschliche
     Einstellung? Ist das überhaupt die richtige Frage — sollten wir
     fragen «fairer für wen»?],
    [Einige Länder beginnen, automatisierte Einstellungsentscheidungen
     zu regulieren. Der KI-Act der EU verlangt menschliche Aufsicht
     für KI-Systeme im Beschäftigungsbereich. Ist das genug?],
    [Wenn Sie wüssten, dass ein Unternehmen ein KI-Tool nutzt, um
     Ihre Bewerbung zu sichten — würde das ändern, wie Sie sich
     bewerben? Würde es ändern, ob Sie dort arbeiten möchten?],
  )
)

#topic(
  "6",
  "KI und kreative Arbeit",
  [
    KI-Systeme können heute Bilder, Musik, Texte und Videos erzeugen,
    die viele Menschen überzeugend finden — manchmal nicht von
    menschlich produzierten Werken zu unterscheiden. Das wirft sowohl
    wirtschaftliche als auch philosophische Fragen auf.

    Wirtschaftlich gesehen sehen viele Kreativschaffende — Illustratorinnen,
    Stockfotografinnen, Sprecher, Nachwuchstexterinnen, Übersetzerinnen —
    ihr Einkommen bereits sinken, da Auftraggeber stattdessen KI-generierte
    Alternativen nutzen. Einige argumentieren, das sei nicht anders als
    jede andere technologische Verdrängung von Facharbeit. Andere
    argumentieren, kreative Arbeit sei grundlegend anders — ihr Wert
    liege nicht nur im Ergebnis, sondern im menschlichen Ausdruck dahinter.

    Philosophisch zwingt es zur Frage, was Kreativität eigentlich ist.
    Wenn eine Maschine ein Bild erzeugen kann, das echte Emotionen weckt —
    ist das Kunst? Spielt es eine Rolle, ob ein Mensch es beabsichtigt hat?
  ],
  list(
    [Wenn KI ein Musikstück erzeugen kann, das Sie bewegt — spielt es
     eine Rolle, dass kein Mensch es komponiert hat? Ändert sich Ihre
     Antwort, wenn Sie es erst im Nachhinein erfahren?],
    [Sollten kreative Werke, die von KI produziert wurden, als solche
     gekennzeichnet werden? Sollte es illegal sein, dies nicht offenzulegen?],
    [Einige argumentieren, KI werde menschliche Künstlerinnen und Künstler
     von Routine- und Auftragsarbeit befreien und ihnen ermöglichen, sich
     auf tieferen kreativen Ausdruck zu konzentrieren. Andere argumentieren,
     sie werde schlicht Lebensgrundlagen vernichten. Was halten Sie für
     wahrscheinlicher?],
    [Gibt es etwas, das menschliche kreative Arbeit hat und KI-Arbeit
     nicht haben kann — oder ist das eine Geschichte, die wir uns
     erzählen, weil wir noch nicht daran gewöhnt sind?],
  )
)
