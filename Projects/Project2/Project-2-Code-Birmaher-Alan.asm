# Alan Birmaher -- 09/18/2014
# Project-1-Code-Birmaher-Alan.asm-- 			
# Purpose: The first part of this program 
# 	takes in a string of words. This string is analyzed 
# 	word by word and checked to see if the word has a hex
# 	value. If it does then we find the decimal value of
# 	that word and print it out to the console in place 
# 	of that word, while reprinting the string. Next we
# 	find the value of of the largest word and determine
# 	if it is Sparse, Intermediate or Plentiful. That is
#	then printed to the console as well	
# Input: User enters a string of words ending in a period
# Output: The same string with all hex values words replaced
# 	by their decimal values. Also the level of the string.
# Design Guidance:No input checking or error error handeling as specified.
# Program Version 1.0 written on 23 October 2014
# Bugs and Concerns: none known
# Tested in MARS 4.4
# Registers used:
# 	$t0 - temp value
# 	$t1 - i value for use throughout
# 	$t2 - stores max value
#	$t3 - stores strength value
# 	$t4 - stores start value
# 	$t5 - stores end value
# 	$t6 - stores hexWord value
# 	$t7 - stores start value
# 	$t8 - stores end value
# 	$t9 - counter
#	$s0 - addy of theString stored here for going through it
#	$s1 - used to store characters individually for analysis
#	$s2 - aditional storage for flag use
# 	$v0 - syscall parameter and return value
# 	$a0 - syscall parameter
#	$a1 - syscall parameter 2
#	$a2 - syscall parameter 3
#Data section
.data				#data
theString:			#theString setup
    .space 101			#set aside 64 bytes			
sparse: .asciiz "\Sparse."		#Sparse string to print
intermediate: .asciiz "\Intermediate"	#Intermediate string to print
plentiful: .asciiz "\Plentiful"		#Plentiful string to print
#
.text 					#tells the computer that the next line will be code
#
main:	#Main function
	#PART A
	#Reading in of string from keyboard
	li $v0, 8			#sets value to tell syscall what to do
    	la $a0, theString		#loads address of string
    	li $a1, 301			#stores the largest amount of characters that can be stored
    	syscall				#syscall
    	la $s0, theString		#theString addy stored into $s0
    	la $t0, theString		#theString addy stored into $t0
    	li $t6, 0			#Initiates value of hexWord to 0
#	
	#Setup Variables
	li $t0, 0			#starts temp value to 0
	li $t1, 0			#start i value to 0
	li $t2, 0xFFFFFFF		#starts max value at 0xFFFFFFF= 268435455
	li $t3, 0			#starts strength value to 0
	li $t4, 0			#starts start value to 0
	li $t5, 0			#starts end value to 0
	li $t6, 0			#starts hexWorld value to 0
#
	#Scan through until the end of string character
	xor $t9, $t9, $t9		#bring $a0 into check for the upcoming loop
#
	#outer while loop, goes through entire string to process
	whileNotPeriod:			#label to jump back to if we have not reached end of string
	lbu $a2, theString($t9)		#loads bit at location into $a2
	beq $a2, '\n', stringEnd	#in the case that we reach the terminating character break out
	bne $a2, ' ', noSpaceChar	#if there is a space we increment the counter on the next line
	li $v0, 11			#sets up syscall to print character
	addi $a0, $a2, 0		#saves value of space for printing 
	syscall				#syscall
	addiu $t9, $t9, 1		#incremement location past the space		
	lbu $a2, theString($t9)		#updare value of $a2
	noSpaceChar:			#point to jump ahead to in the case we dont need to incrememnt
	addi $t7, $t9, 0		#sets up start value
	addi $t8, $t9, 0		#sets up end value
	li $t6, 0
	li $s1, 1
	li $s2, 0
	whileNotSpaceorPeriod:		#label for while if not space or period
	beq $a2, ' ', endWhile2		#if character is a space jump to end while loop
	beq $a2, '.', endWhile2		#if character is a period jump to end of while loop
	beq $a2, '0', endIf1		#if character is not a hex value, checking for 0 here
	beq $a2, '1', endIf1		#if character is not a hex value, checking for 1 here
	beq $a2, '2', endIf1		#if character is not a hex value, checking for 2 here
	beq $a2, '3', endIf1		#if character is not a hex value, checking for 3 here
	beq $a2, '4', endIf1		#if character is not a hex value, checking for 4 here
	beq $a2, '5', endIf1		#if character is not a hex value, checking for 5 here
	beq $a2, '6', endIf1		#if character is not a hex value, checking for 6 here
	beq $a2, '7', endIf1		#if character is not a hex value, checking for 7 here
	beq $a2, '8', endIf1		#if character is not a hex value, checking for 8 here
	beq $a2, '9', endIf1		#if character is not a hex value, checking for 9 here
	beq $a2, 'A', endIf1		#if character is not a hex value, checking for A here
	beq $a2, 'B', endIf1		#if character is not a hex value, checking for B here
	beq $a2, 'C', endIf1		#if character is not a hex value, checking for C here
	beq $a2, 'D', endIf1		#if character is not a hex value, checking for D here
	beq $a2, 'E', endIf1		#if character is not a hex value, checking for E here
	beq $a2, 'F', endIf1		#if character is not a hex value, checking for F here
	li $s1, 0
	j endIf4			#sets value of hexWord to 1
	endIf1:
	li $s2, 1
	endIf4:				#end of if loop label
	beqz $s1 nextCheck
	j afterCheck
	nextCheck:
	beq $s1, 1, yes
	j no
	yes:
	li $t6, 0
	no:
	afterCheck:
	bne $s1, 1, skipCheck
	addi $t6, $t6, 1			
	skipCheck:						
	addi $t9, $t9, 1		#counter incremented
	addi $t8, $t8, 1		#increment end
	lbu $a2, theString($t9)		#updare value of $a2
	bne $a2, ' ', whileNotSpaceorPeriod	#if not a space jump back for while loop
	bne $a2, '.', whileNotSpaceorPeriod	#if not a period jump back for while loop
	endWhile2:			#end of while loop label
	li $s0, 0			#set value of $s0 to 0
	bne $t6, 1, endIf2		#if hexWord is not 1
	bne $s1, 1, endIf2
	slt $s0, $t7, $t8		#check if start is less than end, if so set flag
	while3:				#while3 label
	bne $s0, 1, endIf2		#skip if end> start		
	lbu $a2, theString($t7)		#update value of char to print
	li $v0, 11			#sets value for syscall to print character
	addi $a0, $a2, 0		#sets character for syscall print
	syscall				#syscall to print character
	addi $t7, $t7, 1		#increment start
	slt $s0, $t7, $t8		#check if start is less than end, if so set flag
	j while3			#jumps back to while3 label
	li $s0, 0			#brining value back to 0 for $s0
	#meat of other loop
	endIf2:				#end of if label
	bne $t6, 0, endIf3		#if hexWorld is not 0
	endIf3:				#end of if label
	addiu $t9, $t9, 1		#increment counter
	bne $t9, $a1, whileNotPeriod	#while we have not reached the end of the string, jump back
	stringEnd:			#endString tag for a location to jump to when done reading in
#	
	#Prepare syscall for program termination
	li $v0, 10   			#syscall code 10 is for exit
   	syscall    			#syscall
  # end of Project-2-Code-Birmaher-Alan.asm.
