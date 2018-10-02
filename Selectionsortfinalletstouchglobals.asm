           #selection sort
        #       Written by Nick Stone
            
        .data
        .align  2
valuecount:  .word   3
values: .word   10,-1,-5,-3
fpromt: .asciiz "\n"


#---------------------------------------------------#

        .text
        .globl  main
   
   
main: 

	move $s0, $0 #i = 0 
	move $s1, $0 #j = 0
	move	$s3,$0		    #temp variable to hold min.
	move 	$s4,$0	  	    #momory location that will hold the location of min
	move $s6, $0
	
	
        la      $s7, valuecount     # get arraySize addr
        lw      $s2, 0($s7)         # s2: number of values in the array N 
        la      $s7, values         # get array addr
        lw	$s5,0($s7) #min temp 
	lw      $s3,0($s7)
	#print#
	#j printlist
	
	
	
#	move $s0,$0 
#	la $s7,values 
	
 
 
	
	#call to start the function
	#
	#move $a0,$s0, 
	#move $a1, $s2
	#move $a2, $s7 
	
	

	j loop

 	
            
	
	
	#Print#
	#la $s7,values
	#move $s0,$0
	#jal printlist
	
	#move $a0, $t0 
	#li $v0,1 
	#syscall 


	
printlist: 	
	bge     $s0, $s2, done      # while (index < n)
        lw      $t0, 0($s7)         # t0 = next value in list
        addi    $s0, $s0, 1         # index++
        addi    $s7, $s7, 4         # update address pointer to the next word 
	
	move $a0, $t0
	li $v0, 1
	syscall 
	
	la $a0,fpromt
	li $v0,4
	syscall 


        j   printlist		    #loop to the next value
        
        
done: #jr $ra
	#move $a0, $s4
	#li $v0 1
	#syscall 
	
	li $v0, 10
	syscall 
         
loop: 
	bge     $s1, $s2, inci      # while (index < n)
        lw      $t0, 0($s7)         # t0 = next value in list
        addi    $s1, $s1, 1         # index++
        				
        addi    $s7, $s7, 4         # update address pointer
       # add	$a0,$s4,$0
       # li	$v0,1
       # syscall
        
        blt   	$t0, $s3, newmin    #if the new value is < t3
        j       loop	    #continue looping through the array.
 
                      
inci: 
	
	
	addi $s0,$s0,1
	
	
	
	move $a0, $s2
	move $a1, $s4
	move $a2,$s0

	jal swap 
	move $s1, $0
	add $s1,$s0,$0
	la $s7, values
	mul $t5,$s0,4
	add $s7, $s7, $t5
	lw $s3, 0($s7) 
	add $s4,$s0,$0
	move $t0,$0
	
	
	
	bne $s0, $s2, loop 
	la $s7,values
	move $s0, $0 
	j printlist 

                                          
swap: 
	move $t1, $a0
	move $t2, $a1 #new 
	move $t8, $a2 #old
	
#	move $a0,$0
#	move $a0,$a1
#	li $v0, 1
#	syscall
	
	
	la $t6,values 
	mul $t8, $a2,0
	mul $t5, $a1, 4
	add $t4,$0,$t5
	
	add $t6,$t6,$t3
	lw $t7, 0($t6) 
	
	la $t6, values
	add $t6,$t6,$t5
	 
	lw $t9, 0($t6)

	
	#move $t0,$t2	li $t0,4
	li $t0, 0
	
	sw $t7,values($t5) #needs to hit the first position in the array 
	sw $t9,values($t8)
#	sw   $t9,values($t3)
#	sw   $t7,values($t2)	
	
	#sw   $t8,0($t6)
	
	jr $ra
	
	


 
newmin: add $t2,$s3,$0 
	move $s3,$t0 
	add $s4, $s1,$0
	
	 
	
	j loop 
	
	
		



	



           
           
           
           
           
           
           
           
