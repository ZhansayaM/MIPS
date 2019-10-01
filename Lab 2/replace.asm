.data
	Arr: .word 21, 20, 51, 83, 20, 20
	x: .word 20
	y: .word 5
	index: .word 0
	length: .word 6
	space: .asciiz " "
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
loop:
	beq $t3, $t2, exit
	lw $t5, 0($a1) #t0 = a0[0]
	addi $a1, $a1, 4
	addi $t3, $t3, 1
	beq $t0, $t5, replace
	
	#print the ith element of the array
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	j loop
replace: 
	move $t5, $t1
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	j loop
exit:
	#end of program
	li $v0, 10
	syscall