# lecture-notes

A Typst template for mathematical lecture notes.

```typst
#import "@local/lecture-notes:0.1.0": *

#show: lecture-notes.with(seminar: [Algebra I])

#title-page(
  title: [Lecture Notes: \ Algebra I],
  authors: ([#smallcaps[John Doe]],),
  university: [#smallcaps[Prof. Jane Q. Smith] #v(1.5em)
    #text(size: 12pt)[Winter 2026/27] #v(0pt) Example University],
  location: [City, Country],
)

#lecture("27/10/2026", title: [Introduction to group theory])

= Group Theory

#definition[
  A group is a monoid such that every element has an inverse.
]
```

Style can be partially overridden:

```typst
#show: lecture-notes.with(
  seminar: [Algebra I],
  theme: (
    text: (justify: false,),
    colors: (primary: teal,),
  ),
)
```

The package contains the following components: `lecture-notes`, `title-page`, `lecture`, `definition`, `axiom`, `theorem`, `lemma`, `corollary`, `exercise`, `qed`, `qed-equation`, `Im`, `Re` and `ord`.

`def`, `thm`, `satz`, `kor` and `korollar` stay for backwards compatibility.
