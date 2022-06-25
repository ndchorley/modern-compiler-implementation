open OUnit2
open Compiler.Interpreter
open Compiler.Grammar

let tests =
  "interpret" >::: [
    "prints a single numeric expression" >::
      (fun _ ->
        let output = ref "" in
        let write_line line = output := !output ^ line ^ "\n" in

        let _ =
          interpret (Print [Number (4)]) write_line in

          assert_equal
            "4\n"
            !output
            ~printer:Fun.id
      );

    "prints multiple numeric expressions" >::
      (fun _ ->
        let output = ref "" in
        let write_line line = output := !output ^ line ^ "\n" in

        let _ =
          interpret (Print [Number (1); Number (2); Number (3)]) write_line in

          assert_equal
            "1 2 3\n"
            !output
            ~printer:Fun.id
      );

    "prints the value of an identifier" >::
      (fun _ ->
        let output = ref "" in
        let write_line line = output := !output ^ line ^ "\n" in
        let program =
          CompoundStatement (
            Assignment ("a", Number (1)),
            Print [Identifier ("a")]
          ) in

        let _ = interpret program write_line in

          assert_equal
            "1\n"
            !output
            ~printer:Fun.id
      );

    "evaluates binary expressions" >::
      (fun _ ->
        let output = ref "" in
        let write_line line = output := !output ^ line ^ "\n" in
        let program =
          Print [
            BinaryExpression (Number (0), Plus, Number (1));
            BinaryExpression (Number (3), Minus, Number (1));
            BinaryExpression (Number (3), Times, Number (1));
            BinaryExpression (Number (16), Divide, Number (4))
          ] in

        let _ = interpret program write_line in

          assert_equal
            "1 2 3 4\n"
            !output
            ~printer:Fun.id
      )
  ]

let _ = run_test_tt_main tests
