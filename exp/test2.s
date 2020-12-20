.align 16

.global main

d:
		.zero    4

c0:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		movq    %rdi , -8(%rbp)
		movq    %rsi , -16(%rbp)
		subq    $0 , %rsp
		movq    $2 , %rax
		movq    %rax , d(%rip)
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rbx
		popq    %rax
		cmpq    %rbx , %rax
		xorq    %rax , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY1
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		jmp    .END1
		addq    $0 , %rsp
		jmp    .END_IF1
	.ELSE_BODY1:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF1:
		movq    -8(%rbp) , %rax
		jmp    .END1
		addq    $0 , %rsp
	.END1:
		movq    %rbp , %rsp
		popq    %rbp
		ret

main:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $0 , %rsp
		subq    $0 , %rsp
		movq    $13 , %rax
		movq    %rax , %rdi
		movq    $5 , %rax
		movq    %rax , %rsi
		movq    $5 , %rax
		movq    $13 , %rax
		call    c0
		addq    $0 , %rsp
		addq    $0 , %rsp
		jmp    .END2
		addq    $0 , %rsp
	.END2:
		movq    %rbp , %rsp
		popq    %rbp
		ret


