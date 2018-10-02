      # Ackermann Function Recursive
        # Written by Nick Stone
            
        .data
        .align  2
        
	prompt1: .asciiz "Enter the value of M" 
	prompt2: .asciiz "Enter the value of N"

#--------------------------------------------------------------------------------------------

        .text
        .globl  main

main:
	#prompt the user to enter the M value
	li      $v0, 51              
        la      $a0 prompt1
        syscall
        #store value in register s0 
	move $s0, $a0
	
	


	#prompt the user to get the value of N 
	li      $v0, 51              
        la      $a0 prompt2
        syscall
        
        #load N in a1 
        #load M in a0 
        #Run the ackermann function 
	move $a1,$a0
	
	move $a0,$s0 
	jal ackemain		# Calls Ackermann
	
	
	#stores the value returned into a0 and prints the result 	
	
	
	move $a0,$v0
	li $v0, 1		
	syscall

	li $v0, 10		
	syscall
	

#We allocate memory from the stack and we need $ra 
#as well as to keep track of the value of N 
#as well as keep track of the value of M
#We have loaded M and N into s4 and s5
#we prompted the user for these values 
#and stored them into their respective 
#a registers or parameter passing registers
#we also want to start by jumping to decm or to check if our M 
#value is 0. if m is greater than 0 we want to then jump to decn
#if it is 0 we want to add 1 to our parameter $a1 and add that 
# to $v0  to then jump to done and reallocate memory to the stack 
#this is done as part of the ackerman algorithm 
#or namely if m = 0 then n+1 no recurse call
ackemain:
	#ALLOCATE STACK#
        addi    $sp, $sp, -12       
        sw      $ra, 0($sp)    	        
        sw      $s4, 4($sp)	    
        sw	$s5, 8($sp)	    	     
	#ALLOCATE STACK#

        #load parameters 
	move $s4,$a0 
        move $s5,$a1
     	#start the function by checking the value of M 
     	j decm
     
   
decm:
        bgt 	$s4, $0, decn	
        addi 	$a1, $a1, 1		
        move 	$v0, $a1
        j 	done 			
 	
 
 
# we want to check to make sure our value of n is greater than 0
#	then we load the parameter of a0 to s4 and we want to subtract
#  one from m and add one to n as called for by the funciton 
# then we want to recall the main ackerman function 

# or if n is greater than 0 go to ackrecur
#	then jump to done
#   M - 1 N +1 
decn:    	
        bgt 	$s5, $0, ackrecur
       	move $s4, $a0
        
        addi 	$a0, $a0, -1 		
        
        addi 	$a1, $a1, 1
       
        jal   	ackemain   		  	
        
        j	done
        		
        		
 #we want to set m from a0 
 #then we want to decrement the value of n and call the main acke function 
 #this is finding the value of ackermann (M,(N-1) 
 #but we also need to find the value of Ackerman(m-1,Ackerman(m,(n-1))   
 #this is from the ackerman algorithm 
    		
ackrecur:	
        move	$a0, $s4		
        addi 	$a1, $a1, -1	
        jal 	ackemain
        


	move 	$s5, $v0
	move 	$s0, $a0
        addi 	$a0, $s4, -1		
        jal 	ackemain		
       
      

			
			
#The entire ackerman function is done and we are ready to reallocate to the stack
#Reallocate all memory back and jr $ra back. 
done:	
      	#Reallocate memory to the stack#
        lw 	$ra, 0($sp)
        lw 	$s4, 4($sp)
        lw	$s5, 8($sp)	 
        addi 	$sp, $sp, 12
        #Reallocate memory to the stack #		 
        jr $ra
