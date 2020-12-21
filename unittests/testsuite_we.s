.global main

i:
		.zero    8

k:
		.zero    8

main:
		pushq    %rbp
		movq    %rsp , %rbp
		subq    $0 , %rsp
		subq    $32 , %rsp
