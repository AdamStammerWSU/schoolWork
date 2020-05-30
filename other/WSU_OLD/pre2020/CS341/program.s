	.file	"program.c"
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "Enter a number  \0"
LC1:
	.ascii "%d\0"
LC2:
	.ascii "The number is greater than 0 \0"
LC3:
	.ascii "The number is 0\0"
LC4:
	.ascii "The number is less than 0\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB12:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$32, %esp
	call	___main
	movl	$0, 28(%esp)
	movl	$LC0, (%esp)
	call	_printf
	leal	24(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC1, (%esp)
	call	_scanf
	movl	24(%esp), %eax
	testl	%eax, %eax
	jle	L2
	movl	$LC2, (%esp)
	call	_puts
	jmp	L3
L2:
	movl	24(%esp), %eax
	testl	%eax, %eax
	jne	L4
	movl	$LC3, (%esp)
	call	_puts
	jmp	L3
L4:
	movl	$LC4, (%esp)
	call	_puts
L3:
	movl	24(%esp), %eax
	cmpl	$999, %eax
	jg	L5
	movl	24(%esp), %edx
	movl	24(%esp), %eax
	imull	%edx, %eax
	movl	%eax, 24(%esp)
	jmp	L3
L5:
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE12:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_scanf;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
