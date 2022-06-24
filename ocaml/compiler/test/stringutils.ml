open OUnit2
open Compiler.Stringutils

let tests =
  "join" >::: [
    "produces an empty string if there are no strings to join" >::
      (fun _ ->
       let result = join " " [] in

          assert_equal "" result ~printer:Fun.id
      );

    "joins a list of strings with a separator" >::
      (fun _ ->
        let result = join " " ["1"; "2"; "3"] in

          assert_equal "1 2 3" result ~printer:Fun.id
      )
  ]

let _ = run_test_tt_main tests
