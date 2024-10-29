let f1 l = List.fold_left (fun (a, b) (ia, ib) -> (a +. ia, b +. ib)) (0., 0.) l
let f2 l = List.fold_left (fun (a, b) (ia, ib) -> (a *. ia, b *. ib)) (1., 1.) l
let function_defs = [ (f1, 3); (f2, 5) ]

(* let main step _ =
   Printf.printf "! %f" step;
   let input = Input.main_input_stream in
   function_defs
   |> List.map (fun (f, sz) -> f (Sequtils.sliding_window sz input))
   |> List.map (fun (a, b) -> Printf.sprintf "(%f,%f)" a b)
   |> String.concat ","
   |> fun i -> "[" ^ i ^ "]\n" |> print_string *)
