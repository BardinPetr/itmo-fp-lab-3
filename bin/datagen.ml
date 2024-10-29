(** [gen_range x_min x_max step] is a sequence of float values x in range
    [x_min] to [x_max] increased by [step]*)
let gen_range x_min x_max step =
  Seq.ints 0
  |> Seq.map (fun i -> x_min +. (step *. float_of_int i))
  |> Seq.take_while (fun i -> i <= x_max)

(** [apply_on_range x_seq func] is a sequence of pairs (x, y), where y =
    [func x] for each x from x_seq*)
let apply_on_range func x_seq = Seq.map (fun i -> (i, func i)) x_seq
