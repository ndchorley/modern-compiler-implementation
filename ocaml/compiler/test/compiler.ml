open OUnit2
open Compiler.Grammar
open Compiler.Maxargs

 let tests =
   "max_args" >:::
  ["returns the number of arguments to a print statement" >::
    (fun _ ->
      assert_equal
        2
        (max_args (Print [Number (1); Number (2)])))
  ]

  let _ = run_test_tt_main tests
