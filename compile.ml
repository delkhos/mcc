open CAST
open Genlab

type fun_env = int * int (* id * number of args *) 

type var_env = int * string (* level and adress value *)

let end_n = ref 0
let if_n = ref 0
let while_n = ref 0

type decl_env = 
  |FUN_ENV of fun_env
  |VAR_ENV of var_env

type env = (string*decl_env) list

exception GlobalVarAlreadyDeclared of env*Error.locator
exception RedefiningMainIsForbidden of env*Error.locator
exception TooManyArgumentsForMain of env*Error.locator
exception EmptyReturnOfNonVoidFunction of env*Error.locator
exception Key_Not_found of env*Error.locator
exception ErrorDuringFunctionCompiling of env*Error.locator
exception VarAlreadyDefinedAtSameLevel of env*Error.locator
exception VariableWithSameNameAsFunctionAlreadyDeclared of env*Error.locator
exception FunctionWithSameNameAsVariableAlreadyDeclared of env*Error.locator
exception UnboundVariable of env*Error.locator
exception UnboundFunction of env*Error.locator
exception IllegalRegisterArg

let empty_env = []

let rec add_key env key (value: decl_env) = 
  match env with
  |[] -> [(key,value)]
  |(k,v)::tl -> 
      if key=k then
        (k,value)::tl
      else
        (k,v):: add_key tl key value

let rec get_value_var (env_const: env) (env: env) key loc =
  match env with
  |[] -> raise (UnboundVariable (env_const,loc))
  |(k,v)::tl ->
      if key=k then
        match v with
        |FUN_ENV (_,_)-> raise (UnboundVariable (env_const,loc))
        |VAR_ENV (level,address)-> address
      else
        get_value_var env_const tl key loc

let rec get_value_func (env_const : env) ( env : env) key loc =
  match env with
  |[] -> raise (UnboundFunction (env_const,loc))
  |(k,v)::tl ->
      if key=k then
        match v with
        |VAR_ENV (_,_)-> raise (UnboundFunction (env_const,loc))
        |FUN_ENV (id,nargs)-> id
      else
        get_value_func env_const tl key loc


let rec is_in_environment_same_level env_const (env : env) key loc deepness =
  match env with
  |[] -> ()
  |(k, VAR_ENV (deep ,_ ))::tl ->
      if key=k  then (* ajouter test niveau et tester si une function avec même nom n'est pas déjà défini *)
        if deep=deepness then 
          raise ( VarAlreadyDefinedAtSameLevel (env_const,loc))
        else
          ()
      else
        is_in_environment_same_level env_const tl key loc deepness
  |(k, FUN_ENV ( _ ,_ ))::tl ->
      if key=k  then (* ajouter test niveau et tester si une function avec même nom n'est pas déjà défini *)
        raise ( VarAlreadyDefinedAtSameLevel (env_const,loc))
      else
        is_in_environment_same_level env_const tl key loc deepness

let rec func_is_in_environment env_const (env : env) key loc =
  match env with
  |[] -> (false,(-1))
  |(k, FUN_ENV (_,id))::tl ->
      if key=k then 
        if key = "main" then
            raise ( RedefiningMainIsForbidden (env_const,loc))
          else
            (true,id)

      else
        func_is_in_environment env_const tl key loc
  |(k, VAR_ENV (_,_))::tl ->
      if key=k then 
        raise ( VariableWithSameNameAsFunctionAlreadyDeclared (env_const,loc))
      else
        func_is_in_environment env_const tl key loc

let get_func_id (_,id) = id
let get_func_existence (existence,_) = existence

let p_0argf out func_name = Printf.fprintf out "\t\t%s\n" func_name
let p_1argf out func_name arg1 = Printf.fprintf out "\t\t%s    %s\n" func_name arg1
let p_2argf out func_name arg1 arg2 = Printf.fprintf out "\t\t%s    %s , %s\n" func_name arg1 arg2
let pushq arg1 out = p_1argf out "pushq" arg1
let popq arg1 out = p_1argf out "popq" arg1
let jmp arg1 out = p_1argf out "jmp" arg1
let je arg1 out = p_1argf out "je" arg1
let movq arg1 arg2 out = p_2argf out "movq" arg1 arg2
let movl arg1 arg2 out = p_2argf out "movl" arg1 arg2
let cmpl arg1 arg2 out = p_2argf out "cmpl" arg1 arg2
let addq arg1 arg2 out = p_2argf out "addq" arg1 arg2
let subq arg1 arg2 out = p_2argf out "subq" arg1 arg2
let ret out = p_0argf out "ret"

let p_register delta reg = 
  if delta=0 then
    Printf.sprintf "(%s)" reg 
  else
    Printf.sprintf "%d(%s)" delta reg 

let print_global_int out var_name = Printf.fprintf out "%s:\n\t\t.zero    4\n\n" var_name
let print_func out name id = Printf.fprintf out "%s%d:\n" name id
let print_label out name id = Printf.fprintf out "\t.%s%d:\n" name id
let get_label name id = Printf.sprintf ".%s%d" name id
let int_literal n = Printf.sprintf "$%d" n

let arg_register n_arg =
  match n_arg with
  |0 -> "%edi"
  |1 -> "%esi"
  |2 -> "%edx"
  |3 -> "%ecx"
  |4 -> "%r8d"
  |5 -> "%r9d"
  |_ -> raise ( IllegalRegisterArg )


let handle_args env args out = 
    let nb_args = List.length args in
    let to_sub = if nb_args >= 6 then 6 else nb_args in
    let to_sub_sizeofint = to_sub * 4 in
    let rec aux env args n rbp_deepness = 
      match args with
      |[] -> (rbp_deepness,env)
      |( CDECL (loc,name))::tl -> 
          let adress = match n with
                        |i when i<=5 -> p_register ((-4)*(i+1)) "%rbp"
                        |i -> p_register (8+8*(i-5)) "%rbp"
          in
          let new_env = begin is_in_environment_same_level env env name loc 1 ; add_key env name (VAR_ENV (1,adress)) end
          in
          let new_rbp_deepness = if n > 5 then rbp_deepness else (rbp_deepness-4) in
          begin
            if n < 5 then movl (arg_register n) adress out;
            aux new_env tl (n+1) new_rbp_deepness 
          end
      |_ -> Printf.printf "this case should never happen because syntax handles it" ; (rbp_deepness,env) 
    in
    subq (int_literal to_sub_sizeofint) "%rsp" out;
    aux env args 0 0
    (*addq to_sub_sizeofint "%rsp";*)
    
(* 
 * var deepness : 0 = global , 1 = function arg , 2+ block
 *)

(* penser à tester si il ne va pas y avoir du code inatteignable *)
let rec compile_expr env loc_expr result_destination out =
  let (loc,expr)=loc_expr in
  match expr with
  |VAR (name) -> movl (get_value_var env env name loc) result_destination out
  |_ -> ()



and handle_local_vars env vars var_deepness rbp_deepness = 
  let nb_args = List.length vars in
  let to_sub_sizeofint = nb_args * 4 in
  let rec aux env vars rbp_deepness = 
    match vars with
      |[] -> (rbp_deepness,env)
      |( CDECL (loc,name))::tl -> 
          let new_rbp_deepness = (rbp_deepness-4) in
          let adress = p_register new_rbp_deepness "%rbp" in
          let new_env = begin is_in_environment_same_level env env name loc var_deepness ; add_key env name (VAR_ENV (var_deepness,adress)) end in
          aux new_env tl new_rbp_deepness 
      |_ -> Printf.printf "this case should never happen because syntax handles it" ; (rbp_deepness,env) 
  in
  ( to_sub_sizeofint , aux env vars rbp_deepness)

and compile_block env var_deepness rbp_deepness vars (code_list : CAST.loc_code list) out : unit =
  let (to_sub_sizeofint, (new_rbp_deepness, block_env) ) = handle_local_vars env vars var_deepness rbp_deepness in
  let rec aux (code_list : CAST.loc_code list) env var_deepness rbp_deepness last_was_return =
    if last_was_return = false then
      match code_list with
      |[] -> ()
      |(hd_loc, hd_code)::tl ->
          compile_code env var_deepness rbp_deepness (hd_loc,hd_code) out;
          match hd_code with
                 |CRETURN o -> aux tl env var_deepness rbp_deepness true 
                 |_ -> aux tl env var_deepness rbp_deepness false 
    else
      ()
  in
  subq (int_literal to_sub_sizeofint) "%rsp" out;
  aux code_list block_env var_deepness new_rbp_deepness false;
  addq (int_literal to_sub_sizeofint) "%rsp" out


and compile_if loc_expr l_c_if l_c_else env var_deepness rbp_deepness out : unit =
  if_n := !if_n+1;
  compile_expr env loc_expr "%eax" out;
  cmpl "$0" "%eax" out;
  je (get_label "ELSE_BODY" !if_n) out;
  compile_code env var_deepness rbp_deepness l_c_if out;
  jmp (get_label "END_IF" !if_n) out;
  print_label out "ELSE_BODY" !if_n;
  compile_code env var_deepness rbp_deepness l_c_else out;
  print_label out "END_IF" !if_n
  


and compile_while env loc_expr loc_code var_deepness rbp_deepness out : unit =
  while_n := !while_n+1;
  jmp (get_label "WHILE_TEST" !while_n) out;
  print_label out "WHILE_BODY" !while_n;
  compile_code env var_deepness rbp_deepness loc_code out; 
  print_label out "WHILE_TEST" !while_n;
  compile_expr env loc_expr "%eax" out;
  cmpl "$0" "%eax" out;
  je (get_label "END_WHILE" !while_n) out;
  jmp (get_label "WHILE_BODY" !while_n) out;
  print_label out "END_WHILE" !while_n


and compile_return env loc_expr out : unit = 
  compile_expr env loc_expr "%eax" out;
  jmp (get_label "END" !end_n) out

and compile_code env var_deepness rbp_deepness loc_code out : unit =
  let (loc,code) = loc_code in
  match code with
  | CBLOCK (vars,code_list) -> compile_block env (var_deepness+1) rbp_deepness vars code_list out
  | CEXPR (loc_expr) -> compile_expr env loc_expr "%eax" out 
  | CIF (loc_expr,l_c_if,l_c_else) -> compile_if loc_expr l_c_if l_c_else env var_deepness rbp_deepness out 
  | CWHILE (loc_expr,l_c) -> compile_while env loc_expr l_c var_deepness rbp_deepness out 
  | CRETURN (loc_expr) -> match loc_expr with 
                          |None -> raise ( EmptyReturnOfNonVoidFunction (env,loc))
                          |Some le -> compile_return env le out
  


let compile_fun env name id args code out : unit =
    let (rbp_deepness,fun_env) =
      print_func out name id;
      pushq "%rbp" out;
      movq  "%rsp" "%rbp" out;
      handle_args env args out in
    (*args_begin ; str_code ;args_end ;*)
    (*handle_args env args;*)
    end_n := !end_n + 1 ;
    compile_code fun_env 1 rbp_deepness code out;
    print_label out "END" !end_n;
    movq  "%rbp" "%rsp" out;
    popq  "%rbp" out;
    ret out;
    Printf.fprintf out "\n" 


let compile out decl_list =
  let rec compile_global decl_list env =
    match decl_list with 
    |[] -> ()
    |hd::tl -> match hd with
        |CDECL (loc,name) -> 
            begin
              is_in_environment_same_level env env name loc 0;
              print_global_int out name;

              compile_global tl (add_key env name (VAR_ENV (0, (String.concat "" [name;"(%rip)"]))))
            end
        |CFUN (loc,name,args,code)->
            let func_info = func_is_in_environment env env name loc in
            let id = (get_func_id func_info) + 1 in
            let new_env = add_key env name (FUN_ENV (id,(List.length args))) in 
            begin
              compile_fun new_env name id args code out;
              compile_global tl new_env
            end
  in
  compile_global decl_list []
