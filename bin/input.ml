type 'a stream = Nil | Cons of 'a * 'a stream Lazy.t

(** [next_pair] reads next line from stdin, @returns Some(float, float) 
    if it is correct, if not - retries, if EOF - None *)
let rec next_pair () =
  try
    match
      read_line ()
      |> String.trim
      |> String.split_on_char ' '
      |> List.map float_of_string_opt
    with
    | [ Some x; Some y ] -> Some (x, y)
    | _ ->
        print_string "Invalid input format. Please retry\n";
        next_pair ()
  with End_of_file -> None

(** [input_stream] is a infinite stream (untill EOF) of parsed input data lines *)
let rec input_stream () =
  lazy
    (match next_pair () with
    | Some (x, y) -> Cons ((x, y), input_stream ())
    | None -> Nil)
