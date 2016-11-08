# Alan Birmaher -- 10/01/2014
# strlength.asm-- A program that determine the length of a null terminated string
# Registers used:
#  $s1 - used to hold the loop counter
#  $s0 - used to hold the address of string 
#  $a0 - used to hold values temporarily
#  $v0 - syscall parameter and return value
#
.data   		#data section
str: .asciiz "abcde"	#string to examine
#
.text			#text section
main:			# main
li $s1,0		# initialize the count to zero
la $s0,str		# load in the address
loop:   		# loop label
lb $a0,0($s0)		# load the next character into t1
beqz $a0,exit		# if $ao == 0 jump to exit
addi $s0,$s0,1		# add $s0 = $s0+1
addi $s1,$s1,1		# add $s1 = $s1+1
j loop			# if you get here jump to loop label
exit:    		# exit label
li $v0,1		# prepares value for syscall to print
add $a0, $0, $s1	# places correct value for printing into register
syscall			# syscall
li $v0,10		# places value for ending program to prepare for syscall
syscall			# syscall