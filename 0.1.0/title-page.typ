#let _author-name(author) = if type(author) == dictionary {
  author.at("name", default: [])
} else {
  author
}

#let _display-date(date, format) = if type(date) == datetime {
  date.display(format)
} else if type(date) == array and date.len() == 2 {
  date.first().display(format) + [ -- ] + date.last().display(format)
} else {
  date
}

#let title-page(
  title: none,
  subtitle: none,
  authors: (),
  date: datetime.today(),
  university: none,
  location: none,
  date-label: [Stand:],
  date-format: "[day].[month].[year]",
  language: "de",
  page-grid: 13.6pt,
  title-color: luma(80),
  break-after: true,
  reset-page-counter: true,
) = {
  let authors = if type(authors) == array { authors } else { (authors,) }
  let many-authors = authors.len() > 1

  set page(numbering: none, header: none, footer: none)
  set text(lang: language, size: page-grid)
  set align(center)

  v(7 * page-grid)
  text(weight: "bold", fill: title-color, size: 1.75 * page-grid, title)
  v(0.25 * page-grid)

  if subtitle != none {
    text(fill: title-color, size: page-grid, subtitle)
  }

  v(page-grid)

  if university != none {
    [#university#if location != none [ #location]]
  }

  if authors.len() > 0 {
    place(
      bottom + center,
      dy: -10 * page-grid,
      grid(
        columns: 100%,
        gutter: if many-authors { 14pt } else { 1.25 * page-grid },
        ..authors.map(author => align(center, text(_author-name(author)))),
      ),
    )
  }

  set text(size: 11pt)
  place(
    bottom + center,
    grid(
      columns: (auto, auto),
      row-gutter: 1em,
      column-gutter: 1em,
      align: (right, left),
      text(weight: "bold", fill: title-color, date-label), text(_display-date(date, date-format)),
    ),
  )

  if break-after {
    pagebreak(weak: true)
    if reset-page-counter {
      counter(page).update(1)
    }
  }
}
