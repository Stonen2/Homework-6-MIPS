           #selection sort
        #       Written by Nick Stone
            
        .data
        .align  2
valuecount:  .word   12
values: .word   10, 1, 42, 99, 88, 46, 54, 156, -22, 0, 666, 1
fpromt: .asciiz "\n"


#---------------------------------------------------#

        .text
        .globl  main
   
   
main: 

	move $s0, $0 #i = 0 
	move $s1, $0 #j = 0
	move	$s3,$0		    #temp variable to hold min.
	move 	$s4,$0	  	    #momory location that will hold the location of min
	
        la      $s7, valuecount     # get arraySize addr
        lw      $s2, 0($s7)         # s2: number of values in the array N 
        la      $s7, values         # get array addr
        lw	$s5,0($s7) #min temp 
	
	#print#
	jal printlist
	
	
	
	move $s0,$0 
	la $s7,values 

	
	#call to start the function
	#
	move $a0,$s0, 
	move $a1, $s2
	li $a2, $s7 

	jal selectionsort

 	
            
	
	
	#Print#
	la $s7,values
	move $s0,$0
	jal printlist
	
	
	li $v0, 10
	syscall 

	
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
        
        
done: jr $ra
	
         
           
 swap: 
 
      
           
 selectionsort: 
		
	bge     $s0, $s2, done2      # while (index < n)
        addi    $s0, $s0, 1         # index++
        
         
          #load parameters
          jal findmin 
          
           
            #Load parameters
         jal swap  
	
	j selectionsort

  done2: 
 	jal printlist
 	 
 	 
 	 
	li $v0, 10
	syscall 
           
 findmin: 
 
 
 newmin:
  
           
           
           
           
           
           
           
           