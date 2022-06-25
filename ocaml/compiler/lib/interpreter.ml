open Grammar

let value_for name table =
  (snd
    (List.find
      (fun name_and_value -> (fst name_and_value = name))
      table
    )
  )

type evalulation_result = {value: int}
let rec evaluate table expression =
  match expression with
  | Number (value) -> {value=value}
  | Identifier (name) -> {value=(value_for name table)}
  | BinaryExpression (left, operator, right) -> (
      let left_result = evaluate table left in
      let right_result = evaluate table right in
      let value = (
        match operator with
        | Plus -> left_result.value + right_result.value
        | Minus -> left_result.value - right_result.value
        | Times -> left_result.value * right_result.value
        | Divide -> left_result.value / right_result.value
      ) in
        {value=value}
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
          |> List.map
            (fun expression ->
              (evaluate table expression).value
            )
          |> List.map string_of_int
          |> String.concat " "
          |> (fun line -> line ^ "\n") in
        (table, Some (output))
  | CompoundStatement (first, second) ->
      let first_result = interpret_statement table first in
      let new_table = (fst first_result) in
        (interpret_statement new_table second)
  | Assignment (identifier, expression) ->
      let result = evaluate table expression in
      let new_table = (identifier, result.value) :: table in
        (new_table, None)

let interpret program write =
  let table = [] in
    match (interpret_statement table program) with
    | (_, Some(output)) -> write output
    | _ -> ()
