// ─────────────────────────────────────────────────────────────────────────────
// Lesson — Introduction to SQL
// ─────────────────────────────────────────────────────────────────────────────

#let course          = "Computer Science"
#let level           = "Gymnasium Muttenz"
#let term            = "2026-27"
#let lesson-title    = "Introduction to SQL"
#let lesson-subtitle = "Asking questions of a database"

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
// CONTENT — PART 1: Context and SQL Island
// ─────────────────────────────────────────────────────────────────────────────

#goals(
  [Understand what a database is and why structured data storage matters.],
  [Recognize real-world situations where SQL is used every day.],
  [Understand the basic structure of a relational database: tables, rows, and columns.],
  [Write simple SQL queries using `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT`.],
  [Use *SQL Island* to practice querying a database interactively.],
)

= Databases Are Everywhere

Every time you search for something online, buy a concert ticket, or check
your grade on a school platform, a *database* is working behind the scenes.
A database is simply an organized collection of data that can be stored,
searched, and updated efficiently.

But data alone is not enough. You also need a way to *ask questions* of
that data — and that is exactly what *SQL* is for.

#infobox(
  "What does SQL stand for?",
  [*SQL* stands for *Structured Query Language*. It is pronounced either
   "S-Q-L" or "sequel" — both are acceptable. SQL is the standard
   language used to communicate with relational databases. It has been
   around since the 1970s and is still one of the most widely used
   programming languages in the world today.],
)

== Relational Databases: Tables, Rows, and Columns

The most common type of database is a *relational database*. Data is
organized into *tables*, much like a spreadsheet. Each table has:

- *Columns* — the categories of information (e.g., name, age, city).
- *Rows* — the individual records (e.g., one row per person).

Here is an example of a simple table called `students`:

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

Each row is one student. Each column stores one type of information.
A database can hold many tables that are linked to each other — hence the
word *relational*.

= Real-World Use Cases

SQL is not a niche skill. It is used across almost every industry:

#table(
  columns: (auto, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Field],
    text(size: 9pt, weight: "bold", fill: white)[Example use],
  ),
  [Online shopping],   [Find all orders placed in the last 7 days that have not shipped yet.],
  [Healthcare],        [Retrieve a patient's full medication history.],
  [Social media],      [Suggest friends based on shared connections.],
  [School systems],    [Look up all students who scored below 60% on the last test.],
  [Streaming services],[Recommend shows based on your viewing history.],
  [Banking],           [List all transactions over CHF 1,000 in a given month.],
)

#v(0.5em)

The common thread: a large amount of structured data, and the need to
find or summarize specific parts of it quickly.

== A First Taste of SQL

Imagine you want to find all students from Basel in the table above.
In SQL, you would write:

```sql
SELECT name, city
FROM students
WHERE city = 'Basel';
```

This reads almost like plain English:
_"Select the name and city columns from the students table, but only for
rows where the city is Basel."_

The result would be:

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

That is the essence of SQL: you describe *what* you want, and the database
figures out *how* to find it.

= SQL Island — Learn by Playing

Rather than spending the whole lesson reading examples, you are going to
practice SQL by actually using it. *SQL Island* is an online game in which
you are stranded on a deserted island after a plane crash. To survive and
eventually escape, you must communicate with the island's inhabitants — but
the only language they understand is SQL.

#infobox(
  "Open SQL Island in your browser",
  [Navigate to: #link("https://sql-island.informatik.uni-kl.de/")[
    #text(fill: accent)[https://sql-island.informatik.uni-kl.de/]
  ] \
  The game runs entirely in your browser — no login or installation required.
  Select *English* as the language when prompted, and begin the adventure.],
)

As you play, you will naturally discover the SQL commands you need. The
game introduces them step by step through the story. Take your time,
read the instructions carefully, and do not hesitate to experiment —
incorrect queries will not break anything, they will simply return an
error or an unexpected result, which is itself a useful learning moment.

#warnbox(
  "💡 Tip: Read the table structure first",
  [Before writing a query, always look at which tables are available and
   what columns they contain. SQL Island will show you this information.
   Knowing your data is half the battle.],
)

#pagebreak()

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT — PART 2: Summary and SQL Reference
// ─────────────────────────────────────────────────────────────────────────────

// Reset title block for part 2
#{
  text(size: 16pt, weight: "bold", fill: primary)[SQL Quick Reference]
  v(0.1em)
  text(size: 11pt, fill: muted)[The most important commands with examples]
  v(0.3em)
  line(length: 100%, stroke: 1pt + accent)
  v(0.8em)
}

= What You Have Learned

After working through SQL Island you should now be comfortable with the
core ideas of SQL:

#checklist(
  [A *database* stores data in *tables* made up of rows and columns.],
  [`SELECT` chooses which columns to return.],
  [`FROM` specifies which table to query.],
  [`WHERE` filters rows based on a condition.],
  [`ORDER BY` sorts the results.],
  [`LIMIT` restricts how many rows are returned.],
  [`INSERT`, `UPDATE`, and `DELETE` modify data in a table.],
)

= SQL Command Reference

The examples below all use a table called `inhabitant` with the
following columns: `name`, `age`, `gender`, `job`, `village_id`.

== Selecting Data

The most fundamental operation in SQL is retrieving data with `SELECT`.

=== Select all columns

```sql
SELECT * FROM inhabitant;
```

The `*` means "all columns." Use this to get a quick overview of a table.

=== Select specific columns

```sql
SELECT name, job FROM inhabitant;
```

Only the `name` and `job` columns are returned — useful when you do not
need everything.

=== Filter rows with WHERE

```sql
SELECT name, age FROM inhabitant
WHERE job = 'farmer';
```

Only rows where the `job` column equals `'farmer'` are included. String
values are always enclosed in single quotes.

=== Combine conditions

```sql
SELECT name FROM inhabitant
WHERE age > 18 AND gender = 'female';
```

Use `AND` to require both conditions, `OR` to require at least one.

=== Sort results with ORDER BY

```sql
SELECT name, age FROM inhabitant
ORDER BY age;
```

Results are sorted by `age` in ascending order (youngest first) by default.
Add `DESC` to reverse the order:

```sql
SELECT name, age FROM inhabitant
ORDER BY age DESC;
```

=== Limit the number of results

```sql
SELECT name FROM inhabitant
ORDER BY age DESC
LIMIT 3;
```

Returns only the 3 oldest inhabitants. `LIMIT` is often combined with
`ORDER BY` to find top or bottom records.

== Filtering with Patterns and Ranges

=== Pattern matching with LIKE

```sql
SELECT name FROM inhabitant
WHERE name LIKE 'A%';
```

`%` is a wildcard that matches any sequence of characters. This query
returns all inhabitants whose name starts with the letter A.

=== Check for membership with IN

```sql
SELECT name, job FROM inhabitant
WHERE job IN ('farmer', 'fisher', 'trader');
```

Equivalent to three `OR` conditions, but much more readable.

=== Filter a range with BETWEEN

```sql
SELECT name, age FROM inhabitant
WHERE age BETWEEN 20 AND 30;
```

Returns inhabitants aged 20 through 30, inclusive.

== Counting and Aggregation

=== Count rows

```sql
SELECT COUNT(*) FROM inhabitant;
```

Returns the total number of rows in the table.

=== Count with a condition

```sql
SELECT COUNT(*) FROM inhabitant
WHERE gender = 'male';
```

=== Find the maximum and minimum

```sql
SELECT MAX(age), MIN(age) FROM inhabitant;
```

You can also use `SUM(column)` and `AVG(column)` for totals and averages.

== Modifying Data

=== Insert a new row

```sql
INSERT INTO inhabitant (name, age, gender, job, village_id)
VALUES ('Lena', 17, 'female', 'student', 2);
```

The column names and values must be listed in the same order.

=== Update existing rows

```sql
UPDATE inhabitant
SET job = 'teacher'
WHERE name = 'Lena';
```

#warnbox(
  "⚠ Always use WHERE with UPDATE and DELETE",
  [Without a `WHERE` clause, `UPDATE` and `DELETE` apply to *every
   row* in the table. Always double-check your condition before running
   these commands on real data.],
)

=== Delete rows

```sql
DELETE FROM inhabitant
WHERE name = 'Lena';
```

== Joining Tables

A relational database stores related data across multiple tables. A `JOIN`
combines rows from two tables based on a shared value.

=== Inner join example

Suppose there is also a `village` table with columns `village_id` and
`village_name`. To find each inhabitant's village name:

```sql
SELECT inhabitant.name, village.village_name
FROM inhabitant
JOIN village ON inhabitant.village_id = village.village_id;
```

The `ON` clause specifies which columns link the two tables together.

= Summary Table

#table(
  columns: (auto, 1fr, 1fr),
  stroke: none,
  fill: (_, row) => if row == 0 { primary } else if calc.odd(row) { light } else { white },
  inset: 8pt,
  table.header(
    text(size: 9pt, weight: "bold", fill: white)[Keyword],
    text(size: 9pt, weight: "bold", fill: white)[Purpose],
    text(size: 9pt, weight: "bold", fill: white)[Quick example],
  ),
  [`SELECT`],   [Choose columns to return],          [`SELECT name, age`],
  [`FROM`],     [Specify the table],                 [`FROM inhabitant`],
  [`WHERE`],    [Filter rows by condition],          [`WHERE age > 16`],
  [`ORDER BY`], [Sort results],                      [`ORDER BY age DESC`],
  [`LIMIT`],    [Cap the number of rows returned],   [`LIMIT 5`],
  [`COUNT`],    [Count matching rows],               [`SELECT COUNT(*)`],
  [`MAX/MIN`],  [Find highest or lowest value],      [`SELECT MAX(age)`],
  [`INSERT`],   [Add a new row],                     [`INSERT INTO ...`],
  [`UPDATE`],   [Modify existing rows],              [`UPDATE ... SET ...`],
  [`DELETE`],   [Remove rows],                       [`DELETE FROM ...`],
  [`JOIN`],     [Combine data from two tables],      [`JOIN ... ON ...`],
)
