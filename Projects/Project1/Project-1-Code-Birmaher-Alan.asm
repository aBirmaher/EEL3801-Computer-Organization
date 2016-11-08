# Alan Birmaher -- 09/18/2014
# Project-1-Code-Birmaher-Alan.asm-- 			
# Purpose: The first part of this program 
# 	calculates f=[a+(a*b)+(a*b*c)] and prints it in 
# 	decimal as well as in binary. The second part 
# 	builds on the first but divides the value by the max
# 	input value yeilding, g=[a+(a*b)+(a*b*c)]/max(a, b, c)
# 	This will then print the quotient and remainder in 
# 	decimal. This program must not use any built in 
# 	multiplication or division instructions.		
# Input: User enters 3 integers vua the keyboard
# Output: The value of f in decimal and binary is outputted as well as
# 	the quotient and remainder of g.
# Design Guidance:No input checking or error error handeling as specified.
# Program Version 1.0 written on 18 September 2014
# Bugs and Concerns: none known
# Tested in MARS 4.4 with inputs {15, 15, 15}, {9, 15, 21}, {80, 37, 1}, (99, 12, 75)
# Registers used:
# 	$t0 - used to hold the first number.
# 	$t1 - used to hold the second number.
# 	$t2 - used to hold the third number.
# 	$t4 - used to hold the value of the largest input value.
# 	$t5 - used to hold the value of f.
# 	$t6 - used to hold the value of g quotient.
# 	$t7 - used to hold the value of g remainder.
# 	$t8 - used to store values temporarily.
# 	$t9 - used as a counter for loops.
# 	$v0 - syscall parameter and return value.
# 	$a0 - syscall parameter.
#
main:
	#PART A
	#Print words
	li $v0, 4			#Sets value to print message
	la $a0, opener			#Prints specified message
	syscall				#Syscall
	#	
	# Get first number from user, put into $t0.
	li $v0, 5 			#reads integer in to $v0
	syscall 			#make the syscall
	move $t0, $v0			#move the read in value at $v0 into $t0
	#
	# Get second number from user, put into $t1.
	li $v0, 5 			#reads integer in to $v0
	syscall				#make the syscall
	move $t1, $v0			#move the read in value at $v0 into $t1
	#	
	# Get third number from user, put into $t2.
	li $v0, 5 			#reads integer in to $v0
	syscall				#make the syscall
	move $t2, $v0			#move the read in value at $v0 into $t2
	#
	#Set value of sum to 0
	li $t5, 0			#set value of sum to 0 to start
	#
	#Set up variables for loop
	li $t9, 0			#Starting value for loop at zero
	#
	#Loop to calculate a*b
	loop:				#loop label
	beq $t9, $t1, end 		#if $t9 == $t1 we are done 
	add $t5, $t5, $t0		#Add $t0 to sum $t1 times
	addi $t9, $t9, 1		#Add 1 to counter
	j loop				#Jump back up
	end:				#End of loop
	#
	#Set counter vack to zero
	li $t9, 0			#Starting value for loop at zero
	#
	#Set value to count up with
	li $t8, 0			#Set value to start to zero
	#
	#Loop to calculate a*b*c
	loop2:				#loop label
	beq $t9, $t2, end2 		#if $t9 == $t2 we are done 
	add $t8, $t8, $t5		#Add $t5 to sum $t2 times
	addi $t9, $t9, 1		#Add 1 to counter
	j loop2				#Jump back up
	end2:				#End of loop
	#
	#add a*b and a*b*c
	add $t5, $t5, $t8		#Calculate sum of calculations
	#
	#add a to the previous
	add $t5, $t5, $t0		#Calculate sum of prior and a to get final value to print
	#
	#Print words
	li $v0, 4			#Set value for syscall to print message
	la $a0, f_ten			#Set message to print	
	syscall				#Syscall
	#
	#Move value into location for printing
	move $a0, $t5			#$a0 <== $t5
	#
	# Print out result in decimal.
	print:				#section label
	li $v0, 1			#prints the integer value in $a0
	syscall				#makes the syscall
	#
	#Print word
	li $v0, 4			#Set value for syscall to print message
	la $a0, f_two			#Set message to print
	syscall				#Syscall
	#		
	# Print out result in binary.
	li $v0, 35			#prints the integer value in $a0
	syscall				#makes the syscall
	#
	#PART B
	#Find max value to store in $t4
	#Check if t0 is bigger, if so jump to correct section.
	bge $t0, $t1, t0_bigger		#If $t0>$t1 jump to t0_bigger
	#
	# If number t1 is greater save.
	move $t4, $t1			#$t4 <== $t1
	#		
	# If number t0 is greater
	t0_bigger:			#section label
	move $t4, $t0			#$t4 <== $t0
	#
	#Check if t2 is bigger than the current largest, if so jump to correct section
	bge $t4, $t2, t4_bigger		#If $t4>$t2 jump to t4_bigger
	#
	# If number t2 is greater save in the value
	move $t4, $t2			#$t4 <== $t2
	#
	# If number t4 is already largest
	t4_bigger:			#section label
	#
	#Print words
	li $v0, 4			#Set value for syscall to print message
	la $a0, g_quotient		#Set message to print
	syscall				#Syscall
	#
	#Set value of $t6 to 0
	li $t6 0			#Set value in $t6 to zero
	#
	#Find the quotient value stored in $t6
	loop3:				#loop label
	blt $t5, $t4, end3 		#if $t5 <= $t4 we are done 
	add $t6, $t6, 1			#Add 1 to quotient
	sub $t5, $t5, $t4		#Subtract largest value from sum
	j loop3				#Jump back up
	end3:				#End of loop
	#
	#Set value to print for the quotient
	move $a0, $t6			#$a0 <== $t6 Set vaulue for printing
	#
	#Print quotient
	li $v0, 1			#Set value for syscall to print integer
	syscall				#Syscall
	#
	#Print remainder
	#Print words
	li $v0, 4			#Set value for syscall to print message
	la $a0, g_remainder		#Set message to print
	syscall				#Syscall
	#
	#Set value to print for the remainder
	move $a0, $t5			#$a0 <== $t5 Set vaulue for printing
	#
	#Print remainder
	li $v0, 1			#Set value for syscall to print integer
	syscall				#Systcall
	#
	#Print line
	li $v0, 4			#Set value for syscall to print integer
	la $a0, fraction		#Tells systecall to print " / "
	syscall				#Syscall
	#
	#Print remainder
	move $a0, $t4			# $a0 <== $t4 Set vaulue for printing
	#
	#Print remainder
	li $v0, 1			#Set value for syscall to print integer	
	syscall				#Syscall
	#
	# End program
   	li $v0, 10   	# syscall code 10 is for exit.
   	syscall    	# make the syscall.
   	#
   	
   .data			#start of data elements in memory
  opener: .asciiz "Enter 3 integerss for a, b, c respectively:\n"	
  	#Message for requesting user information
  f_ten: .asciiz "f_ten = "			#Message for first output
  f_two: .asciiz "\nf_two = "			#Message for second output
  g_quotient: .asciiz "\nq_quotient = "		#Message for third output
  g_remainder: .asciiz "\nq_remainder = "	#Message for fourth output
  lf: .asciiz "\n"				#Line break
  fraction: .asciiz " / "			# / for fraction
  # end of Project-1-Code-Birmaher-Alan.asm.