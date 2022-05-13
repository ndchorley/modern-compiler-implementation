open Grammar

exception Todo

let max_args (statement: statement) =
  match statement with
  | Print expressions -> List.length expressions
  | Assignment (_, _) -> 0
  | CompoundStatement (_, _) -> raise Todo
