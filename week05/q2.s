    .text
main:
    # store i int $t0
    li		$t0, 0          # int i = 0;
    

loop:                       # do {
    addi	$t0, $t0, 1     # i++;
    
    li  $v0, 1
    move    $a0, $t0
    syscall                 # printf("%d", i);

    li		$v0, 11
    li		$a0, '\n'
    syscall                 # printf("\n");
    
    blt     $t0, 10, loop   # } while (i < 10);

end:
    li		$v0, 0
    jr		$ra             # return 0;
    