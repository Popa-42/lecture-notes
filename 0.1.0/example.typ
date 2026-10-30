#import "@local/lecture-notes:0.1.0": *

#show: lecture-notes.with(seminar: [Algebra I])

#title-page(
  title: [Inoffizielles Skript zur Vorlesung \ Algebra I],
  authors: ([Zusammengestellt von #smallcaps[Maximilian Mustermann]],),
  university: [#smallcaps[Prof. Dr. Bianca Beispiel]
    #v(1.5em)
    #text(size: 12pt)[Wintersemester 2026/27]
    #v(0pt)
    Beispieluniversität],
  location: [Musterstadt],
)

#set page(numbering: "i")
#outline()
#counter(heading).update(0) // prevent the outline heading from being counted aswell
#pagebreak(weak: true)
#set page(numbering: "1")
#counter(page).update(1)

#lecture("19.10.2026", title: [Einführung in Gruppentheorie])

= Gruppen

== Definitionen

#definition[
  Eine _Gruppe_ ist ein Monoid, in dem jedes Element ein Inverses besitzt.
]

#theorem(label: [Eindeutigkeit], inline: true)[
  Das inverse Element ist eindeutig.
]

Ein kurzer Beweis endet so.#footnote[Anmerkung: Dies ist eine Fußnote.] #qed

#pagebreak()

Fortsetzung der ersten Vorlesung mit automatischer Kopfzeile.
