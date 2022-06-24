open Grammar
open Stringutils

let value_for name table =
  (snd
    (List.find
      (fun name_and_value -> (fst name_and_value = name))
      table
    )
  )

let evaluate table expression =
  match expression with
  | Number (value) -> value
  | Identifier (name) -> value_for name table
  | _ -> 0

let rec interpret_statement table statement =
  match statement with
  | Print expressions ->
      let output =
        expressions
          |> List.map (evaluate table)
          |> List.map string_of_int
          |> join " " in
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
