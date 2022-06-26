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
      let new_state = interpret_statement state statement in
        { (evaluate new_state expression)
          with state=new_state}
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
        {state with output=Some (output)}
  | CompoundStatement (first, second) ->
      let first_state = interpret_statement state first in
        (interpret_statement first_state second)
  | Assignment (identifier, expression) ->
      let result = evaluate state expression in
      let new_table = (identifier, result.value) :: state.table in
        {state with table=new_table}

let interpret program write =
  let initial_state = {table=[]; output=None} in
  let final_state = (interpret_statement initial_state program) in
    match final_state.output with
    | Some (output) -> write output
    | _ -> ()
