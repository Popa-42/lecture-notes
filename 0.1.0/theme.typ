#let default-theme = (
  text: (
    lang: "de",
    text-font: "TeX Gyre Termes",
    sans-font: "Fira Sans",
    math-font: "TeX Gyre Termes Math",
    justify: true,
  ),
  colors: (
    primary: eastern,
    accent: aqua,
    text: eastern.darken(20%),
    stroke: eastern.lighten(50%),
    code-border: gray,
    code-inline-border: rgb("CCCCCC"),
    code-block-fill: luma(98.75%),
    code-inline-fill: luma(96%),
  ),
  statement-colors: (
    definition: eastern,
    axiom: orange,
    theorem: blue,
    lemma: aqua,
    corollary: purple,
  ),
)

#let theme-state = state("lecture-notes.theme", default-theme)

#let resolve-theme(theme) = {
  let result = default-theme

  for (key, value) in result {
    let override = theme.at(key, default: none)
    if override != none {
      result.at(key) = if type(value) == dictionary and type(override) == dictionary {
        value + override
      } else {
        override
      }
    }
  }

  result
}
