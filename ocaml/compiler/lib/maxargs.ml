open Grammar

exception Todo

let rec max_args (statement: statement) =
  match statement with
  | Print expressions -> List.length expressions
  | Assignment (_, expression) -> (
      match expression with
      | StatementThenExpression (statement, _) -> max_args statement
      | _ -> 0
    )
  | CompoundStatement (_, _) -> raise Todo
