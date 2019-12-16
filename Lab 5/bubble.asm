# 'sort' should be implemented as separate and independent procedure, with jr $ra

.data 
	length: .word 6
	S: .asciiz "H ello"
	new: .asciiz "\n"
.text 
main:
	la $a1, S 		# load the address of the string
	
	li $v0, 4		# print the
	la $a0, S		# string S
	syscall
	
	li $v0, 4		# print the
	la $a0, new		# new line
	syscall
	
	lw $a2, length 		# load the length of the string
	jal string_bubble_sort	# jump and link to bubble sorting procedure
print: 
	move $t0, $a2 		# copy the value of the length into t0
	
	li $v0, 4 		# print the
	la $a0, S		# string S
	syscall
loop: 
	blez $t0, exit 		# if t0 is less than 0, then go to exit (end the program)
	lb $a0, ($a1)		# get word at current address based on count 
	addi $a1, $a1, 1 	# increment word address by 4 bytes 
	subi  $t0, $t0, 1 	# decreament count by 1 
	j loop			# iterate through the loop
string_bubble_sort:
	li $t7, 0 		 	# set for swapped: 0 is true, 1 is false 
	swapped:   
		move $t6, $a2 	 	# copy the value of the length into t6
		subi $t6, $t6, 1 	# decrement the value of the length by 1 to get the index of the last element
		bgtz $t7, print		# if swapped is bigger than zero, i.e. is false go to print the array
		li $t7, 1 		# set swapped to false
	count:
		beq $t6, $zero, swapped		# if t6(here is count) is 0, go to swapped
		subi $t5, $t6, 1 		# the value(index) of the pre-last element
		add $t2, $t6, $a1 		# getting the address of the last element
		add $t3, $t5, $a1 		# getting the address of the pre-last element
		lb $t4, ($t2)			# load the value of the last element 
		lb $t5, ($t3)			# load the value of the pre-last element 
		blt $t4, $t5, swap		# if the last element is less than the previous, swap them 
		subi $t6, $t6, 1 		# pointing to an address lower to 1 than before
		j count 			# if the 2 elements are sorted, continue iteration through the word
	swap: 
		sb  $t5, ($t2) 			# swap the values if they're not sorted
		sb  $t4, ($t3)			# swap the values if they're not sorted
		subi $t6, $t6, 1 		# pointing to an address -1 than before
		li $t7, 0 			# set swapped to true
		j count				# iterate through the word
exit: 
	li $v0, 10  			# end of program
	syscall 
