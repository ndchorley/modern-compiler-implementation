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
  let table = [] in
    match program with
    | Print expressions ->
        expressions
        |> List.map
            (fun expression ->
              expression |> evaluate table |> string_of_int
            )
        |> join " "
        |> write_line
    | _ -> ()
