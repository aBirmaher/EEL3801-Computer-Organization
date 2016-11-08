# Alan Birmaher
# EEL 3801
# Assignment 2B
#
.globl main			# Declare main as a global function
.text				# All code goes after .text
#
# registers:
# $s0: limit of outer loop progression for comparison
# $s1: inside loop counter variable
# $s2: offset counter
# $t0: storage location of first number for comparison
# $t1: storage location of second number for comparison
# $v0: storage of parameter for syscall
#
main:				# main function
# set up values for use in code
li $s0, 7			# starting size of outer loop, size-1
# outside of bubble sort 
outside:			# outside label
	blez $s0, outsideDone	# if $s0 is zero, jump to outside2
	li $s1, 0		# reset value of inside counter
	li $s2, 0		# reset value of offset counter
#
# inside of bubble sort
inside:
	bge $s1, $s0, insideDone# if $s1>$s0 jump to insideDone label
	lw $t0, numArr($s2)	# store current element into $t0
	lw $t1, numArr + 4($s2)	# store next element into $t1
	ble $t0, $t1, skip	# if no swap needs to be made jump to skip
	sw $t1, numArr($s2)	# swap first value and store
	sw $t0, numArr + 4 ($s2)# swap second value and store
# if no swap is needed
skip:				# skip label
	addi $s1, $s1, 1	# increment inside loop counter
	addi $s2, $s2, 4	# incrememnt offset counter
	j inside		# jump to top of the inner loop
insideDone:			# insideDone label
	addi  $s0, $s0, -1	# decrement outside counter by 1
	j outside		# jump back up to outer loop
#label for when outer is done	
outsideDone:			# outside is done
#
# terminate program
	li $v0,10		# service code to exit
	syscall			# syscall executes requested service code
#
# Termination of program
#
.data
numArr:	.word	4, 5, 1, 3, 9, 2, 6, 7
