open Grammar

let value_for name table =
  (snd
    (List.find
      (fun name_and_value -> (fst name_and_value = name))
      table
    )
  )

let rec evaluate table expression =
  match expression with
  | Number (value) -> value
  | Identifier (name) -> value_for name table
  | BinaryExpression (left, operator, right) -> (
      let left_value = evaluate table left in
      let right_value = evaluate table right in
        match operator with
        | Plus -> left_value + right_value
        | Minus -> left_value - right_value
        | Times -> left_value * right_value
        | Divide -> left_value / right_value
    )
  | StatementThenExpression (statement, expression) -> (
      let new_table_and_output = interpret_statement table statement in
      let new_table = (fst new_table_and_output) in
        evaluate new_table expression
    )
and
interpret_statement table statement =
  match statement with
  | Print expressions ->
      let output =
        expressions
          |> List.map (evaluate table)
          |> List.map string_of_int
          |> String.concat " "
          |> (fun line -> line ^ "\n") in
        (table, Some (output))
  | CompoundStatement (first, second) ->
      let first_result = interpret_statement table first in
      let new_table = (fst first_result) in
        (interpret_statement new_table second)
  | Assignment (identifier, expression) ->
      let value = evaluate table expression in
      let new_table = (identifier, value) :: table in
        (new_table, None)

let interpret program write_line =
  let table = [] in
    match (interpret_statement table program) with
    | (_, Some(output)) -> write_line output
    | _ -> ()
