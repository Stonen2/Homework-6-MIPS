        # recursive factorial program.
        # Written by Mikey G
        
        # The value whose factorial is to be computed is entered by the user
    
        .data
        .align  2
        fprmpt: .asciiz "Enter the value to compute n!: "
        fanswr: .asciiz "n! is: "
#--------------- Usual stuff at beginning of main -----------------
        .text
       .globl main
main:                               # main has to be a global label
#-------------------------- function body -------------------------
#------ Get integer input from the user
        li      $v0, 51              
        la      $a0 fprmpt
        syscall

        # a0 already has n
        jal     fibo

        #------ Display results
        move    $a1, $v0 
        la      $a0, fanswr           
        li      $v0, 56
        syscall

#----------------- Usual stuff at end of main ---------------------
        li      $v0, 10,
        syscall
#******************************************************************

fibo: 
	
	
	
	bgt $a0, 2, fibor
	
	beq $a0, 0, basecase
	beq $a0, 1, basecase
	beq $a0, 2, basecase2
	
	move $v0,$a0
	jr $ra
	
	
fibor: 
	addi 	$sp, $sp,-12
	sw      $ra, 0($sp)         # store off the return addr, etc 
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


basecase:
	li $v0, 1
	jr $ra
	
basecase2:
	li $v0, 5
	jr $ra