.data
	Arr: .word 21, 20, 51, 83, 20, 20
	x: .word 20
	y: .word 5
	index: .word 0
	length: .word 6
	space: .asciiz " "
	newLine: .asciiz "\n"
.text
	la $a1, Arr
	la $t0, x
	lw $t0, 0($t0)
	la $t1, y
	lw $t1, 0($t1)
	la $t2, length
	lw $t2, 0($t2)
	la $t3, index
	lw $t3, 0($t3)
	addi $t4, $zero, 0
	
	jal printArrInt
	
	la $a1, Arr
	la $t0, x
	lw $t0, 0($t0)
	la $t1, y
	lw $t1, 0($t1)
	la $t2, length
	lw $t2, 0($t2)
	la $t3, index
	lw $t3, 0($t3)
	
	jal replace
	
	la $a1, Arr
	la $t0, x
	lw $t0, 0($t0)
	la $t1, y
	lw $t1, 0($t1)
	la $t2, length
	lw $t2, 0($t2)
	la $t3, index
	lw $t3, 0($t3)
	
	jal printArrInt
	#end of program
	li $v0, 10
	syscall
	
printArrInt:
	beq $t3, $t2, returnn
	lw $t5, 0($a1) #t0 = a0[0]
	addi $a1, $a1, 4
	addi $t3, $t3, 1
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 4 
	la $a0, space
	syscall
	
	j printArrInt
replace:
	beq $t3, $t2, returnnn
	lw $t5, 0($a1) #t0 = a0[0]
	addi $sp, $sp, -4 #if -4x allocating memory in the stack, if +4x then taking away memory form the stack
	sw $ra, 4($sp) #address will be stored in sp
	
	beq $t0, $t5, movee
cont:
	addi $a1, $a1, 4
	addi $t3, $t3, 1
	lw $s0, 0($sp)
	lw $ra, 4($sp) #address of the main (return value)
	addi $sp,  $sp, 4

	j replace
movee: 
	sw $t1, 0($a1)
	jal cont
returnn:
	li $v0, 4 
	la $a0, newLine
	syscall
	
	jr $ra
returnnn:	
	jr $ra
