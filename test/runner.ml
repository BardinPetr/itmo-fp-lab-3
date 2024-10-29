open Alcotest

let test_in =
  List.to_seq
    [ (0.0, 0.0); (1.571, 1.0); (3.142, 0.0); (4.712, -1.0); (12.568, 0.0) ]

let test_out_1 =
  [
    [ 0.000; 0.637; 1.273 ];
    [ 1.000; 0.363; -0.273 ];
    [ 0.000; -0.637; -1.274 ];
    [ -1.000; -0.873; -0.745; -0.618; -0.491; -0.364; -0.236; -0.109; 0.018 ];
  ]

let test_out_2 =
  [
    [ 0.000; 0.973; 0.841; 0.120; -0.674; -1.026 ];
    [
      1.000;
      0.373;
      -0.280;
      -0.915;
      -1.486;
      -1.950;
      -2.262;
      -2.378;
      -2.254;
      -1.845;
      -1.107;
      0.004;
    ];
  ]

let method_1 =
  ( "linear",
    Solution.make_interpolation_runner "Linear interpolation"
      Interp.linear_interpolate,
    2 )

let method_2 =
  ( "lagrange4",
    Solution.make_interpolation_runner "Lagrange interpolation (4pt)"
      Interp.lagrange_interpolate,
    4 )

let test_runner sel_method =
  test_in
  |> Solution.runner 1.0 [ sel_method ]
  |> Seq.map (fun (_, _, _, seq_pts) ->
         seq_pts |> Seq.map (fun (_, y) -> y) |> List.of_seq)
  |> List.of_seq

let gen_main_test test_method test_out () =
  let testable = list (list (float 0.001)) in
  let out = test_runner test_method in
  check testable "Output" test_out out

let () =
  Utils.run_with_save_report "Lab3" "Lab3"
    (Sys.getenv_opt "REPORT_PATH")
    [
      ( "Golden",
        [
          test_case "Linear golden test" `Quick
            (gen_main_test method_1 test_out_1);
          test_case "Lagrange golden test" `Quick
            (gen_main_test method_2 test_out_2);
        ] );
    ]
