        # Selection Sort
        # 
        #       Written by Nick Stone

        .data
        .align  2

valueCount:  .word   11
values: .word   10, 42, 99, -88, 46, 54, -156, -37, 5, 666, 54


#---------------------------------------------------#

        .text
        .globl  main

main:   move	$s0, $0 	    # s0: index = 0
	move	$t3,$0		    #temp variable to hold min.
	move 	$t4,$0	  	    #momory location that will hold the location of min
        la      $s7, valueCount     # get arraySize addr
        lw      $s2, 0($s7)         # s2: number of values in the array
        lw	$t3,0($s7)	    #We assign min the first item in the array.
        la      $s7, values         # get array addr
#---------------------------------------------------#
loop:   bge     $s0, $s2, done      # while (index < n)
        lw      $t0, 0($s7)         # t0 = next value in list
        addi    $s0, $s0, 1         # index++
        addi    $s7, $s7, 4         # update address pointer
        blt  	$t0, $t3, newmin    #if the new value is < t3
        j       loop		    #continue looping through the array.
#---------------------------------------------------#

done:   move    $a0, $t3            # display min in the list
        li      $v0, 1
       	syscall
       	move	$a0,$0 		    #Value in the list is displayed sexond
        move    $a0, $t4            # display location in the array of the min value
        li      $v0, 1
        syscall
        li      $v0, 10             # TTFN
        syscall
#---------------------------------------------------#
newmin: move $t3,$t0		#set t3 or our min register to t0
	move $t4,$s0		#set the location of t4 to s0
	j loop 			#continue looping through the list.
