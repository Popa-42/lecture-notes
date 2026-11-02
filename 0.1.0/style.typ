#import "helpers.typ": render-footnote-entry
#import "theme.typ": default-theme, resolve-theme, theme-state

#let lecture-notes(
  seminar: none,
  theme: (:),
  show-header: true,
  body,
) = {
  let active-theme = resolve-theme(theme)
  theme-state.update(active-theme)

  set page(
    margin: (x: 2.5cm),
    numbering: "1",
    header: context {
      if show-header {
        let page-number = here().page()
        let lectures = query(<lecture-notes-lecture>).filter(
          lecture => lecture.location().page() < page-number,
        )

        set text(size: 0.8em, font: active-theme.text.sans-font)
        let headings = query(selector(heading.where(level: 1)).before(here()))

        if headings.len() > 1 {
          let last = headings.last()

          grid(
            columns: (1fr, 2fr, 1fr),
            align: (start, center, end),
            if seminar == none { [] } else { seminar },
            {
              show linebreak: none
              [*#last.body*]
            },
            if lectures.len() > 0 {
              let current = lectures.last().value
              [#current.prefix#{ if current.number != none [ #current.number] }, #current.date]
            },
          )
        }
      }
    },
  )

  set text(
    lang: active-theme.text.lang,
    font: active-theme.text.text-font,
  )
  show math.equation: set text(font: active-theme.text.math-font)

  show heading: it => context {
    set text(font: theme-state.get().text.sans-font)
    show math.equation: set text(font: "Fira Math")
    it
  }

  show heading.where(level: 1): it => context {
    set text(
      size: 1.25em,
      weight: 700,
      fill: theme-state.get().colors.text,
    )

    if it.numbering == none {
      counter(heading).step(level: 1)
    }

    line(length: 100%, stroke: 0.5pt + theme-state.get().colors.stroke)
    v(-0.55em)
    align(center, it)
    v(-0.5em)
    line(length: 100%, stroke: 0.5pt + theme-state.get().colors.stroke)
    v(0.5em)
  }

  show heading.where(level: 2): it => context {
    set text(
      size: 1.15em,
      weight: 700,
      fill: theme-state.get().colors.text,
    )

    if it.numbering == none {
      counter(heading).step(level: 2)
    }

    align(center, underline(
      background: true,
      evade: false,
      stroke: 4pt + theme-state.get().colors.stroke,
      offset: 3pt,
      it,
    ))
    v(0.25em)
  }

  set par(justify: active-theme.text.justify)

  show divider: set align(center)
  show divider: block(text(fill: active-theme.colors.text)[\u{2217} \u{2217} \u{2217}])

  set footnote(numbering: "[1]")
  set footnote.entry(
    separator: line(
      length: 30% + 0pt,
      stroke: active-theme.colors.primary.lighten(50%) + 0.5pt,
    ),
    indent: 1em,
  )
  show footnote.entry: it => render-footnote-entry(it, numbering-pattern: "[1]")

  show "\u{00A0}": sym.space.nobreak.narrow

  body
}
