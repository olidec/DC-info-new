// ─────────────────────────────────────────────────────────────────────────────
// Lektion — Einführung in SQL
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Informatik"
#let level           = "Gymnasium Muttenz"
#let term            = "2025-26"
#let lesson-title    = "Einführung in SQL"
#let lesson-subtitle = "Fragen an eine Datenbank stellen"

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
// INHALT — TEIL 1: Kontext und SQL Island
// ─────────────────────────────────────────────────────────────────────────────

#goals(
  [Verstehen, was eine Datenbank ist und warum strukturierte Datenspeicherung wichtig ist.],
  [Reale Situationen erkennen, in denen SQL täglich eingesetzt wird.],
  [Den grundlegenden Aufbau einer relationalen Datenbank kennen: Tabellen, Zeilen und Spalten.],
  [Einfache SQL-Abfragen mit `SELECT`, `WHERE`, `ORDER BY` und `LIMIT` schreiben.],
  [*SQL Island* nutzen, um Datenbankabfragen interaktiv zu üben.],
)

= Datenbanken sind überall

Jedes Mal, wenn Sie online etwas suchen, ein Konzertticket kaufen oder
Ihre Note auf einer Schulplattform abrufen, arbeitet im Hintergrund eine
*Datenbank*. Eine Datenbank ist eine organisierte Sammlung von Daten,
die effizient gespeichert, durchsucht und aktualisiert werden kann.

Daten allein genügen jedoch nicht. Man braucht auch eine Möglichkeit,
*Fragen an diese Daten zu stellen* — und genau dafür ist *SQL* da.

#infobox(
  "Wofür steht SQL?",
  [*SQL* steht für *Structured Query Language* (Strukturierte Abfragesprache).
   Die Aussprache lautet entweder «S-Q-L» oder «Sequel» — beide Varianten
   sind gebräuchlich. SQL ist die Standardsprache zur Kommunikation mit
   relationalen Datenbanken. Sie existiert seit den 1970er-Jahren und
   gehört noch heute zu den meistgenutzten Programmiersprachen der Welt.],
)

== Relationale Datenbanken: Tabellen, Zeilen und Spalten

Der häufigste Datenbanktyp ist die *relationale Datenbank*. Die Daten
sind in *Tabellen* organisiert, ähnlich wie in einer Tabellenkalkulation.
Jede Tabelle besteht aus:

- *Spalten* — die Kategorien der gespeicherten Informationen (z. B. Name, Alter, Stadt).
- *Zeilen* — die einzelnen Datensätze (z. B. eine Zeile pro Person).

Hier ist ein Beispiel einer einfachen Tabelle namens `students`:

#table(
  columns: (auto, 1fr, auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[id],
    text(size: 9pt, weight: "bold", fill: white)[name],
    text(size: 9pt, weight: "bold", fill: white)[age],
    text(size: 9pt, weight: "bold", fill: white)[city],
  ),
  [1], [Anna],    [15], [Basel],
  [2], [Leandro], [16], [Liestal],
  [3], [Sophie],  [15], [Muttenz],
  [4], [Noah],    [16], [Basel],
)

#v(0.5em)

Jede Zeile entspricht einer Schülerin oder einem Schüler. Jede Spalte
speichert eine bestimmte Art von Information. Eine Datenbank kann viele
Tabellen enthalten, die miteinander verknüpft sind — daher der Begriff
*relational*.

= Anwendungsbeispiele aus der Praxis

SQL ist keine Nischenkompetenz. Es wird in nahezu jeder Branche eingesetzt:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Bereich],
    text(size: 9pt, weight: "bold", fill: white)[Beispiel],
  ),
  [Online-Shopping],      [Alle Bestellungen der letzten 7 Tage finden, die noch nicht versandt wurden.],
  [Gesundheitswesen],     [Die vollständige Medikamentenhistorie einer Patientin abrufen.],
  [Soziale Medien],       [Freundschaftsvorschläge anhand gemeinsamer Kontakte machen.],
  [Schulsysteme],         [Alle Schülerinnen und Schüler anzeigen, die im letzten Test unter 60 % erzielt haben.],
  [Streaming-Dienste],    [Sendungen basierend auf dem bisherigen Sehverhalten empfehlen.],
  [Bankwesen],            [Alle Transaktionen über CHF 1'000 in einem bestimmten Monat auflisten.],
)

#v(0.5em)

Der gemeinsame Nenner: grosse Mengen strukturierter Daten und die
Notwendigkeit, bestimmte Teile davon schnell zu finden oder zusammenzufassen.

== Ein erster Einblick in SQL

Stellen Sie sich vor, Sie möchten alle Schülerinnen und Schüler aus
Basel in der obigen Tabelle finden. In SQL würden Sie schreiben:

```sql
SELECT name, city
FROM students
WHERE city = 'Basel';
```

Das liest sich fast wie normales English:
_«Wähle die Spalten Name und Stadt aus der Tabelle students,
aber nur für Zeilen, in denen die Stadt Basel ist.»_

Das Ergebnis wäre:

#table(
  columns: (1fr, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[name],
    text(size: 9pt, weight: "bold", fill: white)[city],
  ),
  [Anna], [Basel],
  [Noah], [Basel],
)

#v(0.5em)

Das ist das Wesen von SQL: Sie beschreiben *was* Sie möchten, und die
Datenbank findet heraus, *wie* sie es liefert.

= SQL Island — Lernen durch Spielen

Anstatt die ganze Lektion mit dem Lesen von Beispielen zu verbringen,
werden Sie SQL nun direkt anwenden. *SQL Island* ist ein Online-Spiel,
in dem Sie nach einem Flugzeugabsturz auf einer einsamen Insel stranden.
Um zu überleben und schliesslich zu entkommen, müssen Sie mit den
Bewohnerinnen und Bewohnern der Insel kommunizieren — die einzige
Sprache, die sie verstehen, ist SQL.

#infobox(
  "SQL Island im Browser öffnen",
  [Navigieren Sie zu: #link("https://sql-island.informatik.uni-kl.de/")[
    #text(fill: accent)[https://sql-island.informatik.uni-kl.de/]
  ] \
  Das Spiel läuft vollständig im Browser — keine Anmeldung und keine
  Installation erforderlich. Wählen Sie zu Beginn *Deutsch* als Sprache
  und starten Sie das Abenteuer.],
)

Beim Spielen werden Sie die benötigten SQL-Befehle ganz natürlich
entdecken. Das Spiel führt sie Schritt für Schritt durch die Geschichte
ein. Nehmen Sie sich Zeit, lesen Sie die Anweisungen sorgfältig und
zögern Sie nicht, mit Abfragen zu experimentieren — falsche Abfragen
zerstören nichts, sie liefern lediglich einen Fehler oder ein
unerwartetes Ergebnis, was selbst ein wertvoller Lernmoment ist.

#warnbox(
  "💡 Tipp: Zuerst die Tabellenstruktur lesen",
  [Schauen Sie sich vor dem Schreiben einer Abfrage immer an, welche
   Tabellen verfügbar sind und welche Spalten sie enthalten.
   SQL Island zeigt Ihnen diese Informationen an.
   Die eigenen Daten zu kennen, ist die halbe Miete.],
)

#pagebreak()

// ─────────────────────────────────────────────────────────────────────────────
// INHALT — TEIL 2: Zusammenfassung und SQL-Referenz
// ─────────────────────────────────────────────────────────────────────────────

#{
  text(size: 16pt, weight: "bold", fill: primary)[SQL-Kurzreferenz]
  v(0.1em)
  text(size: 11pt, fill: muted)[Die wichtigsten Befehle mit Beispielen]
  v(0.3em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.8em)
}

= Was Sie gelernt haben

Nach der Arbeit mit SQL Island sollten Sie mit den grundlegenden
Konzepten von SQL vertraut sein:

#checklist(
  [Eine *Datenbank* speichert Daten in *Tabellen*, die aus Zeilen und Spalten bestehen.],
  [`SELECT` legt fest, welche Spalten zurückgegeben werden.],
  [`FROM` gibt an, welche Tabelle abgefragt wird.],
  [`WHERE` filtert Zeilen anhand einer Bedingung.],
  [`ORDER BY` sortiert die Ergebnisse.],
  [`LIMIT` begrenzt die Anzahl der zurückgegebenen Zeilen.],
  [`INSERT`, `UPDATE` und `DELETE` verändern Daten in einer Tabelle.],
)

= SQL-Befehlsreferenz

Die folgenden Beispiele verwenden alle eine Tabelle namens `inhabitant`
mit den Spalten: `name`, `age`, `gender`, `job`, `village_id`.

== Daten abfragen

Der grundlegendste SQL-Vorgang ist das Abrufen von Daten mit `SELECT`.

=== Alle Spalten auswählen

```sql
SELECT * FROM inhabitant;
```

Das `*` bedeutet «alle Spalten». Verwenden Sie dies, um einen schnellen
Überblick über eine Tabelle zu erhalten.

=== Bestimmte Spalten auswählen

```sql
SELECT name, job FROM inhabitant;
```

Es werden nur die Spalten `name` und `job` zurückgegeben — nützlich,
wenn nicht alle Daten benötigt werden.

=== Zeilen mit WHERE filtern

```sql
SELECT name, age FROM inhabitant
WHERE job = 'farmer';
```

Es werden nur Zeilen einbezogen, in denen die Spalte `job` den Wert
`'farmer'` hat. Zeichenkettenwerte werden stets in einfache
Anführungszeichen gesetzt.

=== Bedingungen kombinieren

```sql
SELECT name FROM inhabitant
WHERE age > 18 AND gender = 'female';
```

Mit `AND` müssen beide Bedingungen erfüllt sein, mit `OR` genügt eine.

=== Ergebnisse mit ORDER BY sortieren

```sql
SELECT name, age FROM inhabitant
ORDER BY age;
```

Die Ergebnisse werden standardmässig aufsteigend nach `age` sortiert
(jüngste zuerst). Mit `DESC` kehren Sie die Reihenfolge um:

```sql
SELECT name, age FROM inhabitant
ORDER BY age DESC;
```

=== Anzahl der Ergebnisse begrenzen

```sql
SELECT name FROM inhabitant
ORDER BY age DESC
LIMIT 3;
```

Es werden nur die 3 ältesten Bewohnerinnen und Bewohner zurückgegeben.
`LIMIT` wird häufig mit `ORDER BY` kombiniert, um die obersten oder
untersten Einträge zu finden.

== Filtern mit Mustern und Bereichen

=== Mustererkennung mit LIKE

```sql
SELECT name FROM inhabitant
WHERE name LIKE 'A%';
```

`%` ist ein Platzhalter, der für eine beliebige Folge von Zeichen steht.
Diese Abfrage gibt alle Bewohnerinnen und Bewohner zurück, deren Name
mit dem Buchstaben A beginnt.

=== Zugehörigkeit prüfen mit IN

```sql
SELECT name, job FROM inhabitant
WHERE job IN ('farmer', 'fisher', 'trader');
```

Dies entspricht drei `OR`-Bedingungen, ist aber deutlich lesbarer.

=== Bereich filtern mit BETWEEN

```sql
SELECT name, age FROM inhabitant
WHERE age BETWEEN 20 AND 30;
```

Gibt Bewohnerinnen und Bewohner zwischen 20 und 30 Jahren zurück,
einschliesslich der Grenzwerte.

== Zählen und Aggregieren

=== Zeilen zählen

```sql
SELECT COUNT(*) FROM inhabitant;
```

Gibt die Gesamtzahl der Zeilen in der Tabelle zurück.

=== Mit Bedingung zählen

```sql
SELECT COUNT(*) FROM inhabitant
WHERE gender = 'male';
```

=== Maximum und Minimum ermitteln

```sql
SELECT MAX(age), MIN(age) FROM inhabitant;
```

Für Summen und Durchschnittswerte können Sie ausserdem
`SUM(Spalte)` und `AVG(Spalte)` verwenden.

== Daten verändern

=== Eine neue Zeile einfügen

```sql
INSERT INTO inhabitant (name, age, gender, job, village_id)
VALUES ('Lena', 17, 'female', 'student', 2);
```

Die Spaltennamen und die Werte müssen in derselben Reihenfolge
angegeben werden.

=== Bestehende Zeilen aktualisieren

```sql
UPDATE inhabitant
SET job = 'teacher'
WHERE name = 'Lena';
```

#warnbox(
  "⚠ UPDATE und DELETE immer mit WHERE verwenden",
  [Ohne eine `WHERE`-Klausel wirken `UPDATE` und `DELETE` auf *jede
   Zeile* der Tabelle. Überprüfen Sie Ihre Bedingung stets sorgfältig,
   bevor Sie diese Befehle auf echten Daten ausführen.],
)

=== Zeilen löschen

```sql
DELETE FROM inhabitant
WHERE name = 'Lena';
```

== Tabellen verknüpfen

Eine relationale Datenbank speichert zusammengehörige Daten in mehreren
Tabellen. Ein `JOIN` verbindet Zeilen aus zwei Tabellen anhand eines
gemeinsamen Wertes.

=== Beispiel für einen Inner Join

Angenommen, es gibt auch eine Tabelle `village` mit den Spalten
`village_id` und `village_name`. Um den Dorfnamen jeder Bewohnerin
und jedes Bewohners zu ermitteln:

```sql
SELECT inhabitant.name, village.village_name
FROM inhabitant
JOIN village ON inhabitant.village_id = village.village_id;
```

Die `ON`-Klausel legt fest, welche Spalten die beiden Tabellen
miteinander verknüpfen.

= Übersichtstabelle

#table(
  columns: (auto, 1fr, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Befehl],
    text(size: 9pt, weight: "bold", fill: white)[Zweck],
    text(size: 9pt, weight: "bold", fill: white)[Kurzbeispiel],
  ),
  [`SELECT`],   [Spalten auswählen, die zurückgegeben werden],   [`SELECT name, age`],
  [`FROM`],     [Tabelle angeben],                               [`FROM inhabitant`],
  [`WHERE`],    [Zeilen nach Bedingung filtern],                 [`WHERE age > 16`],
  [`ORDER BY`], [Ergebnisse sortieren],                         [`ORDER BY age DESC`],
  [`LIMIT`],    [Anzahl der zurückgegebenen Zeilen begrenzen],   [`LIMIT 5`],
  [`COUNT`],    [Passende Zeilen zählen],                        [`SELECT COUNT(*)`],
  [`MAX/MIN`],  [Höchsten oder niedrigsten Wert ermitteln],      [`SELECT MAX(age)`],
  [`INSERT`],   [Neue Zeile hinzufügen],                         [`INSERT INTO ...`],
  [`UPDATE`],   [Bestehende Zeilen ändern],                      [`UPDATE ... SET ...`],
  [`DELETE`],   [Zeilen entfernen],                              [`DELETE FROM ...`],
  [`JOIN`],     [Daten aus zwei Tabellen verknüpfen],            [`JOIN ... ON ...`],
)
