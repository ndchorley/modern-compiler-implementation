open Grammar

exception Todo

let rec max_args (statement: statement) =
  match statement with
  | Print expressions -> (
      let args_for_expressions = List.map args_for expressions in
      let max_args_for_expressions =
        List.fold_left max 0 args_for_expressions in
      (max (List.length expressions) max_args_for_expressions)
    )
  | Assignment (_, expression) -> args_for expression
  | CompoundStatement (_, _) -> raise Todo
  and args_for (expression: expression) =
    match expression with
    | StatementThenExpression (statement, _) -> max_args statement
    | _ -> 0
