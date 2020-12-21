.global main

.data
d:
		.zero    8
.text
c0:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		movq    %rdi , -8(%rbp)
		movq    %rsi , -16(%rbp)
		subq    $0 , %rsp
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rbx
		popq    %rcx
		cmpq    %rcx , %rbx
		movq    $0 , %rax
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
		movq    $2 , %rax
		movq    %rax , d(%rip)
		subq    $0 , %rsp
		leaq    LString0(%rip) , %rax
		movq    %rax , %rdi
		movq    d(%rip) , %rax
		movq    %rax , %rsi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		subq    $0 , %rsp
		movq    $3 , %rax
		movq    %rax , %rdi
		movq    $5 , %rax
		movq    %rax , %rsi
		call    c0
		addq    $0 , %rsp
		addq    $0 , %rsp
		jmp    .END2
		addq    $0 , %rsp
	.END2:
		movq    %rbp , %rsp
		popq    %rbp
		ret

.data
e:
		.zero    8
.text
LString0:
    .string    "test  %d\n"
