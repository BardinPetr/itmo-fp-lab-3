(* let main step = Printf.printf "! %f" step *)
let main step methods = Printf.printf "! %f %s" step (String.concat " " methods)

(* open Input

   let () =
     let stream = input_stream () in

     let rec print_stream = function
       | Cons ((x, y), tl) ->
           Printf.printf "(%f, %f)\n" x y;

           print_stream (Lazy.force tl)
       | Nil -> ()
     in

     print_stream (Lazy.force stream) *)
