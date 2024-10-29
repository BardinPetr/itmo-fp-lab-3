open Printf

(** [print_table name data] creates string with two-row table for the pair seq
    [data] and a header with [name]*)
let print_table name data =
  let x, y = Seq.split data in
  let data_str =
    [ ("X", x); ("Y", y) ]
    |> List.map (fun (name, seq) ->
           sprintf "%s | %s" name
             (seq
             |> Seq.map (sprintf "%5.2f")
             |> List.of_seq
             |> String.concat " |"))
    |> String.concat "\n"
  in
  sprintf "\nMethod: %s\n%s\n" name data_str
