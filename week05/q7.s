    .text
main:
    # store i in $t0
    li		$t0, 0
    
loop1:
    bge		$t0, 10, end1
    
    li  $v0, 5
    syscall

# method 1 of storing something at &numbers[i]
    # store &numbers[0] into $t1
    la		$t1, numbers
    li		$t2, 4
    # calculates sizeof(int) * i
    mul     $t3, $t0, $t2
    # now $t4 contains &numbers[i]
    add		$t4, $t3, $t1
    
    sw		$v0, ($t4)                  # scanf("%d", &numbers[i]);
    
    addi	$t0, $t0, 1                 # i++;
    
    b   loop1

end1:

    li		$t0, 9

loop2:
    bltz    $t0, end2

# method 2 of loading word from &numbers[i]
    li		$t2, 4
    # calculates sizeof(int) * i
    mul     $t3, $t0, $t2
    
    lw		$a0, numbers($t3)

    li		$v0, 1
    syscall                             # printf("%d", numbers[i]);

    li		$v0, 11
    li		$a0, '\n'
    syscall                             # printf("\n");
    
    addi	$t0, $t0, -1                # i--;
    
    b   loop2

end2:
    li		$v0, 0
    jr		$ra

    .data
numbers:
    .word   0 0 0 0 0 0 0 0 0 0