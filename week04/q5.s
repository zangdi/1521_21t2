    .text
main:
    # store x in t0
    li	$t0, 24         # int x = 24;

loop:
    bge $t0, 42, end    # if (x >= 42) goto end;

    move    $a0, $t0
    li  $v0, 1
    syscall             # printf("%d", x);

    li	$a0, '\n'
    li  $v0, 11
    syscall             # printf("\n");

    addi	$t0, $t0, 3 # x = x + 3
    
    b   loop            # goto loop;

end:
    li  $v0, 0
    jr  $ra