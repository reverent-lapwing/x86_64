.globl main	// we make label "main" visible to the linker - this is where programs always start from
main:	// a label named "main"
	mov	$0, %rax	// we populate the register "rax" with value "0" - rax is here the return value is stored
