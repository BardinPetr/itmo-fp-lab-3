(** [linear_interpolate arr] is a function f(x) which is linear fit function for
    two point array [arr] *)
let linear_interpolate = function
  | [ (x0, y0); (x1, y1) ] ->
      fun x -> y0 +. ((x -. x0) *. (y1 -. y0) /. (x1 -. x0))
  | _ -> failwith "Invalid source points for method"

(** [lagrange_interpolate data] is a function f(x) which implements lagrangian
    interpolation polynomial for two point array [arr] *)
let lagrange_interpolate data =
  let n = List.length data in
  if n < 2 then failwith "Not enough points";
  let x_arr, y_arr = data |> List.split in
  let x_seq = x_arr |> List.to_seq in
  fun x ->
    y_arr
    |> List.to_seq
    |> Seq.mapi (fun i yi ->
           let xi = List.nth x_arr i in
           yi
           *. (x_seq
              |> Seq.mapi (fun j xj ->
                     if i != j then
                       (x -. xj) /. (xi -. xj)
                     else
                       1.)
              |> Seq.fold_left ( *. ) 1.))
    |> Seq.fold_left ( +. ) 0.
