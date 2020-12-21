.global main

global_3:
		.zero    8

global_4:
		.zero    8

global_5:
		.zero    8

global_6:
		.zero    8

test_expr0:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $144 , %rsp
		movq    $587 , %rax
		movq    %rax , -136(%rbp)
		movq    $158 , %rax
		negq    %rax
		movq    %rax , -144(%rbp)
		movq    $156 , %rax
		movq    %rax , -8(%rbp)
		movq    $129 , %rax
		movq    %rax , -16(%rbp)
		movq    $11 , %rax
		movq    %rax , -24(%rbp)
		movq    $1 , %rax
		negq    %rax
		movq    %rax , -32(%rbp)
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rbx
		popq    %rax
		imulq    %rbx , %rax
		pushq    %rax
		movq    -24(%rbp) , %rbx
		popq    %rax
		addq    %rbx , %rax
		pushq    %rax
		movq    -32(%rbp) , %rbx
		popq    %rax
		subq    %rbx , %rax
		pushq    %rax
		movq    $2 , %rbx
		popq    %rax
		addq    %rbx , %rax
		pushq    %rax
		movq    $10 , %rax
		pushq    %rax
		movq    $2 , %rbx
		popq    %rax
		cqto
		idivq    %rbx
		popq    %rax
		addq    %rbx , %rax
		negq    %rax
		movq    %rax , -40(%rbp)
		movq    $5 , %rax
		negq    %rax
		pushq    %rax
		movq    -8(%rbp) , %rax
		pushq    %rax
		movq    -16(%rbp) , %rbx
		popq    %rax
		addq    %rbx , %rax
		pushq    %rax
		movq    -24(%rbp) , %rbx
		popq    %rax
		addq    %rbx , %rax
		pushq    %rax
		movq    -32(%rbp) , %rbx
		popq    %rax
		subq    %rbx , %rax
		popq    %rax
		imulq    %rbx , %rax
		pushq    %rax
		movq    -32(%rbp) , %rax
		pushq    %rax
		movq    $5 , %rbx
		popq    %rax
		imulq    %rbx , %rax
		pushq    %rax
		movq    $3 , %rbx
		popq    %rax
		addq    %rbx , %rax
		popq    %rax
		imulq    %rbx , %rax
		pushq    %rax
		movq    -24(%rbp) , %rax
		pushq    %rax
		movq    $11 , %rbx
		popq    %rax
		cqto
		idivq    %rbx
		popq    %rax
		addq    %rbx , %rax
		movq    %rax , -48(%rbp)
		movq    -40(%rbp) , %rax
		pushq    %rax
		movq    -48(%rbp) , %rbx
		popq    %rax
		imulq    %rbx , %rax
		pushq    %rax
		movq    -32(%rbp) , %rbx
		popq    %rax
		addq    %rbx , %rax
		pushq    %rax
		movq    -24(%rbp) , %rbx
		popq    %rax
		subq    %rbx , %rax
		pushq    %rax
		movq    $8 , %rbx
		popq    %rax
		addq    %rbx , %rax
		pushq    %rax
		movq    $7 , %rbx
		popq    %rax
		imulq    %rbx , %rax
		pushq    %rax
		movq    $6 , %rbx
		popq    %rax
		subq    %rbx , %rax
		movq    %rax , -56(%rbp)
		movq    -48(%rbp) , %rax
		pushq    %rax
		movq    -48(%rbp) , %rax
		movq    -48(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -48(%rbp)
		popq    %rax
		subq    %rbx , %rax
		movq    %rax , -64(%rbp)
		movq    -56(%rbp) , %rax
		pushq    %rax
		movq    -56(%rbp) , %rax
		movq    -56(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -56(%rbp)
		popq    %rax
		subq    %rbx , %rax
		movq    %rax , -72(%rbp)
		movq    -8(%rbp) , %rax
		inc    %rax
		movq    %rax , -8(%rbp)
		pushq    %rax
		movq    -8(%rbp) , %rax
		inc    %rax
		movq    %rax , -8(%rbp)
		popq    %rax
		subq    %rbx , %rax
		movq    %rax , -80(%rbp)
		movq    -8(%rbp) , %rax
		movq    -8(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -8(%rbp)
		pushq    %rax
		movq    -8(%rbp) , %rax
		movq    -8(%rbp) , %rbx
		inc    %rbx
		movq    %rbx , -8(%rbp)
		popq    %rax
		subq    %rbx , %rax
		movq    %rax , -104(%rbp)
		movq    -24(%rbp) , %rax
		notq    %rax
		movq    %rax , -88(%rbp)
		movq    -40(%rbp) , %rax
		pushq    %rax
		movq    -32(%rbp) , %rax
		pushq    %rax
		movq    -24(%rbp) , %rbx
		popq    %rax
		addq    %rbx , %rax
		popq    %rax
		cqto
		idivq    %rbx
		movq    %rdx , %rax
		movq    %rax , -96(%rbp)
