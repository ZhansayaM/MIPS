# OP2 implemented, but only for one string
#'reverse' should be implemented with a0, a1, etc. as arguments, not s0, t0, k0, etc.

.data
	source:		.space	1024
	reversed:	.space	1024
	stop:		.byte '-'
	new:		.asciiz "\n"
.text
main:
	li	$v0, 8			# get a string from the user
	la	$a0, source		# store in source
	li	$a1, 1024		# max of 1024 bytes
	syscall
	
	jal	string			# jump and link to string procedure, saves return address to $ra
	
	addi	$t1, $v0, 0		# t1 = v0
	addi	$t2, $a0, 0		# t2 = a0 = source
	addi	$a0, $v0, 0		# a0 = v0
	j reverse
string:
	
	li	$t0, 0 			#initialize t0 =0
	li	$t2, 0			#initialize t2 =0, pointer to a string
loop:
	add	$t2, $a0, $t0		#t2 = a0 + t0; t2 = a0, t2 now points to the a0 (source string)
	lb	$t1, 0($t2)		#get the character from memory (1st char of source string)
	#beq 	$t1, $t5, end
	blez	$t1, strExit		#if t1 <=0, go to strExit label
	addi	$t0, $t0, 1		#if not, t0++, for getting the next char of a source
	j	loop			#iterate through the loop
strExit:
	subi	$t0, $t0, 2		#if the pointer is pointing to 0(which usuallu occurs at the end of the string), decrement by two to get the last char of a string
	addi	$v0, $t0, 0		#v0 = t0
	addi	$t0, $zero, 0		#t0 = 0
	jr	$ra			#return to the caller
reverse:
	li	$t3, 0			#t3 = 0
loop1:
	add	$t3, $t2, $t0		#t3 = base address for the string
	lb	$t4, 0($t3)		#load the byte from the string
	blez	$t4, exit		#if this byte is <=0 go to exit label
	sb	$t4, reversed($t1)	#if not, store the value of t4 into the first address of the reversed string
	subi	$t1, $t1, 1		#t1--(of reversed string)
	addi	$t0, $t0, 1		#t0++ (the next char of string)
	j	loop1			#iterate loop
	
exit:
	li	$v0, 4			# Print the reversed string to the console
	la	$a0, reversed		
	syscall
	li	$v0, 10			# end of program
	syscall
