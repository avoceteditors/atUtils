
type read_data = 
   | Line of string * int * char list * int
   | Char of string * int * int * char * string

let rec print = function
   | [] -> ()
   | Line (file, lineno, chs, indent) :: lns ->
         let text = String.of_seq (List.to_seq chs) in
         Printf.printf "%s:%d(indent=%d) - %S\n" file lineno indent text;
         print lns
   | Char (file, lineno, charno, _, text) :: chs ->
         Printf.printf "%s:%d.%d - %S\n" file lineno charno text;
         print chs

let rec count_indent (chs : char list) (indent : int) =
   match chs with 
   | [] -> -1
   | ' ' :: rchs -> count_indent rchs (indent + 1)
   | '\n' :: rchs -> count_indent rchs indent
   | _ -> indent

let mk_char (file: string) (lineno : int) (charno : int) (ch : char) =
   let str = String.make 1 ch in
   Char(file, lineno, charno, ch, str)

let mk_line (file: string) (chs: char list) (lineno: int) =
   let indent = count_indent chs 0 in
   (*let lchs = match chs with
   | '\n' :: nchs -> nchs
   | _ -> chs in*)
   if indent = -1 then
      Line(file, lineno, [], indent)
   else
      Line(file, lineno, chs, indent)

let rec read_lines (file: string) (chs: char list)  (line : char list) (lines: read_data list) (lineno: int) =
   match chs with
   | [] -> 
         let ln = mk_line file line lineno in
         let lns = lines @ [ln] in
         lns
   | ch :: tchs ->
         match ch with
         | '\n' ->
               let dln = mk_line file line lineno in
               let nlns = lines @ [dln] in
               let nl = lineno + 1 in
               read_lines file tchs [] nlns nl
         | _ ->
               let ln = line @ [ch] in
               read_lines file tchs ln lines lineno

let rec inread_line_chars (file : string) (lineno: int) (charno : int) (chs : char list) (chars : read_data list) =
   match chs with
   | ch :: nchs ->
         let dch = mk_char file lineno charno ch in
         let ncharno = charno + 1 in
         let nchars = chars @ [dch] in
         inread_line_chars file lineno ncharno nchs nchars
   | _ -> chars

let rec inread_lines (lines : read_data list) (chars : read_data list) =
   match lines with
   | Line (file, lineno, chs, _) :: lns ->
         let nchars = inread_line_chars file lineno 1 chs chars in
         inread_lines lns nchars
   | _ -> chars

let read_string (text: string) : read_data list =
   let chs : char list = text |> String.to_seq |> List.of_seq in
   read_lines "STDIN" chs [] [] 1

let read_file (file: string) : read_data list =
   let con = In_channel.with_open_bin file In_channel.input_all in
   let chs : char list = con |> String.to_seq |> List.of_seq in
   read_lines file chs [] [] 1

let inread_string (text: string) : read_data list =
   let lns = read_string text in
   inread_lines  lns [] 

