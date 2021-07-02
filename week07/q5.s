    .text
# be careful when writing functions with prologue, body and epilogue to
# put name of the function above the prologue and to give the body a name that
# is not the name of the function!!
main:
main_prologue:
    addiu   $sp, $sp, -4
    sw		$ra, ($sp)

main_body:
    li		$a0, 11
    li		$a1, 13
    li		$a2, 17
    li		$a3, 19
    jal		sum4
    
    move 	$a0, $v0
    li		$v0, 1
    syscall                 # printf("%d", z);
    
    li      $v0, 11
    li		$a0, '\n'
    syscall                 # printf("\n");

main_epilogue:
    lw      $ra, ($sp)
    addiu   $sp, $sp, 4

    li		$v0, 0
    jr      $ra             # return 0;

# saving things from saved registers and ra onto the stack
sum4:
sum4_prologue:
    addiu   $sp, $sp, -4
    sw		$ra, ($sp)

    addiu   $sp, $sp, -4
    sw		$s0, ($sp)

    addiu   $sp, $sp, -4
    sw		$s1, ($sp)

    addiu   $sp, $sp, -4
    sw		$s2, ($sp)
    
sum4_body:
    move 	$s0, $a2        # save c into $s0
    move 	$s1, $a3        # save d into $s1

    # a and b are already in $a0 and $a1
    jal		sum2            # sum2(a, b)
    
    move    $s2, $v0        # save e into $s2

    move 	$a0, $s0        # load c into $a0
    move 	$a1, $s1        # load d into $a1
    jal		sum2            # sum2(c, d)
    
    move 	$a0, $s2        # load e into $a0
    move 	$a1, $v0        # load f into $a1
    jal     sum2            # sum2(e, f)

    # sum2(e, f) will be stored in $v0

# placing things from the stack back into the registers
sum4_epilogue:
    lw  $s2, ($sp)
    addiu   $sp, $sp, 4

    lw  $s1, ($sp)
    addiu   $sp, $sp, 4

    lw  $s0, ($sp)
    addiu   $sp, $sp, 4

    lw  $ra, ($sp)
    addiu   $sp, $sp, 4

    jr		$ra             # return sum2(e, f)
    
sum2:
    add		$v0, $a0, $a1
    jr		$ra					# return x + y
    