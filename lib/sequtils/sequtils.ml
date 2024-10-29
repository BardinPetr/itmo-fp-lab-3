let rec stdin_dispenser parser =
  try
    match read_line () |> parser with
    | None ->
        print_string "Invalid input format. Please retry\n";
        stdin_dispenser parser
    | x -> x
  with End_of_file -> None

let nzip (seq_list : 'a Seq.t list) : 'a list Seq.t =
  List.fold_left
    (fun acc seq ->
      Seq.map2 (fun acci seqi -> List.append acci [ seqi ]) acc seq)
    (seq_list |> List.hd |> Seq.map (fun i -> [ i ]))
    (seq_list |> List.tl)

let sliding_window n seq =
  let open Seq in
  ints 0 |> take n |> map (fun i -> drop i seq) |> List.of_seq |> nzip
