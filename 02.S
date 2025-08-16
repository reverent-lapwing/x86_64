data:	
	// a label where we store our data - it can be called whatever we want
	.string "hello world"	// a string - characters stored in memory one after the other
.globl main
main:
	// here we will prepare parameters of a function and later call it
	// the registers used to pass arguments to functions are (in order):
	// %rdi, %rsi, %rdx, %rcx, %r8, %r9
	mov	$1, %rdi	// we tell the write function to use file description 1 - on linux its "stdout", output to terminal
	leaq	data(%rip), %rsi	// %rip has the value of current instruction (this line), data is a relative distance to "data" label - it cancels out to 0, the position where our string is stored
	mov	$11, %rdx	// we need to let the function know how many bytes it needs to write
	call	write	// call system function called "write" - it will read from %rdi where it is supposed to write to, from %rsi it will read bytes to write and from %rdx how many byte to write there are
	
	mov	$0, %rax	// we set rax to 0 to let system know everything went ok 
	ret	// we need to let the program know that "main" function is over and it should keep going - I'm not sure why we didn't have to last time but it's probably becuse of something that happens in "write"
