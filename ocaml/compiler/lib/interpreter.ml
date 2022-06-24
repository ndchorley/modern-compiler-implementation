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

let interpret_statement table statement =
  match statement with
  | Print expressions ->
      let output =
        expressions
          |> List.map (evaluate table)
          |> List.map string_of_int
          |> join " " in
        (table, Some (output))
  | _ -> (table, None)

let interpret program write_line =
  let table = [] in
    match (interpret_statement table program) with
    | (_, Some(output)) -> write_line output
    | _ -> ()
