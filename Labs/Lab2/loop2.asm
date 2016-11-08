# Alan Birmaher -- 09/10/2014
# loop2.asm-- A program that counts up from
# 0 to 15.
# Registers used:
# $t0 - used to hold the starting value.
# $t1 - used to hold temporary values.
# $t2 - used to hold the exit parameter.
# $v0 - syscall parameter and return value.
# $a0 - syscall parameter.

main:

	#Set start and end points
	li $t0, 0		#Store start value of 0 into register
	li $t2, 15		#Stores end value of 15 into register
	
	# loops from 0 to 15 inclusive
	L1: bge $t0, $t2, EXIT           
	add $t1, $t0, 1		#$t1= $t0 + 1
	move $t0, $t1		#$t0= $t1   
	move $a0, $t1		#$a0= $t0
	li $v0, 34		#Prints current value
	syscall			#Makes syscall       
	j L1
	
	EXIT:			#EXIT label

	# End program
   	li $v0, 10   	# syscall code 10 is for exit.
   	syscall    	# make the syscall.
   	
  # end of loop2.asm.