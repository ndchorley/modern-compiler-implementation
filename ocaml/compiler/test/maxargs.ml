open OUnit2
open Compiler.Grammar
open Compiler.Maxargs

 let tests =
   "max_args" >:::
  [
    "returns the number of arguments to a print statement" >::
      (fun _ ->
        assert_equal
          2
          (max_args (Print [Number (1); Number (2)]))
          ~printer:string_of_int
      );

    "returns 0 for an assignment statement" >::
      (fun _ ->
        assert_equal
          0
          (max_args (Assignment ("x", Number (2))))
          ~printer:string_of_int
      );

    "returns the maximum number of arguments to a print nested " ^
    "within an assignment" >::
        (fun _ ->
          let statement = Assignment (
            "x",
            StatementThenExpression (
              Print [Number (1)],
              Number (2)
            )
          ) in
            (
              assert_equal
                1
                (max_args statement)
                ~printer:string_of_int
            )
      );

    "returns the maximum number of arguments of a print nested " ^
    "within other print statements" >::
        (fun _ ->
          let statement = Print [
            StatementThenExpression (
              Print [Number (1); Number(2)],
              Number (3)
            )
          ] in
            (
              assert_equal
                2
                (max_args statement)
                ~printer:string_of_int
            )

        );

    "returns the maximum number of arguments of any print statement " ^
    "within any subexpression of a statement" >::
      (fun _ ->
        let statement = CompoundStatement (
          Assignment ("a", BinaryExpression (Number (5), Plus, Number (3))),
          CompoundStatement (
            Assignment (
              "b",
              StatementThenExpression (
                Print [
                  Identifier ("a");
                  BinaryExpression (Identifier ("a"), Minus, Number (1))
                ],
                BinaryExpression (Number (10), Times, Identifier ("a"))
              )
            ),
            Print [Identifier ("b")]
          )
        ) in
          (
            assert_equal
              2
              (max_args statement)
              ~printer:string_of_int
          )

      )
  ]

  let _ = run_test_tt_main tests
