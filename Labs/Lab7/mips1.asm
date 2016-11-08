.text			#text section
li $a0, 1		#$a0=1
li $a1, 0		#$a1=0
li $a2, 5		#$a2=5
fib_iter:		#fib_iter label
bne $a0, $0, else	#set up loop for if n!=0, will jump to else
addi $v0, $a1, 0	#result = b
jr $ra			#return to caller
else:			#else label
subi $sp, $sp, 4	#allocate frame, 4 byte
sw $ra, 0($sp)		#store return addy
addi $t0, $a0, 0	#extract argument passed
add $a0, $a0, $a1	#$a0= a+b
addi $a1, $t0, 0	#$a1= a
addi $a2, $a2, -1	#$a2= n-1
jal fib_iter		#recursive call
lw $ra, 0($sp)		#to restore return addy
addi $sp, $sp, 4	#to free stack frame
#
jr $ra			#return to caller
#
li $v0, 10		#setup for systcall
syscall			#syscall
