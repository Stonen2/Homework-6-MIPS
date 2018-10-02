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
   
   
   
   
# we set all of our variables such as i and j in order to keep track of where 
#we are in the double loop that we have as well as holding a min 
#value and the memory location in the min of the array 
#we then load up all of the arrays such asholding out min
#and then finding our N value or the max size of the array 
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

	

	j loop

 
#we loop through every value in the array and we then print out the 
#value in the array. To keep the formatting clean we then 
#print a line break and then we loop until we have 
#gone through and printed out every value in the array
	
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
        
      
#this is the done condition and we finish the program
#Only finished from printing the list   
done: #jr $ra
	#move $a0, $s4
	#li $v0 1
	#syscall 
	
	li $v0, 10
	syscall 

#
#this is our main loop where we iterate through and find our min
#we iterate through every value and then find min and update the min value 
                  
loop: 
	bge     $s1, $s2, inci      # while (j < n)
        lw      $t0, 0($s7)         # t0 = next value in list
        addi    $s1, $s1, 1         # j++
        				
        addi    $s7, $s7, 4         # update address pointer

        blt   	$t0, $s3, newmin    #if the new value is < s3
        j       loop	    #continue looping through the array.
 
 
 #this is our main loop where we keep track of our i value
 #every time this loop runs we call swap since we have found
 #our new min. after that we then reload the value 
 #of j to be the new i after we increment i 
 #we then reloadt the array. we load the parameters to 
 #pass into the swap function. Then we continue 
 #to call find min and loop until our i is 
 #equal to the value of the array if that is 
 #the case then we reset i to 0 to then 
 #print the list 
                      
inci: 
	
	
	addi $s0,$s0,1
	
	
	#load parameters to pass to swap 
	#give them n and positon of new and 
	#old min values
	move $a0, $s2
	move $a1, $s4
	move $a2,$s0

	jal swap 
	#we reset all of the values to then 
	#pass back to the find min loop. 
	move $s1, $0
	add $s1,$s0,$0
	la $s7, values
	mul $t5,$s0,4
	add $s7, $s7, $t5
	lw $s3, 0($s7) 
	add $s4,$s0,$0
	move $t0,$0
	
	
	#if i is not equal to n then we reloop 
	bne $s0, $s2, loop 
	la $s7,values
	move $s0, $0 
	j printlist 


#we pass in the parameters a0 is the size of the array
#we then have the location that the new min is at and at
#parameter a1 we also have the old position at a2
#we then multiply the posiiton by 4 in order
#to find the value and locations in the array 
#from then we can swap the values from the position which
#we have and then swap the values in the aray and jump back 
                                          
swap: 
	#Load all of our values from parameters
	move $t1, $a0
	move $t2, $a1 #new 
	move $t8, $a2 #old
	
	#find memory locations of new min 
	
	la $t6,values 
	mul $t8, $a2,0
	mul $t5, $a1, 4
	add $t4,$0,$t5
	
	#offset the values in the array to get their values at those positions
	add $t6,$t6,$t3
	lw $t7, 0($t6) 
	
	la $t6, values
	add $t6,$t6,$t5
	 
	lw $t9, 0($t6)

	
	#move $t0,$t2	li $t0,4
	li $t0, 0
	
	#replace the values and there positions in the array 
	sw $t7,values($t5) #needs to hit the first position in the array 
	sw $t9,values($t8)

	
	jr $ra
	
	



#we know that we can swap the new value and new position to s4 where we
#store the min value as as s3 to hold the value of min
#after that we jump back up to the loop and continue looping
 
newmin: add $t2,$s3,$0 
	move $s3,$t0 
	add $s4, $s1,$0
	
	 
	
	j loop 
	
	
		



	



           
           
           
           
           
           
           
           
