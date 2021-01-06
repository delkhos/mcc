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
		subq    $32 , %rsp
		leaq    LString0(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		leaq    LString1(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		leaq    LString2(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		leaq    LString1(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		leaq    LString3(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		movq    $1 , %rax
		cmpq    $0 , %rax
		je    .ELSE_BODY1
		leaq    LString4(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF1
	.ELSE_BODY1:
		leaq    LString5(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
	.END_IF1:
		leaq    LString6(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		movq    $0 , %rax
		call    variables
		cmpq    $0 , %rax
		je    .ELSE_BODY2
		leaq    LString5(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		addq    $32 , %rsp
		popq    %rbp
		ret

		jmp    .END_IF2
	.ELSE_BODY2:
	.END_IF2:
		leaq    LString7(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		movq    $0 , %rax
		call    test_comp
		cmpq    $0 , %rax
		je    .ELSE_BODY3
		leaq    LString5(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		jmp    .END_IF3
	.ELSE_BODY3:
	.END_IF3:
		leaq    LString8(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		movq    $0 , %rax
		call    test_op
		leaq    LString9(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		movq    $0 , %rax
		movq    %rax , -8(%rbp)
		jmp    .WHILE_TEST1
	.WHILE_BODY1:
	.WHILE_TEST1:
		movq    $3 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		incq    -8(%rbp)
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .END_WHILE1
		jmp    .WHILE_BODY1
	.END_WHILE1:
		movq    $4 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY4
		leaq    LString4(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF4
	.ELSE_BODY4:
		leaq    LString5(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		addq    $32 , %rsp
		popq    %rbp
		ret

	.END_IF4:
		addq    $32 , %rsp
		popq    %rbp
		ret

test_comp:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $16 , %rsp
		movq    $2 , %rax
		movq    %rax , -8(%rbp)
		movq    $2 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY5
		movq    $0 , %rax
		jmp    .END_IF5
	.ELSE_BODY5:
		movq    $1 , %rax
		addq    $16 , %rsp
		popq    %rbp
		ret

	.END_IF5:
		movq    $3 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY6
		movq    $0 , %rax
		jmp    .END_IF6
	.ELSE_BODY6:
		movq    $1 , %rax
		addq    $16 , %rsp
		popq    %rbp
		ret

	.END_IF6:
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    $1 , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY7
		movq    $0 , %rax
		jmp    .END_IF7
	.ELSE_BODY7:
		movq    $1 , %rax
		addq    $16 , %rsp
		popq    %rbp
		ret

	.END_IF7:
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
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
		addq    $16 , %rsp
		popq    %rbp
		ret

	.END_IF8:
		movq    $2 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
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
		addq    $16 , %rsp
		popq    %rbp
		ret

		addq    $16 , %rsp
		popq    %rbp
		ret

test_op:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $16 , %rsp
		movq    $0 , %rax
		movq    %rax , -8(%rbp)
		movq    $0 , %rax
		movq    %rax , -16(%rbp)
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		incq    -8(%rbp)
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE12
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END12
	.EIF_ELSE12:
		movq    $0 , %rax
	.EIF_END12:
		cmpq    $0 , %rax
		je    .ELSE_BODY11
		movq    $1 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		movq    %rax , -16(%rbp)
		leaq    LString10(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF11
	.ELSE_BODY11:
	.END_IF11:
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		decq    -8(%rbp)
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE14
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END14
	.EIF_ELSE14:
		movq    $0 , %rax
	.EIF_END14:
		cmpq    $0 , %rax
		je    .ELSE_BODY13
		movq    $1 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		movq    %rax , -16(%rbp)
		leaq    LString11(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF13
	.ELSE_BODY13:
	.END_IF13:
		movq    $1 , %rax
		pushq    %rax
		incq    -8(%rbp)
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE16
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END16
	.EIF_ELSE16:
		movq    $0 , %rax
	.EIF_END16:
		cmpq    $0 , %rax
		je    .ELSE_BODY15
		movq    $1 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		movq    %rax , -16(%rbp)
		leaq    LString12(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF15
	.ELSE_BODY15:
	.END_IF15:
		movq    $0 , %rax
		pushq    %rax
		decq    -8(%rbp)
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE18
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END18
	.EIF_ELSE18:
		movq    $0 , %rax
	.EIF_END18:
		cmpq    $0 , %rax
		je    .ELSE_BODY17
		movq    $1 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		movq    %rax , -16(%rbp)
		leaq    LString13(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF17
	.ELSE_BODY17:
	.END_IF17:
		movq    $4 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
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
		leaq    LString14(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		jmp    .END_IF19
	.ELSE_BODY19:
	.END_IF19:
		movq    $16 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    malloc
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
		movq    -8(%rbp) , %rax
		popq    %rbx
		imulq    $8 , %rbx
		addq    %rbx , %rax
		pushq    (%rax)
		incq    (%rax)
		popq    %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE22
		movq    $6 , %rax
		pushq    %rax
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    $8 , %rax
		addq    %rbx , %rax
		movq    (%rax) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END22
	.EIF_ELSE22:
		movq    $0 , %rax
	.EIF_END22:
		cmpq    $0 , %rax
		je    .ELSE_BODY21
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString15(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF21
	.ELSE_BODY21:
	.END_IF21:
		movq    $9 , %rax
		pushq    %rax
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		imulq    $8 , %rbx
		addq    %rbx , %rax
		pushq    (%rax)
		decq    (%rax)
		popq    %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE24
		movq    $8 , %rax
		pushq    %rax
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    $8 , %rax
		addq    %rbx , %rax
		movq    (%rax) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END24
	.EIF_ELSE24:
		movq    $0 , %rax
	.EIF_END24:
		cmpq    $0 , %rax
		je    .ELSE_BODY23
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString16(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF23
	.ELSE_BODY23:
	.END_IF23:
		movq    $7 , %rax
		pushq    %rax
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		imulq    $8 , %rbx
		addq    %rbx , %rax
		incq    (%rax)
		movq    (%rax) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE26
		movq    $7 , %rax
		pushq    %rax
		movq    $0 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    $8 , %rax
		addq    %rbx , %rax
		movq    (%rax) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END26
	.EIF_ELSE26:
		movq    $0 , %rax
	.EIF_END26:
		cmpq    $0 , %rax
		je    .ELSE_BODY25
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString17(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF25
	.ELSE_BODY25:
	.END_IF25:
		movq    $7 , %rax
		pushq    %rax
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		imulq    $8 , %rbx
		addq    %rbx , %rax
		decq    (%rax)
		movq    (%rax) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE28
		movq    $7 , %rax
		pushq    %rax
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    $8 , %rax
		addq    %rbx , %rax
		movq    (%rax) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		jmp    .EIF_END28
	.EIF_ELSE28:
		movq    $0 , %rax
	.EIF_END28:
		cmpq    $0 , %rax
		je    .ELSE_BODY27
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString18(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF27
	.ELSE_BODY27:
	.END_IF27:
		movq    $4 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
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
		leaq    LString14(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		jmp    .END_IF29
	.ELSE_BODY29:
	.END_IF29:
		movq    $0 , %rax
		movq    %rax , -16(%rbp)
		movq    $3 , %rax
		pushq    %rax
		movq    $5 , %rax
		pushq    %rax
		movq    $13 , %rax
		popq    %rbx
		cqto
		idivq    %rbx
		movq    %rdx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY31
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString19(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF31
	.ELSE_BODY31:
	.END_IF31:
		movq    $12 , %rax
		pushq    %rax
		movq    $5 , %rax
		pushq    %rax
		movq    $7 , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY32
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString20(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF32
	.ELSE_BODY32:
	.END_IF32:
		movq    $92 , %rax
		negq    %rax
		pushq    %rax
		movq    $23 , %rax
		pushq    %rax
		movq    $4 , %rax
		negq    %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY33
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString21(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF33
	.ELSE_BODY33:
	.END_IF33:
		movq    $2 , %rax
		pushq    %rax
		movq    $3 , %rax
		pushq    %rax
		movq    $7 , %rax
		popq    %rbx
		cqto
		idivq    %rbx
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY34
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString22(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF34
	.ELSE_BODY34:
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
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString23(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF35
	.ELSE_BODY35:
	.END_IF35:
		movq    $7 , %rax
		pushq    %rax
		movq    $5 , %rax
		pushq    %rax
		movq    $12 , %rax
		popq    %rbx
		subq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY37
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		leaq    LString24(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF37
	.ELSE_BODY37:
	.END_IF37:
		movq    $6 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
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
		leaq    LString25(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		jmp    .END_IF38
	.ELSE_BODY38:
	.END_IF38:
		movq    $0 , %rax
		addq    $16 , %rsp
		popq    %rbp
		ret

		addq    $16 , %rsp
		popq    %rbp
		ret

zer:
		pushq    %rbp
		movq    %rsp , %rbp
		movq    $0 , %rax
		movq    %rax , i(%rip)
		popq    %rbp
		ret

		popq    %rbp
		ret

inci:
		pushq    %rbp
		movq    %rsp , %rbp
		incq    i(%rip)
		movq    i(%rip) , %rax
		popq    %rbp
		ret

		popq    %rbp
		ret

variables:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $8 , %rsp
		movq    $3 , %rax
		movq    %rax , -8(%rbp)
		subq    $8 , %rsp
		movq    $0 , %rax
		call    zer
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $5 , %rax
		movq    %rax , -16(%rbp)
		movq    $5 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
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
		movq    $1 , %rax
		addq    $16 , %rsp
		popq    %rbp
		ret

		jmp    .END_IF40
	.ELSE_BODY40:
	.END_IF40:
		addq    $8 , %rsp
		movq    $3 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
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
		movq    $1 , %rax
		addq    $8 , %rsp
		popq    %rbp
		ret

		jmp    .END_IF42
	.ELSE_BODY42:
	.END_IF42:
		movq    $1 , %rax
		pushq    %rax
		subq    $8 , %rsp
		movq    $0 , %rax
		call    inci
		addq    $8 , %rsp
		popq    %rbx
		cmpq    %rbx , %rax
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
		subq    $8 , %rsp
		movq    $0 , %rax
		call    inci
		addq    $8 , %rsp
		popq    %rbx
		cmpq    %rbx , %rax
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
		movq    $1 , %rax
		addq    $8 , %rsp
		popq    %rbp
		ret

		jmp    .END_IF44
	.ELSE_BODY44:
	.END_IF44:
		movq    $0 , %rax
		addq    $8 , %rsp
		popq    %rbp
		ret

		addq    $8 , %rsp
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
