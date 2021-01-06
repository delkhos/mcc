.global main

main:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $8 , %rsp
		movq    $12 , -8(%rbp)
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    $10 , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY1
		movq    $2 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    %rbx , %rax
		movq    %rax , -8(%rbp)
		jmp    .END_IF1
		.ELSE_BODY1:
		.END_IF1:
		movq    -8(%rbp) , %rax
		addq    $8 , %rsp
		popq    %rbp
		ret

		addq    $8 , %rsp
		popq    %rbp
		ret

