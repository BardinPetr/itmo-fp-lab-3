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

(** [apply_on_range x_min x_max step func] is a sequence of pairs (x,y) where x
    is in range [x_min] to [x_max] increased by [step], and y is [func] applied
    to each x *)
let apply_on_range x_min x_max step func =
  Seq.ints 0
  |> Seq.map (fun i -> x_min +. (step *. float_of_int i))
  |> Seq.take_while (fun i -> i <= x_max)
  |> Seq.map (fun i -> (i, func i))
