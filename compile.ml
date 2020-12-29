open CAST
open Genlab

type fun_env = int (* id * number of args *) 

type var_env = int * string (* level and adress value *)

let end_n = ref 0
let if_n = ref 0
let while_n = ref 0
let string_n = ref 0

type decl_env = 
  |FUN_ENV of fun_env
  |VAR_ENV of var_env

type env = (string*decl_env) list
type strenv = (string*string) list

exception RedefiningFunctionIsForbidden
exception EmptyReturnOfNonVoidFunction
exception VarAlreadyDefinedAtSameLevel
exception VariableWithSameNameAsFunctionAlreadyDeclared
exception IllegalUseOfFunctionNameAsVariable 
exception IllegalUseOfVariableNameAsFunction  
exception IllegalMonOpOnNonVar
exception IllegalRegisterArg
exception UnboundFunction

let custom_raise excpt loc =
  Error.prerr_loc loc;
  raise excpt

let empty_env = []

let str_env = ref empty_env

let rec get_str_adress str env = 
  match env with
  |[] -> None
  |(k,v)::tl -> 
      if str=k then
        Some v
      else
        get_str_adress str tl

let put_str_adress str =
  str_env := (str, Printf.sprintf "LString%d" !string_n)::!str_env ;
  string_n := !string_n + 1;
  Printf.sprintf "LString%d" (!string_n-1)

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
  |[] -> key^ "(%rip)"
  |(k,v)::tl ->
      if key=k then
        match v with
        |FUN_ENV (_)-> custom_raise IllegalUseOfFunctionNameAsVariable (Some loc)
        |VAR_ENV (level,address)-> address
      else
        get_value_var env_const tl key loc


(* ajouter l'utilisation de ça *)
let rec get_value_func (env_const : env) ( env : env) key loc =
  match env with
  |[] -> key
  |(k,v)::tl ->
      if key=k then
        match v with
        |VAR_ENV (_,_)-> custom_raise IllegalUseOfVariableNameAsFunction  (Some loc)
        |FUN_ENV (nargs)-> key
      else
        get_value_func env_const tl key loc

let effective_func name id = Printf.sprintf "%s%d" name id

let rec is_in_environment_same_level env_const (env : env) key (loc: Error.locator) deepness =
  match env with
  |[] -> ()
  |(k, VAR_ENV (deep ,_ ))::tl ->
      if key=k  then (* ajouter test niveau et tester si une function avec même nom n'est pas déjà défini *)
        if deep=deepness then 
          custom_raise  VarAlreadyDefinedAtSameLevel (Some loc)
        else
          ()
      else
        is_in_environment_same_level env_const tl key loc deepness
  |(k, FUN_ENV ( _ ))::tl ->
      if key=k  then (* ajouter test niveau et tester si une function avec même nom n'est pas déjà défini *)
        custom_raise  VarAlreadyDefinedAtSameLevel (Some loc)
      else
        is_in_environment_same_level env_const tl key loc deepness

let rec func_is_in_environment env_const (env : env) key loc =
  match env with
  |[] -> (false,(-1))
  |(k, FUN_ENV (nargs))::tl ->
      if key=k then 
        custom_raise  RedefiningFunctionIsForbidden (Some loc)
      else
        func_is_in_environment env_const tl key loc
  |(k, VAR_ENV (_,_))::tl ->
      if key=k then 
        custom_raise  VariableWithSameNameAsFunctionAlreadyDeclared (Some loc)
      else
        func_is_in_environment env_const tl key loc

let get_func_id (_,id) = id
let get_func_existence (existence,_) = existence

let p_0argf out func_name = Printf.fprintf out "\t\t%s\n" func_name
let p_1argf out func_name arg1 = Printf.fprintf out "\t\t%s    %s\n" func_name arg1
let p_2argf out func_name arg1 arg2 = Printf.fprintf out "\t\t%s    %s , %s\n" func_name arg1 arg2
let setl arg1 out = p_1argf out "setl" arg1
let setle arg1 out = p_1argf out "setle" arg1
let sete arg1 out = p_1argf out "sete" arg1
let call arg1 out = p_1argf out "call" arg1
let idivq arg1 out = p_1argf out "idivq" arg1
let pushq arg1 out = p_1argf out "pushq" arg1
let popq arg1 out = p_1argf out "popq" arg1
let notq arg1 out = p_1argf out "notq" arg1
let negq arg1 out = p_1argf out "negq" arg1
let incq arg1 out = p_1argf out "incq" arg1
let decq arg1 out = p_1argf out "decq" arg1
let jmp arg1 out = p_1argf out "jmp" arg1
let je arg1 out = p_1argf out "je" arg1
let leaq arg1 arg2 out = p_2argf out "leaq" arg1 arg2
let movq arg1 arg2 out = p_2argf out "movq" arg1 arg2
let addq arg1 arg2 out = p_2argf out "addq" arg1 arg2
let subq arg1 arg2 out = p_2argf out "subq" arg1 arg2
let cmpq arg1 arg2 out = p_2argf out "cmpq" arg1 arg2
let imulq arg1 arg2 out = p_2argf out "imulq" arg1 arg2
let ret out = p_0argf out "ret"
let cqto out = p_0argf out "cqto"

let p_register delta reg = 
  if delta=0 then
    Printf.sprintf "(%s)" reg 
  else
    Printf.sprintf "%d(%s)" delta reg 

let print_global_int out var_name = Printf.fprintf out ".data\n%s:\n\t\t.zero    8\n.text\n" var_name
let print_func out name id = Printf.fprintf out "%s%d:\n" name id
let get_func_inline out name id = Printf.sprintf "%s%d" name id
let print_label out name id = Printf.fprintf out "\t.%s%d:\n" name id
let get_label name id = Printf.sprintf ".%s%d" name id
let int_literal n = Printf.sprintf "$%d" n
let string_literal str = Printf.sprintf "$%s" str

let arg_register n_arg =
  match n_arg with
  |0 -> "%rdi"
  |1 -> "%rsi"
  |2 -> "%rdx"
  |3 -> "%rcx"
  |4 -> "%r8"
  |5 -> "%r9"
  |_ -> raise ( IllegalRegisterArg )



(* 
 * var deepness : 0 = global , 1 = function arg , 2+ block
 *)

(* penser à tester si il ne va pas y avoir du code inatteignable *)
let rec compile_expr env loc_expr stack_offset out =
  let (loc,expr)=loc_expr in
  match expr with
  |VAR (name) -> movq (get_value_var env env name loc) "%rax" out
  |CST (n) -> movq (int_literal n) "%rax" out
  |STRING (str) -> begin 
    let address = get_str_adress str !str_env in
    match address with
      |None -> leaq ((put_str_adress str)^"(%rip)") "%rax" out
      |Some addr -> leaq (addr ^"(%rip)" )"%rax" out (* potentillement penser à esaped *)
    end
  |SET_VAR (var, loc_expr1) -> 
      compile_expr env loc_expr1 stack_offset out;
      movq "%rax" (get_value_var env env var loc) out
  |SET_ARRAY (var, loc_expr_index , loc_expr_val) ->
      compile_expr env loc_expr_index stack_offset out;
      imulq (int_literal 8) "%rax" out;
      pushq "%rax" out;
      compile_expr env loc_expr_val stack_offset out;
      popq "%rbx" out;
      movq (get_value_var env env var loc) "%rcx" out ;
      addq "%rbx" "%rcx" out;
      movq "%rax" (p_register 0 "%rcx") out 
  |CALL (name, args) ->
      let func_name = get_value_func env env name loc in
      let nb_args = List.length args in
      let stack_delta_args = if nb_args <= 6 then 0 else (nb_args-6)*8 in
      let new_stack_offset = stack_offset + stack_delta_args in
      let stack_adjustment = (abs new_stack_offset) mod 16 in
      subq (int_literal stack_adjustment) "%rsp" out; (* adjusting stack *)
      handling_args_call env (new_stack_offset+stack_adjustment)  out args;
      movq (int_literal 0) "%rax" out;
      call func_name out;
      addq (int_literal stack_delta_args) "%rsp" out; (* adjusting stack *)
      addq (int_literal stack_adjustment) "%rsp" out (* adjusting stack *)


  |OP1 (op1, le) -> compile_mon_op env stack_offset op1 le out     
  |OP2 (op2, le1, le2) -> compile_bin_op env stack_offset op2 le1 le2 out
  |CMP (cmpop, le1, le2) -> compile_cmp_op env stack_offset cmpop le1 le2 out
  |EIF (le, leIf, leElse) ->
      let current_if_n = !if_n +1 in
      if_n := !if_n + 1;
      compile_expr env le stack_offset out;
      cmpq (int_literal 0) "%rax" out;
      je (get_label "EIF_ELSE" current_if_n) out;
      compile_expr env leIf stack_offset  out;
      jmp (get_label "EIF_END" current_if_n) out;
      print_label out "EIF_ELSE" current_if_n;
      compile_expr env leElse stack_offset  out;
      print_label out "EIF_END" current_if_n
  |ESEQ list_loc_expr -> 
      List.iter (fun le ->
      compile_expr env le stack_offset out
      ) list_loc_expr

and compile_mon_op env stack_offset op1 le out =
  let (loc,expr) = le in
  match op1 with 
  | M_MINUS -> 
      compile_expr env le stack_offset out;
      negq "%rax" out
  | M_NOT ->
      compile_expr env le stack_offset out;
      notq "%rax" out
  | _ ->
    match expr with
    |VAR v -> 
      begin
        match op1 with
        |M_POST_INC ->
            movq (get_value_var env env v loc) "%rax" out;
            incq  (get_value_var env env v loc) out
        |M_POST_DEC ->
            movq (get_value_var env env v loc) "%rax" out;
            decq  (get_value_var env env v loc) out
        |M_PRE_INC ->
            incq (get_value_var env env v loc) out;
            movq (get_value_var env env v loc) "%rax" out
        |M_PRE_DEC ->
            decq (get_value_var env env v loc) out;
            movq (get_value_var env env v loc) "%rax" out
        |_ -> ()
      end 
    |OP2 (S_INDEX, (loc1,e1) , (loc2,e2))->
        begin
          compile_expr env (loc2,e2) stack_offset out;
          pushq "%rax" out;
          compile_expr env (loc1,e1) stack_offset out;
          popq "%rbx" out;
          imulq (int_literal 8) "%rbx" out;
          addq "%rbx" "%rax" out;
          match op1 with
          |M_POST_INC ->
              pushq (p_register 0 "%rax" ) out;
              incq (p_register 0 "%rax" ) out;
              popq "%rax" out
          |M_POST_DEC ->
              pushq (p_register 0 "%rax" ) out;
              decq (p_register 0 "%rax" ) out;
              popq "%rax" out
          |M_PRE_INC ->
              incq (p_register 0 "%rax" ) out;
              movq (p_register 0 "%rax" ) "%rax" out
          |M_PRE_DEC ->
              decq (p_register 0 "%rax" ) out;
              movq (p_register 0 "%rax" ) "%rax" out
          |_ -> ()

        end
    |_ -> custom_raise IllegalMonOpOnNonVar (Some loc)
and compile_bin_op env stack_offset op2 le1 le2 out =
  compile_expr env le2 stack_offset  out;
  pushq "%rax" out;
  compile_expr env le1 stack_offset  out;
  popq "%rbx" out;
  match op2 with
  |S_MUL -> 
      movq "%rbx" "%r15" out;
      movq "%rax" "%rbx" out;
      movq "%r15" "%rax" out;
      imulq "%rbx" "%rax" out
  |S_DIV ->
      cqto out;
      idivq "%rbx" out;
  |S_MOD ->
      cqto out;
      idivq "%rbx" out;
      movq "%rdx" "%rax" out
  |S_ADD -> 
      movq "%rbx" "%r15" out;
      movq "%rax" "%rbx" out;
      movq "%r15" "%rax" out;
      addq "%rbx" "%rax" out
  |S_SUB -> 
      subq "%rbx" "%rax" out
  |S_INDEX -> 
      movq "%rbx" "%r15" out;
      movq "%rax" "%rbx" out;
      movq "%r15" "%rax" out;
      imulq (int_literal 8) "%rax" out;
      addq "%rbx" "%rax" out;
      movq (p_register 0 "%rax") "%rax" out

and compile_cmp_op env stack_offset cmp_op le1 le2 out =
  compile_expr env le2 stack_offset out;
  pushq "%rax" out;
  compile_expr env le1 stack_offset out;
  popq "%rbx" out;
  cmpq "%rbx" "%rax" out;
  movq (int_literal 0) "%rax" out; 
  (* potentiellement reset rax *)
  match cmp_op with
  |C_LT -> setl "%al" out
  |C_LE -> setle "%al" out
  |C_EQ -> sete "%al" out


and handling_args_call env stack_offset out args = 
  let rev_args = List.rev args in
  List.iteri (fun i arg ->
      begin
        compile_expr env arg stack_offset  out;
        pushq "%rax" out;    
      end
  ) rev_args;
  List.iteri (fun i arg ->
    if i <= 5 then
      begin
        popq (arg_register i) out    
      end
  ) args


and handle_local_vars env vars var_deepness stack_offset = 
  let nb_args = List.length vars in
  let to_sub_sizeofint = nb_args * 8 in
  let rec aux env vars stack_offset = 
    match vars with
      |[] -> (stack_offset,env)
      |( CDECL (loc,name))::tl -> 
          let new_stack_offset = (stack_offset-8) in
          let adress = p_register new_stack_offset "%rbp" in
          let new_env = begin is_in_environment_same_level env env name loc var_deepness ; add_key env name (VAR_ENV (var_deepness,adress)) end in
          aux new_env tl new_stack_offset 
      |_ -> Printf.printf "this case should never happen because syntax handles it" ; (stack_offset,env) 
  in
  ( to_sub_sizeofint , aux env vars stack_offset)

and compile_block env var_deepness stack_offset vars (code_list : CAST.loc_code list) out : unit =
  let (to_sub_sizeofint, (new_stack_offset, block_env) ) = handle_local_vars env vars var_deepness stack_offset in
  let rec aux (code_list : CAST.loc_code list) env var_deepness stack_offset last_was_return =
    if last_was_return = false then
      match code_list with
      |[] -> ()
      |(hd_loc, hd_code)::tl ->
          compile_code env var_deepness stack_offset (hd_loc,hd_code) out;
          match hd_code with
                 |CRETURN o -> aux tl env var_deepness stack_offset true 
                 |_ -> aux tl env var_deepness stack_offset false 
    else
      ()
  in
  subq (int_literal to_sub_sizeofint) "%rsp" out;
  aux code_list block_env var_deepness new_stack_offset false;
  addq (int_literal to_sub_sizeofint) "%rsp" out

and compile_if loc_expr l_c_if l_c_else env var_deepness stack_offset out : unit =
  let current_if_n = !if_n+1 in
  if_n := !if_n+1;
  compile_expr env loc_expr stack_offset  out;
  cmpq "$0" "%rax" out;
  je (get_label "ELSE_BODY" current_if_n) out;
  compile_code env var_deepness stack_offset l_c_if out;
  jmp (get_label "END_IF" current_if_n) out;
  print_label out "ELSE_BODY" current_if_n;
  compile_code env var_deepness stack_offset l_c_else out;
  print_label out "END_IF" current_if_n
  
and compile_while env loc_expr loc_code var_deepness stack_offset out : unit =
  let current_while_n = !while_n+1 in
  while_n := !while_n+1;
  jmp (get_label "WHILE_TEST" current_while_n) out;
  print_label out "WHILE_BODY" current_while_n;
  compile_code env var_deepness stack_offset loc_code out; 
  print_label out "WHILE_TEST" current_while_n;
  compile_expr env loc_expr stack_offset  out;
  cmpq "$0" "%rax" out;
  je (get_label "END_WHILE" current_while_n) out;
  jmp (get_label "WHILE_BODY" current_while_n) out;
  print_label out "END_WHILE" current_while_n

and compile_return env loc_expr stack_offset out : unit = 
  compile_expr env loc_expr stack_offset  out;
  addq (int_literal (abs stack_offset)) "%rsp" out;
  popq  "%rbp" out;
  ret out;
  Printf.fprintf out "\n" 

and compile_code env var_deepness stack_offset loc_code out : unit =
  let (loc,code) = loc_code in
  match code with
  | CBLOCK (vars,code_list) -> compile_block env (var_deepness+1) stack_offset vars code_list out
  | CEXPR (loc_expr) -> compile_expr env loc_expr stack_offset  out 
  | CIF (loc_expr,l_c_if,l_c_else) -> compile_if loc_expr l_c_if l_c_else env var_deepness stack_offset out 
  | CWHILE (loc_expr,l_c) -> compile_while env loc_expr l_c var_deepness stack_offset out 
  | CRETURN (loc_expr) -> match loc_expr with 
                          |None -> custom_raise  EmptyReturnOfNonVoidFunction (Some loc) 
                          |Some le -> compile_return env le stack_offset out

let rec compile_fun env name args code out : unit =
    let (stack_offset,fun_env) =
      Printf.fprintf out "%s:\n" name;
      pushq "%rbp" out;
      movq  "%rsp" "%rbp" out;
      handle_args env args out in
    (*args_begin ; str_code ;args_end ;*)
    (*handle_args env args;*)
    compile_code fun_env 1 stack_offset code out;
    addq (int_literal (-stack_offset)) "%rsp" out;
    popq  "%rbp" out;
    ret out;
    Printf.fprintf out "\n" 


and handle_args env args out = 
    let nb_args = List.length args in
    let to_sub = min 6 nb_args in
    let to_sub_sizeofint = to_sub * 8 in
    let rec aux env args n stack_offset = 
      match args with
      |[] -> (stack_offset,env)
      |( CDECL (loc,name))::tl -> 
          let adress = match n with
                        |i when i<=5 -> p_register ((-8)*(i+1)) "%rbp"
                        |i -> p_register (8+8*(i-5)) "%rbp"
          in
          let new_env = begin is_in_environment_same_level env env name loc 1 ; add_key env name (VAR_ENV (1,adress)) end
          in
          let new_stack_offset = if n > 5 then stack_offset else (stack_offset-8) in
          begin
            if n <= 5 then movq (arg_register n) adress out;
            aux new_env tl (n+1) new_stack_offset 
          end
      |_ -> Printf.printf "this case should never happen because syntax handles it" ; (stack_offset,env) 
    in
    subq (int_literal to_sub_sizeofint) "%rsp" out;
    aux env args 0 0
    (*addq to_sub_sizeofint "%rsp";*)
    


let compile out decl_list =
  let rec compile_global decl_list env =
    match decl_list with 
    |[] -> ()
    |hd::tl -> match hd with
        |CDECL (loc,name) -> 
            begin
              is_in_environment_same_level env env name loc 0;
              print_global_int out name;
              compile_global tl (add_key env name (VAR_ENV (0, (name ^ "(%rip)"))))
            end
        |CFUN (loc,name,args,code)->
            let _ = func_is_in_environment env env name loc in
            let new_env = add_key env name (FUN_ENV (List.length args)) in 
            begin
              Printf.printf "Debug : name = %s\n" name;
              compile_fun new_env name args code out;
              compile_global tl new_env
            end
  in
  (* Printf.fprintf out ".align 16\n\n"; *)
  (*Printf.fprintf out ".file    \"test.c\"\n";
  Printf.fprintf out ".section .text\n";*)
  Printf.fprintf out ".global main\n\n";
  compile_global decl_list empty_env;
  List.iter (fun v ->
    let (value, label) = v in
    Printf.fprintf out "%s:\n    .string    \"%s\"\n" label (String.escaped value)
    ) !str_env


  (* cquand call vérifier que ce n'est pas main ? *)
