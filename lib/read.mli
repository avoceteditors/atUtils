
(** [read_data] type is an algebraic data type used to collect
    data on a Line of text read from the file or an individual
    character read from the Line *)
type read_data = 
   | Line of string * int * char list * int
   | Char of string * int * int * char * string


(** [print] takes a Line list or a Char list and prints the
    contets to stdout. It is mainly used internally by the
    [atutils] command-line utility to show what information
    the package sends on to lexers.*)
val print : read_data list -> unit

(** [read_string] takes an arbitrary string and returns a Line
    list of its content.*)
val read_string : string -> read_data list

(** [read_file] takes an arbitrary filename and returns a Line
    list of its content. *)
val read_file : string -> read_data list

(** [inread_string] takes an arbitrary string and returns a Char
    list of its content. *)
val inread_string : string -> read_data list
