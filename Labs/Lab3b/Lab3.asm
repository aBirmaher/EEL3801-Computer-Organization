# Alan Birmaher
# EEL 3801
# Assignment 3
#
# Registers
# $a0  - holds memory location
# $t1  - counter 
# $f0  - used to divide for average
# $f1  - hold setA/setB values
# $f2  - hold setA/setB values
# $f3  - hold product and add to f12
# $f12 - kept running sum total
# $v0  - parameter for syscall
#
.globl main		# Declare main as a global function
#
# Data section
.data
setA: .space 100
setB: .space 100
promptA: .asciiz "Please enter 10 numbers for set A (pressing enter after each):\n"
meanA: .asciiz "The Mean of A = "
promptB: .asciiz "Please enter 10 numbers for set B (pressing enter after each):\n"
meanB: .asciiz "\nThe Mean of B = "
dotP: .asciiz "\nThe Dot Product of A and B = "
zeroFloat: .float 100.00
#
# Text section
.text
main:			# main
#
# Prompt user for input for A
li $v0,4		# set value for printing string
la $a0, promptA 	# store address of string to print
syscall			# syscall
#
# Load values for setA
li $v0, 6		# loads value for syscall to read floats
li $t1, 0		# sets counter to 0
la $a0, setA		# loads location of set into a0
readLoopA:		# readLookA label
beq $t1, 10, endReadA	# if counter reaches 10, end
syscall			# syscall
s.s $f0, 0($a0)		# store value read in to array A
addi $t1, $t1, 1	# incrmement counter
addi $a0, $a0, 4	# increment location to store to
j readLoopA		# jump back to readLoopA
endReadA:		# end label to go on
#
# Prompt user for input for B
li $v0,4		# set value for printing string
la $a0, promptB 	# store address of string to print
syscall			# syscall
#
# Load values for setB
li $v0, 6		# loads value for syscall to read float
li $t1, 0		# sets counter to 0
la $a0, setB		# loads location of set into a0
readLoopB:		# readLookB label
beq $t1, 10, endReadB	# if counter reaches 10, end
syscall			# syscall
s.s $f0, 0($a0)		# store value read in to array B
addi $t1, $t1, 1	# incrmement counter
addi $a0, $a0, 4	# increment location to store to
j readLoopB		# jump back to readLoopA
endReadB:		# end label to go on
#
# Calculate mean of setA
la $a0, setA		# load floating point set A into a0
mtc1 $zero, $f1		# intialize f1 register to zero
li $t1, 0		# counter to 0
jal mean		# jump to mean loop for MeanA, return when done
#
# Print label for mean A
li $v0, 4		# set for string printing
la $a0, meanA		# load mean A to a0 to print
syscall			# syscall
#
# Truncate
l.s $f4, zeroFloat	# stores zero float to register
mul.s $f12, $f12, $f4	# multiplies value by zero float
cvt.w.s $f5, $f12	# convert from single precision to word
cvt.s.w $f12, $f5	# convert back
div.s $f12, $f12, $f4	# divide by 100
#
# Print mean A
li $v0, 2		# print floating point value
syscall
#
# Calculate and print mean for B
la $a0, setB		# load floating point set B into a0
mtc1 $zero, $f12	# initialize f12 to zero
mtc1 $zero, $f1		# initialize f1 to zero 
li $t1, 0		# counter to 0
jal mean		# jump to mean loop for MeanB, return when done
#
# when were done with means
j exit			# jump to exit after means done
#
# Mean calculation
mean:			# mean label
l.s $f1, 0($a0)		# load a0 to f1
add.s $f12, $f12, $f1	# f12+=f1
addi $t1, $t1, 1	# counter incremented
beq $t1, 10 divide	# if t1 == 10 branch to division
addi $a0, $a0, 4	# increments a0 register by 4 to arrive at the next float
j mean			# jump to loop top
#
# Divide calculation
divide:			# divide label
mtc1 $t1, $f0		# move t0 to f0
cvt.s.w $f0, $f0	# converts f0 to single precision
div.s $f12, $f12, $f0	# divide average f12 by f0
jr $ra			# jump return to address
#
# Exit label to continue to
exit:			# exit path
#
# Print mean b print label
li $v0, 4		# set for string printing
la $a0, meanB		# load mean B to a0 to print
syscall			# syscall
#
# Truncate
l.s $f4, zeroFloat	# stores zero float to register
mul.s $f12, $f12, $f4	# multiplies value by zero float
cvt.w.s $f5, $f12	# convert from single precision to word
cvt.s.w $f12, $f5	# convert back
div.s $f12, $f12, $f4	# divide by 100
#
# Print number for mean B
li $v0, 2		# print mean of B
syscall
#
# Dot product calculation starts here
dotProductStart:       	# dot product procedure starts here
la $a0, setA		# load setA to a0
la $a1, setB		# load setB to a1
mtc1 $zero, $f12	# initialize f12 to zero
mtc1 $zero, $f1		# initialize f1 to zero
mtc1 $zero, $f2		# initialize f2 to zero
li $t1, 0		# initialize $t1 to zero 
#
# dot loop
dot:			# dot label for start of loop
l.s $f1, 0($a0)		# load current setA value to f1
l.s $f2, 0($a1)		# load current setB value to f2
mul.s $f3, $f1, $f2	# multiplies f2 and f1 into f3
add.s $f12, $f12, $f3	# adds f3 into f12
addi $t1, $t1, 1	# t1++
addi $a0, $a0, 4	# increment a0 for next value
addi $a1, $a1, 4	# increment a1 for next value
beq $t1, 10, exitDot	# if t1 == 10 branch to exitdot
j dot			# if condition not met jump back up
#
exitDot:		# exit label
#
# Print string for dot product
li $v0, 4		# syscall to print string
la $a0, dotP		# moves 'dotprod' string to a0 to be printed
syscall			# syscall
# Truncate
l.s $f4, zeroFloat	# stores zero float to register
mul.s $f12, $f12, $f4	# multiplies value by zero float
cvt.w.s $f5, $f12	# convert from single precision to word
cvt.s.w $f12, $f5	# convert back
div.s $f12, $f12, $f4	# divide by 100
#
# Print dot product
li $v0, 2		# syscall to print floating point value
syscall			# syscall
#
# Terminate program
li $v0, 10		# syscall to end program
syscall			# syscall
#
# END