	.text
	.file	"LLVMDialectModule"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	external_dce_flag_1@PLT
	xorl	%eax, %eax
	movl	%eax, %edi
	movabsq	$80000000000, %rax              # imm = 0x12A05F2000
	addq	%rax, %rdi
	callq	malloc@PLT
	movabsq	$18601915472, %rdx              # imm = 0x454C2B450
	movq	%rax, %rcx
	addq	%rdx, %rcx
	movsd	(%rcx), %xmm0                   # xmm0 = mem[0],zero
	movabsq	$8279155096, %rcx               # imm = 0x1ED79E198
	addq	%rcx, %rax
	movsd	%xmm0, (%rax)
	movl	$23252, %eax                    # imm = 0x5AD4
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
