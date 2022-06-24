open Grammar

let string_of expression =
  match expression with
  | Number (value) -> string_of_int value
  | _ -> ""

let interpret program write_line =
  match program with
  | Print expressions ->
    expressions
    |> List.hd
    |> string_of
    |> write_line
  | _ -> ()
