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

let rec evaluate state expression =
  match expression with
  | Number (value) ->
      {value=value; state=state}
  | Identifier (name) ->
      {value=(value_for name state.table); state=state}
  | BinaryExpression (left, operator, right) -> (
      let left_result = evaluate state left in
      let right_result = evaluate state right in
        {value=(
          evaluate_binary_expression
            operator left_result.value right_result.value
          );
          state=state
        }
    )
  | StatementThenExpression (statement, expression) -> (
      let new_table_and_output = interpret_statement state statement in
      let new_table = (fst new_table_and_output) in
      let new_output = (snd new_table_and_output) in
        { (evaluate new_table expression)
          with state={output=new_output; table=state.table}}
    )
and
interpret_statement state statement =
  match statement with
  | Print expressions ->
      let results = List.map (evaluate state) expressions in
      let output =
        results
        |> List.map (fun result -> string_of_int result.value)
        |> String.concat " "
        |> (fun line -> line ^ "\n") in
        state, Some (output)
  | CompoundStatement (first, second) ->
      let first_result = interpret_statement state first in
      let new_table = (fst first_result) in
        (interpret_statement new_table second)
  | Assignment (identifier, expression) ->
      let result = evaluate state expression in
      let new_table = (identifier, result.value) :: state.table in
        ({state with table=new_table}, None)

let interpret program write =
  let state = {table=[]; output=None} in
    match (interpret_statement state program) with
    | (_, Some(output)) -> write output
    | _ -> ()
