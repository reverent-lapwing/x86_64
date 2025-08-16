data:
	.string "hello world v.2\n\0secret_dont_print" // you can notice \n and \0 in the string - first means "new line, another "byte of the value 0"
.globl main
main:
	leaq	data(%rip), %rdi
	call	strlen	// count number of characters until \0
	mov	%rax, %rdx	// save the character count as third argument to write, like before
	mov	$1, %rdi
	leaq	data(%rip), %rsi
	call	write
	mov	$0, %rax
	ret
