open OUnit2
open Compiler.Stringutils

let tests =
  "join" >::: [
    "joins a list of strings with a separator" >::
      (fun _ ->
        let strings = ["1"; "2"; "3"] in

        let result = join strings " " in

          assert_equal "1 2 3" result ~printer:Fun.id
      )
  ]

let _ = run_test_tt_main tests
