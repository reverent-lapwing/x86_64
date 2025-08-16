data:
	.string	"to print\0not to print" // notice no newline in the string - usually we have to add it ourselves
.globl main
main:
	leaq	data(%rip), %rdi
	call	print
	mov	$0, %rax
	ret
