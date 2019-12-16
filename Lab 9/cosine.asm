# insert int, convert to float, put into $f12, jal cosine, return $f0
.data
	pi: .float 3.14159265359
	prompt: .asciiz "Please, enter the value of the angle in degree: "
	degree: .word 180
	zero: .float 0
	onee: .float 1
	minone: .float -1
.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5		#value of x in degree
	syscall
	
	move $t2, $v0		#value of x is stored
	beq $t2, -1, exit
	mtc1 $t2, $f14
	l.s $f10, degree		#t1 = 180
	
	l.s $f0, one		#power degree
	l.s $f4, pi		#f4 = pi
	div.s $f6, $f4, $f10	#f6 = pi/180
	mul.s $f12, $f6, $f14	#f12 = pi/180 * x
	
	l.s $f4, onee
	li $t0, 0
	l.s $f6, onee
	li $t1, 0
	li $t5, 4
	l.s $f16, minone
	jal cosine
print:
	li $v0, 2
	mov.s $f12, $f0
	syscall
	
	j main
cosine:				#to approximate the value of cosine, last term x^14/14!
	beq $t0, 16, print
	j power
	
	li $t1, 0
	
	j fact
	
	div.s $f8, $f6, $f4
	
	div $t0, $t5
	mfhi $t4
	bne $t4, 0, notzero
	
	add.s $f0, $f0, $f8
	addi $t0, $t0, 2
	li $t1, 0
	j cosine
notzero:
	mul.s $f8, $f8, $f16
	add.s $f0, $f0, $f8
	addi $t0, $t0, 2
	li $t1, 0
	j cosine
power:
	beq $t0, $t1,cosine	#if the power == 16, should terminate
	beq $t1, 1, one
	mul.s $f6, $f12,$f12 
	addi $t1, $t1, 1
	j power
one:
	mov.s $f6, $f12
	addi $t1, $t1, 1
	j power
fact:
	beq $t1, $t0, cosine
	mtc1 $t1, $f18
	mul.s $f4, $f4, $f18
	addi $t1, $t1, 1
	j fact
exit:
	li $v0, 10
	syscall