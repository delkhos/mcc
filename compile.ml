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

let unoptimized_code = ref []

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

let p_0argf func_name () = 
  unoptimized_code := [Printf.sprintf "\t\t%s\n" func_name]@(!unoptimized_code)
let p_1argf func_name arg1 = 
  unoptimized_code := [Printf.sprintf "\t\t%s    %s\n" func_name arg1]@(!unoptimized_code)
let p_2argf func_name arg1 arg2 = 
  unoptimized_code := [Printf.sprintf "\t\t%s    %s , %s\n" func_name arg1 arg2]@(!unoptimized_code)
let setl arg1 = p_1argf "setl" arg1
let setle arg1 = p_1argf "setle" arg1
let sete arg1 = p_1argf "sete" arg1
let call arg1 = p_1argf "call" arg1
let idivq arg1 = p_1argf "idivq" arg1
let pushq arg1 = p_1argf "pushq" arg1
let popq arg1 = p_1argf "popq" arg1
let notq arg1 = p_1argf "notq" arg1
let negq arg1 = p_1argf "negq" arg1
let incq arg1 = p_1argf "incq" arg1
let decq arg1 = p_1argf "decq" arg1
let jmp arg1 = p_1argf "jmp" arg1
let je arg1 = p_1argf "je" arg1
let leaq arg1 arg2 = p_2argf "leaq" arg1 arg2
let movq arg1 arg2 = p_2argf "movq" arg1 arg2
let addq arg1 arg2 = if not (arg1 = "$0")then p_2argf "addq" arg1 arg2 else ()
let subq arg1 arg2 = if not (arg1 = "$0")then p_2argf "subq" arg1 arg2 else ()
let cmpq arg1 arg2 = p_2argf "cmpq" arg1 arg2
let imulq arg1 arg2 = p_2argf "imulq" arg1 arg2
let ret = p_0argf "ret"
let cqto = p_0argf "cqto"

let p_register delta reg = 
  if delta=0 then
    Printf.sprintf "(%s)" reg 
  else
    Printf.sprintf "%d(%s)" delta reg 

let print_global_int var_name = 
  unoptimized_code := [Printf.sprintf ".data\n%s:\n\t\t.zero    8\n.text\n" var_name]@(!unoptimized_code)
(*let print_func out name id = Printf.fprintf out "%s%d:\n" name id*)
(*let get_func_inline out name id = Printf.sprintf "%s%d" name id*)
let print_label name id = 
  unoptimized_code := [Printf.sprintf "\t\t.%s%d:\n" name id]@(!unoptimized_code)
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
let rec compile_expr env loc_expr stack_offset =
  let (loc,expr)=loc_expr in
  match expr with
  |VAR (name) -> movq (get_value_var env env name loc) "%rax"
  |CST (n) -> movq (int_literal n) "%rax"
  |STRING (str) -> begin 
    let address = get_str_adress str !str_env in
    match address with
      |None -> leaq ((put_str_adress str)^"(%rip)") "%rax" 
      |Some addr -> leaq (addr ^"(%rip)" )"%rax"  (* potentillement penser à esaped *)
    end
  |SET_VAR (var, loc_expr1) -> 
      compile_expr env loc_expr1 stack_offset ;
      movq "%rax" (get_value_var env env var loc) 
  |SET_ARRAY (var, loc_expr_index , loc_expr_val) ->
      compile_expr env loc_expr_index stack_offset ;
      imulq (int_literal 8) "%rax" ;
      pushq "%rax" ;
      compile_expr env loc_expr_val stack_offset ;
      popq "%rbx" ;
      movq (get_value_var env env var loc) "%rcx"  ;
      addq "%rbx" "%rcx" ;
      movq "%rax" (p_register 0 "%rcx")  
  |CALL (name, args) ->
      let func_name = get_value_func env env name loc in
      let nb_args = List.length args in
      let stack_delta_args = if nb_args <= 6 then 0 else (nb_args-6)*8 in
      let new_stack_offset = stack_offset + stack_delta_args in
      let stack_adjustment = (abs new_stack_offset) mod 16 in
      subq (int_literal stack_adjustment) "%rsp" ; (* adjusting stack *)
      handling_args_call env (new_stack_offset+stack_adjustment)   args;
      movq (int_literal 0) "%rax" ;
      call func_name ;
      addq (int_literal stack_delta_args) "%rsp" ; (* adjusting stack *)
      addq (int_literal stack_adjustment) "%rsp"  (* adjusting stack *)


  |OP1 (op1, le) -> compile_mon_op env stack_offset op1 le      
  |OP2 (op2, le1, le2) -> compile_bin_op env stack_offset op2 le1 le2 
  |CMP (cmpop, le1, le2) -> compile_cmp_op env stack_offset cmpop le1 le2 
  |EIF (le, leIf, leElse) ->
      let current_if_n = !if_n +1 in
      if_n := !if_n + 1;
      compile_expr env le stack_offset ;
      cmpq (int_literal 0) "%rax" ;
      je (get_label "EIF_ELSE" current_if_n) ;
      compile_expr env leIf stack_offset  ;
      jmp (get_label "EIF_END" current_if_n) ;
      print_label  "EIF_ELSE" current_if_n;
      compile_expr env leElse stack_offset  ;
      print_label  "EIF_END" current_if_n
  |ESEQ list_loc_expr -> 
      List.iter (fun le ->
      compile_expr env le stack_offset 
      ) list_loc_expr

and compile_mon_op env stack_offset op1 le  =
  let (loc,expr) = le in
  match op1 with 
  | M_MINUS -> 
      compile_expr env le stack_offset ;
      negq "%rax" 
  | M_NOT ->
      compile_expr env le stack_offset ;
      notq "%rax" 
  | _ ->
    match expr with
    |VAR v -> 
      begin
        match op1 with
        |M_POST_INC ->
            movq (get_value_var env env v loc) "%rax" ;
            incq  (get_value_var env env v loc) 
        |M_POST_DEC ->
            movq (get_value_var env env v loc) "%rax" ;
            decq  (get_value_var env env v loc) 
        |M_PRE_INC ->
            incq (get_value_var env env v loc) ;
            movq (get_value_var env env v loc) "%rax" 
        |M_PRE_DEC ->
            decq (get_value_var env env v loc) ;
            movq (get_value_var env env v loc) "%rax" 
        |_ -> ()
      end 
    |OP2 (S_INDEX, (loc1,e1) , (loc2,e2))->
        begin
          compile_expr env (loc2,e2) stack_offset ;
          pushq "%rax" ;
          compile_expr env (loc1,e1) stack_offset ;
          popq "%rbx" ;
          imulq (int_literal 8) "%rbx" ;
          addq "%rbx" "%rax" ;
          match op1 with
          |M_POST_INC ->
              pushq (p_register 0 "%rax" ) ;
              incq (p_register 0 "%rax" ) ;
              popq "%rax" 
          |M_POST_DEC ->
              pushq (p_register 0 "%rax" ) ;
              decq (p_register 0 "%rax" ) ;
              popq "%rax" 
          |M_PRE_INC ->
              incq (p_register 0 "%rax" ) ;
              movq (p_register 0 "%rax" ) "%rax" 
          |M_PRE_DEC ->
              decq (p_register 0 "%rax" ) ;
              movq (p_register 0 "%rax" ) "%rax" 
          |_ -> ()

        end
    |_ -> custom_raise IllegalMonOpOnNonVar (Some loc)
and compile_bin_op env stack_offset op2 le1 le2  =
  compile_expr env le2 stack_offset  ;
  pushq "%rax" ;
  compile_expr env le1 stack_offset  ;
  popq "%rbx" ;
  match op2 with
  |S_MUL -> 
      movq "%rbx" "%r15" ;
      movq "%rax" "%rbx" ;
      movq "%r15" "%rax" ;
      imulq "%rbx" "%rax" 
  |S_DIV ->
      cqto ();
      idivq "%rbx" ;
  |S_MOD ->
      cqto ();
      idivq "%rbx" ;
      movq "%rdx" "%rax" 
  |S_ADD -> 
      movq "%rbx" "%r15" ;
      movq "%rax" "%rbx" ;
      movq "%r15" "%rax" ;
      addq "%rbx" "%rax" 
  |S_SUB -> 
      subq "%rbx" "%rax" 
  |S_INDEX -> 
      movq "%rbx" "%r15" ;
      movq "%rax" "%rbx" ;
      movq "%r15" "%rax" ;
      imulq (int_literal 8) "%rax" ;
      addq "%rbx" "%rax" ;
      movq (p_register 0 "%rax") "%rax" 

and compile_cmp_op env stack_offset cmp_op le1 le2  =
  compile_expr env le2 stack_offset ;
  pushq "%rax" ;
  compile_expr env le1 stack_offset ;
  popq "%rbx" ;
  cmpq "%rbx" "%rax" ;
  movq (int_literal 0) "%rax" ; 
  (* potentiellement reset rax *)
  match cmp_op with
  |C_LT -> setl "%al" 
  |C_LE -> setle "%al" 
  |C_EQ -> sete "%al" 


and handling_args_call env stack_offset  args = 
  let rev_args = List.rev args in
  List.iteri (fun i arg ->
      begin
        compile_expr env arg stack_offset  ;
        pushq "%rax" ;    
      end
  ) rev_args;
  List.iteri (fun i arg ->
    if i <= 5 then
      begin
        popq (arg_register i)     
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

and compile_block env var_deepness stack_offset vars (code_list : CAST.loc_code list)  : unit =
  let (to_sub_sizeofint, (new_stack_offset, block_env) ) = handle_local_vars env vars var_deepness stack_offset in
  let rec aux (code_list : CAST.loc_code list) env var_deepness stack_offset last_was_return =
    if last_was_return = false then
      match code_list with
      |[] -> ()
      |(hd_loc, hd_code)::tl ->
          compile_code env var_deepness stack_offset (hd_loc,hd_code) ;
          match hd_code with
                 |CRETURN o -> aux tl env var_deepness stack_offset true 
                 |_ -> aux tl env var_deepness stack_offset false 
    else
      ()
  in
  subq (int_literal to_sub_sizeofint) "%rsp" ;
  aux code_list block_env var_deepness new_stack_offset false;
  addq (int_literal to_sub_sizeofint) "%rsp" 

and compile_if loc_expr l_c_if l_c_else env var_deepness stack_offset  : unit =
  let current_if_n = !if_n+1 in
  if_n := !if_n+1;
  compile_expr env loc_expr stack_offset  ;
  cmpq "$0" "%rax" ;
  je (get_label "ELSE_BODY" current_if_n) ;
  compile_code env var_deepness stack_offset l_c_if ;
  jmp (get_label "END_IF" current_if_n) ;
  print_label  "ELSE_BODY" current_if_n;
  compile_code env var_deepness stack_offset l_c_else ;
  print_label  "END_IF" current_if_n
  
and compile_while env loc_expr loc_code var_deepness stack_offset  : unit =
  let current_while_n = !while_n+1 in
  while_n := !while_n+1;
  jmp (get_label "WHILE_TEST" current_while_n) ;
  print_label  "WHILE_BODY" current_while_n;
  compile_code env var_deepness stack_offset loc_code ; 
  print_label  "WHILE_TEST" current_while_n;
  compile_expr env loc_expr stack_offset  ;
  cmpq "$0" "%rax" ;
  je (get_label "END_WHILE" current_while_n) ;
  jmp (get_label "WHILE_BODY" current_while_n) ;
  print_label  "END_WHILE" current_while_n

and compile_return env loc_expr stack_offset  : unit = 
  compile_expr env loc_expr stack_offset  ;
  addq (int_literal (abs stack_offset)) "%rsp" ;
  popq  "%rbp" ;
  ret ();
  unoptimized_code := ["\n"]@(!unoptimized_code)

and compile_code env var_deepness stack_offset loc_code  : unit =
  let (loc,code) = loc_code in
  match code with
  | CBLOCK (vars,code_list) -> compile_block env (var_deepness+1) stack_offset vars code_list 
  | CEXPR (loc_expr) -> compile_expr env loc_expr stack_offset   
  | CIF (loc_expr,l_c_if,l_c_else) -> compile_if loc_expr l_c_if l_c_else env var_deepness stack_offset  
  | CWHILE (loc_expr,l_c) -> compile_while env loc_expr l_c var_deepness stack_offset  
  | CRETURN (loc_expr) -> match loc_expr with 
                          |None -> custom_raise  EmptyReturnOfNonVoidFunction (Some loc) 
                          |Some le -> compile_return env le stack_offset 

let rec compile_fun env name args code  : unit =
    let (stack_offset,fun_env) =
      unoptimized_code := [Printf.sprintf "%s:\n" name]@(!unoptimized_code) ;
      pushq "%rbp" ;
      movq  "%rsp" "%rbp" ;
      handle_args env args  in
    (*args_begin ; str_code ;args_end ;*)
    (*handle_args env args;*)
    compile_code fun_env 1 stack_offset code ;
    addq (int_literal (-stack_offset)) "%rsp" ;
    popq  "%rbp" ;
    ret ();
    unoptimized_code := ["\n"]@(!unoptimized_code) 


and handle_args env args  = 
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
            if n <= 5 then movq (arg_register n) adress ;
            aux new_env tl (n+1) new_stack_offset 
          end
      |_ -> Printf.printf "this case should never happen because syntax handles it" ; (stack_offset,env) 
    in
    subq (int_literal to_sub_sizeofint) "%rsp" ;
    aux env args 0 0
    (*addq to_sub_sizeofint "%rsp";*)

let rec optimize_code_empty_elses code (acc : string list) =
  match code with
  |[] -> acc
  |hd::tl -> 
      match tl with
      |[] -> List.rev ([hd]@(List.rev acc))
      |hd2::tl2 ->
          match tl2 with
          |[] -> List.rev ([hd2;hd]@(List.rev acc))
          |hd3::tl3 ->
              try Scanf.sscanf hd "\t\t%s    .END_IF%d\n" (
                fun cmd id1 ->
                  try Scanf.sscanf hd2 "\t\t.ELSE_BODY%d:\n" (
                    fun id2 ->
                      try Scanf.sscanf hd3 "\t\t.END_IF%d:\n" (
                        fun id3 ->
                          if id1=id2 && id2=id3 then
                            begin
                            Printf.printf "On passe ! id1 = %d , id2 = %d , id3 = %d\n" id1 id2 id3;
                            optimize_code_empty_elses tl3 (List.rev ([hd2]@(List.rev acc)))
                            end
                          else
                            optimize_code_empty_elses tl (List.rev ([hd]@(List.rev acc)))
                      )
                      with e ->
                        optimize_code_empty_elses tl (List.rev ([hd]@(List.rev acc)))
                  )
                  with e ->
                    optimize_code_empty_elses tl (List.rev ([hd]@(List.rev acc)))
              )
              with e ->
                optimize_code_empty_elses tl (List.rev ([hd]@(List.rev acc)))


let rec rax_wont_be_used rest_of_code =
  match rest_of_code with
  |[] -> true
  |hd::tl -> 
      try Scanf.sscanf hd "\t\t%s    %s , %s\n" (
        fun cmd arg1 arg2 ->
          if arg1="%rax" then 
            false
          else if arg2="%rax" && cmd="movq" then
            true
          else
            rax_wont_be_used tl
      )
      with e ->
      try Scanf.sscanf hd "\t\t%s    %s\n" (
        fun cmd arg1 ->
          if arg1="%rax" || arg1="%al" then 
            false
          else
            rax_wont_be_used tl
      )
      with e ->
      try Scanf.sscanf hd "\t\t%s\n" (
        fun cmd ->
          if cmd="ret" || cmd="cqto" then 
            false
          else
            rax_wont_be_used tl
      )
      with e -> true



let rec optimize_code_rax_const code (acc : string list) =
  match code with
  |[] -> acc
  |hd::tl -> 
      match tl with
      |[] -> List.rev ([hd]@(List.rev acc))
      |hd2::tl2 ->
          try Scanf.sscanf hd "\t\t%s    $%d , %s\n" (
            fun cmd value arg2 ->
              try Scanf.sscanf hd2 "\t\t%s    %s , %s\n" (
                fun cmd2 arg3 arg4 ->
                  if cmd=cmd2 && cmd="movq" && arg2=arg3 && arg2="%rax" && (rax_wont_be_used tl2) then
                    optimize_code_rax_const tl2 (List.rev ([Printf.sprintf "\t\t%s    $%d , %s\n" cmd value arg4 ]@(List.rev acc)))
                  else
                    optimize_code_rax_const tl (List.rev ([hd]@(List.rev acc)))
              )
              with e ->
                optimize_code_rax_const tl2 (List.rev ([hd2;hd]@(List.rev acc)))
          )
          with e ->
            optimize_code_rax_const tl (List.rev ([hd]@(List.rev acc)))

    





let rec print_code out code =
  match code with
  |[] -> ()
  |hd::tl -> Printf.fprintf out "%s" hd ; print_code out tl

let compile out decl_list =
  let rec compile_global decl_list env =
    match decl_list with 
    |[] -> ()
    |hd::tl -> match hd with
        |CDECL (loc,name) -> 
            begin
              is_in_environment_same_level env env name loc 0;
              print_global_int  name;
              compile_global tl (add_key env name (VAR_ENV (0, (name ^ "(%rip)"))))
            end
        |CFUN (loc,name,args,code)->
            let _ = func_is_in_environment env env name loc in
            let new_env = add_key env name (FUN_ENV (List.length args)) in 
            begin
              Printf.printf "Debug : name = %s\n" name;
              compile_fun new_env name args code ;
              compile_global tl new_env
            end
  in
  (* Printf.fprintf out ".align 16\n\n"; *)
  (*Printf.fprintf out ".file    \"test.c\"\n";
  Printf.fprintf out ".section .text\n";*)
  Printf.fprintf out ".global main\n\n";
  compile_global decl_list empty_env;
  let optimized_code_first_pass = optimize_code_empty_elses (List.rev !unoptimized_code) [] in
  let optimized_code_second_pass = optimize_code_rax_const optimized_code_first_pass [] in
  print_code out optimized_code_second_pass;
  List.iter (fun v ->
    let (value, label) = v in
    Printf.fprintf out "%s:\n    .string    \"%s\"\n" label (String.escaped value)
  ) !str_env


  (* cquand call vérifier que ce n'est pas main ? *)
