open OUnit2
open Compiler.Grammar
open Compiler.Interpreter

let tests =
  "evaluating" >::: [
    "an identifier produces its value" >::
      (fun _ ->
        let table = [("a", 1)] in

        let result = evaluate table (Identifier ("a")) in

          assert_equal 1 result ~printer:string_of_int
      )
  ]

let _ = run_test_tt_main tests
