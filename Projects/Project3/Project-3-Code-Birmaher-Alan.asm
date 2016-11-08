# Alan Birmaher
# EEL 3801
# Homework 5A
#
# Registers used: 
# 	$a0= value to base calculation on
# 	$v0= storage of sum value to be printed
#	$ra= location to jump back to
#	
.text			# text	
#
main:			# main function
#
addi $a0, $0, 9		# store value for calculation into $a0
#
jal SUM			# jump to SUM function for calculations
#
move $a0, $v0		# move result from $v0 to $a0 for printing
li $v0, 1		# load value of 1 into $v0 for syscall, print integer
syscall			# syscall
#
li $v0, 10		# load function 10 into $v0 for syscall, end program
syscall			# syscall
#

SUM:
li $v0, 0
jump1:
beq $a0, $0, end
add $v0, $v0, $a0
subi $a0, $a0, 1
j jump1
end:
jr $ra