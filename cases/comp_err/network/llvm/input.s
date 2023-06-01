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
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	callq	external_dce_flag_1@PLT
	movq	%rsp, %r14
	leaq	-64(%r14), %rdi
	movq	%rdi, %rsp
	callq	free@PLT
	leaq	-3200000(%rsp), %rdi
	movq	%rdi, %rsp
	movq	-64(%r14), %rax
	movq	%rax, -64(%r14)
	movq	%rsp, %r15
	leaq	-256(%r15), %rbx
	movq	%rbx, %rsp
	callq	free@PLT
	callq	external_dce_flag_2@PLT
	movq	-232(%r15), %rax
	movq	%rax, -232(%r15)
	movq	-240(%r15), %rax
	movq	%rax, -240(%r15)
	movq	-256(%r15), %rax
	movq	-248(%r15), %rcx
	movq	%rcx, -248(%r15)
	movq	%rax, -256(%r15)
	movq	-64(%r14), %rax
	movq	%rax, -64(%r14)
	movq	%rbx, %rdi
	callq	free@PLT
	xorl	%eax, %eax
	leaq	-24(%rbp), %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
