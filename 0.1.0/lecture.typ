#import "./theme.typ": theme-state

#let lecture-counter = counter("lecture-notes.lecture")

#let reset-lectures() = lecture-counter.update(0)

#let lecture(date, title: none, prefix: [Vorlesung], no-numbering: false) = {
  lecture-counter.step()

  context {
    let theme = theme-state.get()

    let number = lecture-counter.get().first()

    [#metadata((
      number: if no-numbering { none } else { number },
      date: date,
      title: title,
      prefix: prefix,
    )) <lecture-notes-lecture>]

    block(width: 100%, above: 1.5em, below: 1.5em)[
      #if number > 1 { divider() }
      #set text(font: theme.text.sans-font)
      *#prefix#if not no-numbering [ #number], #date*#if title != none [ -- #title]
    ]
  }
}
