open Grammar

exception Todo

let rec max_args (statement: statement) =
  match statement with
  | Print expressions -> List.length expressions
  | Assignment (_, expression) -> args_for expression
  | CompoundStatement (_, _) -> raise Todo
  and args_for (expression: expression) =
    match expression with
    | StatementThenExpression (statement, _) -> max_args statement
    | _ -> 0
