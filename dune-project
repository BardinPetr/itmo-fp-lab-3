(lang dune 3.16)

(name lab3)

(generate_opam_files true)

(source
 (github BardinPetr/itmo-fp-lab-3))

(authors "Bardin Petr")

(maintainers "Bardin Petr")

(license MIT)

(package
 (name lab3)
 (synopsis "ITMO FP course laboratory work #3")
 (description "Implemetation of linear interpolation")
 (depends ocaml dune (alcotest :with-test) (junit_alcotest :with-test) (qcheck :with-test) (qcheck-alcotest :with-test) cmdliner)
 (allow_empty))
