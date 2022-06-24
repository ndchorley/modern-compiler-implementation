open Grammar
open Stringutils

let evaluate expression =
  match expression with
  | Number (value) -> value
  | _ -> 0

let interpret program write_line =
  match program with
  | Print expressions ->
      expressions
      |> List.map (fun expression -> string_of_int (evaluate expression))
      |> join " "
      |> write_line
  | _ -> ()
