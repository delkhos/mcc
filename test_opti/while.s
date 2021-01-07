.global main

main:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $40 , %rsp
		movq    $0 , %rax
		movq    %rax , -8(%rbp)
		movq    $0 , %rax
		movq    %rax , -16(%rbp)
		movq    $0 , %rax
		movq    %rax , -24(%rbp)
		movq    $0 , %rax
		movq    %rax , -32(%rbp)
		movq    $0 , %rax
		movq    %rax , -40(%rbp)
		jmp    .WHILE_TEST1
	.WHILE_BODY1:
		movq    $476 , %rax
		movq    %rax , -8(%rbp)
		movq    $576 , %rax
		movq    %rax , -16(%rbp)
		movq    $2345 , %rax
		movq    %rax , -24(%rbp)
		movq    $45 , %rax
		movq    %rax , -32(%rbp)
		movq    -40(%rbp) , %rax
		incq    -40(%rbp)
	.WHILE_TEST1:
		movq    $67899899999 , %rax
		pushq    %rax
		movq    -40(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .END_WHILE1
		jmp    .WHILE_BODY1
	.END_WHILE1:
		subq    $8 , %rsp
		movq    -32(%rbp) , %rax
		pushq    %rax
		movq    -24(%rbp) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		pushq    %rax
		leaq    LString0(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		movq    $0 , %rax
		call    printf
		addq    $8 , %rsp
		movq    $0 , %rax
		addq    $40 , %rsp
		popq    %rbp
		ret

		addq    $40 , %rsp
		popq    %rbp
		ret

LString0:
    .string    "a=%d , b=%d , c=%d , d=%d\n"
