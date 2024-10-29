open Seq

(** [stdin_xy_dispenser] is dispenser for float pairs parsed from stdin lines. 
    @see stdin_dispenser. *)
let stdin_xy_dispenser () =
  Sequtils.stdin_dispenser (fun i ->
      match
        i
        |> String.trim
        |> String.split_on_char ' '
        |> List.map float_of_string_opt
      with
      | [ Some x; Some y ] -> Some (x, y)
      | _ -> None)

(** [main_input_stream] is a infinite stream (untill EOF) of parsed input data
    lines *)
let main_input_stream = stdin_xy_dispenser |> of_dispenser
