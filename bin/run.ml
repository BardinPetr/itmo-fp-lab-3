let f1 l =
  List.fold_left (fun x (ia, ib) -> x +. ia +. ib) 0. l |> string_of_float

let f2 l =
  List.fold_left (fun x (ia, ib) -> x *. ia *. ib) 1. l |> string_of_float

let function_defs = [ (f1, 2); (f2, 3); (f1, 5) ]

let main step _ =
  Printf.printf "! %f" step;
  let input = Input.main_input_stream in
  let min_window_size =
    List.fold_left (fun acc (_, i) -> min i acc) max_int function_defs
  in
  function_defs
  |> List.map (fun (f, sz) ->
         Sequtils.sliding_window sz input
         (* apply function over all windows *)
         |> Seq.map (fun i -> Some (f i))
         (* add None-window-result paddings
            so there won't be sync problems when doing zip *)
         |> Seq.append
              (Seq.repeat None |> Seq.take (max 0 (sz - min_window_size))))
  (* synchronized seq could be merged now and then flattened in round-robin fashion*)
  |> Sequtils.nzip
  |> Seq.flat_map List.to_seq
  |> Seq.filter_map Fun.id
  (* print out only valid results *)
  |> Seq.iter (Printf.printf "\n->\n%s\n\n")
