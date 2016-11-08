# Alan Birmaher -- 10/1/14
# To_lowercase.asm-- A program that convert uppercase to lowercase
# Registers used:
# $t0 - address location
# t2 - parameter for test
# v0 - value storage for syscall
# a0 - value to perform syscall on storage
.data 					# data
string:  .asciiz "HeLlo WoRld"   	# We want to lower this string 
newline: .asciiz "\n"			# new line
.text 					# text
main:					# main 	
    la $t0, string       		# Load here the string 
toLowerCase: 				# toLowerCase label
    lb $t2, 0($t0)  			# We do as always, get the first byte pointed by the address 
    beqz $t2, end   			# if is equal to zero, the string is terminated 
    #if (character >= 'A'
    beq $t2, 0, upperCaseTest2
    j continue  
upperCaseTest2: 			# upperCaseTest2 label
       # && character <= 'Z') 
    beq $t2, 0, isUpperCase
continue: 				# continue label
    # Continue the iteration
    addi $t0, $t0, 1        		# Increment the address
    j toLowerCase 			# jump to toLowerCase label
isUpperCase: 				# isUpperCase label
    # add 32, so it goes lower case 
    addi $t0, $t0, 32
    sb $t2, 0($t0)     			# store it in the string
    j continue              		# continue iteration as always 
end:					# end label
    li $v0, 4                		# print the string 
    la $a0, string  			# stores value for printing
    syscall     			# syscall
#
    li $v0, 4               		# A nice newline  
    la $a0, newline			# stores in new line to print
    syscall  				# syscall
#
    # We have done, exit the program  
    li $v0, 10 				#stores value for execution of end program syscall
    syscall				# syscall
