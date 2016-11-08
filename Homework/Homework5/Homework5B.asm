# Alan Birmaher
# EEL 3801
# Homework 5B
#
# Registers used: 
# 	$a0= value to base calculation on
# 	$v0= storage of sum value to be printed
#	$ra= location to jump back to
#	
.data			# .data
space: .asciiz "\n"	# blank line to print
.text			# .text	
#
main:			# main function
addi $a0, $0, -9	# store value for calculation into $a0
jal ABS			# jump to ABS function for calculation 1
move $a0, $v0		# move result from $v0 to $a0 for printing
li $v0, 1		# load value of 1 into $v0 for syscall, print integer
syscall			# syscall
la $a0, space		# place next line in memory location for printing
li $v0, 4		# set up to print next line
syscall			# syscall
addi $a0, $0, 15	# store value for calculation into $a0
jal ABS			# jump to ABS function for calculation 2
move $a0, $v0		# move result from $v0 to $a0 for printing
li $v0, 1		# load value of 1 into $v0 for syscall, print integer
syscall			# syscall
li $v0, 10		# load function 10 into $v0 for syscall, end program
syscall			# syscall
#
ABS:			# ABS function
bgez $a0, end		# if number is positive jump ahead	
sub $a0, $0, $a0	# subtract the number from zero to flip it
end:			# end label
move $v0, $a0		# moves value in a0 to $v0
jr $ra			# jumps back to main
# END