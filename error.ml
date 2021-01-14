
type locator = string * int * int * int * int
    (* nom du fichier, ou "";
       première ligne,
       première colonne,
       dernière ligne,
       dernière colonne.
     *)

let sup_locator (file, line1, col1, _, _) (file', _, _, line2, col2) =
  (if file="" then file' else file),
  line1, col1, line2, col2

type hlocator = string * int * int

let loc_start (file, line1, col1, _, _) = (file, line1, col1)
let loc_end (file, _, _, line2, col2) = (file, line2, col2)

let prerr_locator (file, line1, col1, line2, col2) =
  if file<>"" then
    begin
      prerr_string file;
      prerr_string ", line";
      if line1<>line2 then prerr_string "s";
      prerr_string " ";
      prerr_int line1;
      if col1<>0 then
        begin
          prerr_string "("; prerr_int col1; prerr_string ")"
        end;
      if line1<>line2 || col1<>col2 then
        begin
          prerr_string "-";
          prerr_int line2;
          if col2<>0 then
            begin
              prerr_string "(";
              prerr_int col2;
              prerr_string ")"
            end
        end
    end

let prerr_loc loc = match loc with
  | Some l ->
     prerr_locator l;
     prerr_string ": "
  | _ -> ()
       
let warning loc msg =
  prerr_string "parser: ";
  prerr_loc loc;
  prerr_endline msg

let error_count = ref 0
let error_count_max = 10000
                    
let fatal loc msg =
  warning loc msg; exit 10
  
let flush_error () =
  if !error_count>=error_count_max then
    fatal None "Too many errors: quit"
  
let error loc msg =
  error_count := !error_count + 1;
  warning loc msg;
  if !error_count>=error_count_max then
    fatal loc "Too many errors: quit"
  
let gensym_count = ref 0

let gensym prefix =
  incr gensym_count;
  let s = string_of_int (!gensym_count) in
  prefix ^ s
