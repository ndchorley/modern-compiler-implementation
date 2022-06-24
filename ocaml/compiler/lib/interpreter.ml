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

let interpret program write_line =
  match program with
  | Print expressions ->
      expressions
      |> List.map
          (fun expression -> string_of_int (evaluate [] expression))
      |> join " "
      |> write_line
  | _ -> ()
