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
	li $v0, 1		# Prints result
	syscall

	li $v0, 10		#:D
	syscall
	

ackemain:

        addi    $sp, $sp, -12       
        sw      $ra, 0($sp)    	        
        sw      $s0, 4($sp)	    
        sw	$s1, 8($sp)	    	     


         
	move $s0,$a0 
        move $s1,$a1
        
decm:
        bgt 	$s0, $0, decn	
        addi 	$a1, $a1, 1		
        move 	$v0, $a1
        j 	done 			
 	
 
decn:    	
        bgt 	$s1, $0, ackrecur
       	move $s0, $a0
        
        addi 	$a0, $a0, -1 		
        
        addi 	$a1, $a1, 1
       
        jal   	ackemain   		# Ackermann(m-1, 1)  	
        
        j	done
        		
ackrecur:	
        move	$a0, $s0		# s0: m (for other call)
        addi 	$a1, $a1, -1	
        jal 	ackemain
        
        				# Ackermann(m, (n -1))
	move 	$s1, $v0
	move 	$s0, $a0
        addi 	$a0, $s0, -1		# a0 = n - 1
        jal 	ackemain		# Ackermann(m-1,A(m, (n - 1)))
       
      

			
done:	
        lw 	$ra, 0($sp)
        lw 	$s0, 4($sp)
        lw	$s1, 8($sp)	 
        addi 	$sp, $sp, 12
        		 
        jr $ra
