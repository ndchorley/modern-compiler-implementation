let alternate_strings_with_separators strings separator =
  (Seq.interleave
    (List.to_seq strings)
    ((Seq.repeat separator) |> Seq.take (List.length strings - 1))
  )

let join strings separator =
  match strings with
  | [] -> ""
  | _ ->
    Seq.fold_left
      String.cat
      ""
      (alternate_strings_with_separators strings separator)
