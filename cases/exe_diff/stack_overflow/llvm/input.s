	.text
	.file	"LLVMDialectModule"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	callq	external_dce_flag_1@PLT
	movq	%rsp, %rax
	movabsq	$-1000000000000000, %rcx        # imm = 0xFFFC72815B398000
	addq	%rcx, %rax
	movq	%rax, %rsp
	callq	external_dce_flag_2@PLT
	callq	external_dce_flag_3@PLT
	callq	external_dce_flag_4@PLT
	callq	external_dce_flag_5@PLT
	movl	$400000, %edi                   # imm = 0x61A80
	callq	malloc@PLT
	xorl	%eax, %eax
	movq	%rbp, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
