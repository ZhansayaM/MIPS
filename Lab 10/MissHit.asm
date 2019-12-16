# M >= 6000 && M < 7000 :: 80pts;; -Incorrect combination of number and size of the blocks, by incorrect we mean any combination that doesn't give 128 kb of cache size:: -10pts;;

.data
	array: .byte 1024
.text
#number of blocks: 1
#cache block size: 256
#your metric score: 6243.328
#the reasons for my optimization
#in assembly code: use locality of caches and iterate through a loop (temporal) and return to the primary address - spatial locality
#in the configuration of cache parameters: 1 number of block - minimum number so that all the data will be stored at once, 256 - increasing the number of cache block size to lower the miss rates

la $a0, array				#reading the array of bytes
li $t0,1				#storing 1 in $t0

loop:
	beq $t2, 1024, exit		#$t2 is empty at the beginning; if $t2!=1024 continue looping, elif $t2==1024, jump to exit
	lb $t1, ($a0)			#loading the first element from the array into $t1
	addi $t1, $t1, 1		#increment $t1 to 1
	sb $t1, ($a0)			#store the value from $t1 to the first element of the array
	add $a0, $a0, $t0		#step into the next element of the array
	addi $t2, $t2,1			#increment the $t2
	j loop				#iterate through a loop
exit:
	li $v0, 10			#exit the program
	syscall
