
(** [Level] indicates the logging level *)
type level = 
   | TRACE (** TRACE is used in trace logging *)
   | DEBUG (** DEBUG is used in debug logging *)
   | INFO
   | WARN
   | ERROR
   | FATAL
   | QUIET

(** [trace] logs a trace message, if the given level is set to
    TRACE *)
val trace : level -> string -> string -> unit

(** [debug] logs a debug message, if the given level is set to
    TRACE *)
val debug : level -> string -> string -> unit

(** [info] logs a info message, if the given level is set to
    TRACE *)
val info : level -> string -> string -> unit


(** [warn] logs a warn message, if the given level is set to
    TRACE *)
val warn : level -> string -> string -> unit

(** [error] logs a error message, if the given level is set to
    TRACE *)
val error : level -> string -> string -> unit

(** [fatal] logs a fatal message, if the given level is set to
    TRACE *)
val fatal : level -> string -> string -> unit



