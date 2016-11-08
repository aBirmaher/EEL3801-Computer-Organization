# Alan Birmaher
# EEL 3801
# Assignment 2A
#
# registers:
# $a0: holds necessary input for syscall to run
# $s1: storage location of values being read and summed
# $v0: holds syscall parameter option
#
.globalmain
main:				# main label
#
# Strings for printing within the code
#
.data
intro: .asciiz "Enter 4 integers to be added:\n"
sum:  .asciiz "Sum = "
#
.text				# .text
#
# obtain user input of 4 integers from the keyboard
#
	li $v0,4  		# service code to output string to console
	la $a0,intro 		# address of user input prompt
	syscall 		# syscall executes requested service code
	li $v0,5  		# service code to read integer from keyboard
	syscall  		# syscall executes requested service code
	move $s1,$v0  		# store a
	li $v0,5		# service code to read integer from keyboard
	syscall			# syscall executes requested service code
	add $s1,$s1, $v0	# store b
	li $v0,5		# service code to read integer from keyboard
	syscall			# syscall executes requested service code
	add $s1,$s1, $v0	# store c
	li $v0,5		# service code to read integer from keyboard
	syscall			# syscall executes requested service code
	add $s1,$s1, $v0	# store d
#
# print sum to console
#
	li $v0,4		# service code to output string to console
	la $a0,sum		# address of string to output
	syscall			# syscall executes requested service code
	li $v0,1		# service code to output integer to console
	move $a0,$s1		# value of f is to be displayed
	syscall 		# syscall executes requested service code
#
# terminate program
#
	li $v0,10		# service code to exit
	syscall			# syscall executes requested service code
# End of program
