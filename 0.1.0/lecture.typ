#let lecture-counter = counter("lecture-notes.lecture")

#let reset-lectures() = lecture-counter.update(0)

#let lecture(date, title: none, prefix: [Vorlesung]) = {
  lecture-counter.step()

  context {
    let number = lecture-counter.get().first()

    [#metadata((number: number, date: date, title: title, prefix: prefix)) <lecture-notes-lecture>]

    block(width: 100%, above: 1.5em, below: 1.5em)[
      #if number > 1 { divider() }
      #prefix #number, #date#if title != none [ -- #title]
    ]
  }
}
