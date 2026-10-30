# lecture-notes

A Typst template for mathematical lecture notes.

## Example Usage

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

## Installation

Since I don't want to include this package in the official Typst package registry (bc I'm too shy), you have to install it manually. To do so, you have to first find out where Typst stores packages on your system. Run the following command in your terminal:

```bash
typst info
```

and search for the line "Package path". In this folder, create a new folder called `local` (if it doesn't exist yet) and then simply clone this repository into a subfolder called `lecture-notes`. When you're done, the path to the `typst.toml` file should look like this:

```
<package path>/local/lecture-notes/0.1.0/typst.toml
```

Now you're ready to type your lecture notes. Enjoy :)

## Components

The package contains the following components: `lecture-notes`, `title-page`, `lecture`, `definition`, `axiom`, `theorem`, `lemma`, `corollary`, `exercise`, `qed`, `qed-equation`, `Im`, `Re` and `ord`.

`def`, `thm`, `satz`, `kor` and `korollar` stay for backwards compatibility.
