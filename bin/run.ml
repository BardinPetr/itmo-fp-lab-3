let main step method_names =
  let function_defs =
    [
      ( "linear",
        Solution.make_interpolation_runner "Linear interpolation"
          Interp.linear_interpolate,
        2 );
      ( "lagrange3",
        Solution.make_interpolation_runner "Lagrange interpolation (3pt)"
          Interp.lagrange_interpolate,
        3 );
      ( "lagrange4",
        Solution.make_interpolation_runner "Lagrange interpolation (4pt)"
          Interp.lagrange_interpolate,
        4 );
    ]
  in
  let methods =
    function_defs |> List.filter (fun (tag, _, _) -> List.mem tag method_names)
  in
  Input.main_input_stream
  |> Solution.runner step methods
  |> Seq.map (fun (name, _, _, pts) -> Output.print_table name pts)
  |> Seq.iter print_string
