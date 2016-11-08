# Alan Birmaher -- 09/10/2014
# add2.asm-- A program that computes and prints the sum
# of two numbers specified at runtime by the user.
# Registers used:
# $t0 - used to hold the first number.
# $t1 - used to hold the second number.
# $t2 - used to hold the sum of the $t1 and $t2.
# $v0 - syscall parameter and return value.
# $a0 - syscall parameter.

main:
	## Get first number from user, put into $t0.
	li $v0, 5 	#reads integer in to $v0
	syscall 	#make the syscall
	move $t0, $v0	#move the read in value at $v0 into $t0

	## Get second number from user, put into $t1.
	li $v0, 5 	#reads integer in to $v0
	syscall		#make the syscall
	move $t1, $v0	#move the read in value at $v0 into $t1
 
	# compute the sum.
	add $t2, $t0, $t1 # $t2 = $t0 + $t1.
	
	# store value into $a0 for printing
	move $a0, $t2	#$a0 <== $t2

	# Print out $t2.
	li $v0, 34	#prints the integer value in $a0 in hexadecimal format
	syscall		#makes the syscall

	# End program
   	li $v0, 10   	# syscall code 10 is for exit.
   	syscall    	# make the syscall.
   	
  # end of add2.asm.