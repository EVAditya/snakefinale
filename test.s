	.file	"test.c"
# GNU C17 (Ubuntu 14.2.0-4ubuntu2) version 14.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 14.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.rodata
.LC0:
	.string	"LED %d: %x\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
# test.c:3: int main() {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp114
	movq	%rax, -8(%rbp)	# tmp114, D.3217
	xorl	%eax, %eax	# tmp114
# test.c:4:     unsigned char head=0b00110111;
	movb	$55, -21(%rbp)	#, head
# test.c:5:     unsigned char leds[8] = {0};
	movq	$0, -16(%rbp)	#, leds
# test.c:6:     leds[head>>4] |= 1<<(head&0b00001111);
	movzbl	-21(%rbp), %eax	# head, tmp115
	shrb	$4, %al	#, _1
	movzbl	%al, %eax	# _1, _2
	cltq
	movzbl	-16(%rbp,%rax), %eax	# leds[_2], _3
	movl	%eax, %esi	# _3, _4
# test.c:6:     leds[head>>4] |= 1<<(head&0b00001111);
	movzbl	-21(%rbp), %eax	# head, _5
	andl	$15, %eax	#, _6
# test.c:6:     leds[head>>4] |= 1<<(head&0b00001111);
	movl	$1, %edx	#, tmp117
	movl	%eax, %ecx	# _6, tmp128
	sall	%cl, %edx	# tmp128, tmp117
	movl	%edx, %eax	# tmp117, _7
# test.c:6:     leds[head>>4] |= 1<<(head&0b00001111);
	orl	%eax, %esi	# _8, _4
	movl	%esi, %edx	# _4, _9
# test.c:6:     leds[head>>4] |= 1<<(head&0b00001111);
	movzbl	-21(%rbp), %eax	# head, tmp118
	shrb	$4, %al	#, _10
	movzbl	%al, %eax	# _10, _11
# test.c:6:     leds[head>>4] |= 1<<(head&0b00001111);
	cltq
	movb	%dl, -16(%rbp,%rax)	# _12, leds[_11]
# test.c:7:     for(int i=0; i<8; i++) {
	movl	$0, -20(%rbp)	#, i
# test.c:7:     for(int i=0; i<8; i++) {
	jmp	.L2	#
.L3:
# test.c:8:         printf("LED %d: %x\n", i, leds[i]);
	movl	-20(%rbp), %eax	# i, tmp121
	cltq
	movzbl	-16(%rbp,%rax), %eax	# leds[i_15], _13
# test.c:8:         printf("LED %d: %x\n", i, leds[i]);
	movzbl	%al, %edx	# _13, _14
	movl	-20(%rbp), %eax	# i, tmp122
	movl	%eax, %esi	# tmp122,
	leaq	.LC0(%rip), %rax	#, tmp123
	movq	%rax, %rdi	# tmp123,
	movl	$0, %eax	#,
	call	printf@PLT	#
# test.c:7:     for(int i=0; i<8; i++) {
	addl	$1, -20(%rbp)	#, i
.L2:
# test.c:7:     for(int i=0; i<8; i++) {
	cmpl	$7, -20(%rbp)	#, i
	jle	.L3	#,
	movl	$0, %eax	#, _23
# test.c:10: }
	movq	-8(%rbp), %rdx	# D.3217, tmp125
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp125
	je	.L5	#,
	call	__stack_chk_fail@PLT	#
.L5:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 14.2.0-4ubuntu2) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
