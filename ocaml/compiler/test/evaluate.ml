open OUnit2
open Compiler.Grammar
open Compiler.Interpreter

let tests =
  "evaluating" >::: [
    "an identifier produces its value" >::
      (fun _ ->
        let state = {table=[("a", 1)]; output=None} in

        let result = evaluate state (Identifier ("a")) in

          assert_equal 1 (result.value) ~printer:string_of_int
      );

    ("returns output produced by a print statement" ^
    "as part of an expression") >::
      (fun _ ->
        let result =
          evaluate 
            {table=[]; output=None}
            (StatementThenExpression (
              Print [Number (1)],
              Number (2)
            )) in

          assert_equal
            "1\n"
            (Option.get result.state.output)
            ~printer:Fun.id
      );

    "returns output produced by all nested print statements" >::
      (fun _ ->
        let result =
          evaluate
            {table=[]; output=None}
            (StatementThenExpression(
              Print [
                StatementThenExpression(
                  Print [Number (1)],
                  Number (2)
                );
                Number (3)
              ],
              Number (4)
            )) in

          assert_equal
            ("1\n" ^
             "2 3\n")
            (Option.get result.state.output)
            ~printer:Fun.id
      )
  ]

let _ = run_test_tt_main tests
