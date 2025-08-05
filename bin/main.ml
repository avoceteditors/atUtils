open Core

let prefix = "ATUTILS"
let level = Atutils.Log.TRACE

let trace (msg: string) =
   Atutils.Log.trace level prefix msg

let debug (msg: string) =
   Atutils.Log.debug level prefix msg

let info (msg: string) =
   Atutils.Log.info level prefix msg

let warn (msg: string) =
   Atutils.Log.warn level prefix msg

let error (msg: string) = 
   Atutils.Log.error level prefix msg

let fatal (msg: string) =
   Atutils.Log.fatal level prefix msg

   (*
let prog = "atUtils"

let verbose_flag = 
   Command.Param.flag "-v" ( Command.Param.optional_with_default false Command.Param.bool)
   ~doc: "Test"

let version =
   Command.basic
      ~summary:"Version cmd"
      Command.Let_syntax.(
         let%map_open 
            verbose = verbose_flag 
         in
         fun () ->
            if verbose then (
               Printf.printf "%s - The Avocet Tools Utilities Library\n" prog ;
               Printf.printf " Kenneth P. J. Dyer <kenneth@avoceteditors.com>\n" ;
               Printf.printf " Avocet Editorial Consulting\n" ;
               Printf.printf " Version %s\n\n" Atutils.Info.version)
            else Printf.printf "%s - version %s\n\n" prog Atutils.Info.version
      ):
      *)

let logging =
   Command.basic
      ~summary:"runs through the default logging commands to stderr to show how atUtils.Log renders output"
      (Command.Param.return (
         fun () ->
            trace "Testing trace logging message" ;
            debug "Testing debug logging message" ;
            info  "Testing info  logging message" ; 
            warn  "Testing warn  logging message" ;
            error "Testing error logging message" ;
            fatal "Testing fatal logging message" ;
            ()
      ))

let line_read =
   Command.basic
   ~summary: "reads the given string and prints the lines it finds to stdout"
   (
      Command.Param.(
         map (anon ("input" %: string))
         ~f:(fun input () -> 
            let lns = Atutils.Read.read_string input in
            Atutils.Read.print lns ;
            ()
         )
      )
   )

let char_read =
   Command.basic
   ~summary: "reads the given string and prints the characters it finds to stdout"
   (
      Command.Param.(
         map (anon ("input" %: string))
         ~f:(fun input () ->
            let chs = Atutils.Read.inread_string input in
            Atutils.Read.print chs ;
            ()
         )
      )
   )

let file_read =
   Command.basic
   ~summary: "reads the given file and prints the lines it finds to stdout"
   (
      Command.Param.(
         map (anon ("file" %: string))
         ~f:(fun file () ->
            let chs = Atutils.Read.read_file file in
            Atutils.Read.print chs ;
            ()
         )
      )
   )

let read =
   Command.group
      ~summary:"reads an arbitrary set of lines, characters, or files and prints its findings to stdout"
      [
         ("line", line_read);
         ("char", char_read);
         ("file", file_read);
      ]
let () = 
   Command.group 
      ~summary:"Avocet Tools Utilities Library"
      [
         ("log", logging);
         ("read", read);
      ] |> Command_unix.run ~version:"0.1.1"
