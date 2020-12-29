.global main

main:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $8 , %rsp
		movq    $6 , %rax
		movq    %rax , -8(%rbp)
		movq    $5 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rbx
		popq    %rcx
		cmpq    %rcx , %rbx
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE2
		movq    $0 , %rax
		jmp    .EIF_END2
	.EIF_ELSE2:
		movq    $1 , %rax
	.EIF_END2:
		cmpq    $0 , %rax
		je    .ELSE_BODY1
		subq    $0 , %rsp
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $8 , %rsp
		leaq    LString0(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $8 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF1
	.ELSE_BODY1:
		subq    $0 , %rsp
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $8 , %rsp
		leaq    LString1(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $8 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
	.END_IF1:
		addq    $8 , %rsp
	.END1:
		movq    %rbp , %rsp
		popq    %rbp
		ret

LString1:
    .string    "dans le else\n"
LString0:
    .string    "dans le if\n"
