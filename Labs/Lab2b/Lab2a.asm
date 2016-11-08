# Alan Birmaher
# EEL 3801
# Assignment 2A
#
#
.globl main			# Declare main as a global function
.text				# All code goes after .text
#
# registers:
# $a0: holds necessary input for syscall to run
# $a1: store length of array into $a1
# $a2: store length of array into $a1
# $s0: storage location of positive sum
# $s1: storage location of negative sum
# $s2: counter
# $s3: counter
# $t0: holds location in array
# $t1: holds current array value
# $v0: holds syscall parameter option
#
main:				# main function
# set up values for use in code
li $s0, 0			# initialize value for posSum
li $s1, 0			# initialize value for negSum
li $s2, 0 			# create array offset counter
li $s3, 0			# create counter
la $a0, numArr			# store array address into $a0
li $a1, 9			# store length of array into $a1
#
# jump to the function for calculations
jal SUM				#jump to SUM function label
#
# print positive sum to console
	li $v0,4		# service code to output string to console
	la $a0,sumPos		# address of string to output
	syscall			# syscall executes requested service code
	li $v0,1		# service code to output integer to console
	move $a0,$s0		# value of f is to be displayed
	syscall 		# syscall executes requested service code
#
# print negative sum to console
	li $v0,4		# service code to output string to console
	la $a0,sumNeg		# address of string to output
	syscall			# syscall executes requested service code
	li $v0,1		# service code to output integer to console
	move $a0,$s1		# value of f is to be displayed
	syscall 		# syscall executes requested service code
#
# terminate program
	li $v0,10		# service code to exit
	syscall			# syscall executes requested service code
#
# Termination of program
#
# SUM function
SUM:				# SUM function label
#
# while (counter< length)
	loop:
	beq $a1, $s3, goBack	# if counter reaches amount in array jump back
	lw $t1, ($a0)		# loads value in question into $t1 for analysis
	bgtz $t1, posSum	# value is positive, jump to posSum function
	bltz $t1, negSum	# value is positive, jump to negSum function
	loopReturn:		# loop return label
	addi $a0, $a0, 4	# increment counter for array elements
	addi $s3, $s3, 1	# increment counter
	j loop			# jump back up to loop start
#
# value is positive, add to posSum
	posSum:			# posSum function
	add $s0, $s0, $t1	# add value from array to posSum
	j loopReturn		# jump back to loop
#
# value is negative, add to negSum
	negSum:			# negSum function
	add $s1, $s1, $t1	# add value from array to negSum
	j loopReturn		# jump back to loop
#
# jumps back to main to print and finish
	goBack:			# goBack label
	jr $ra			# jump to $ra
#
# end sum function
#
# data section
.data
sumPos:	.asciiz "The sum of the positive values = "
sumNeg:	.asciiz "\nThe sum of the negative values = "
numArr:	.word	-3, 12, -8, 9, 22, 15, -44, 0, 20
#
