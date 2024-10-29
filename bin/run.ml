(** [make_interpolation_runner name make_interpolator steps src_data] is a
    function that wraps running interpolation, applying interpolated function to
    test range and building output table. Function returns result string.
    [make_interpolator] is a function that returns f(x) interpolation function
    by input points *)
let make_interpolation_runner name make_interpolator step src_data =
  let min_x, _ = List.hd src_data in
  let max_x, _ = List.nth src_data (List.length src_data - 1) in
  Datagen.gen_range min_x max_x step
  |> Datagen.apply_on_range (make_interpolator src_data)
  |> Output.print_table name

(** [apply_windowed_interpolations step methods input] is main function that
    applies all selected interpolation methods over input *)
let apply_windowed_interpolations step methods input =
  let min_window_size =
    List.fold_left (fun acc (_, _, win) -> min win acc) max_int methods
  in
  methods
  |> List.map (fun (_, f, sz) ->
         (* for each function make independent steram of sliding windows*)
         Sequtils.sliding_window sz input
         (* apply function over all windows *)
         |> Seq.map (fun data -> Some (f step data))
         (* add None-window-result paddings
            so there won't be sync problems when doing zip *)
         |> Seq.append
              (Seq.repeat None |> Seq.take (max 0 (sz - min_window_size))))

let main step method_names =
  let function_defs =
    [
      ( "linear",
        make_interpolation_runner "Linear interpolation (2pt)"
          Interp.linear_interpolate,
        2 );
    ]
  in
  let methods =
    function_defs |> List.filter (fun (tag, _, _) -> List.mem tag method_names)
  in
  Input.main_input_stream
  |> Seq.memoize
  |> apply_windowed_interpolations step methods
  (* synchronized seq could now be merged now and flattened in round-robin pattern *)
  |> Sequtils.nzip
  |> Seq.flat_map List.to_seq
  |> Seq.filter_map Fun.id
  (* print out only valid results *)
  |> Seq.iter (Printf.printf "%s\n")
