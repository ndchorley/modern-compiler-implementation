open Grammar
open Math 

let rec max_args (statement) =
  match statement with
  | Print expressions -> (
      let args_for_expressions = List.map args_for expressions in
      (max (List.length expressions) (max_of args_for_expressions))
    )
  | Assignment (_, expression) -> args_for expression
  | CompoundStatement (left, right) -> (max (max_args left) (max_args right))
  and args_for (expression) =
    match expression with
    | StatementThenExpression (statement, _) -> max_args statement
    | _ -> 0
