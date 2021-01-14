.global main

.data
global:
		.zero    8
.text
test_32bits:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $24 , %rsp
		subq    $8 , %rsp
		leaq    LString0(%rip) , %rax
		pushq    %rax
		leaq    LString1(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    fopen
		addq    $8 , %rsp
		movq    %rax , -8(%rbp)
		movq    $0 , -16(%rbp)
		jmp    .WHILE_TEST1
		.WHILE_BODY1:
		movq    -16(%rbp) , %rax
		incq    -16(%rbp)
		.WHILE_TEST1:
		movq    $1 , %rax
		negq    %rax
		pushq    %rax
		subq    $8 , %rsp
		movq    -8(%rbp) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    fgetc
		cltq
		addq    $8 , %rsp
		movq    %rax , -24(%rbp)
		popq    %rbx
		cmpq    %rbx , %rax
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
		je    .EIF_ELSE1
		movq    $45000 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		jmp    .EIF_END1
		.EIF_ELSE1:
		movq    $0 , %rax
		.EIF_END1:
		cmpq    $0 , %rax
		je    .END_WHILE1
		jmp    .WHILE_BODY1
		.END_WHILE1:
		subq    $8 , %rsp
		movq    -8(%rbp) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    fclose
		cltq
		addq    $8 , %rsp
		movq    -16(%rbp) , %rax
		addq    $24 , %rsp
		popq    %rbp
		ret

		addq    $24 , %rsp
		popq    %rbp
		ret

testing_registers_preservation:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $48 , %rsp
		movq    %rdi , -8(%rbp)
		movq    %rsi , -16(%rbp)
		movq    %rdx , -24(%rbp)
		movq    %rcx , -32(%rbp)
		movq    %r8 , -40(%rbp)
		movq    %r9 , -48(%rbp)
		movq    24(%rbp) , %rax
		pushq    %rax
		movq    16(%rbp) , %rax
		pushq    %rax
		movq    -48(%rbp) , %rax
		pushq    %rax
		movq    -40(%rbp) , %rax
		pushq    %rax
		movq    -32(%rbp) , %rax
		pushq    %rax
		movq    -24(%rbp) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		addq    $48 , %rsp
		popq    %rbp
		ret

		addq    $48 , %rsp
		popq    %rbp
		ret

stack_test_impair:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $8 , %rsp
		movq    %rdi , -8(%rbp)
		subq    $16 , %rsp
		movq    $4 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE4
		movq    $0 , %rax
		jmp    .EIF_END4
		.EIF_ELSE4:
		movq    $1 , %rax
		.EIF_END4:
		cmpq    $0 , %rax
		je    .ELSE_BODY3
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    stack_test_pair
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    -8(%rbp) , %rax
		pushq    %rax
		leaq    LString2(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF3
		.ELSE_BODY3:
		movq    $0 , %rax
		addq    $24 , %rsp
		popq    %rbp
		ret

		.END_IF3:
		addq    $16 , %rsp
		addq    $8 , %rsp
		popq    %rbp
		ret

stack_test_pair:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $8 , %rsp
		movq    %rdi , -8(%rbp)
		subq    $8 , %rsp
		movq    $4 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE6
		movq    $0 , %rax
		jmp    .EIF_END6
		.EIF_ELSE6:
		movq    $1 , %rax
		.EIF_END6:
		cmpq    $0 , %rax
		je    .ELSE_BODY5
		movq    $1 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    stack_test_impair
		movq    -8(%rbp) , %rax
		pushq    %rax
		leaq    LString2(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    printf
		cltq
		jmp    .END_IF5
		.ELSE_BODY5:
		movq    $0 , %rax
		addq    $16 , %rsp
		popq    %rbp
		ret

		.END_IF5:
		addq    $8 , %rsp
		addq    $8 , %rsp
		popq    %rbp
		ret

setting_glob:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $8 , %rsp
		movq    %rdi , -8(%rbp)
		movq    -8(%rbp) , %rax
		movq    %rax , global(%rip)
		addq    $8 , %rsp
		popq    %rbp
		ret

testing_glob:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $16 , %rsp
		movq    %rdi , -8(%rbp)
		movq    %rsi , -16(%rbp)
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    global(%rip) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE8
		movq    $0 , %rax
		jmp    .EIF_END8
		.EIF_ELSE8:
		movq    $1 , %rax
		.EIF_END8:
		cmpq    $0 , %rax
		je    .ELSE_BODY7
		movq    global(%rip) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		pushq    %rax
		leaq    LString3(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		movq    $0 , %rax
		call    printf
		cltq
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		jmp    .END_IF7
		.ELSE_BODY7:
		movq    -16(%rbp) , %rax
		pushq    %rax
		leaq    LString4(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    printf
		cltq
		.END_IF7:
		addq    $16 , %rsp
		popq    %rbp
		ret

testing_scope:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $8 , %rsp
		movq    $12 , -8(%rbp)
		subq    $8 , %rsp
		movq    $30 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    setting_glob
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		movq    $30 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    testing_glob
		addq    $8 , %rsp
		movq    $12 , %rax
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
		cmpq    $0 , %rax
		je    .ELSE_BODY9
		subq    $8 , %rsp
		movq    -8(%rbp) , %rax
		pushq    %rax
		leaq    LString5(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		jmp    .END_IF9
		.ELSE_BODY9:
		subq    $8 , %rsp
		leaq    LString6(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		.END_IF9:
		subq    $8 , %rsp
		movq    $100 , -16(%rbp)
		movq    $3 , %rax
		pushq    %rax
		movq    $30 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    testing_glob
		movq    $100 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE12
		movq    $0 , %rax
		jmp    .EIF_END12
		.EIF_ELSE12:
		movq    $1 , %rax
		.EIF_END12:
		cmpq    $0 , %rax
		je    .ELSE_BODY11
		movq    -16(%rbp) , %rax
		pushq    %rax
		leaq    LString7(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    printf
		cltq
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		jmp    .END_IF11
		.ELSE_BODY11:
		leaq    LString8(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		.END_IF11:
		addq    $8 , %rsp
		movq    $12 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .EIF_ELSE14
		movq    $0 , %rax
		jmp    .EIF_END14
		.EIF_ELSE14:
		movq    $1 , %rax
		.EIF_END14:
		cmpq    $0 , %rax
		je    .ELSE_BODY13
		subq    $8 , %rsp
		movq    -8(%rbp) , %rax
		pushq    %rax
		leaq    LString9(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		jmp    .END_IF13
		.ELSE_BODY13:
		subq    $8 , %rsp
		leaq    LString10(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		.END_IF13:
		movq    $0 , %rax
		addq    $8 , %rsp
		popq    %rbp
		ret

		addq    $8 , %rsp
		popq    %rbp
		ret

main:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $24 , %rsp
		subq    $8 , %rsp
		leaq    LString11(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		leaq    LString12(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		leaq    LString13(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		movq    $7 , %rax
		pushq    %rax
		movq    $5 , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY15
		subq    $8 , %rsp
		leaq    LString14(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		jmp    .END_IF15
		.ELSE_BODY15:
		subq    $8 , %rsp
		leaq    LString15(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		.END_IF15:
		movq    $13 , %rax
		pushq    %rax
		movq    $13 , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY16
		subq    $8 , %rsp
		leaq    LString16(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF16
		.ELSE_BODY16:
		subq    $8 , %rsp
		leaq    LString17(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF16:
		movq    $10 , %rax
		pushq    %rax
		movq    $8 , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY17
		subq    $8 , %rsp
		leaq    LString18(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF17
		.ELSE_BODY17:
		subq    $8 , %rsp
		leaq    LString19(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF17:
		movq    $10 , %rax
		pushq    %rax
		movq    $12 , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY18
		subq    $8 , %rsp
		leaq    LString20(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		jmp    .END_IF18
		.ELSE_BODY18:
		subq    $8 , %rsp
		leaq    LString21(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		.END_IF18:
		movq    $8 , %rax
		pushq    %rax
		movq    $8 , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setle    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY19
		subq    $8 , %rsp
		leaq    LString22(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF19
		.ELSE_BODY19:
		subq    $8 , %rsp
		leaq    LString23(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF19:
		movq    $12 , %rax
		pushq    %rax
		movq    $4 , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setle    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY20
		subq    $8 , %rsp
		leaq    LString24(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF20
		.ELSE_BODY20:
		subq    $8 , %rsp
		leaq    LString25(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF20:
		subq    $8 , %rsp
		leaq    LString26(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		movq    $56 , %rax
		pushq    %rax
		movq    $7 , %rax
		pushq    %rax
		movq    $8 , %rax
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
		je    .ELSE_BODY21
		subq    $8 , %rsp
		leaq    LString27(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF21
		.ELSE_BODY21:
		subq    $8 , %rsp
		leaq    LString28(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF21:
		movq    $9 , %rax
		pushq    %rax
		movq    $5 , %rax
		pushq    %rax
		movq    $47 , %rax
		popq    %rbx
		cqto
		idivq    %rbx
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY22
		subq    $8 , %rsp
		leaq    LString29(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF22
		.ELSE_BODY22:
		subq    $8 , %rsp
		leaq    LString30(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF22:
		movq    $2 , %rax
		pushq    %rax
		movq    $5 , %rax
		pushq    %rax
		movq    $47 , %rax
		popq    %rbx
		cqto
		idivq    %rbx
		movq    %rdx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY23
		subq    $8 , %rsp
		leaq    LString31(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF23
		.ELSE_BODY23:
		subq    $8 , %rsp
		leaq    LString32(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF23:
		movq    $149 , %rax
		pushq    %rax
		movq    $47 , %rax
		pushq    %rax
		movq    $102 , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setle    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY24
		subq    $8 , %rsp
		leaq    LString33(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF24
		.ELSE_BODY24:
		subq    $8 , %rsp
		leaq    LString34(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF24:
		movq    $15 , %rax
		pushq    %rax
		movq    $13 , %rax
		pushq    %rax
		movq    $28 , %rax
		popq    %rbx
		subq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY25
		subq    $8 , %rsp
		leaq    LString35(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF25
		.ELSE_BODY25:
		subq    $8 , %rsp
		leaq    LString36(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF25:
		subq    $8 , %rsp
		leaq    LString37(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		leaq    LString13(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		movq    $5 , -8(%rbp)
		movq    $13 , -16(%rbp)
		movq    $7 , -24(%rbp)
		movq    -24(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY26
		subq    $8 , %rsp
		leaq    LString14(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		jmp    .END_IF26
		.ELSE_BODY26:
		subq    $8 , %rsp
		leaq    LString15(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		.END_IF26:
		movq    $13 , -24(%rbp)
		movq    -24(%rbp) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY27
		subq    $8 , %rsp
		leaq    LString16(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF27
		.ELSE_BODY27:
		subq    $8 , %rsp
		leaq    LString17(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF27:
		movq    $8 , -8(%rbp)
		movq    $12 , -16(%rbp)
		movq    $10 , -24(%rbp)
		movq    -24(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY28
		subq    $8 , %rsp
		leaq    LString18(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF28
		.ELSE_BODY28:
		subq    $8 , %rsp
		leaq    LString19(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF28:
		movq    -24(%rbp) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY29
		subq    $8 , %rsp
		leaq    LString20(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		jmp    .END_IF29
		.ELSE_BODY29:
		subq    $8 , %rsp
		leaq    LString21(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		.END_IF29:
		movq    $8 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setle    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY30
		subq    $8 , %rsp
		leaq    LString22(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF30
		.ELSE_BODY30:
		subq    $8 , %rsp
		leaq    LString23(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF30:
		movq    $4 , -24(%rbp)
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    -24(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setle    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY31
		subq    $8 , %rsp
		leaq    LString24(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF31
		.ELSE_BODY31:
		subq    $8 , %rsp
		leaq    LString25(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF31:
		subq    $8 , %rsp
		leaq    LString26(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		movq    $8 , -8(%rbp)
		movq    $7 , -16(%rbp)
		movq    $56 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
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
		je    .ELSE_BODY32
		subq    $8 , %rsp
		leaq    LString27(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF32
		.ELSE_BODY32:
		subq    $8 , %rsp
		leaq    LString28(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF32:
		movq    $47 , -8(%rbp)
		movq    $5 , -16(%rbp)
		movq    $9 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cqto
		idivq    %rbx
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY33
		subq    $8 , %rsp
		leaq    LString29(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF33
		.ELSE_BODY33:
		subq    $8 , %rsp
		leaq    LString30(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF33:
		movq    $2 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cqto
		idivq    %rbx
		movq    %rdx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY34
		subq    $8 , %rsp
		leaq    LString31(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF34
		.ELSE_BODY34:
		subq    $8 , %rsp
		leaq    LString32(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF34:
		movq    $102 , -16(%rbp)
		movq    $149 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setle    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY35
		subq    $8 , %rsp
		leaq    LString33(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF35
		.ELSE_BODY35:
		subq    $8 , %rsp
		leaq    LString34(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF35:
		movq    $28 , -8(%rbp)
		movq    $13 , -16(%rbp)
		movq    $15 , %rax
		pushq    %rax
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		subq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY36
		subq    $8 , %rsp
		leaq    LString35(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF36
		.ELSE_BODY36:
		subq    $8 , %rsp
		leaq    LString36(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF36:
		subq    $8 , %rsp
		leaq    LString38(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		movq    $33 , -8(%rbp)
		movq    $33 , %rax
		negq    %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		negq    %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY37
		subq    $8 , %rsp
		leaq    LString39(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF37
		.ELSE_BODY37:
		subq    $8 , %rsp
		leaq    LString40(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF37:
		movq    $0 , -8(%rbp)
		movq    $1 , %rax
		negq    %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		notq    %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY38
		subq    $8 , %rsp
		leaq    LString41(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF38
		.ELSE_BODY38:
		subq    $8 , %rsp
		leaq    LString42(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF38:
		movq    $5 , -8(%rbp)
		movq    $5 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		incq    -8(%rbp)
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY39
		subq    $8 , %rsp
		leaq    LString43(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF39
		.ELSE_BODY39:
		subq    $8 , %rsp
		leaq    LString44(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF39:
		movq    $7 , %rax
		pushq    %rax
		incq    -8(%rbp)
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY40
		subq    $8 , %rsp
		leaq    LString45(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF40
		.ELSE_BODY40:
		subq    $8 , %rsp
		leaq    LString46(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF40:
		movq    $13 , -8(%rbp)
		movq    $13 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		decq    -8(%rbp)
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY41
		subq    $8 , %rsp
		leaq    LString47(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF41
		.ELSE_BODY41:
		subq    $8 , %rsp
		leaq    LString48(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF41:
		movq    $11 , %rax
		pushq    %rax
		decq    -8(%rbp)
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY42
		subq    $8 , %rsp
		leaq    LString49(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF42
		.ELSE_BODY42:
		subq    $8 , %rsp
		leaq    LString50(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF42:
		subq    $8 , %rsp
		leaq    LString51(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		leaq    LString13(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $3 , %rax
		pushq    %rax
		movq    $8 , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    %rbx , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    malloc
		addq    $8 , %rsp
		movq    %rax , -8(%rbp)
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $12 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $1 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $12 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $2 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $7 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $2 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    $8 , %rax
		addq    %rbx , %rax
		movq    (%rax) , %rax
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
		cmpq    $0 , %rax
		je    .ELSE_BODY43
		subq    $8 , %rsp
		leaq    LString14(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		jmp    .END_IF43
		.ELSE_BODY43:
		subq    $8 , %rsp
		leaq    LString15(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		.END_IF43:
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
		cmpq    $0 , %rax
		je    .ELSE_BODY44
		subq    $8 , %rsp
		leaq    LString16(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF44
		.ELSE_BODY44:
		subq    $8 , %rsp
		leaq    LString17(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF44:
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $8 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $1 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $12 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $2 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $10 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $2 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    $8 , %rax
		addq    %rbx , %rax
		movq    (%rax) , %rax
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
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY45
		subq    $8 , %rsp
		leaq    LString18(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF45
		.ELSE_BODY45:
		subq    $8 , %rsp
		leaq    LString19(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF45:
		movq    $2 , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    $8 , %rax
		addq    %rbx , %rax
		movq    (%rax) , %rax
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
		setl    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY46
		subq    $8 , %rsp
		leaq    LString20(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		jmp    .END_IF46
		.ELSE_BODY46:
		subq    $8 , %rsp
		leaq    LString21(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		.END_IF46:
		movq    $8 , %rax
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
		setle    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY47
		subq    $8 , %rsp
		leaq    LString22(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF47
		.ELSE_BODY47:
		subq    $8 , %rsp
		leaq    LString23(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF47:
		movq    $2 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $4 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
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
		pushq    %rax
		movq    $2 , %rax
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
		setle    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY48
		subq    $8 , %rsp
		leaq    LString24(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF48
		.ELSE_BODY48:
		subq    $8 , %rsp
		leaq    LString25(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF48:
		subq    $8 , %rsp
		leaq    LString26(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $1672 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $1 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $8971 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $2 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $45 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $1672 , %rax
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
		cmpq    $0 , %rax
		je    .EIF_ELSE51
		movq    $8971 , %rax
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
		jmp    .EIF_END51
		.EIF_ELSE51:
		movq    $0 , %rax
		.EIF_END51:
		cmpq    $0 , %rax
		je    .EIF_ELSE50
		movq    $45 , %rax
		pushq    %rax
		movq    $2 , %rax
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
		jmp    .EIF_END50
		.EIF_ELSE50:
		movq    $0 , %rax
		.EIF_END50:
		cmpq    $0 , %rax
		je    .ELSE_BODY49
		subq    $8 , %rsp
		leaq    LString52(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF49
		.ELSE_BODY49:
		subq    $8 , %rsp
		leaq    LString53(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF49:
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $8 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $1 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $7 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $56 , %rax
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
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY52
		subq    $8 , %rsp
		leaq    LString27(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF52
		.ELSE_BODY52:
		subq    $8 , %rsp
		leaq    LString28(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF52:
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $47 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $1 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $5 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $9 , %rax
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
		cqto
		idivq    %rbx
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY53
		subq    $8 , %rsp
		leaq    LString29(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF53
		.ELSE_BODY53:
		subq    $8 , %rsp
		leaq    LString30(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF53:
		movq    $2 , %rax
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
		cqto
		idivq    %rbx
		movq    %rdx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY54
		subq    $8 , %rsp
		leaq    LString31(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF54
		.ELSE_BODY54:
		subq    $8 , %rsp
		leaq    LString32(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF54:
		movq    $1 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $102 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $149 , %rax
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
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		setle    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY55
		subq    $8 , %rsp
		leaq    LString33(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF55
		.ELSE_BODY55:
		subq    $8 , %rsp
		leaq    LString34(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF55:
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $28 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $1 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $13 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $15 , %rax
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
		subq    %rbx , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY56
		subq    $8 , %rsp
		leaq    LString35(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF56
		.ELSE_BODY56:
		subq    $8 , %rsp
		leaq    LString36(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF56:
		subq    $8 , %rsp
		leaq    LString38(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $33 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $33 , %rax
		negq    %rax
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
		negq    %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY57
		subq    $8 , %rsp
		leaq    LString39(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF57
		.ELSE_BODY57:
		subq    $8 , %rsp
		leaq    LString40(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF57:
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $0 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $1 , %rax
		negq    %rax
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
		notq    %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY58
		subq    $8 , %rsp
		leaq    LString41(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF58
		.ELSE_BODY58:
		subq    $8 , %rsp
		leaq    LString42(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF58:
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $5 , %rax
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
		je    .ELSE_BODY59
		subq    $8 , %rsp
		leaq    LString43(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF59
		.ELSE_BODY59:
		subq    $8 , %rsp
		leaq    LString44(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF59:
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
		je    .ELSE_BODY60
		subq    $8 , %rsp
		leaq    LString45(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF60
		.ELSE_BODY60:
		subq    $8 , %rsp
		leaq    LString46(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF60:
		movq    $0 , %rax
		imulq    $8 , %rax
		pushq    %rax
		movq    $13 , %rax
		popq    %rbx
		movq    -8(%rbp) , %rcx
		addq    %rbx , %rcx
		movq    %rax , (%rcx)
		movq    $13 , %rax
		pushq    %rax
		movq    $0 , %rax
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
		je    .ELSE_BODY61
		subq    $8 , %rsp
		leaq    LString47(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF61
		.ELSE_BODY61:
		subq    $8 , %rsp
		leaq    LString48(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF61:
		movq    $11 , %rax
		pushq    %rax
		movq    $0 , %rax
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
		je    .ELSE_BODY62
		subq    $8 , %rsp
		leaq    LString49(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF62
		.ELSE_BODY62:
		subq    $8 , %rsp
		leaq    LString50(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF62:
		subq    $8 , %rsp
		leaq    LString54(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $0 , %rax
		call    testing_scope
		addq    $8 , %rsp
		subq    $8 , %rsp
		leaq    LString55(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    stack_test_impair
		addq    $8 , %rsp
		subq    $8 , %rsp
		leaq    LString56(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $64 , %rax
		pushq    %rax
		movq    $63 , %rax
		pushq    %rax
		movq    $62 , %rax
		pushq    %rax
		movq    $61 , %rax
		pushq    %rax
		movq    $60 , %rax
		pushq    %rax
		movq    $59 , %rax
		pushq    %rax
		movq    $58 , %rax
		pushq    %rax
		movq    $57 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		popq    %r9
		movq    $0 , %rax
		call    testing_registers_preservation
		addq    $16 , %rsp
		pushq    %rax
		movq    $56 , %rax
		pushq    %rax
		movq    $55 , %rax
		pushq    %rax
		movq    $54 , %rax
		pushq    %rax
		movq    $53 , %rax
		pushq    %rax
		movq    $52 , %rax
		pushq    %rax
		movq    $51 , %rax
		pushq    %rax
		movq    $50 , %rax
		pushq    %rax
		movq    $49 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		popq    %r9
		movq    $0 , %rax
		call    testing_registers_preservation
		addq    $16 , %rsp
		pushq    %rax
		movq    $48 , %rax
		pushq    %rax
		movq    $47 , %rax
		pushq    %rax
		movq    $46 , %rax
		pushq    %rax
		movq    $45 , %rax
		pushq    %rax
		movq    $44 , %rax
		pushq    %rax
		movq    $43 , %rax
		pushq    %rax
		movq    $42 , %rax
		pushq    %rax
		movq    $41 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		popq    %r9
		movq    $0 , %rax
		call    testing_registers_preservation
		addq    $16 , %rsp
		pushq    %rax
		movq    $40 , %rax
		pushq    %rax
		movq    $39 , %rax
		pushq    %rax
		movq    $38 , %rax
		pushq    %rax
		movq    $37 , %rax
		pushq    %rax
		movq    $36 , %rax
		pushq    %rax
		movq    $35 , %rax
		pushq    %rax
		movq    $34 , %rax
		pushq    %rax
		movq    $33 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		popq    %r9
		movq    $0 , %rax
		call    testing_registers_preservation
		addq    $16 , %rsp
		pushq    %rax
		movq    $32 , %rax
		pushq    %rax
		movq    $31 , %rax
		pushq    %rax
		movq    $30 , %rax
		pushq    %rax
		movq    $29 , %rax
		pushq    %rax
		movq    $28 , %rax
		pushq    %rax
		movq    $27 , %rax
		pushq    %rax
		movq    $26 , %rax
		pushq    %rax
		movq    $25 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		popq    %r9
		movq    $0 , %rax
		call    testing_registers_preservation
		addq    $16 , %rsp
		pushq    %rax
		movq    $24 , %rax
		pushq    %rax
		movq    $23 , %rax
		pushq    %rax
		movq    $22 , %rax
		pushq    %rax
		movq    $21 , %rax
		pushq    %rax
		movq    $20 , %rax
		pushq    %rax
		movq    $19 , %rax
		pushq    %rax
		movq    $18 , %rax
		pushq    %rax
		movq    $17 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		popq    %r9
		movq    $0 , %rax
		call    testing_registers_preservation
		addq    $16 , %rsp
		pushq    %rax
		movq    $16 , %rax
		pushq    %rax
		movq    $15 , %rax
		pushq    %rax
		movq    $14 , %rax
		pushq    %rax
		movq    $13 , %rax
		pushq    %rax
		movq    $12 , %rax
		pushq    %rax
		movq    $11 , %rax
		pushq    %rax
		movq    $10 , %rax
		pushq    %rax
		movq    $9 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		popq    %r9
		movq    $0 , %rax
		call    testing_registers_preservation
		addq    $16 , %rsp
		pushq    %rax
		movq    $8 , %rax
		pushq    %rax
		movq    $7 , %rax
		pushq    %rax
		movq    $6 , %rax
		pushq    %rax
		movq    $5 , %rax
		pushq    %rax
		movq    $4 , %rax
		pushq    %rax
		movq    $3 , %rax
		pushq    %rax
		movq    $2 , %rax
		pushq    %rax
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		popq    %r9
		movq    $0 , %rax
		call    testing_registers_preservation
		addq    $16 , %rsp
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		popq    %rcx
		popq    %r8
		popq    %r9
		movq    $0 , %rax
		call    testing_registers_preservation
		addq    $16 , %rsp
		addq    $8 , %rsp
		movq    %rax , -8(%rbp)
		movq    $2 , %rax
		pushq    %rax
		movq    $65 , %rax
		pushq    %rax
		movq    $64 , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    %rbx , %rax
		popq    %rbx
		cqto
		idivq    %rbx
		pushq    %rax
		movq    -8(%rbp) , %rax
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY63
		subq    $8 , %rsp
		leaq    LString57(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		jmp    .END_IF63
		.ELSE_BODY63:
		subq    $8 , %rsp
		leaq    LString58(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		.END_IF63:
		subq    $8 , %rsp
		leaq    LString59(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		movq    $45000 , %rax
		pushq    %rax
		subq    $8 , %rsp
		movq    $0 , %rax
		call    test_32bits
		addq    $8 , %rsp
		popq    %rbx
		cmpq    %rbx , %rax
		movq    $0 , %rax
		sete    %al
		cmpq    $0 , %rax
		je    .ELSE_BODY64
		subq    $8 , %rsp
		leaq    LString60(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		subq    $8 , %rsp
		movq    $1 , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    exit
		cltq
		addq    $8 , %rsp
		jmp    .END_IF64
		.ELSE_BODY64:
		subq    $8 , %rsp
		leaq    LString61(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		.END_IF64:
		subq    $8 , %rsp
		leaq    LString62(%rip) , %rax
		pushq    %rax
		popq    %rdi
		movq    $0 , %rax
		call    printf
		cltq
		addq    $8 , %rsp
		movq    $0 , %rax
		addq    $24 , %rsp
		popq    %rbp
		ret

		addq    $24 , %rsp
		popq    %rbp
		ret

LString62:
    .string    "[** Congratulations ! All unit tests have succeeded **]\n"
LString61:
    .string    "    [ 32bits compatibility passed ]\n"
LString60:
    .string    "    [ 32bits compatibility failed ]\n"
LString59:
    .string    "** Testing 32bits compatibility **\n"
LString58:
    .string    "    [ Register preservation ] Failed\n"
LString57:
    .string    "    [ Register preservation ] Passed\n"
LString56:
    .string    "** Testing register preservation **\n"
LString55:
    .string    "** Testing stack 16 alignment **\n"
LString54:
    .string    "** Testing variables scope **\n"
LString53:
    .string    "    [ a[i] ] Failed\n"
LString52:
    .string    "    [ a[i] ] Passed\n"
LString51:
    .string    "** Unit Testing with arrays **\n"
LString50:
    .string    "    [--x] Failed\n"
LString49:
    .string    "    [--x] Passed\n"
LString48:
    .string    "    [x--] Failed\n"
LString47:
    .string    "    [x--] Passed\n"
LString46:
    .string    "    [++x] Failed\n"
LString45:
    .string    "    [++x] Passed\n"
LString44:
    .string    "    [x++] Failed\n"
LString43:
    .string    "    [x++] Passed\n"
LString42:
    .string    "    [~] Failed\n"
LString41:
    .string    "    [~] Passed\n"
LString40:
    .string    "    [- unary] Failed\n"
LString39:
    .string    "    [- unary] Passed\n"
LString38:
    .string    "  {Testing Unary operators}\n"
LString37:
    .string    "** Unit Testing with variables **\n"
LString36:
    .string    "    [- binary] Failed\n"
LString35:
    .string    "    [- binary] Passed\n"
LString34:
    .string    "    [+] Failed\n"
LString33:
    .string    "    [+] Passed\n"
LString32:
    .string    "    [%%] Failed\n"
LString31:
    .string    "    [%%] Passed\n"
LString30:
    .string    "    [/] Failed\n"
LString29:
    .string    "    [/] Passed\n"
LString28:
    .string    "    [*] Failed\n"
LString27:
    .string    "    [*] Passed\n"
LString26:
    .string    "  {Testing Binary operators}\n"
LString25:
    .string    "    [<= Test2] Failed\n"
LString24:
    .string    "    [<= Test2] Passed\n"
LString23:
    .string    "    [<= Test1] Failed\n"
LString22:
    .string    "    [<= Test1] Passed\n"
LString21:
    .string    "    [< Test2] Passed\n"
LString20:
    .string    "    [< Test2] Failed\n"
LString19:
    .string    "    [< Test1] Failed\n"
LString18:
    .string    "    [< Test1] Passed\n"
LString17:
    .string    "    [== Test2] Failed\n"
LString16:
    .string    "    [== Test2] Passed\n"
LString15:
    .string    "    [== Test1] Passed\n"
LString14:
    .string    "    [== Test1] Failed\n"
LString13:
    .string    "  {Testing Comparisons}\n"
LString12:
    .string    "** Unit Testing with constants **\n"
LString11:
    .string    "[Printing Works]\n"
LString10:
    .string    "    [ global test5 passed] Passed\n"
LString9:
    .string    "    [ global test5 failed with balue : %d] Failed\n"
LString8:
    .string    "    [ global test4 passed] Passed\n"
LString7:
    .string    "    [ global test4 failed with balue : %d] Failed\n"
LString6:
    .string    "    [ global test2 passed] Passed\n"
LString5:
    .string    "    [ global test2 failed with balue : %d] Failed\n"
LString4:
    .string    "    [ global test%d passed] Passed\n"
LString3:
    .string    "    [ global test%d failed with balue : %d] Failed\n"
LString2:
    .string    "    [ stack alignment test%d passed] Passed\n"
LString1:
    .string    "./unittests"
LString0:
    .string    "r"
