open OUnit2
open Compiler.Interpreter
open Compiler.Grammar

let tests =
  "interpret" >::: [
    "produces the output of the program" >::
      (fun _ ->
        let output = ref "" in
        let write_line line = output := !output ^ line ^ "\n" in

        let _ =
          interpret (Print [ Number (4)]) write_line in

          assert_equal
            "4\n"
            !output
            ~printer:Fun.id
      )
  ]

let _ = run_test_tt_main tests
