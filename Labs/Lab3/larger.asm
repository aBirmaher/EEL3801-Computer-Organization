# Alan Birmaher -- 09/17/2014
# larger.asm-- A program that takes two numbers
# from a user and prints the larger of the two.
# Registers used:
# $t0 - used to hold the first number.
# $t1 - used to hold the second number.
# $v0 - syscall parameter and return value.
# $a0 - syscall parameter.

main:
	# Get first number from user, put into $t0.
	li $v0, 5 	#reads integer in to $v0
	syscall 	#make the syscall
	move $t0, $v0	#move the read in value at $v0 into $t0

	# Get second number from user, put into $t1.
	li $v0, 5 	#reads integer in to $v0
	syscall		#make the syscall
	move $t1, $v0	#move the read in value at $v0 into $t1
 
	#Check if t0 is bigger, is so jump to correct section
	bge $t0, $t1, t0_bigger		#If $t0>$t1 jump to t0_bigger
	
	# If number t1 is greater save in the value and jump to print
	move $a0, $t1	#$a0 <== $t1
	j print		#jump to print section
	
	# If number t0 is greater
	t0_bigger:	#section label
	move $a0, $t0	#$a0 <== $t0

	# Print out $t2.
	print:		#section label
	li $v0, 1	#prints the integer value in $a0
	syscall		#makes the syscall

	# End program
   	li $v0, 10   	# syscall code 10 is for exit.
   	syscall    	# make the syscall.
   	
  # end of larger.asm.
