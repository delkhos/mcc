.global main

.data
i:
		.zero    8
.text
.data
k:
		.zero    8
.text
main:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $32 , %rsp
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString0(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString1(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString2(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString1(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString3(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		movq    $1 , %rax
		cmpq    $0 , %rax
		je    .ELSE_BODY1
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString4(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		jmp    .END_IF1
	.ELSE_BODY1:
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString5(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		movq    %rax , %rdi
		call    exit
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
	.END_IF1:
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString6(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		call    variables
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		cmpq    $0 , %rax
		je    .ELSE_BODY2
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString5(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		jmp    .END1
		jmp    .END_IF2
	.ELSE_BODY2:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF2:
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString7(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		call    test_comp
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		cmpq    $0 , %rax
		je    .ELSE_BODY3
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString5(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		movq    %rax , %rdi
		call    exit
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		jmp    .END_IF3
	.ELSE_BODY3:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF3:
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString8(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		call    test_op
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString9(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		subq    $0 , %rsp
		movq    $0 , %rax
		movq    %rax , -8(%rbp)
		jmp    .WHILE_TEST1
	.WHILE_BODY1:
	.WHILE_TEST1:
		movq    $3 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		movq    -8(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -8(%rbp)
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .END_WHILE1
		jmp    .WHILE_BODY1
	.END_WHILE1:
		addq    $0 , %rsp
		movq    $4 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY4
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString4(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		jmp    .END_IF4
	.ELSE_BODY4:
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString5(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		jmp    .END1
	.END_IF4:
		addq    $32 , %rsp
	.END1:
		movq    %rbp , %rsp
		popq    %rbp
		ret

test_comp:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $16 , %rsp
		movq    $2 , %rax
		movq    %rax , -8(%rbp)
		movq    $2 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY5
		movq    $0 , %rax
		jmp    .END_IF5
	.ELSE_BODY5:
		movq    $1 , %rax
		jmp    .END2
	.END_IF5:
		movq    $3 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY6
		movq    $0 , %rax
		jmp    .END_IF6
	.ELSE_BODY6:
		movq    $1 , %rax
		jmp    .END2
	.END_IF6:
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    $1 , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY7
		movq    $0 , %rax
		jmp    .END_IF7
	.ELSE_BODY7:
		movq    $1 , %rax
		jmp    .END2
	.END_IF7:
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE9
		movq    $0 , %rax
		jmp    .EIF_END9
	.EIF_ELSE9:
		movq    $1 , %rax
	.EIF_END9:
		cmpq    $0 , %rax
		je    .ELSE_BODY8
		movq    $0 , %rax
		jmp    .END_IF8
	.ELSE_BODY8:
		movq    $1 , %rax
		jmp    .END2
	.END_IF8:
		movq    $2 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE10
		movq    $0 , %rax
		jmp    .EIF_END10
	.EIF_ELSE10:
		movq    $1 , %rax
	.EIF_END10:
		movq    %rax , -16(%rbp)
		movq    -16(%rbp) , %rax
		jmp    .END2
		addq    $16 , %rsp
	.END2:
		movq    %rbp , %rsp
		popq    %rbp
		ret

test_op:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $16 , %rsp
		movq    $0 , %rax
		movq    %rax , -8(%rbp)
		movq    $0 , %rax
		movq    %rax , -16(%rbp)
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		movq    -8(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -8(%rbp)
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE12
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END12
	.EIF_ELSE12:
		movq    $0 , %rax
	.EIF_END12:
		cmpq    $0 , %rax
		je    .ELSE_BODY11
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    $1 , %rbx
		popq    %rax
		addq    %rbx , %rax
		movq    %rax , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString10(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF11
	.ELSE_BODY11:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF11:
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		movq    -8(%rbp) , %rbx
		dec    %rbx
		movq    %rbx , -8(%rbp)
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE14
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END14
	.EIF_ELSE14:
		movq    $0 , %rax
	.EIF_END14:
		cmpq    $0 , %rax
		je    .ELSE_BODY13
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    $1 , %rbx
		popq    %rax
		addq    %rbx , %rax
		movq    %rax , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString11(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF13
	.ELSE_BODY13:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF13:
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		inc    %rax
		movq    %rax , -8(%rbp)
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE16
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END16
	.EIF_ELSE16:
		movq    $0 , %rax
	.EIF_END16:
		cmpq    $0 , %rax
		je    .ELSE_BODY15
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    $1 , %rbx
		popq    %rax
		addq    %rbx , %rax
		movq    %rax , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString12(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF15
	.ELSE_BODY15:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF15:
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		dec    %rax
		movq    %rax , -8(%rbp)
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE18
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END18
	.EIF_ELSE18:
		movq    $0 , %rax
	.EIF_END18:
		cmpq    $0 , %rax
		je    .ELSE_BODY17
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    $1 , %rbx
		popq    %rax
		addq    %rbx , %rax
		movq    %rax , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString13(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF17
	.ELSE_BODY17:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF17:
		movq    $4 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE20
		movq    $0 , %rax
		jmp    .EIF_END20
	.EIF_ELSE20:
		movq    $1 , %rax
	.EIF_END20:
		cmpq    $0 , %rax
		je    .ELSE_BODY19
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString14(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		movq    %rax , %rdi
		call    exit
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		jmp    .END_IF19
	.ELSE_BODY19:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF19:
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		movq    $8 , %rax
		movq    %rax , %rdi
		call    malloc
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		movq    %rax , -8(%rbp)
		movq    $0 , %rax
		movq    %rax , -16(%rbp)
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $5 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $1 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $9 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $5 , %rax
		pushq    %rax
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rbx
		popq    %rax
		imulq    $8 , %rax
		addq    %rax , %rbx
		movq    (%rbx) , %rax
		movq    (%rbx) , %rcx
		inc    %rcx
		movq    %rcx , (%rbx)
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE22
		movq    $6 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    $0 , %rbx
		popq    %rax
		imulq    $8 , %rbx
		addq    %rbx , %rax
		movq    (%rax) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END22
	.EIF_ELSE22:
		movq    $0 , %rax
	.EIF_END22:
		cmpq    $0 , %rax
		je    .ELSE_BODY21
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString15(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF21
	.ELSE_BODY21:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF21:
		movq    $9 , %rax
		pushq    %rax
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rbx
		popq    %rax
		imulq    $8 , %rax
		addq    %rax , %rbx
		movq    (%rbx) , %rax
		movq    (%rbx) , %rcx
		dec    %rcx
		movq    %rcx , (%rbx)
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE24
		movq    $8 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    $1 , %rbx
		popq    %rax
		imulq    $8 , %rbx
		addq    %rbx , %rax
		movq    (%rax) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END24
	.EIF_ELSE24:
		movq    $0 , %rax
	.EIF_END24:
		cmpq    $0 , %rax
		je    .ELSE_BODY23
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString16(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF23
	.ELSE_BODY23:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF23:
		movq    $7 , %rax
		pushq    %rax
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rbx
		popq    %rax
		imulq    $8 , %rax
		addq    %rax , %rbx
		movq    (%rbx) , %rcx
		inc    %rcx
		movq    %rcx , (%rbx)
		movq    %rcx , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE26
		movq    $7 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    $0 , %rbx
		popq    %rax
		imulq    $8 , %rbx
		addq    %rbx , %rax
		movq    (%rax) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END26
	.EIF_ELSE26:
		movq    $0 , %rax
	.EIF_END26:
		cmpq    $0 , %rax
		je    .ELSE_BODY25
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString17(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF25
	.ELSE_BODY25:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF25:
		movq    $7 , %rax
		pushq    %rax
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rbx
		popq    %rax
		imulq    $8 , %rax
		addq    %rax , %rbx
		movq    (%rbx) , %rcx
		dec    %rcx
		movq    %rcx , (%rbx)
		movq    %rcx , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE28
		movq    $7 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    $1 , %rbx
		popq    %rax
		imulq    $8 , %rbx
		addq    %rbx , %rax
		movq    (%rax) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END28
	.EIF_ELSE28:
		movq    $0 , %rax
	.EIF_END28:
		cmpq    $0 , %rax
		je    .ELSE_BODY27
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString18(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF27
	.ELSE_BODY27:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF27:
		movq    $4 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE30
		movq    $0 , %rax
		jmp    .EIF_END30
	.EIF_ELSE30:
		movq    $1 , %rax
	.EIF_END30:
		cmpq    $0 , %rax
		je    .ELSE_BODY29
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString14(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		movq    %rax , %rdi
		call    exit
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		jmp    .END_IF29
	.ELSE_BODY29:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF29:
		movq    $0 , %rax
		movq    %rax , -16(%rbp)
		movq    $3 , %rax
		pushq    %rax
		movq    $13 , %rax
		pushq    %rax
		movq    $5 , %rbx
		popq    %rax
		cqto
		idivq    %rbx
		movq    %rdx , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY31
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString19(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF31
	.ELSE_BODY31:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF31:
		movq    $12 , %rax
		pushq    %rax
		movq    $7 , %rax
		pushq    %rax
		movq    $5 , %rbx
		popq    %rax
		addq    %rbx , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY32
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString20(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF32
	.ELSE_BODY32:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF32:
		movq    $92 , %rax
		negq    %rax
		pushq    %rax
		movq    $4 , %rax
		negq    %rax
		pushq    %rax
		movq    $23 , %rbx
		popq    %rax
		imulq    %rbx , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY33
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString21(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF33
	.ELSE_BODY33:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF33:
		movq    $2 , %rax
		pushq    %rax
		movq    $7 , %rax
		pushq    %rax
		movq    $3 , %rbx
		popq    %rax
		cqto
		idivq    %rbx
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY34
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString22(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF34
	.ELSE_BODY34:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF34:
		movq    $0 , %rax
		cmpq    $0 , %rax
		je    .EIF_ELSE36
		movq    $0 , %rax
		jmp    .EIF_END36
	.EIF_ELSE36:
		movq    $1 , %rax
	.EIF_END36:
		cmpq    $0 , %rax
		je    .ELSE_BODY35
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString23(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF35
	.ELSE_BODY35:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF35:
		movq    $7 , %rax
		pushq    %rax
		movq    $12 , %rax
		pushq    %rax
		movq    $5 , %rbx
		popq    %rax
		subq    %rbx , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY37
		subq    $0 , %rsp
		movq    -16(%rbp) , %rax
		movq    -16(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -16(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString24(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		addq    $0 , %rsp
		jmp    .END_IF37
	.ELSE_BODY37:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF37:
		movq    $6 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE39
		movq    $0 , %rax
		jmp    .EIF_END39
	.EIF_ELSE39:
		movq    $1 , %rax
	.EIF_END39:
		cmpq    $0 , %rax
		je    .ELSE_BODY38
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $0 , %rsp
		leaq    LString25(%rip) , %rax
		movq    %rax , %rdi
		call    printf
		addq    $0 , %rsp
		addq    $0 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		jmp    .END_IF38
	.ELSE_BODY38:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF38:
		movq    $0 , %rax
		jmp    .END3
		addq    $16 , %rsp
	.END3:
		movq    %rbp , %rsp
		popq    %rbp
		ret

zer:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $0 , %rsp
		movq    $0 , %rax
		movq    %rax , i(%rip)
		jmp    .END4
		addq    $0 , %rsp
	.END4:
		movq    %rbp , %rsp
		popq    %rbp
		ret

inci:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $0 , %rsp
		movq    i(%rip) , %rax
		inc    %rax
		movq    %rax , i(%rip)
		jmp    .END5
		addq    $0 , %rsp
	.END5:
		movq    %rbp , %rsp
		popq    %rbp
		ret

variables:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $8 , %rsp
		movq    $3 , %rax
		movq    %rax , -8(%rbp)
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $8 , %rsp
		call    zer
		addq    $0 , %rsp
		addq    $8 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		subq    $8 , %rsp
		movq    $5 , %rax
		movq    %rax , -16(%rbp)
		movq    $5 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE41
		movq    $0 , %rax
		jmp    .EIF_END41
	.EIF_ELSE41:
		movq    $1 , %rax
	.EIF_END41:
		cmpq    $0 , %rax
		je    .ELSE_BODY40
		subq    $0 , %rsp
		movq    $1 , %rax
		jmp    .END6
		addq    $0 , %rsp
		jmp    .END_IF40
	.ELSE_BODY40:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF40:
		addq    $8 , %rsp
		movq    $3 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE43
		movq    $0 , %rax
		jmp    .EIF_END43
	.EIF_ELSE43:
		movq    $1 , %rax
	.EIF_END43:
		cmpq    $0 , %rax
		je    .ELSE_BODY42
		subq    $0 , %rsp
		movq    $1 , %rax
		jmp    .END6
		addq    $0 , %rsp
		jmp    .END_IF42
	.ELSE_BODY42:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF42:
		movq    $1 , %rax
		pushq    %rax
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $8 , %rsp
		call    inci
		addq    $0 , %rsp
		addq    $8 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE46
		movq    $0 , %rax
		jmp    .EIF_END46
	.EIF_ELSE46:
		movq    $1 , %rax
	.EIF_END46:
		cmpq    $0 , %rax
		je    .EIF_ELSE45
		movq    $1 , %rax
		jmp    .EIF_END45
	.EIF_ELSE45:
		movq    $2 , %rax
		pushq    %rax
		pushq    %rdi
		pushq    %rsi
		pushq    %rdx
		pushq    %rcx
		pushq    %r8
		pushq    %r9
		subq    $8 , %rsp
		call    inci
		addq    $0 , %rsp
		addq    $8 , %rsp
		popq    %r9
		popq    %r8
		popq    %rcx
		popq    %rdx
		popq    %rsi
		popq    %rdi
		popq    %rcx
		cmpq    %rcx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE47
		movq    $0 , %rax
		jmp    .EIF_END47
	.EIF_ELSE47:
		movq    $1 , %rax
	.EIF_END47:
	.EIF_END45:
		cmpq    $0 , %rax
		je    .ELSE_BODY44
		subq    $0 , %rsp
		movq    $1 , %rax
		jmp    .END6
		addq    $0 , %rsp
		jmp    .END_IF44
	.ELSE_BODY44:
		subq    $0 , %rsp
		addq    $0 , %rsp
	.END_IF44:
		movq    $0 , %rax
		jmp    .END6
		addq    $8 , %rsp
	.END6:
		movq    %rbp , %rsp
		popq    %rbp
		ret

LString25:
    .string    " [x] Some tests failed ! Check your binary operators.\n"
LString24:
    .string    "  [+] Substract OK\n"
LString23:
    .string    "  [+] Negation OK\n"
LString22:
    .string    "  [+] Quotient OK\n"
LString21:
    .string    "  [+] Product OK\n"
LString20:
    .string    "  [+] Sum OK\n"
LString19:
    .string    "  [+] Modulo OK\n"
LString18:
    .string    "  [+] Pre decrement array OK\n"
LString17:
    .string    "  [+] Pre increment array OK\n"
LString16:
    .string    "  [+] Post decrement array OK\n"
LString15:
    .string    "  [+] Post increment array OK\n"
LString14:
    .string    " [x] Some tests failed ! Check your increment/decrement operators.\n"
LString13:
    .string    "  [+] Pre decrement OK\n"
LString12:
    .string    "  [+] Pre increment OK\n"
LString11:
    .string    "  [+] Post decrement OK\n"
LString10:
    .string    "  [+] Post increment OK\n"
LString9:
    .string    " [o] Testing loops ...\t\t\t\t"
LString8:
    .string    "OK.\n [o] Testing binary operators ... \n"
LString7:
    .string    "OK.\n [o] Testing compare operators ...\t\t"
LString6:
    .string    " [o] Testing local and global variables ... \t"
LString5:
    .string    "ERROR !\n"
LString4:
    .string    "OK.\n"
LString3:
    .string    " [o] Testing conditional blocks ...\t\t"
LString2:
    .string    "          ++ Testing basic compiler features ++\n"
LString1:
    .string    "============================================================\n"
LString0:
    .string    "Starting Testsuite for C--, see Goubault's webpage for semantics references.\n"
