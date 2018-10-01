        # recursive variation on fibonacci sequence. 
        # Written by Nick Stone 9/26/18
        
        # The value we are finding in the fibonacci sequence is given by the user. 
    
        .data
        .align  2
        fprmpt: .asciiz "Enter the value to compute the fibonacci sequence: "
        fanswr: .asciiz "The fibonacci value of the the number entered  is: "
        
        
#--------------- Usual stuff at beginning of main -----------------
       .text
       .globl main
main:                               
#-------------------------- function body -------------------------
#-User input
        li      $v0, 51              
        la      $a0 fprmpt
        syscall

        # a0 already has the number we are fibo 
        #jump and link to the recursive function
        jal     fibo

        #------ Display results
        #since recusive only need to call the function once. 
        
        
        move    $a1, $v0 
        la      $a0, fanswr           
        li      $v0, 56
        syscall

#----------------- Usual stuff at end of main ---------------------
        li      $v0, 10,
        syscall
#******************************************************************

fibo: 
	#if the number the user enter is greater than 2 then we need to recurse further
	#if it is less than 2 then we can enter our base cases.
	#the base cases are when f = 0 1 or 2 
	# both 0 and 1 have a base value of 1 
	#2 has a base value or 5 thus we then find the base value
	#then we jump register back 
	
	bgt $a0, 2, fibor
	
	beq $a0, 0, basecase
	beq $a0, 1, basecase
	beq $a0, 2, basecase2
	
	move $v0,$a0
	jr $ra
	

#if the value of n is greater than 2 we have to have a recursive call on ourself
# we know the function is F(n-1) + 4 * F(n-2) 
#we allocate memory in the stack to store our Ra and the value of s0
#s0 holds the value of N in the stack 
#then we decrement our N value and we have TWO jal aclls in this function 
#One jump and link is for F(n-1) 
#the other jump and link is for F(n-2) 
#after we get the value of F9N-1) we store that value in the stack 
#then we computer F9N-2) 
#WE put the value of F(n-2) into the register $t1
#load the value of F(N-1) into T0 and we know the algorithm
#is f(n-1) or T0 + 4 * t1 or F(n-2) 
# we hold that value in V0 reallocate all memory to the stack 
#THen we jump register out of the function 
fibor: 
	addi 	$sp, $sp,-12
	sw      $ra, 0($sp)        
        sw      $s0, 4($sp)
	move $s0, $a0
	addi $a0,$a0, -1
	jal fibo
	move $t0, $v0
	sw $t0,8($sp)
	
	
	
	move $a0, $s0
	addi $a0, $a0,-2
	jal fibo
	move $t1, $v0
	lw $t0,8($sp)
	mul $t1,$t1, 4
	add $v0, $t1, $t0
		
	lw	$ra,0($sp)
	lw 	$s0,4($sp)
	addi 	$sp,$sp,12
	
	jr	$ra

#we have three base cases with this variation of the fibonacci sequence.
#we know f sub 0 is going to be 1 
#we know f sub 1 is also 1 
#f sub 2 is going to be 5 
#we can consolidate the first 2 base cases to be 1 
#the seccond base case is if the value is going to be 2 
#we then load $v0 with the base case value and jump back 
#when we jump back we then use the sequence F k-1 + 4 * f k-2
basecase:
	li $v0, 1
	jr $ra
	
basecase2:
	li $v0, 5
	jr $ra
