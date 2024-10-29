(** [linear_interpolate arr] is a function f(x) which is linear fit function for
    two point array [arr] *)
let linear_interpolate = function
  | [ (x0, y0); (x1, y1) ] ->
      fun x -> y0 +. ((x -. x0) *. (y1 -. y0) /. (x1 -. x0))
  | _ -> failwith "Invalid source points for method"
