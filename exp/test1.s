test0:
		pushq		%rbp
		movq		%rsp , %rbp
		subq		$2 , %rsp
		leave
		ret

glob1:
		.zero		4

glob2:
		.zero		4

test1:
		pushq		%rbp
		movq		%rsp , %rbp
		subq		$2 , %rsp
		leave
		ret

main0:
		pushq		%rbp
		movq		%rsp , %rbp
		subq		$2 , %rsp
		leave
		ret

