# Alan Birmaher
# EEL 3801
# Assignment 1B
#
# registers:
# $a0: holds address of string in question
# $a1: aditional value for syscall use
# $v0: syscall parameter to choose what to do
# $t0: location we are looking at
# $t1: storage of bit being examined
# $t2: store ascci value of lower limit of lower case for comparison
# $t3: store ascci value of upper limit of lower case for comparison
#
# Strings for printing within the code
#
.data
intro: .asciiz "Enter name to be capitalized and press enter: "
sum:  .asciiz "Converted name:  "
buffer: .space 100
#
.text				# .text
main:				# Main
#
# obtain user input of string for conversion
#
	li $v0,4  		# service code to output string to console
	la $a0,intro 		# address of user input prompt
	syscall 		# syscall executes requested service code
	li $v0,8  		# service code to read integer from keyboard
	li $a1, 100		# allots the byte space for string
	la $a0, buffer		# load byte space into address
	syscall  		# syscall executes requested service code
#
# store limit values for finding out if a letter is lower case or not
#
	li $t2, 97		# stores lower limit of lower case for comparison
	li $t3, 122		# stores higher limit of lower case for comparison
#
# loop through the string character by character and check each character
#
	loop:			# loop label, for start of loop
	lb $t1,buffer($t0)	# load character into register for checking
	beq $t1,0,print		# if(char==null terminator) jump to end
	blt $t1, $t2, skip	# if ascii value is under that of lower case
	bgt $t1, $t3, skip	# if ascii value is above that of lower case
	sub $t1,$t1,32		# change lower case to upper
	skip:			# skip label
	sb $t1,buffer($t0)	# store new value
	addi $t0,$t0,1		# add 1 to counter
	j loop			# jump back up to loop
#	
# print string to console
#
	print:			# print label
	li $v0, 4		# service code to output string to console
	la $a0, sum		# address of string to output
	syscall			# syscall executes requested service code
	li $v0, 4		# service code to output converted string
	la $a0, buffer		# load buffer location into $a0
	syscall 		# syscall executes requested service code
#
# terminate program
#
	li $v0,10		# service code to exit
	syscall			# syscall executes requested service code
#
# End of program
