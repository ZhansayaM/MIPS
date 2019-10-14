.data
	prompt: .asciiz "Please, enter 2 integers to sum them up\n"
.text

loop:
	li $v0, 4		#print the message
	la $a0, prompt
	syscall
	
	li $v0, 5		#get the user input
	syscall
	move $t0, $v0		#store the input in $t0
	
	li $v0, 5		#get the user input
	syscall
	move $t1, $v0		#store the input in $t1

	add $t0, $t0, $t1	#sum the numbers
	li $v0, 1		#print the sum
	move $a0, $t0
	syscall
	
.ktext 0x80000180		#exception handler
	mfc0 $k0, $14
	addi $k0, $k0, 4
	la $k0, loop
	mtc0 $k0, $14
	
	li $v0, 4		#print "Try again!"
	la $a0, try
	syscall
	
	eret
	#jr $k0
.kdata
	try: .asciiz "Try again!\n"