.global main

main:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $16 , %rsp
		movq    %rdi , -8(%rbp)
		movq    %rsi , -16(%rbp)
		subq    $16 , %rsp
		movq    $1 , -24(%rbp)
		jmp    .WHILE_TEST1
		.WHILE_BODY1:
		subq    $16 , %rsp
		movq    $1 , %rax
		negq    %rax
		movq    %rax , -48(%rbp)
		leaq    LString0(%rip) , %rax
		pushq    %rax
		movq    -24(%rbp) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    $8 , %rax
		addq    %rbx , %rax
		movq    (%rax) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    fopen
		movq    %rax , -40(%rbp)
		jmp    .WHILE_TEST2
		.WHILE_BODY2:
		movq    stdout(%rip) , %rax
		pushq    %rax
		movq    -32(%rbp) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    fputc
		cltq
		.WHILE_TEST2:
		movq    $1 , %rax
		negq    %rax
		pushq    %rax
		movq    -40(%rbp) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    fgetc
		cltq
		movq    %rax , -32(%rbp)
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE1
		movq    $0 , %rax
		jmp    .EIF_END1
		.EIF_ELSE1:
		movq    $1 , %rax
		.EIF_END1:
		cmpq    $0 , %rax
		je    .END_WHILE2
		jmp    .WHILE_BODY2
		.END_WHILE2:
		movq    -40(%rbp) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    fclose
		cltq
		addq    $16 , %rsp
		movq    -24(%rbp) , %rax
		incq    -24(%rbp)
		.WHILE_TEST1:
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    -24(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .END_WHILE1
		jmp    .WHILE_BODY1
		.END_WHILE1:
		movq    stdout(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    fflush
		cltq
		movq    $0 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $16 , %rsp
		addq    $16 , %rsp
		popq    %rbp
		ret

LString0:
    .string    "r"
