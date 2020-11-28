open CAST
open Genlab

type fun_env = int * int (* number of args and id if multiple declaration *) 

type var_env = int * string (* level and adress value *)

let end_n = ref 0
let if_n = ref 0
let while_n = ref 0

type decl_env = 
  |FUN_ENV of fun_env
  |VAR_ENV of var_env

type env = (string*decl_env) list

exception GlobalVarAlreadyDeclared of env*Error.locator
exception EmptyReturnOfNonVoidFunction of env*Error.locator
exception Key_Not_found of env*Error.locator
exception ErrorDuringFunctionCompiling of env*Error.locator
exception VarAlreadyDefinedAtSameLevel of env*Error.locator
exception VariableWithSameNameAsFunctionAlreadyDeclared of env*Error.locator
exception FunctionWithSameNameAsVariableAlreadyDeclared of env*Error.locator

let empty_env = []

let rec add_key env key (value: decl_env) = 
  match env with
  |[] -> [(key,value)]
  |(k,v)::tl -> 
      if key=k then
        (k,value)::tl
      else
        (k,v):: add_key tl key value

let rec get_value env_const env key loc =
  match env with
  |[] -> raise (Key_Not_found (env_const,loc))
  |(k,v)::tl ->
      if key=k then
        v
      else
        get_value env_const tl key loc

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

let handle_args env args = 
    let nb_args = List.length args in
    let to_sub = if nb_args >= 6 then 6 else nb_args in
    let to_sub_sizeofint = to_sub * 4 in
    let rec aux env str args n rbp_deepness = 
      match args with
      |[] -> (str,rbp_deepness,env)
      |( CDECL (loc,name))::tl -> 
          let adress = match n with
                        |i when i<=5 -> String.concat "" [string_of_int ((-4)*(i+1)); "(%rbp)"]
                        |i when i>5 -> String.concat "" [string_of_int (8+8*(i-5)); "(%rbp)"]
          in
          let new_env = begin is_in_environment_same_level env env name loc 1 ; add_key env name (VAR_ENV (1,adress)) end in
          let line_to_concat = match n with
                               |i when i > 5 -> ""
                               |i when i = 0 -> String.concat "" ["\n\t\tmovl\t\t%edi , ";adress]
                               |i when i = 1 -> String.concat "" ["\n\t\tmovl\t\t%esi , ";adress]
                               |i when i = 2 -> String.concat "" ["\n\t\tmovl\t\t%edx , ";adress]
                               |i when i = 3 -> String.concat "" ["\n\t\tmovl\t\t%ecx , ";adress]
                               |i when i = 4 -> String.concat "" ["\n\t\tmovl\t\t%r8d , ";adress]
                               |i when i = 5 -> String.concat "" ["\n\t\tmovl\t\t%r9d , ";adress]
          in
          let new_str = String.concat "" [str;line_to_concat] in
          let new_rbp_deepness = if n > 5 then rbp_deepness else (rbp_deepness-4) in
          aux new_env new_str tl (n+1) new_rbp_deepness 
      |_ -> Printf.printf "this case should never happen because syntax handles it" ; ("",rbp_deepness,env) 
    in
    (aux env (String.concat "" ["\n\t\tsubq\t\t$";string_of_int to_sub_sizeofint;" , %rsp"] ) args 0 0 ,(String.concat "" ["\n\t\taddq\t\t$";string_of_int to_sub_sizeofint;" , %rsp"] ) )

(* 
 * var deepness : 0 = global , 1 = function arg , 2+ block
 *)

(* penser à tester si il ne va pas y avoir du code inatteignable *)
let rec compile_expr env loc_expr result_destination =
  let (loc,exp) = loc_expr in
  match exp with 
  |CST n -> String.concat "" ["\n\t\tmovl\t\t$";string_of_int n ;" , ";result_destination] 
  |_ -> ""

and handle_local_vars env vars var_deepness rbp_deepness = 
  let nb_args = List.length vars in
  let to_sub_sizeofint = nb_args * 4 in
  let rec aux env vars rbp_deepness = 
    match vars with
      |[] -> (rbp_deepness,env)
      |( CDECL (loc,name))::tl -> 
          let adress = String.concat "" [string_of_int (rbp_deepness-4); "(%rbp)"] in
          let new_env = begin is_in_environment_same_level env env name loc var_deepness ; add_key env name (VAR_ENV (var_deepness,adress)) end in
          let new_rbp_deepness = (rbp_deepness-4) in
          aux new_env tl new_rbp_deepness 
      |_ -> Printf.printf "this case should never happen because syntax handles it" ; (rbp_deepness,env) 
  in
  ( to_sub_sizeofint , aux env vars rbp_deepness)

and compile_block env var_deepness rbp_deepness vars (code_list : CAST.loc_code list) =
  let (to_sub_sizeofint, (new_rbp_deepness, block_env) ) = handle_local_vars env vars var_deepness rbp_deepness in
  let rec aux str (code_list : CAST.loc_code list) env var_deepness rbp_deepness last_was_return =
    if last_was_return = false then
      match code_list with
      |[] -> (str,false)
      |(hd_loc, hd_code)::tl ->
          let new_str = String.concat "" [str;compile_code env var_deepness rbp_deepness (hd_loc,hd_code)] in 
          match hd_code with
                 |CRETURN o -> aux new_str tl env var_deepness rbp_deepness true 
                 |_ -> aux new_str tl env var_deepness rbp_deepness false 
    else
      (str,true)
  in
  let (block_code_str,was_return) = aux "" code_list block_env var_deepness new_rbp_deepness false
  in
  let jump_if_necessary = if was_return = true then String.concat "" ["\n\t\tjmp .END";string_of_int !end_n] else "" in
  String.concat "" [
    "\n\t\tsubq\t\t$";string_of_int to_sub_sizeofint;" , %rsp"
    ; block_code_str
    ;"\n\t\taddq\t\t$";string_of_int to_sub_sizeofint;" , %rsp"
    ;jump_if_necessary]
  

  


and compile_if loc_expr l_c_if l_c_else env var_deepness rbp_deepness =
  if_n := !if_n+1;
  String.concat ""
  [compile_expr env loc_expr "%eax"
  ;"\n\t\tcmpl\t\t$0 , %eax"
  ;"\n\t\tje\t\t.ELSE_BODY";string_of_int !if_n
  ;compile_code env var_deepness rbp_deepness l_c_if 
  ;"\n\t\tjmp .END_IF";string_of_int !if_n
  ;"\n\t.ELSE_BODY";string_of_int !if_n;":"
  ;compile_code env var_deepness rbp_deepness l_c_else 
  ;"\n\t.END_IF";string_of_int !if_n;":"]
  


and compile_while env loc_expr loc_code var_deepness rbp_deepness =
  while_n := !while_n+1;
  String.concat "" ["\n\t\tjmp .WHILE_TEST";string_of_int !while_n
  ;"\n\t.WHILE_BODY";string_of_int !while_n;":"
  ; compile_code env var_deepness rbp_deepness loc_code 
  ;"\n\t.WHILE_TEST";string_of_int !while_n;":"
  ;compile_expr env loc_expr "%eax"
  ;"\n\t\tcmpl\t\t$0 , %eax"
  ;"\n\t\tje\t\t.END_WHILE";string_of_int !while_n
  ;"\n\t\tjmp .WHILE_BODY";string_of_int !while_n
  ;"\n\t.END_WHILE";string_of_int !while_n;":"]


and compile_return env loc_expr = 
  compile_expr env loc_expr "%eax" 

and compile_code env var_deepness rbp_deepness loc_code =
  let (loc,code) = loc_code in
  match code with
  | CBLOCK (vars,code_list) -> compile_block env (var_deepness+1) rbp_deepness vars code_list
  | CEXPR (loc_expr) -> compile_expr env loc_expr "%eax"
  | CIF (loc_expr,l_c_if,l_c_else) -> compile_if loc_expr l_c_if l_c_else env var_deepness rbp_deepness
  | CWHILE (loc_expr,l_c) -> compile_while env loc_expr l_c var_deepness rbp_deepness 
  | CRETURN (loc_expr) -> match loc_expr with 
                          |None -> raise ( EmptyReturnOfNonVoidFunction (env,loc))
                          |Some le -> compile_return env le
  


let compile_fun env name id args code =
    let ((args_begin,rbp_deepness,fun_env),args_end) = handle_args env args in
    let str_code = compile_code fun_env 1 rbp_deepness code in
    let fun_code = String.concat "" [name;string_of_int id;":";"\n\t\tpushq\t\t%rbp";"\n\t\tmovq\t\t%rsp , %rbp"; args_begin ; str_code ; "\n\t\t.END"; string_of_int !end_n;":"; args_end ;"\n\t\tpopq\t\t%rbp";"\n\t\tret";"\n\n"] in 
    end_n := !end_n + 1;
    fun_code



let compile out decl_list =
  let rec compile_global decl_list str_code env =
    match decl_list with 
    |[] -> str_code
    |hd::tl -> match hd with
        |CDECL (loc,name) -> 
            begin
              is_in_environment_same_level env env name loc 0;
              compile_global tl (String.concat "" [str_code;name;":";"\n\t\t.zero\t\t4\n\n"]) (add_key env name (VAR_ENV (0, (String.concat "" [name;"(%rip)"]))))
            end
        |CFUN (loc,name,args,code)->
            let func_info = func_is_in_environment env env name loc in
            let id = (get_func_id func_info) + 1 in
            let new_env = add_key env name (FUN_ENV (id,(List.length args))) in 
            compile_global tl (String.concat "" [str_code;(compile_fun new_env name id args code)]) new_env
  in
  let generated_code = compile_global decl_list "" [] in
  Printf.fprintf out "%s" generated_code
