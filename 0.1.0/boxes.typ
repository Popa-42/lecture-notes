#import "theme.typ": theme-state

#let _box(body, color, header: none, breakable: false) = {
  let thickness = 0.5pt
  let background = color.transparentize(90%)
  let accent = (paint: color, thickness: thickness * 4)
  let border = (paint: color.transparentize(50%), thickness: thickness)

  set enum(numbering: "(i)")

  block(
    width: 100%,
    inset: 0pt,
    stroke: (x: border),
    breakable: breakable,
    fill: if header == none { background },
  )[
    #block(outset: (x: thickness / 2), width: 100%, stroke: (top: accent), sticky: true)

    #if header != none {
      block(
        width: 100%,
        fill: background,
        inset: (x: 12pt, y: 8pt),
        above: 0pt,
        below: 0pt,
        sticky: true,
      )[#header]
    }

    #block(
      width: 100%,
      inset: (x: 12pt, top: 8pt, bottom: if header != none { 12pt } else { 8pt }),
      above: 0pt,
      below: 0pt,
    )[#body]
    #block(outset: (x: thickness / 2), width: 100%, stroke: (bottom: border))
  ]
}


#let _statement(
  kind,
  body,
  color,
  label: none,
  note: none,
  inline: false,
  breakable: true,
) = context {
  let headings = counter(heading).get()
  let first = if headings.len() >= 1 { calc.max(1, headings.at(0)) } else { 1 }
  let second = if headings.len() >= 2 { calc.max(1, headings.at(1)) } else { 1 }
  let statement = counter("lecture-notes.statement-" + str(first) + "-" + str(second))
  let suffix = if label != none { [ (#label)] }

  statement.step()

  context {
    let mark = statement.display(number => numbering("1.1.1", first, second, number))

    let heading = text(
      font: theme-state.get().text.sans-font,
      size: 0.9em,
      fill: color.darken(20%),
    )[*#kind #mark*#suffix]

    let header = if note == none {
      heading
    } else {
      grid(
        columns: (1fr, auto),
        column-gutter: 12pt,
        align: (left, right),

        heading, text(size: 0.9em)[#note],
      )
    }

    if inline {
      _box([#heading #body], color.darken(20%), breakable: false)
    } else {
      _box(body, color.darken(20%), header: header, breakable: breakable)
    }
  }
}


#let statement-names = (
  en: (
    definition: [Definition],
    axiom: [Axiom],
    theorem: [Theorem],
    lemma: [Lemma],
    corollary: [Corollary],
  ),
  de: (
    definition: [Definition],
    axiom: [Axiom],
    theorem: [Satz],
    lemma: [Lemma],
    corollary: [Korollar],
  ),
)

#let _statement-name(kind, lang) = statement-names.at(lang, default: statement-names.en).at(kind)

#let definition(body, label: none, note: none, inline: false, breakable: true, lang: none) = context {
  let lang = if lang == none { theme-state.get().text.lang } else { lang }
  _statement(
    _statement-name("definition", lang),
    body,
    theme-state.get().statement-colors.definition,
    label: label,
    note: note,
    inline: inline,
    breakable: breakable,
  )
}

#let axiom(body, label: none, note: none, inline: false, breakable: true, lang: none) = context {
  let lang = if lang == none { theme-state.get().text.lang } else { lang }
  _statement(
    _statement-name("axiom", lang),
    body,
    theme-state.get().statement-colors.axiom,
    label: label,
    note: note,
    inline: inline,
    breakable: breakable,
  )
}

#let theorem(body, label: none, note: none, inline: false, breakable: true, lang: none) = context {
  let lang = if lang == none { theme-state.get().text.lang } else { lang }
  _statement(
    _statement-name("theorem", lang),
    body,
    theme-state.get().statement-colors.theorem,
    label: label,
    note: note,
    inline: inline,
    breakable: breakable,
  )
}

#let lemma(body, label: none, note: none, inline: false, breakable: true, lang: none) = context {
  let lang = if lang == none { theme-state.get().text.lang } else { lang }
  _statement(
    _statement-name("lemma", lang),
    body,
    theme-state.get().statement-colors.lemma,
    label: label,
    note: note,
    inline: inline,
    breakable: breakable,
  )
}

#let corollary(body, label: none, note: none, inline: false, breakable: true, lang: none) = context {
  let lang = if lang == none { theme-state.get().text.lang } else { lang }
  _statement(
    _statement-name("corollary", lang),
    body,
    theme-state.get().statement-colors.corollary,
    label: label,
    note: note,
    inline: inline,
    breakable: breakable,
  )
}

#let satz(..args) = theorem(..args, lang: "de")
#let korollar(..args) = corollary(..args, lang: "de")

#let def = definition
#let thm = theorem
#let cor = corollary
#let kor = korollar

#let exercise(
  body,
  heading: [],
  points: [],
  color: none,
  stroke-color: none,
  text-color: none,
  radius: 5pt,
) = context {
  let theme = theme-state.get()
  let color = if color != none { color } else { theme.colors.accent }
  let stroke-color = if stroke-color != none { stroke-color } else { theme.colors.stroke }
  let text-color = if text-color != none { text-color } else { theme.colors.text }
  let background = color.lighten(95%)

  let label-box = content => block(
    fill: white,
    stroke: stroke-color + 0.4pt,
    radius: radius * 0.75,
    inset: 5pt,
    text(text-color, content),
  )

  let head = if heading != [] or points != [] {
    if heading != [] {
      let badge = label-box(heading)
      place(dy: -measure(badge).height / 2 - 12pt, badge)
    }

    if points != [] {
      let badge = label-box(points)
      place(dy: -measure(badge).height / 2 - 12pt, box(width: 100%, align(right)[#badge]))
    }

    v(0.5em)
  } else { [] }

  if head != [] { v(1em) }

  block(
    fill: background,
    stroke: (
      left: color + 1.7pt,
      top: stroke-color + 0.4pt,
      right: stroke-color + 0.6pt,
      bottom: stroke-color + 0.6pt,
    ),
    width: 100%,
    radius: radius,
    inset: 12pt,
    above: 12pt,
    below: 18pt,
  )[
    #set enum(numbering: "(i)")
    #head
    #body
  ]
}
