val stdin_dispenser : (string -> 'a option) -> 'a option

val sliding_window : (int -> 'a Seq.t -> 'a list Seq.t)
