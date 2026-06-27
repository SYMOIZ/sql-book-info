# Writing Standard — Part 1: SQL, The Language of Data

> **Status:** Active — applies to all chapter files under `e-learning/`.  
> **Applies to:** `Chapter NN - Title.md` files and shared assets.  
> **Audience:** Beginners and students with little or no SQL experience.

---

## 1. Purpose of This Guide

Every lesson, exercise, and chapter README in this e-learning book must follow this standard. The goal is a consistent voice: clear, practical, and friendly — not academic, not copied from vendor docs, and not overloaded with jargon.

When in doubt, ask: **Would a first-year student understand this on a first read?**

---

## 2. Audience and Tone

### Who we write for

- College or bootcamp students learning SQL for the first time
- Career changers setting up SQL Server for practice
- Self-learners who have never written a query before

**Assume the reader can:**

- Use a computer and install software
- Understand tables as rows and columns (spreadsheet mental model)

**Do not assume the reader knows:**

- Relational algebra, normalization theory, or DBA tasks
- Other programming languages
- Cloud, DevOps, or enterprise architecture

### Tone

| Do | Don't |
|----|-------|
| Write like a helpful instructor in a lab | Write like an API reference manual |
| Use "you" and "we" | Use passive voice ("it can be observed that…") |
| Be direct and warm | Be stiff, formal, or condescending |
| Acknowledge when something is tricky | Pretend everything is trivial |
| Keep sentences short | Chain many ideas into one long paragraph |

**Example — preferred tone:**

> A `JOIN` combines rows from two tables when they share a related value — for example, matching each product to its brand name.

**Example — avoid:**

> Join operations facilitate the relational composition of tuple sets across normalized entities via predicate-based cardinality expansion.

---

## 3. Chapter and Topic Structure

Every chapter is a **single Markdown file**. Topics, exercises, and solutions live in that file — use headings to organize them.

### 3.1 Chapter file layout

```
e-learning/
├── Chapter 01 - Environment Setup.md
├── Chapter 02 - Querying and Filtering.md
├── …
└── Chapter 17 - Window Functions.md
```

Each `Chapter NN - Title.md` file contains:

| Heading level | Section | Purpose |
|---------------|---------|---------|
| `#` | Chapter title | One H1 at the top |
| `##` | Overview blocks | Prerequisites, learning goals, time estimate |
| `##` | Topics | Former lessons — one `##` per major topic |
| `## Exercises` | Practice tasks | 3–8 exercises per chapter |
| `## Solutions` | Answers | SQL + brief explanation |
| `## Chapter Summary` | Close | Recap and link to the next chapter file |

Do **not** split a chapter into subfolders or subtopic files (for example, no separate `INNER_JOIN.md`).

### 3.2 Chapter opening (required sections)

1. **Title** — `# Chapter NN - Topic Name`
2. **One-sentence summary** — what the reader will be able to do after the chapter
3. **Prerequisites** — linked chapter file(s) and setup (e.g. BikeStores loaded)
4. **Learning goals** — 3–6 bullet points, each starting with a verb (*Write*, *Explain*, *Use*, *Create*)
5. **Time estimate** — read + practice (e.g. "~90 minutes")
6. **What you'll need** — database objects, scripts from `assets/database/`

### 3.3 Topic section structure (required order)

Each major topic inside a chapter (`## Topic name`) must follow this order:

| # | Section | Purpose |
|---|---------|---------|
| 1 | **Why this matters** (2–4 sentences) | Real-world motivation before any syntax |
| 2 | **Concept** | Plain-language explanation; diagrams optional |
| 3 | **Syntax** | Minimal template in a fenced `sql` block |
| 4 | **Walkthrough** | Step-by-step example on BikeStores |
| 5 | **How it works** | Brief explanation of what SQL Server did |
| 6 | **Another example** (optional) | Second scenario if it adds clarity |
| 7 | **Common mistakes** | 2–4 bullets — what beginners get wrong |
| 8 | **Quick recap** | 3–5 bullets |
| 9 | **Next** (optional) | Link to the next topic (`#anchor`) or to `#exercises` |

**Rule: Concept before syntax.** Never open a topic with a code block. The reader must understand *what* and *why* before *how*.

### 3.4 Exercises

- **3–8 exercises** per chapter, under `## Exercises`
- Each exercise: numbered, clear task, hint optional, states which table(s) to use
- Solutions under `## Solutions` with: task restatement, SQL, one-line explanation of result
- Prefer exercises that build on earlier chapters (progressive difficulty)

---

## 4. Language and Readability

### 4.1 Simple English rules

- **Sentence length:** aim for under 25 words; split longer sentences
- **Paragraph length:** 2–5 sentences; one idea per paragraph
- **Vocabulary:** everyday words first; define every technical term on first use
- **Abbreviations:** spell out on first use — e.g. "Structured Query Language (SQL)"
- **Active voice:** "You write a query" not "A query is written"

### 4.2 Jargon policy

| Term | First mention |
|------|----------------|
| Required technical terms (SELECT, JOIN, index) | Define in plain language + show example in same or next section |
| Optional advanced terms (B-tree, execution plan) | One short sentence max; link to "deeper dive" note or skip if not needed for the exercise |
| Vendor marketing terms | Avoid unless necessary (e.g. "Transact-SQL" once, then "T-SQL") |

**Banned or minimize:**

- "Simply", "just", "obviously", "trivially" (dismisses learner struggle)
- "Leverage", "utilize" (use "use")
- "Performant" (use "faster" or "better performance")
- Walls of acronyms without explanation

### 4.3 Definitions

When introducing a new term, use this pattern:

> **Term:** Short definition in one sentence.  
> **Example:** One line tying it to BikeStores.

Example:

> **Primary key:** A column (or set of columns) that uniquely identifies each row in a table.  
> **Example:** In `sales.customers`, `customer_id` is the primary key — no two customers share the same ID.

---

## 5. SQL and Code Formatting

### 5.1 Code blocks

- Always use fenced blocks with language tag `sql`
- Keywords in **UPPERCASE** in examples: `SELECT`, `FROM`, `WHERE`
- Indent nested clauses for readability (4 spaces)
- One statement per block unless showing a short sequence (max 3 related statements)

```sql
SELECT
    first_name,
    last_name
FROM
    sales.customers
WHERE
    city = 'Albany';
```

### 5.2 Naming in examples

- **Default database:** `BikeStores`
- **Schemas:** `sales`, `production` (as in source sample)
- **New objects** created in lessons: prefix tutorial objects clearly — e.g. `sales.udfNetSale`, `production.trg_product_audit`
- **Avoid** `foo`, `bar`, `table1` — use domain names (customer, product, order)

### 5.3 Showing results

After runnable examples, show expected output in one of:

1. A small **table** (markdown) for ≤6 columns and ≤5 rows
2. A **comment block** for wider results, with note: "partial output"
3. A **plain description** when output is large: "Returns about 200 rows, one per product."

Do not use fake `Code language: CSS` or `Code language: PHP` labels (legacy scrape artifact — never reproduce).

### 5.4 Syntax templates

Use placeholders in angle brackets or italics in prose:

```sql
SELECT <column_list>
FROM <schema>.<table>
WHERE <condition>;
```

Explain each placeholder immediately below the block.

---

## 6. Data and Examples

### 6.1 BikeStores first

- **Reuse repository data** whenever possible — same tables, same stories across chapters
- Build a **running narrative:** customers place orders → products belong to brands → staff work in stores → reports use aggregates and window functions
- New tutorial-only objects go in `assets/database/04-tutorial-extensions.sql` and are introduced in the lesson that first needs them

### 6.2 Example design rules

| Rule | Detail |
|------|--------|
| **Start small** | First example: one table, few columns, small result set |
| **Add complexity gradually** | Second example: add JOIN or filter, not both at once unless lesson topic requires it |
| **Realistic values** | Use believable names, prices, dates from BikeStores — not `test`, `aaa`, `123` |
| **Explain the scenario** | One sentence before the query: "Find all customers in Albany." |
| **Tie to prior chapters** | "Remember `WHERE` from Chapter 02? Here we combine it with `JOIN`." |

### 6.3 Tables reference (canonical)

Use these tables consistently:

| Schema | Tables | Typical use |
|--------|--------|-------------|
| `sales` | `customers`, `orders`, `order_items`, `staffs`, `stores` | People, transactions, reporting |
| `production` | `products`, `brands`, `categories`, `stocks` | Catalog, inventory |

Tutorial extensions (document when first used): `sales.sales_summary`, `production.parts`, `production.product_audits`, views such as `sales.vw_staff_sales`.

---

## 7. Advanced Topics

Keep advanced material **concise and practical**.

### 7.1 What counts as "advanced" in this book

- Cursors, dynamic SQL, DDL triggers, indexed views, CUBE/ROLLUP, execution plan internals
- Population vs sample variance (`VARP`, `STDEVP`)
- `GENERATE_SERIES`, `OUTER APPLY` edge cases

### 7.2 How to teach advanced topics

1. **One paragraph** — what it is and when a beginner might meet it
2. **One working example** on BikeStores
3. **When to use / when to skip** — bullet list
4. **No deep theory** unless required for the exercise

**Cap:** Advanced sections should not exceed **30%** of a lesson's word count.

### 7.3 Out of scope (mention only if needed)

- High availability, replication, Always On
- Security hardening, encryption, compliance
- Performance tuning at production scale
- Other databases (PostgreSQL, MySQL) — SQL Server 2022 focus only; optional footnote if syntax differs widely

---

## 8. Markdown and Formatting Conventions

### 8.1 Headings

| Level | Use |
|-------|-----|
| `#` | Lesson title only (one per file) |
| `##` | Major sections (Concept, Syntax, Walkthrough, etc.) |
| `###` | Subsections within a major section |
| `####` | Rare — avoid deep nesting |

Do not skip heading levels (`#` then `###`).

### 8.2 Emphasis

- **Bold** — first definition of a key term, UI labels ("Click **Execute**")
- `Backticks` — SQL identifiers, file names, code literals
- *Italics* — placeholders in prose only, not in SQL blocks

### 8.3 Lists

- Use bullets for unordered ideas
- Use numbered lists for sequential steps (install, run script, verify)
- Keep list items parallel in grammar

### 8.4 Links

- Link to previous chapters: `[Chapter 03: Joins](Chapter 03 - Joins.md)`
- Link to assets: `[create-objects script](assets/database/01-create-objects.sql)`
- Link to another topic in the same chapter: `[Inner join](#inner-join)`
- Link to exercises in the same chapter: `[Exercises](#exercises)`

### 8.5 Images

- Store under `assets/images/`
- Always include **alt text** describing what the learner should see
- Caption: one sentence explaining why the image matters
- Prefer ASCII or Mermaid for simple diagrams when no screenshot is needed

### 8.6 Callout boxes (optional, consistent labels)

Use blockquotes with a bold label:

> **Note:** SQL Server runs `FROM` before `SELECT` even though `SELECT` appears first.

> **Tip:** Press F5 in SSMS to run the current query.

> **Warning:** This exercise changes data. Use a transaction and `ROLLBACK` if unsure.

---

## 9. Pedagogy Checklist

Before marking a lesson complete, verify:

- [ ] Concept explained before any syntax
- [ ] At least one BikeStores example
- [ ] SQL in fenced `sql` blocks, keywords uppercase
- [ ] Expected output shown or described
- [ ] **Common mistakes** section included
- [ ] **Quick recap** included
- [ ] No scrape artifacts ("Was this tutorial helpful?", wrong code-language tags)
- [ ] No unexplained jargon
- [ ] Links to prerequisites and next lesson
- [ ] Reading level appropriate for beginners (no sentence over ~30 words without good reason)

---

## 10. Content Integrity

### 10.1 Original writing

- **Rewrite** source material from the legacy repository; do not copy paragraphs verbatim
- Remove third-party site branding (e.g. SQLServerTutorial.Net welcome text)
- Fix known source typos (`Congratulation`, `Aruze`, `QL Server`)

### 10.2 Version and environment

- State once per chapter (in README or first lesson): **SQL Server 2022 Developer Edition**, **SSMS**, database **BikeStores**
- Use syntax valid on SQL Server 2022 unless noting "older versions" in a Note

### 10.3 Object dependencies

- If a lesson uses a view or table not in base BikeStores, the lesson (or a prior lesson in the same chapter) must include its `CREATE` script or reference `04-tutorial-extensions.sql`
- Never reference `sales.vw_staff_sales` (or similar) before it is created

---

## 11. Exercise Writing Standard

### 11.1 Exercise format

```markdown
### Exercise 3 — Customers by state

List the first name, last name, and city of all customers in California.

**Tables:** `sales.customers`  
**Hint:** Use `WHERE` with the `state` column.
```

### 11.2 Solution format

```markdown
### Exercise 3 — Solution

```sql
SELECT
    first_name,
    last_name,
    city
FROM
    sales.customers
WHERE
    state = 'CA';
```

Returns one row per matching customer.
```

### 11.3 Difficulty mix (per chapter)

| Level | Share | Description |
|-------|-------|-------------|
| Warm-up | ~30% | Single concept from current lesson |
| Apply | ~50% | Combine with one prior chapter |
| Stretch | ~20% | Slightly harder; optional star ★ in title |

---

## 12. File Naming

| Item | Pattern | Example |
|------|---------|---------|
| Chapter file | `Chapter NN - Title.md` | `Chapter 03 - Joins.md` |
| Topic heading | `## Topic name` inside chapter file | `## Inner join` |
| Exercises | `## Exercises` and `## Solutions` in same file | — |

Chapter numbers are two digits, zero-padded. Do not create separate files per topic.

---

## 13. Word Count Guidelines (soft targets)

| Content type | Target |
|--------------|--------|
| Short lesson | 400–700 words |
| Standard lesson | 700–1,200 words |
| Advanced lesson | 1,200–1,800 words (hard cap) |
| Chapter README | 200–400 words |
| Single exercise + solution pair | 50–150 words |

Prefer clarity over length. Split a lesson if it exceeds 1,800 words or teaches more than **one main concept**.

---

## 14. Quick Reference — Lesson Template

Copy this skeleton when authoring (Phase 4+):

```markdown
# Lesson NN: Title

## Why this matters

[2–4 sentences]

## Concept

[Plain explanation]

## Syntax

```sql
-- minimal template
```

## Walkthrough

[Scenario sentence]

```sql
-- full example
```

### Expected result

[Table or description]

## How it works

[2–4 sentences]

## Common mistakes

- Mistake one — correction
- Mistake two — correction

## Quick recap

- Bullet one
- Bullet two
- Bullet three

## Next

[Link to next lesson or exercises]
```

---

## 15. Approval and Changes

| Version | Date | Status |
|---------|------|--------|
| 1.0 | Phase 3 | Awaiting approval |

Changes to this guide after approval should be noted here with a brief changelog so existing chapters can be aligned.

---

*End of writing standard — no chapter content has been written.*
