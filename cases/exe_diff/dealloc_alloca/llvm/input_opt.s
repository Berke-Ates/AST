	.text
	.file	"LLVMDialectModule"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	subq	$6400008, %rsp                  # imm = 0x61A808
	.cfi_def_cfa_offset 6400016
	callq	external_dce_flag_1@PLT
	leaq	8(%rsp), %rdi
	callq	free@PLT
	xorl	%eax, %eax
	addq	$6400008, %rsp                  # imm = 0x61A808
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
