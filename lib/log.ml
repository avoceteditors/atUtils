(** [Level] indicates the logging level *)
type level = 
   | TRACE 
   | DEBUG
   | INFO
   | WARN
   | ERROR
   | FATAL
   | QUIET

(** [get_name lvl: level] Returns a string representation of the function *)
let get_name = function
   | TRACE -> "TRACE"
   | DEBUG -> "DEBUG"
   | INFO ->  "INFOR"
   | WARN ->  "WARNI"
   | ERROR -> "ERROR"
   | _ -> "FATAL"

let get_attrs = function
   | TRACE -> [ANSITerminal.Bold; ANSITerminal.Foreground ANSITerminal.Black; ANSITerminal.Background ANSITerminal.White]
   | DEBUG -> [ANSITerminal.Bold; ANSITerminal.Foreground ANSITerminal.White; ANSITerminal.Background ANSITerminal.Cyan]
   | INFO -> [ANSITerminal.Bold; ANSITerminal.Foreground ANSITerminal.Yellow; ANSITerminal.Background ANSITerminal.Green]
   | WARN -> [ANSITerminal.Bold; ANSITerminal.Foreground ANSITerminal.Red; ANSITerminal.Background ANSITerminal.Yellow]
   | ERROR -> [ANSITerminal.Bold; ANSITerminal.Foreground ANSITerminal.White; ANSITerminal.Background ANSITerminal.Red]
   | _ -> [ANSITerminal.Bold; ANSITerminal.Background ANSITerminal.Magenta]

let get_label (lvl: level) (prefix: string) : string =
   let attrs = get_attrs lvl in
   let name = get_name lvl in
   ANSITerminal.sprintf attrs " %s:%s " name prefix

let trace_log (prefix: string) (msg:string) : unit =
   let label = get_label TRACE prefix in
   Printf.eprintf "%s - %s\n" label msg ;
   ()

let trace (min_level: level) (prefix: string) (msg: string) : unit =
   match min_level with
   | TRACE -> trace_log prefix msg
   | _ -> ()


let debug_log (prefix: string) (msg:string) : unit =
   let label = get_label DEBUG prefix in
   Printf.eprintf "%s - %s\n" label msg ;
   ()

let debug (min_level: level) (prefix: string) (msg: string) : unit =
   match min_level with
   | TRACE -> debug_log prefix msg
   | DEBUG -> debug_log prefix msg
   | _ -> ()
 
let info_log (prefix: string) (msg:string) : unit =
   let label = get_label INFO prefix in
   Printf.eprintf "%s - %s\n" label msg ;
   ()

let info (min_level: level) (prefix: string) (msg: string) : unit =
   match min_level with
   | TRACE -> info_log prefix msg
   | DEBUG -> info_log prefix msg
   | INFO  -> info_log prefix msg
   | _ -> ()

let warn_log (prefix: string) (msg: string) : unit =
   let label = get_label WARN prefix in
   Printf.eprintf "%s - %s\n" label msg ;
   ()

let warn (min_level: level) (prefix: string) (msg: string) : unit =
   match min_level with
   | TRACE -> warn_log prefix msg
   | DEBUG -> warn_log prefix msg
   | INFO  -> warn_log prefix msg
   | WARN -> warn_log prefix msg
   | _ -> ()
 
let error_log (prefix: string) (msg: string) : unit =
   let label = get_label ERROR prefix in
   Printf.eprintf "%s - %s\n" label msg ;
   ()

let error (min_level: level) (prefix: string) (msg: string) : unit =
   match min_level with
   | TRACE -> error_log prefix msg
   | DEBUG -> error_log prefix msg
   | INFO  -> error_log prefix msg
   | WARN -> error_log prefix msg
   | ERROR -> error_log prefix msg
   | _ -> ()
 
let fatal_log (prefix: string) (msg: string) : unit =
   let label = get_label FATAL prefix in
   Printf.eprintf "%s - %s\n" label msg ;
   ()

let fatal (min_level: level) (prefix: string) (msg: string) : unit =
   match min_level with
   | TRACE -> fatal_log prefix msg
   | DEBUG -> fatal_log prefix msg
   | INFO  -> fatal_log prefix msg
   | WARN -> fatal_log prefix msg
   | ERROR -> fatal_log prefix msg
   | FATAL -> fatal_log prefix msg
   | _ -> ()
