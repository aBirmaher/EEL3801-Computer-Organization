# Alan Birmaher
# EEL 3801
# Homework 6B
#
.globl main			# Declare main as a global function
.text				# All code goes after .text
#
# registers:
# $a0: address location
# $s0: limit of loop progression for comparison
# $s1: counter variable
# $s2: value for comparison
# $t1: storage location of number for comparison
# $v0: storage of value to return from function
#
main:				# main function
# set up values for passing in to function
la $a0, arrayX			# store array address into $a0
li $s0, 10			# words in array
li $s1, 0			# counter
li $s2, 4			# value for comparison
li $v0, 0			# counter to be read back from function
#
# call the divBy4 function
jal divBy4
#
# print negative sum to console
	move $a0, $v0		# function attained value stored for printing
	li $v0,1		# service code to output integer to console
	syscall 		# syscall executes requested service code
#
# terminate program
	li $v0,10		# service code to exit
	syscall			# syscall executes requested service code
#
# Termination of program
#
# divBy4 function
divBy4:
	# while (counter< length)
	loop:
	beq $s1, $s0, goBack	# if counter reaches amount in array jump back
	lw $t1, ($a0)		# loads the number to check
	div $t1, $s2		# divide number
	mfhi $t2		# loads value in question into $t1 for analysis
	bne $t2, $0, nonDiv	# jump counter is not remainder 0
	addi $v0, $v0, 1	# add 1 to counter
	nonDiv:			# nonDiv label
	addi $a0, $a0, 4	# increment counter for array elements
	addi $s1, $s1, 1	# increment counter
	j loop			# jump back up to loop start
#
# jumps back to main to print and finish
	goBack:			# goBack label
	jr $ra			# jump to $ra
#
# end sum function
#
.data
arrayX: .word 0, 16, 2, 3, 4, 5, 6, 7, 8, 9, 10
