# Alan Birmaher
# EEL 3801
# Homework 6b
#
.globl main			# Declare main as a global function
.text				# All code goes after .text
#
# registers:
# $a0: sum for printing
# $s0: n value
# $s1: n+1 for calculation
# $s2: 2 for calculation
# $t0: temporary value holder
#
main:				# main function
# set up values for passing in to function
li $a0, 0			# store sum
li $s0, 666			# number limit to sum to
li $s1, 0			# number for calculations
li $s2, 2			# 2 for calculations
li $t0, 0			# temporary value holder
#
jal N_SUM			# jump to function
#
# print solution
li $v0,1		# service code to output integer to console
syscall 		# syscall executes requested service code
# terminate program
li $v0,10		# service code to exit
syscall			# syscall executes requested service code
#
# Termination of program
#
# N_SUM function
N_SUM:
addi $s1, $s0, 1	# find n+1 and store for Newton Method
mult $s1, $s0		# multiply n*(n+1)
mflo $t0		# store multiplied value to $t0
div $t0, $s2		# divide by 2
mflo $a0		# return value for return
jr $ra			# jump back to main
# conclusion of N_SUM