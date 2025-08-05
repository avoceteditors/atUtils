(lang dune 3.19)

(name atutils)

(generate_opam_files true)

(source (github "avoceteditors/atutils"))

(authors "Kenneth P. J. Dyer <kenneth@avoceteditors.com>")

(maintainers "Kenneth P. J. Dyer <kenneth@avoceteditors.com>")

(license ./LICENSE)

(documentation https://github.com/avoceteditors/atutils)
(homepage https://github.com/avoceteditors/atutils)

(package
 (name atutils)
 (version 0.1.6)
 (synopsis "Avocet Tools Utilities Library")
 (description "Collection of utilities used by all Avocet Tools, especially those with lexers and parsers")
 (depends ocaml ANSITerminal)
 (license "BSD-3-Clause")
 ;(tags
 ; ("add topics" "to describe" your project)))

 )

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
