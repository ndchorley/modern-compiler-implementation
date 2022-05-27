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
      )
  ]

  let _ = run_test_tt_main tests
