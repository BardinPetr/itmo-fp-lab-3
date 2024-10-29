open Cmdliner

let step_t =
  let doc =
    "The float step value for points generator when evaluating interpolation"
  in
  Arg.(value & opt float 1.0 & info [ "s"; "step" ] ~doc)

let methods = [ "linear"; "lagrange3"; "lagrange4" ]

let methods_t =
  let doc =
    "Choose one or more methods to use from: " ^ String.concat "," methods
  in
  Arg.(
    value
    & opt_all (enum (List.map (fun m -> (m, m)) methods)) []
    & info [ "m" ] ~doc)

let runner step methods_list =
  if List.is_empty methods_list then
    failwith "No methods selected"
  else
    let methods_set = List.sort_uniq Stdlib.compare methods_list in
    Run.main step methods_set

let app_t = Term.(const runner $ step_t $ methods_t)
let cmd = Cmd.v (Cmd.info "Interpolation app") app_t
let () = exit (Cmd.eval cmd)
