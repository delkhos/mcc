.global main

test_ordre_args:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $24 , %rsp
		movq    %rdi , -8(%rbp)
		movq    %rsi , -16(%rbp)
		movq    %rdx , -24(%rbp)
		subq    $8 , %rsp
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
		movq    %rax , -32(%rbp)
		movq    -16(%rbp) , %rax
		pushq    %rax
		movq    -32(%rbp) , %rax
		pushq    %rax
		movq    $3 , -32(%rbp)
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		imulq    %rbx , %rax
		popq    %rbx
		movq    %rbx , %r15
		movq    %rax , %rbx
		movq    %r15 , %rax
		addq    %rbx , %rax
		addq    $32 , %rsp
		popq    %rbp
		ret

		addq    $8 , %rsp
		addq    $24 , %rsp
		popq    %rbp
		ret

main:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $32 , %rsp
		movq    $67 , -8(%rbp)
		movq    $91 , -16(%rbp)
		movq    -16(%rbp) , %rax
		movq    %rax , -24(%rbp)
		pushq    %rax
		incq    -24(%rbp)
		movq    -24(%rbp) , %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		movq    %rax , -24(%rbp)
		pushq    %rax
		popq    %rdi
		popq    %rsi
		popq    %rdx
		movq    $0 , %rax
		call    test_ordre_args
		movq    %rax , -32(%rbp)
		movq    -24(%rbp) , %rax
		pushq    %rax
		leaq    LString0(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    printf
		movq    -32(%rbp) , %rax
		pushq    %rax
		leaq    LString1(%rip) , %rax
		pushq    %rax
		popq    %rdi
		popq    %rsi
		movq    $0 , %rax
		call    printf
		movq    $0 , %rax
		addq    $32 , %rsp
		popq    %rbp
		ret

		addq    $32 , %rsp
		popq    %rbp
		ret

LString1:
    .string    "res=%d\n"
LString0:
    .string    "c=%d\n"
