max:
    # prologue
    addi    $sp, $sp, -4
    sw  $ra, ($sp)
    addi	$sp, $sp, -4
    sw  $s0, ($sp)

    # alternate way of prologue
    # addi	$sp, $sp, -8
    # sw		$ra, 4($sp)
    # sw		$s0, 0($sp)

    # body
    lw		$s0, ($a0)          # int first_element = a[0];
                                # stored first_element in $s0
    

    bne $a1, 1, else1           # if (length != 1) goto else1;

    move 	$v0, $s0            # store first_element in $v0 for return
    j   end                     # goto end;

else1:
    addi	$a0, $a0, 4         # $a0 contains &a[1] (&a[0] + sizeof(int))
    addi	$a1, $a1, -1        # $a1 contains (length - 1)
    jal max                     # max(&a[1], length - 1);

    
    ble		$s0, $v0, end       # if (first_element <= max_so_far) goto end;
    
    move 	$v0, $s0            # max_so)far = first_element;

end:
    # epilogue
    lw		$s0, ($sp)
    addi	$sp, $sp, 4
    lw		$ra, ($ra)
    addi	$sp, $sp, 4

    # alternate way of epilogue
    # lw		$ra, 4($sp)
    # lw		$s0, 0($sp)
    # addi	$sp, $sp, 8
    
    jr		$ra
    


a:
    .word   1 2 3 4 5 6 7 8 9 10