data:
	"to print\n\0not to print"
.globl main
main:
	leaq	data(%rsi), %rdi
