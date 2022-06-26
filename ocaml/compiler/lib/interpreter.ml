open Grammar

type state = {table: (string * int) list; output: string option}
type evalulation_result = {value: int; state: state}

let value_for name table =
    (List.find
      (fun name_and_value -> (fst name_and_value = name))
      table)
    |> snd

let evaluate_binary_expression operator left_operand right_operand =
  match operator with
  | Plus -> left_operand + right_operand
  | Minus -> left_operand - right_operand
  | Times -> left_operand * right_operand
  | Divide -> left_operand / right_operand

let rec evaluate table expression =
  match expression with
  | Number (value) ->
      {value=value; state={output=None; table=table}}
  | Identifier (name) ->
      {value=(value_for name table); state={output=None; table=table}}
  | BinaryExpression (left, operator, right) -> (
      let left_result = evaluate table left in
      let right_result = evaluate table right in
        {value=(
          evaluate_binary_expression
            operator left_result.value right_result.value
          );
          state={output=None; table=table}
        }
    )
  | StatementThenExpression (statement, expression) -> (
      let new_table_and_output = interpret_statement table statement in
      let new_table = (fst new_table_and_output) in
      let new_output = (snd new_table_and_output) in
        { (evaluate new_table expression)
          with state={output=new_output; table=table}}
    )
and
interpret_statement table statement =
  match statement with
  | Print expressions ->
      let results = List.map (evaluate table) expressions in
      let output =
        results
        |> List.map (fun result -> string_of_int result.value)
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
