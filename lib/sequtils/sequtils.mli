val stdin_dispenser : (string -> 'a option) -> 'a option

val nzip : 'a Seq.t list -> 'a list Seq.t

val sliding_window : (int -> 'a Seq.t -> 'a list Seq.t)
