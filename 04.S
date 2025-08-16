.globl strlen
strlen:
	movb	$0, %sil	// storing 0 in a register for later because cmp only works with registers
	movq	%rdi, %rax	// safe current location where string begins
loop:	
	cmpb	(%rax), %sil	// check if character at location %rax is equal "0"
	je 	done	// skip to "done" if result of comparision was yes
	addq	$1, %rax	// move location of %rax up by one (one character)
	jmp	loop	// skip back to "loop" and keep going until 0 is found
done:
	subq	%rdi, %rax	// calculate the difference between end and beginning (%rax <- %rax - %rdi)
	
//	mov	$11, %rax // uncomment to see that linker is using this version over system version (will always return 5)
	ret
