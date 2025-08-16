#####
# This is the simplest possible program that exits immediately.
# 
# Before we move on to analyzing the code, let's discuss some basics. This 
# program is written in GNU AS format, which is the standard format for Linux.
# The choice of what format you are using comes down to personal preference.
# Assembly code contains CPU instructions and data in human readable format
# and it's turned into machine code by a program called compiler - for GNU AS
# that program is called `as`. The machine code then get turns into an 
# executable by program called linker - on Linux that program will be `ld`.
#
# This part of the code is a comment, everything behind '#' sign will be 
# ignored by the compiler.
#
# Assembly instructions tell the CPU what to do - adding or subtracting numbers
# etc. Values that CPU operates on are stored in registers, a physical space
# the CPU's circuits. x86_64 processors have 16 general purpose 64-bit
# registers for us to use, meaning that we can freely write and read from them
# and that they can hold any number from 0 to 2^64.
#
# By convention, whenever we are annotating code, the comment is place 
# immediatelly above the line being annotated.
#####



# compiler command to make the label "_start" visible for linker - we need to 
# do that because linker looks for that label to know where it should start the
# execution
.globl _start

# label "_start" will refer to the instruction right after this line 
_start:
	# write value "60" into register called %rax
	movq 	$60, %rax

	# write value "0" into register called %rdi
 	movq 	$0, %rdi

	# invoke operating system to execute a system command
	# first operating system looks at %rax register to determine what 
	# command should be called - "60" coresponds with command "exit" that
	# end the program
	# next operating system looks at the register %rdi to see what exit code
	# it should return - exit code 0 indicates success, any other code will
	# be specific to the program to indicate what went wrong 
 	syscall
