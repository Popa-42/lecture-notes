#let render-footnote-entry(entry, numbering-pattern: "[1]") = {
  let loc = entry.note.location()
  let mark = numbering(numbering-pattern + ":", ..counter(footnote).at(loc))

  pad(left: entry.indent)[
    #grid(
      columns: (auto, 1fr),
      gutter: 0.3em,
      mark, entry.note.body,
    )
  ]
}

#let chevrons(..children) = {
  let body = children.pos().join(", ")
  math.lr([$chevron.l #body chevron.r$])
}

#let _qed = $square$
#let qed-equation(eq) = {
  set math.equation(numbering: _ => _qed, number-align: right + bottom)
  eq
}
#let qed = [#h(1fr)#_qed]

#let Im = math.op("Im")
#let Re = math.op("Re")
#let ü = text(font: "Fira Sans", size: 0.85em, weight: 600)[[Ü]]

#let ord = math.op("ord")

#let grad = math.op("grad")
