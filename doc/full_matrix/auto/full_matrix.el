(TeX-add-style-hook "full_matrix"
 (lambda ()
    (LaTeX-add-bibliographies
     "library"
     "books"
     "paper")
    (TeX-add-symbols
     "vector"
     "braces"
     "bracem"
     "braceb"
     "lefts"
     "rights"
     "leftb"
     "rightb"
     "leftm"
     "rightm")
    (TeX-run-style-hooks
     "braket"
     "graphicx"
     "dvipdfmx"
     "latex2e"
     "jsarticle10"
     "jsarticle"
     "a4paper")))

