.data
	prompt1: .asciiz "Enter the base, please\n"
	prompt2: .asciiz "Enter the exponent, please\n"
.text
	li $v0, 4		#print the prompt about base
	la $a0, prompt1
	syscall
	
	li $v0, 5		#get the user input (base)
	syscall
	move $t0, $v0

	li $v0, 4		#print the prompt about exponent
	la $a0, prompt2
	syscall
	
	li $v0, 5		#get the user input (exponent)
	syscall
	move $a1, $v0		#$a1 - exponent
	move $a0, $t0		#$a0 - base
	
	jal pow			#jump and link to the pow procedure
	
	move $a2, $v0		#move the return value to the register $a2
	li $v0, 1		#print the power of a number
	move $a0, $a2
	syscall
	
	li $v0, 10		#end of the program
	syscall
	
pow:
	addi $sp, $sp, -4	#create a stack pointer with 1 'space'
	sw $ra, 0($sp)
	
	bne $a1, 0, others	#if the exponent is a numver rather than 0
	
	li $v0, 1		#store 1 in $v0
	addi $sp, $sp, 4	#delete the 'space' created by stack pointer
	jr $ra			#return to the jumping address

others:
	bne $a1, 1, notone	#if the exponent != 1
	move $v0, $a0		#move the exponent itself into $v0 register
	addi $sp, $sp, 4	#delete the stack pointer
	jr $ra			#return to the jumping address
notone:
	sub $a1, $a1, 1		#n-1
	jal pow			#recursion to pow procedure
	lw $ra, 0($sp)		
	addi $sp, $sp, 4	#deletion of the created 'space' for stack pointer
	mul $v0, $v0, $a0	#multiplication
	jr $ra			#return to the jumping address

