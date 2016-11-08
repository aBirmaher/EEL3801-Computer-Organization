# Alan Birmaher
# EEL 3801
# Assignment 3
#
# Registers
# $t1  - counter 
# $t5  - used for truncation
# $f0  - used to divide for average
# $f1  - hold setA/setB values
# $f2  - hold setA/setB values
# $f3  - hold product and add to f12
# $f5  - used for trunction, temp num storage
# $f12 - kept running sum total
#
.globl main			# Declare main as a global function
#
# Data section
.data
setA: .float  0.11, 0.34, 1.23, 5.34, 0.76, 0.65, 0.34, 0.12, 0.87, .56
setB: .float  7.89, 6.87, 9.89, 7.12, 6.23, 8.76, 8.21, 7.32, 7.32, 8.22
meanA: .asciiz "The Mean of A = "
meanB: .asciiz "\nThe Mean of B = "
dotP: .asciiz "\nThe Dot Product of A and B = "
#
# Text section
.text
main:			# main
la $a0, setA		# load floating point set A into a0
mtc1 $zero, $f1		# intialize f1 register to zero
jal mean		# jump to mean loop for MeanA, return when done
#
# Print label for mean A
li $v0, 4		# set for string printing
la $a0, meanA		# load mean A to a0 to print
syscall			# syscall
#
# Truncate
li $t5, 100		# t5= 100(word)
mtc1 $t5, $f5		# f5= t5(word)
cvt.s.w $f5, $f5	# f5= wordToSingle(f5)
mul.s $f12, $f12, $f5	# f12= f12*f5
trunc.w.s $f12, $f12	# f12= truncate(f12)
cvt.s.w $f12, $f12	# word to single conversion
div.s $f12, $f12, $f5	# f12= f12/f5
#
# Print mean A
li $v0, 2		# print floating point value
syscall
#
# Find and print mean for B
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
li $t5, 100		# t5= 100(word)
mtc1 $t5, $f5		# f5= t5(word)
cvt.s.w $f5, $f5	# f5= wordToSingle(f5)
mul.s $f12, $f12, $f5	# f12= f12*f5
trunc.w.s $f12, $f12	# f12= truncate(f12)
cvt.s.w $f12, $f12	# word to single conversion
div.s $f12, $f12, $f5	# f12= f12/f5
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
dot:			# dot label for start of loop
l.s $f1, 0($a0)		# load current setA value to f1
l.s $f2, 0($a1)		# load current setB value to f2
mul.s $f3, $f1, $f2	# multiplies f2 and f1 into f3
add.s $f12, $f12, $f3	# adds f3 into f12
addi $t1, $t1, 1	# t1++
addi $a0, $a0, 4	# increment a0 for next value
addi $a1, $a1, 4	# increment a1 for next value
beq $t1, 10 exitDot	# if t1 == 10 branch to exitdot
j dot			# if condition not met jump back up
#
exitDot:		# exit label
#
# Print string for dot product
li $v0, 4		# syscall to print string
la $a0, dotP		# moves 'dotprod' string to a0 to be printed
syscall			# syscall
#
# Truncate
li $t5, 100		# t5= 100(word)
mtc1 $t5, $f5		# f5= t5(word)
cvt.s.w $f5, $f5	# f5= wordToSingle(f5)
mul.s $f12, $f12, $f5	# f12= f12*f5
trunc.w.s $f12, $f12	# f12= truncate(f12)
cvt.s.w $f12, $f12	# word to single conversion
div.s $f12, $f12, $f5	# f12= f12/f5
#
# Print dor product
li $v0, 2		# syscall to print floating point value
syscall			# syscall
#
# Terminate program
li $v0, 10		# syscall to end program
syscall			# syscall
#
# END