/*
 * For the first time we will be calling a function from another function (we
 * technically did that already because main is a function, we will get back to
 * that later), so we need to learn about caller-safe registers and the stack.
 *
 * The following registers are not guaranteed to have the same value before
 * and after a call to another function:
 * %rax, %rcx, %rdx, %rdi, %rsi, %rsp and %r8 through %r11
 * 
 * We call those registers caller-safe, because the caller (function being
 * called) can safely use them for whatever purposes programmer wants without
 * caring about preserving their value.
 * 
 * That leaves following general purpose registers as callee-safe, meaning that
 * every time we used them in a function, we need to return them to the 
 * original value before returning control to the callee:
 * %rbx, %rbp and %r12 through %r15
 *
 * There is nothing special about those registers and this is merely
 * a convention that most code follows. It's impoortant to stick to this
 * convention because thanks to that when we're interfacing with other people's
 * code, we know what to expect to happen to registers when calling functions
 * without knowing what happens inside them and people interfacing with our
 * code know what to expect too.
 *
 * By convention, %rsp is used as a stack pointer and starts with the maximum
 * possible value that can be stored in it. Stack is a piece of limited memory
 * given to all programs by the operating system where we can write to and read
 * from freely without worrying about any other program modifying it. The size
 * of the stack is determined by the operating system configuration.
 * 
 * When we want to store some amount of bytes on the stack, we subtract that
 * amount from %rsp, moving the stack pointer towards 0 position. That means
 * that stack pointer holds value of a memory address below all the adresses
 * that are already in use, giving us the guarantee that when we decrese the
 * stack pointer, the adresses between the previous and current value are 
 * previously unused and we can use them without interfering with memory of
 * any other function. After the memory is no longer needed, we increas the
 * %rsp by the same value we decressed it by, so we can reuse those adresses
 * later.
 *
 * But remember that %rsp is a caller-safe register, meaning that its value
 * can change after calling a function. This is why by convention functions
 * store the adress of the memory they use in the %rbp register.
 * 
 * Using the stack is useful for storing values passed to the function in the
 * caller-safe registers so we can be sure we always have the original value
 * when we need it.
 *
 * Notice that after increasing the stack pointer, the data stored on the stack
 * is still there, only the stack pointer was moved. This means that when
 * another function uses that memory, it will have some undefined data that we
 * need to overwrite before using it.
 */
.rodata
data:
	 // write needs an address to a string, so we need to save it to memory
	.string "\n"
.text
.globl print
print:
	// store the curent value of the callee-safe register %rbp so we can
	// restore it later before returning
	//
	// this ia shorthand for storing %rbp at address %rsp and moving %rsp
	// down by 8 bytes
	push	%rbp
	// safe the current value of the stack pointer so we don't need to
	// worry about other functions changing its value
	mov	%rsp, %rbp
	// move the stack pointer by 8 bytes (size of one 64-bit register), so
	// now when another function wants to use the stack, they know to not
	// use the memory we are using
	sub	$16, %rsp

	// save caller-safe register %rdi on the stack - in the address 8 bytes
	// below the %rbp ( %rbp holds the end of memory allocated for
	// our function we allocated 8 bytes, so start of the memory is
	// %rbp - 8)
	movq	%rdi, -8(%rbp)

	// print takes address of a string as a first argument and strlen does
	// too, so we can just call it stright away and get lenght in %rax in
 	// return - remember that registers can change outside of our control
	// only after calling another function, so for now we're still
 	// guaranteed that they hold the original value
	call	strlen 
	mov	%rax, %rdx

	// reading from the stack the address of the string passed as the first 
	// argument of the function because strlen is allowed to change the
	// value of %rdi and we don't know what is stored in there right now
	mov	-8(%rbp), %rsi	

	// printing always to stdout (to the terminal)
	mov	$1, %rdi 
	call	write

	// adding newline at the end for convienience
	mov	$1, %rdi
	leaq	data(%rip), %rsi
	mov	$1, %rdx
	call	write
	
done:
	// move the stack pointer to the original position so another functions
	// can reuse the memory we no longer need
	mov	%rbp, %rsp
	// return the original value of callee-safe %rbp
	//
	// short-hand for storing value at the position %rsp into %rbp and
	// increasing %rsp by 8
	pop	%rbp
	mov	$0, %rax
	ret
	
	


