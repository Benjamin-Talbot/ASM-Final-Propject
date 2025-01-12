    .section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 3	sdk_version 11, 3
	.globl	_test
	.p2align	2
_test:
    mov x0, #10
    ret