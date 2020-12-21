open CAST
open Genlab

type fun_env = int * int (* id * number of args *) 

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

exception GlobalVarAlreadyDeclared
exception RedefiningMainIsForbidden
exception TooManyArgumentsForMain
exception EmptyReturnOfNonVoidFunction
exception Key_Not_found
exception ErrorDuringFunctionCompiling
exception VarAlreadyDefinedAtSameLevel
exception VariableWithSameNameAsFunctionAlreadyDeclared
exception FunctionWithSameNameAsVariableAlreadyDeclared
exception NotEnoughArgswhenCallingFunc
exception UnboundVariable
exception UnboundFunction
exception IllegalMonOpOnNonVar
exception IllegalRegisterArg

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
  |[] -> custom_raise UnboundVariable (Some loc)
  |(k,v)::tl ->
      if key=k then
        match v with
        |FUN_ENV (_,_)-> custom_raise UnboundVariable (Some loc)
        |VAR_ENV (level,address)-> address
      else
        get_value_var env_const tl key loc

let rec get_value_func (env_const : env) ( env : env) key loc =
  match env with
  |[] -> custom_raise UnboundFunction (Some loc)
  |(k,v)::tl ->
      if key=k then
        match v with
        |VAR_ENV (_,_)-> custom_raise UnboundFunction (Some loc)
        |FUN_ENV (id,nargs)-> (id,nargs)
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
  |(k, FUN_ENV ( _ ,_ ))::tl ->
      if key=k  then (* ajouter test niveau et tester si une function avec même nom n'est pas déjà défini *)
        custom_raise  VarAlreadyDefinedAtSameLevel (Some loc)
      else
        is_in_environment_same_level env_const tl key loc deepness

let rec func_is_in_environment env_const (env : env) key loc =
  match env with
  |[] -> (false,(-1))
  |(k, FUN_ENV (_,id))::tl ->
      if key=k then 
        if key = "main" then
            custom_raise  RedefiningMainIsForbidden (Some loc)
          else
            (true,id)

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
let inc arg1 out = p_1argf out "inc" arg1
let dec arg1 out = p_1argf out "inc" arg1
let jmp arg1 out = p_1argf out "jmp" arg1
let je arg1 out = p_1argf out "je" arg1
let leaq arg1 arg2 out = p_2argf out "leaq" arg1 arg2
let movq arg1 arg2 out = p_2argf out "movq" arg1 arg2
let addq arg1 arg2 out = p_2argf out "addq" arg1 arg2
let addl arg1 arg2 out = p_2argf out "addl" arg1 arg2
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
  |4 -> "%r8d"
  |5 -> "%r9d"
  |_ -> raise ( IllegalRegisterArg )



let handle_args env args out = 
    let nb_args = List.length args in
    let to_sub = max 0 (nb_args-6) in
    let to_sub_sizeofint = to_sub * 8 in
    let rec aux env args n rbp_deepness = 
      match args with
      |[] -> (rbp_deepness,env)
      |( CDECL (loc,name))::tl -> 
          let adress = match n with
                        |i when i<=5 -> p_register ((-8)*(i+1)) "%rbp"
                        |i -> p_register (8+8*(i-5)) "%rbp"
          in
          let new_env = begin is_in_environment_same_level env env name loc 1 ; add_key env name (VAR_ENV (1,adress)) end
          in
          let new_rbp_deepness = if n > 5 then rbp_deepness else (rbp_deepness-8) in
          begin
            if n < 5 then movq (arg_register n) adress out;
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
let rec compile_expr env loc_expr rbp_deepness result_destination out =
  let (loc,expr)=loc_expr in
  match expr with
  |VAR (name) -> movq (get_value_var env env name loc) result_destination out
  |CST (n) -> movq (int_literal n) result_destination out
  |STRING (str) -> begin 
    let address = get_str_adress str !str_env in
    match address with
      |None -> leaq ((put_str_adress str)^"(%rip)") result_destination out
      |Some addr -> leaq (addr ^"(%rip)" )result_destination out (* potentillement penser à esaped *)
    end
  |SET_VAR (var, loc_expr1) -> 
      compile_expr env loc_expr1 rbp_deepness result_destination out;
      movq result_destination (get_value_var env env var loc) out
  |SET_ARRAY (var, loc_expr1 , loc_expr2) ->
      compile_expr env loc_expr1 rbp_deepness result_destination out;
      imulq (int_literal 8) result_destination out;
      pushq result_destination out;
      compile_expr env loc_expr2 rbp_deepness result_destination out;
      popq "%rbx" out;
      movq (get_value_var env env var loc) "%rcx" out ;
      addq "%rbx" "%rcx" out;
      movq result_destination (p_register 0 "%rcx") out 
  |CALL (name, args) ->
      let is_builtin = not (get_func_existence (func_is_in_environment env env name loc)) in
      Printf.printf "call : %s " name;
      Printf.printf (if is_builtin then "true\n" else "false\n");
      if not is_builtin then
        let nb_args = List.length args in
        let (id,nb_real_args) = get_value_func env env name loc in 
        if not (nb_real_args=nb_args) then
          custom_raise NotEnoughArgswhenCallingFunc (Some loc)
        else
          begin
            let stack_delta_args = if nb_args <= 6 then 0 else (nb_args-6)*8 in
            subq (int_literal ((rbp_deepness+stack_delta_args) mod 16)) "%rsp" out; (* adjusting stack *)
            handling_args_call env (rbp_deepness-(stack_delta_args/8)) out args;
            call (get_func_inline out name id) out;
            addq (int_literal ((max 0 (nb_args-6))*8)) "%rsp" out; (* adjusting stack *)
            addq (int_literal ((rbp_deepness+stack_delta_args) mod 16)) "%rsp" out (* adjusting stack *)
          end
      else
        let nb_args = List.length args in
        let stack_delta_args = if nb_args <= 6 then 0 else (nb_args-6)*8 in
        subq (int_literal ((rbp_deepness+stack_delta_args) mod 16)) "%rsp" out; (* adjusting stack *)
        handling_args_call env (rbp_deepness-(stack_delta_args/8)) out args;
        call name out;
        addq (int_literal ((max 0 (nb_args-6))*8)) "%rsp" out; (* adjusting stack *)
        addq (int_literal ((rbp_deepness+stack_delta_args) mod 16)) "%rsp" out (* adjusting stack *)


  |OP1 (op1, le) -> compile_mon_op env rbp_deepness op1 le out     
  |OP2 (op2, le1, le2) -> compile_bin_op env rbp_deepness op2 le1 le2 out
  |CMP (cmpop, le1, le2) -> compile_cmp_op env rbp_deepness cmpop le1 le2 out
  |EIF (le, leIf, leElse) ->
      let current_if_n = !if_n +1 in
      if_n := !if_n + 1;
      compile_expr env le rbp_deepness "%rax" out;
      cmpq (int_literal 0) "%rax" out;
      je (get_label "EIF_ELSE" current_if_n) out;
      compile_expr env leElse rbp_deepness "%rax" out;
      jmp (get_label "EIF_END" current_if_n) out;
      print_label out "EIF_ELSE" current_if_n;
      compile_expr env leIf rbp_deepness "%rax" out;
      print_label out "EIF_END" current_if_n
  |ESEQ list_loc_expr -> 
      List.iter (fun le ->
      compile_expr env le rbp_deepness "%rax" out
      ) list_loc_expr

and compile_mon_op env rbp_deepness op1 le out =
  let (loc,expr) = le in
  match op1 with 
  | M_MINUS -> 
      compile_expr env le rbp_deepness "%rax" out;
      negq "%rax" out
  | M_NOT ->
      compile_expr env le rbp_deepness "%rax" out;
      notq "%rax" out
  | _ ->
    match expr with
    |VAR v -> 
      begin
        match op1 with
        |M_POST_INC ->
            movq (get_value_var env env v loc) "%rax" out;
            movq (get_value_var env env v loc) "%rbx" out; 
            inc "%rbx" out;
            movq "%rbx" (get_value_var env env v loc) out
        |M_POST_DEC ->
            movq (get_value_var env env v loc) "%rax" out;
            movq (get_value_var env env v loc) "%rbx" out; 
            dec "%rbx" out;
            movq "%rbx" (get_value_var env env v loc) out
        |M_PRE_INC ->
            movq (get_value_var env env v loc) "%rax" out;
            inc "%rax" out;
            movq "%rax" (get_value_var env env v loc) out
        |M_PRE_DEC ->
            movq (get_value_var env env v loc) "%rax" out;
            dec "%rax" out;
            movq "%rax" (get_value_var env env v loc) out
        |_ -> ()
      end 
    |OP2 (S_INDEX, (loc1,e1) , (loc2,e2))->
        begin
          compile_expr env (loc2,e2) rbp_deepness "%rax" out;
          pushq "%rax" out;
          compile_expr env (loc1,e1) rbp_deepness "%rbx" out;
          popq "%rax" out;
          imulq (int_literal 8) "%rax" out;
          addq "%rax" "%rbx" out;
          match op1 with
          |M_POST_INC ->
              movq (p_register 0 "%rbx" ) "%rax" out;
              movq (p_register 0 "%rbx" ) "%rcx" out;
              inc "%rcx" out;
              movq "%rcx" (p_register 0 "%rbx" ) out;
          |M_POST_DEC ->
              movq (p_register 0 "%rbx" ) "%rax" out;
              movq (p_register 0 "%rbx" ) "%rcx" out;
              dec "%rcx" out;
              movq "%rcx" (p_register 0 "%rbx" ) out;
          |M_PRE_INC ->
              movq (p_register 0 "%rbx" ) "%rcx" out;
              inc "%rcx" out;
              movq "%rcx" (p_register 0 "%rbx" ) out;
              movq "%rcx" "%rax" out;
          |M_PRE_DEC ->
              movq (p_register 0 "%rbx" ) "%rcx" out;
              dec "%rcx" out;
              movq "%rcx" (p_register 0 "%rbx" ) out;
              movq "%rcx" "%rax" out;
          |_ -> ()

        end
    |_ -> custom_raise IllegalMonOpOnNonVar (Some loc)
and compile_bin_op env rbp_deepness op2 le1 le2 out =
  compile_expr env le1 rbp_deepness "%rax" out;
  pushq "%rax" out;
  compile_expr env le2 rbp_deepness "%rbx" out;
  popq "%rax" out;
  match op2 with
  |S_MUL -> imulq "%rbx" "%rax" out
  |S_DIV ->
      cqto out;
      idivq "%rbx" out;
  |S_MOD ->
      cqto out;
      idivq "%rbx" out;
      movq "%rdx" "%rax" out
  |S_ADD -> addq "%rbx" "%rax" out
  |S_SUB -> subq "%rbx" "%rax" out
  |S_INDEX -> 
      imulq (int_literal 8) "%rbx" out;
      addq "%rbx" "%rax" out;
      movq (p_register 0 "%rax") "%rax" out

and compile_cmp_op env rbp_deepness cmp_op le1 le2 out =
  compile_expr env le2 rbp_deepness "%rax" out;
  pushq "%rax" out;
  compile_expr env le1 rbp_deepness "%rbx" out;
  popq "%rcx" out;
  cmpq "%rcx" "%rbx" out;
  movq (int_literal 0) "%rax" out; 
  (* potentiellement reset rax *)
  match cmp_op with
  |C_LT -> setl "%al" out
  |C_LE -> setle "%al" out
  |C_EQ -> sete "%al" out


and handling_args_call env rbp_deepness out args = 
  let rev_args = List.rev args in
  let nb_args = List.length args in
  List.iteri (fun i arg ->
    if i <= 5 then
      begin
      compile_expr env arg rbp_deepness "%rax" out;
      movq "%rax" (arg_register i) out    
      end
  ) args;
  List.iteri (fun i arg ->
    if i < (nb_args-6) then
      begin
      compile_expr env arg rbp_deepness "%rax" out;
      pushq "%rax" out;    
      end
  ) rev_args


and handle_local_vars env vars var_deepness rbp_deepness = 
  let nb_args = List.length vars in
  let to_sub_sizeofint = nb_args * 8 in
  let rec aux env vars rbp_deepness = 
    match vars with
      |[] -> (rbp_deepness,env)
      |( CDECL (loc,name))::tl -> 
          let new_rbp_deepness = (rbp_deepness-8) in
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
  compile_expr env loc_expr rbp_deepness "%rax" out;
  cmpq "$0" "%rax" out;
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
  compile_expr env loc_expr rbp_deepness "%rax" out;
  cmpq "$0" "%rax" out;
  je (get_label "END_WHILE" !while_n) out;
  jmp (get_label "WHILE_BODY" !while_n) out;
  print_label out "END_WHILE" !while_n

and compile_return env loc_expr rbp_deepness out : unit = 
  compile_expr env loc_expr rbp_deepness "%rax" out;
  jmp (get_label "END" !end_n) out

and compile_code env var_deepness rbp_deepness loc_code out : unit =
  let (loc,code) = loc_code in
  match code with
  | CBLOCK (vars,code_list) -> compile_block env (var_deepness+1) rbp_deepness vars code_list out
  | CEXPR (loc_expr) -> compile_expr env loc_expr rbp_deepness "%rax" out 
  | CIF (loc_expr,l_c_if,l_c_else) -> compile_if loc_expr l_c_if l_c_else env var_deepness rbp_deepness out 
  | CWHILE (loc_expr,l_c) -> compile_while env loc_expr l_c var_deepness rbp_deepness out 
  | CRETURN (loc_expr) -> match loc_expr with 
                          |None -> custom_raise  EmptyReturnOfNonVoidFunction (Some loc) 
                          |Some le -> compile_return env le rbp_deepness out

let compile_fun env name id args code out : unit =
    let (rbp_deepness,fun_env) =
      if name = "main" then Printf.fprintf out "main:\n"
      else print_func out name id;
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
              compile_global tl (add_key env name (VAR_ENV (0, (name ^ "(%rip)"))))
            end
        |CFUN (loc,name,args,code)->
            let func_info = func_is_in_environment env env name loc in
            let id = (get_func_id func_info) + 1 in
            let new_env = add_key env name (FUN_ENV (id,(List.length args))) in 
            begin
              Printf.printf "Debug : name = %s et id = %d\n" name id;
              compile_fun new_env name id args code out;
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
