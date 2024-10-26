open Printf

(** [print_table name data] prints header with [name] and two-row table for the
    pair seq [data] *)
let print_table name data =
  printf "\nMethod: %s\n" name;

  let x, y = Seq.split data in

  [ ("X", x); ("Y", y) ]
  |> List.iter (fun (name, seq) ->
         printf "%s | " name;
         seq |> Seq.iter (printf "%10.2f |");
         print_newline ())
