# Draws only 1 orange circle

.data
	DISPLAY: .space 16384
	DISPLAYWIDTH: .word 64
	DISPLAYHEIGHT: .word 64
	COLOR: .word 0xff8433,0xff0000, 0xfefa00, 0x00fe11, 0x0066fe, 0xcd00fe, 0x00ffff, 0xff00ff, 0x00ff00, 0x800000
	value: .float 23.4
.text
j main
set_pixel_color:
	lw $t0, DISPLAYWIDTH
	mul $t0, $t0, $a1
	add $t0,$t0, $a0 	
	sll $t0, $t0, 2 	
	la $t1, DISPLAY 	
	add $t1, $t1, $t0	
	sw $a3, ($t1) 		
	jr $ra 		
circleRainbow:
	li $t2, 0
	move $t3, $a2
	mul $t4, $a2, 2
	li $t5, 1
	sub $t4, $t5, $t4
	li $t6, 0
	move $s5, $a0
	move $s6, $a1
	move $s7, $a3
	move $s0, $ra
for:
	blt $t3, 0, fors
	
	add $a0, $s5, $t2
	add $a1, $s6, $t3
	move $a2, $s7
	jal set_pixel_color
	
	add $a0, $s5, $t2
	sub $a1, $s6, $t3
	move $a2, $s7
	jal set_pixel_color
	
	sub $a0, $s5, $t2
	add $a1, $s6, $t3
	move $a2, $s7
	jal set_pixel_color
	
	sub $a0, $s5, $t2
	sub $a1, $s6, $t3
	move $a2, $s7
	jal set_pixel_color
	
	add $t5, $t4, $t3
	mul $t5, $t5, 2
	addi $t5, $t5, -1
	move $t6, $t5
	
	bge $t4, 0, nont
	bgt $t6, 0, nont
	addi $t2, $t2, 1
	mul $t5, $t2, 2
	add $t4, $t4, $t5
	addi $t4, $t4, 1
	j for 
nont:
	ble $t4, 0, nont1
	ble $t6, 0, nont1
	mul $t5, $t3, 2
	sub $t4, $t4, $t5
	addi $t4, $t4, 1
	addi $t3, $t3, -1
	j for 
nont1:
	addi $t2, $t2, 1
	sub $t5, $t2, $t3
	mul $t5, $t5, 2
	add $t4, $t4, $t5
	addi $t3, $t3, -1
	j for
fors:
	move $ra, $s0
	jr $ra
main:
	li $a0, 32
	li $a1, 32
	li $t9, 15
	la $t8, COLOR
	lw $a3, 0($t8)
	move $a2, $t9
	beq $a2, 5, exit
	jal circleRainbow
	addi $t8, $t8, 1
	sub $t9, $t9, 1
	j main
exit:
	li $v0, 10
	syscall
	
