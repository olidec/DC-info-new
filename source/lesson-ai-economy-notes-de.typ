// ─────────────────────────────────────────────────────────────────────────────
// Lektion — KI & die Wirtschaft: Ethik und Konsequenzen
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Informatik"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "KI & die Wirtschaft"
#let lesson-subtitle = "Ethik, Arbeit und die Frage, wer von immer klügeren Maschinen profitiert"

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
// INHALT
// ─────────────────────────────────────────────────────────────────────────────

#tier-legend

#v(0.5em)

#goals(
  [Das historische Muster erklären, wie Technologie Arbeitsmärkte beeinflusst.],
  [Beschreiben, worin sich KI von früheren Automatisierungswellen unterscheidet.],
  [Erkennen, wer heute wirtschaftlich von KI profitiert und warum.],
  [Zu einem konkreten KI-und-Wirtschafts-Thema recherchieren und glaubwürdige Quellen finden.],
  [Fragen formulieren, die echte Meinungsverschiedenheiten und Diskussionen eröffnen.],
  [An einer strukturierten Gruppendiskussion teilnehmen, anderen zuhören und auf sie eingehen.],
)

= Hintergrund: Technologie und Arbeit #h(1fr) #tier-core

Jede grosse Technologiewelle hat das Bild von Arbeit verändert —
und Ängste ausgelöst, ob es noch genug davon geben würde.

Als im frühen neunzehnten Jahrhundert mechanische Webstühle in England
eingeführt wurden, stellten Weber, die jahrelang ihr Handwerk perfektioniert
hatten, plötzlich fest, dass ihre Fähigkeiten wertlos geworden waren. Einige
von ihnen, die *Ludditen*, reagierten darauf, indem sie die Maschinen zerstörten.
Sie lehnten Technologie nicht grundsätzlich ab — sie lehnten es ab, dass
Technologie eingesetzt wurde, um ihre Löhne zu senken und ihre
Lebensgrundlagen zu vernichten, ohne dass ihnen ein Anteil an den Gewinnen zukam.

Das Wort «Luddite» wird heute als Schimpfwort verwendet und bezeichnet
jemanden, der neue Technologie irrational fürchtet. Das ist eine Verzerrung
der Geschichte. Die Ludditen stellten eine legitime Frage, die wir uns
noch heute stellen: *Wenn Technologie die Produktion effizienter macht —
wer profitiert davon?*

Im zwanzigsten Jahrhundert beseitigte die Mechanisierung der Landwirtschaft
den grössten Teil der Landarbeit in wohlhabenden Ländern, doch fanden
diese Arbeitnehmerinnen und Arbeitnehmer schliesslich Beschäftigung in
Fabriken und im Dienstleistungssektor. Die Fabrikautomatisierung eliminierte
dann viele Produktionsarbeitsplätze, aber der Dienstleistungssektor
expandierte und absorbierte viele dieser Arbeitskräfte. Ökonominnen und
Ökonomen bezeichnen dieses Muster als *Arbeitsmarktanpassung* — die Idee,
dass aus einem Sektor verdrängte Arbeitnehmende letztlich neue Rollen
in anderen Bereichen finden.

Ob dieses Muster auch bei KI Bestand haben wird, gehört heute zu den
umstrittensten Fragen der Wirtschaftswissenschaft.

#infobox(
  "Der Lump-of-Labour-Trugschluss — und seine Grenzen",
  [Ein verbreitetes Argument gegen Jobverlust-Ängste ist der
   *Lump-of-Labour-Trugschluss*: die Idee, dass es in einer Wirtschaft
   keine feste Menge an Arbeit gibt. Neue Technologie schafft neue
   Branchen und neue Arten von Arbeit, die es vorher nicht gab. Im Jahr
   1900 war niemand als Webentwickler oder Social-Media-Manager tätig.
   Dieses Argument war historisch gesehen korrekt. Aber es beantwortet
   zwei schwierigere Fragen nicht: Wie lange dauert die Anpassung, und
   was passiert mit den Menschen, deren Fähigkeiten während des Übergangs
   obsolet werden? Eine 50-jährige Arbeitnehmerin, deren Qualifikationen
   nicht mehr gefragt sind, hat wenig Zeit für eine Umschulung. «Die
   Wirtschaft wird sich irgendwann anpassen» ist ein schwacher Trost,
   wenn man nächsten Monat die Miete zahlen muss.],
)

= Was KI anders macht #h(1fr) #tier-core

Frühere Automatisierungswellen ersetzten vor allem *körperliche* oder
*Routinearbeit* — also Tätigkeiten, die vorhersehbaren Regeln folgen.
Eine Maschine, die Metallteile stanzt, muss nicht denken; sie wiederholt
nur dieselbe Bewegung. Büroarbeit, kognitive, kreative und soziale
Tätigkeiten galten als sicher — diese Aufgaben erforderten Urteilsvermögen,
Flexibilität und menschliches Verständnis, das Maschinen nicht nachahmen konnten.

KI — insbesondere die grossen Sprachmodelle und Bildgeneratoren, die ab
2022 breiter verfügbar wurden — hat dies verändert. Zum ersten Mal können
Maschinen überzeugend Aufgaben ausführen, die früher Bildung, Kreativität
und ausgefeiltes Urteilsvermögen erforderten:

- Texte schreiben und redigieren
- Bilder, Musik und Videos erzeugen
- Software-Code schreiben und prüfen
- Juristische und medizinische Dokumente zusammenfassen und analysieren
- Komplexe Kundenanfragen beantworten
- Sprachen in nahezu menschlicher Qualität übersetzen

Das sind keine schlecht bezahlten Hilfsarbeiten. Viele davon sind
genau die Berufe, die Hochschulabsolventinnen und -absolventen
empfohlen wurden, weil sie als automatisierungssicher galten. Wenn
die Disruption eintritt, wird sie sich sehr anders verteilen als
frühere Wellen.

#warnbox(
  "⚠ Prognosen sind schwierig",
  [Wirtschaftswissenschaftlerinnen und Technologen haben eine schwache
   Bilanz bei der Vorhersage, wie Technologie Arbeitsplätze beeinflusst.
   In der Frühphase jeder Automatisierungswelle schwankten die Prognosen
   zwischen Katastrophe und Utopie, und die Realität war meist unordentlicher
   und ungleichmässiger als beides. Behandeln Sie sichere Prognosen —
   einschliesslich optimistischer — mit Skepsis. Wichtiger als die
   Prognose ist es, die Mechanismen zu verstehen: Wer hat Macht, wer
   trägt das Risiko, und welche Entscheidungen werden von wem getroffen?],
)

= Wer profitiert? #h(1fr) #tier-core

Wenn KI ein Unternehmen produktiver macht, fliesst der geschaffene Wert
irgendwohin. Zu verstehen, wohin, ist zentral für jede ethische Analyse.

== Kapital und Arbeit

In der Wirtschaftswissenschaft kombiniert Produktion *Kapital* (Maschinen,
Software, Gebäude, Geld) und *Arbeit* (menschliche Tätigkeiten). Wenn
Technologie die Produktivität erhöht, können die Gewinne an Kapitaleigner
(als Profit) oder an Arbeitnehmende (als höhere Löhne, kürzere Arbeitszeiten
oder billigere Güter) fliessen. In welche Richtung die Gewinne fliessen,
hängt von Verhandlungsmacht, Marktstruktur, Regulierung und politischen
Entscheidungen ab — nicht nur von der Ökonomie.

Historisch gesehen hat die Einführung arbeitssparender Technologie tendenziell
eher den Kapitaleignern als den Arbeitnehmenden zugutegekommen — besonders
kurzfristig und besonders dann, wenn Arbeitnehmende schwache Verhandlungsmacht
haben. Es gibt keinen automatischen Mechanismus, der Produktivitätsgewinne
an die verdrängten Arbeitnehmenden weitergibt.

== Eigentumskonzentration

Die KI-Entwicklung wird derzeit von einer kleinen Anzahl sehr grosser
Unternehmen dominiert — hauptsächlich amerikanischer. Das Training eines
Frontier-KI-Modells erfordert Rechenressourcen und Datensätze, die sich
nur eine Handvoll Organisationen weltweit leisten kann. Diese Konzentration
der Fähigkeiten hat auch die wirtschaftlichen Gewinne konzentriert.

Eine kleine Gruppe von Menschen, die in diese Unternehmen investiert oder
sie gegründet haben, hat ihr Vermögen um Beträge gesteigert, die vor einem
Jahrzehnt als fantastisch gegolten hätten. Gleichzeitig haben die
Arbeitnehmenden, deren Stellen durch die Technologie verdrängt werden,
keinen automatischen Anteil an diesen Gewinnen.

== Die Datenfrage

Grosse KI-Modelle werden auf riesigen Mengen menschlich erzeugter Inhalte
trainiert: Bücher, Artikel, Kunstwerke, Code, Fotos, Musik. Die Menschen,
die diese Inhalte erstellt haben, wurden weder um Erlaubnis gefragt noch
bezahlt. Schriftstellerinnen, Künstler, Programmiererinnen und Musiker
haben — mit einigem Erfolg vor Gericht — zu argumentieren begonnen, dass
das Training eines kommerziellen KI-Systems auf ihrer Arbeit ohne
Vergütung eine Form von Diebstahl ist.

Das ist noch keine rechtlich oder ethisch geklärte Frage. Aber es ist
eine echte: Wenn der wirtschaftliche Wert eines KI-Modells zum Teil aus
der kreativen Arbeit von Millionen von Menschen stammt — haben diese
Menschen dann einen Anspruch auf einen Teil dieses Wertes?

#infobox(
  "Die Klagen um Trainingsdaten",
  [Seit 2025 werden mehrere wichtige Klagen vor Gerichten in den USA und
   Europa über KI-Trainingsdaten verhandelt. Die New York Times klagte
   gegen OpenAI und Microsoft mit der Behauptung, deren Modelle seien
   ohne Genehmigung auf Times-Artikeln trainiert worden. Getty Images
   klagte gegen Stability AI wegen des Trainings auf ihrer Fotobibliothek.
   Eine Gruppe von Autorinnen und Autoren — darunter bekannte Romanschriftstellerinnen
   — klagte gegen mehrere KI-Unternehmen. Die Ergebnisse werden den
   rechtlichen Rahmen für KI-Trainingsdaten auf Jahre hinaus prägen —
   aber selbst wenn die Unternehmen jeden Fall gewinnen, bleibt die
   ethische Frage, ob ihr Handeln fair war, offen.],
)

= Die politische Landschaft #h(1fr) #tier-extension

Gesellschaften haben mehrere Instrumente zur Verfügung, um zu gestalten,
wie die Gewinne aus KI verteilt werden. Keines davon ist einfach.

*Besteuerung* — wenn KI Arbeitnehmende verdrängt und Wohlstand konzentriert,
besteht eine Reaktionsmöglichkeit darin, die Gewinne stärker zu besteuern
und umzuverteilen. Vorschläge für eine «Robotersteuer» — eine Abgabe auf
Unternehmen, die Automatisierung einsetzen, um Arbeitnehmende zu ersetzen —
wurden in mehreren Ländern diskutiert. Kritikerinnen und Kritiker argumentieren,
dies würde die Einführung nützlicher Technologie verlangsamen.

*Regulierung* — Regierungen können Unternehmen verpflichten, Arbeitnehmenden
vor automatisierten Entlassungen rechtzeitig Bescheid zu geben, verdrängte
Arbeitnehmende umzuschulen oder automatisierte Einstellungs- und
Beförderungsentscheidungen zu begründen. Der KI-Act der EU, der 2024 in
Kraft trat, verlangt Transparenz und menschliche Aufsicht für KI-Systeme,
die bei folgenreichen Entscheidungen über Beschäftigung, Kredite und
Bildung eingesetzt werden.

*Bedingungsloses Grundeinkommen* — einige Wirtschaftswissenschaftlerinnen
und Technologen (darunter prominente Figuren aus dem Silicon Valley)
argumentieren, dass die richtige Reaktion ein bedingungsloses Grundeinkommen
wäre, wenn KI schliesslich genug Arbeit eliminiert: eine regelmässige,
bedingungslose Zahlung an alle Bürgerinnen und Bürger, finanziert durch
die Besteuerung KI-generierter Gewinne. Dies ist über das gesamte
politische Spektrum hinweg tatsächlich umstritten.

*Kollektivverhandlungen* — Arbeitnehmende haben historisch gesehen
Gewerkschaften genutzt, um über die Verteilung von Produktivitätsgewinnen
zu verhandeln. Mehrere grosse Gewerkschaften — darunter Hollywood-Drehbuchautoren
und Schauspielerinnen im Jahr 2023 — haben begonnen, explizite
KI-Bestimmungen in ihre Verträge aufzunehmen, die regeln, wann und wie
KI eingesetzt werden darf und welchen Schutz Arbeitnehmende geniessen.

= Stundenplan #h(1fr) #tier-core

Diese Lektion dauert 90 Minuten und ist in drei Phasen gegliedert.

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Zeit],
    text(size: 9pt, weight: "bold", fill: white)[Phase],
    text(size: 9pt, weight: "bold", fill: white)[Aktivität],
  ),
  [0–15 Min.],   [Einführung],    [Plenum: lehrergeleitete Rahmung anhand der Abschnitte 1–3 oben. Ziel: Den Schülerinnen und Schülern genug Kontext geben, um produktiv recherchieren zu können. Kurz und prägnant halten — es geht darum, Fragen aufzuwerfen, nicht sie zu beantworten.],
  [15–50 Min.],  [Recherche],     [Gruppen zu je 3 Personen erhalten die Recherchekarte. Jede Gruppe wählt ein Thema, recherchiert und formuliert 2–4 Diskussionsfragen. Die Lehrperson geht umher.],
  [50–90 Min.],  [Diskussion],    [Gruppen stellen ihre Fragen vor und leiten eine 5–8-minütige Klassendiskussion zu ihrem Thema. Nicht alle Gruppen müssen präsentieren — die Gruppen wählen je nachdem, was sie am meisten beschäftigt.],
)

== Hinweise zur Moderation

*Gruppenbildung:* Wenn möglich, sollen die Schülerinnen und Schüler ihre
eigenen Gruppen bilden — selbst gewählte Gruppen sind in der Regel motivierter.
Wenn eine Gruppe nach wenigen Minuten noch kein Thema gewählt hat, weisen
Sie ihr eines zu, anstatt sie stagnieren zu lassen.

*Während der Recherche:* Die Recherchekarte enthält Ausgangsfragen und
Einstiegspunkte für jedes Thema, aber die Schülerinnen und Schüler sollten
darüber hinausgehen. Ermutigen Sie sie, eine Quelle zu finden, der sie
widersprechen, und nicht nur eine, die ihre bestehende Meinung bestätigt.
Wenn Gruppen nur eine Seite des Arguments finden, fragen Sie nach:
«Was würde jemand sagen, der das anders sieht?»

*Diskussionsformat:* Eine Gruppenvertreterin oder ein Gruppenvertreter
fasst kurz zusammen, was die Gruppe gefunden hat (maximal 2 Minuten),
und stellt dann die Fragen an die Klasse. Die Rolle der Lehrperson
während der Diskussion besteht darin, das Gespräch am Laufen zu halten,
ruhigere Schülerinnen und Schüler einzubeziehen und dem Impuls zu
widerstehen, die «richtige Antwort» zu geben — diese Fragen haben keine.

*Auswahl der präsentierenden Gruppen:* Fragen Sie, welche Gruppen etwas
Überraschendes gefunden haben, etwas, dem sie stark zustimmen oder
widersprechen, oder etwas, das innerhalb der Gruppe den meisten Streit
ausgelöst hat. Das sind in der Regel die besten Diskussionen. Bei fünf
oder sechs Gruppen in 40 Minuten können Sie realistischerweise drei bis
vier Themen in die Tiefe besprechen, anstatt alle oberflächlich zu streifen.

*Abschluss:* Die Lektion braucht kein ordentliches Fazit. Ein gutes Zeichen
ist, wenn die Schülerinnen und Schüler noch diskutieren, wenn es klingelt.
Wenn Sie einen kurzen Abschluss wünschen, bitten Sie jede Gruppe, etwas
zu nennen, das sie in ihrer Meinung geändert hat, oder eine Frage, mit der
sie die Stunde verlassen, die sie zu Beginn noch nicht hatten.

== Themen auf der Recherchekarte

Die Recherchekarte für Schülerinnen und Schüler enthält sechs Themen.
Ein kurzer Hinweis zu jedem für die Lehrperson:

*Thema 1 — Jobverdrängung* ist das zugänglichste und löst starke Reaktionen
aus. Schülerinnen und Schüler beginnen oft mit starken Meinungen («KI wird
alle Jobs übernehmen» oder «Menschen finden immer neue Arbeit»), und die
Recherche tendiert dazu, beide Ansichten produktiv zu hinterfragen.

*Thema 2 — Die Trainingsdatenfrage* steht in direktem Bezug zu Dingen,
die die Schülerinnen und Schüler kennen (Bildgeneratoren, Chatbots) und
hat eine angenehme Konkretheit: Es gibt echte Gerichtsverfahren, echte
betroffene Künstlerinnen und Künstler, echte Unternehmen, die ihre
Praktiken verteidigen. Es verknüpft sich auch mit Urheberrechtskonzepten,
mit denen viele Schülerinnen und Schüler vage vertraut sind.

*Thema 3 — Machtkonzentration* zieht tendenziell Schülerinnen und Schüler
mit Interesse an Politik oder Wirtschaft an. Es kann die ausgefeilteste,
aber auch die abstrakteste Diskussion erzeugen — drängen Sie die Gruppen
immer wieder zu konkreten Beispielen.

*Thema 4 — Bedingungsloses Grundeinkommen* ist politisch das provokativste
und erzeugt verlässlich lebhafte Meinungsverschiedenheiten über politische
Grenzen hinweg. Schülerinnen und Schüler haben hier möglicherweise bereits
vorgefertigte starke Meinungen; die Recherchephase ist wertvoll, weil sie
sie zwingt, sich mit dem stärksten Gegenargument auseinanderzusetzen.

*Thema 5 — KI bei der Stellenbesetzung* ist das für Schülerinnen und
Schüler persönlich relevanteste Thema, da sie in einigen Jahren in den
Arbeitsmarkt eintreten werden. Es verknüpft sich auch klar mit den
Inhalten zum algorithmischen Bias aus der Ethik-Lektion, sofern diese
bereits behandelt wurde.

*Thema 6 — Kreative Arbeit und KI* eignet sich gut für Schülerinnen und
Schüler mit Interesse an Kunst, Musik oder Schreiben. Die Frage, was
Kreativität eigentlich ist — und ob sie automatisiert werden kann —
tendiert dazu, echtes philosophisches Engagement zu erzeugen, nicht nur
Politikdebatten.

= Zusammenfassung

#checklist(
  [Sie können erklären, warum KI-Automatisierung verschiedene Arbeitnehmende anders betreffen könnte als frühere Wellen.],
  [Sie können erkennen, wer derzeit den grössten Teil der wirtschaftlichen Gewinne aus der KI-Entwicklung abschöpft.],
  [Sie können die Trainingsdatenfrage beschreiben und erläutern, warum sie ethisch umstritten ist.],
  [Sie haben zu Ihrem Recherchegebiet mindestens zwei glaubwürdige Quellen gefunden und können deren Argumente zusammenfassen.],
  [Ihre Gruppe hat 2–4 Diskussionsfragen erarbeitet, die echte Meinungsverschiedenheiten eröffnen.],
  [Sie haben an mindestens einer Klassendiskussion teilgenommen und dabei auf den Beitrag einer anderen Person eingegangen.],
)
