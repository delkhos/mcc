glob:
		.zero		4

a:
		.zero		4

function0:
		pushq		%rbp
		movq		%rsp , %rbp
		subq		$12 , %rsp
		movl		%edi , -4(%rbp)
		movl		%esi , -8(%rbp)
		movl		%edx , -12(%rbp)
		subq		$4 , %rsp
		cmpl		$0 , %eax
		je		.ELSE_BODY1
		jmp .END_IF1
	.ELSE_BODY1:
		subq		$0 , %rsp
		addq		$0 , %rsp
	.END_IF1:
		addq		$4 , %rsp
		jmp .END0
		.END0:
		addq		$12 , %rsp
		popq		%rbp
		ret

fun20:
		pushq		%rbp
		movq		%rsp , %rbp
		subq		$4 , %rsp
		movl		%edi , -4(%rbp)
		subq		$4 , %rsp
		jmp .WHILE_TEST1
	.WHILE_BODY1:
		subq		$0 , %rsp
		movl		$8 , %eax
		addq		$0 , %rsp
		jmp .END1
	.WHILE_TEST1:
		cmpl		$0 , %eax
		je		.END_WHILE1
		jmp .WHILE_BODY1
	.END_WHILE1:
		movl		$2 , %eax
		addq		$4 , %rsp
		jmp .END1
		.END1:
		addq		$4 , %rsp
		popq		%rbp
		ret

main0:
		pushq		%rbp
		movq		%rsp , %rbp
		subq		$0 , %rsp
		subq		$0 , %rsp
		movl		$8 , %eax
		addq		$0 , %rsp
		jmp .END2
		.END2:
		addq		$0 , %rsp
		popq		%rbp
		ret

