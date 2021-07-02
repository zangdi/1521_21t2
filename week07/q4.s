    .text
main:
    # store row in $t0
    li		$t0, 0

loop1:
    bge		$t0, 6, end1
    
    # store col in $t1
    li		$t1, 0

loop2:
    bge		$t1, 12, end2
    
    li		$t2, 12
    mul     $t3, $t0, $t2       # row * 12
    add		$t3, $t3, $t1       # row * 12 + col (index of flag[row][col])
    
    lb		$a0, flag($t3)
    li		$v0, 11
    syscall                     # printf("%c", flag[row][col]);

    addi	$t1, $t1, 1

    b		loop2
    
end2:
    li		$a0, '\n'
    li		$v0, 11
    syscall

    addi	$t0, $t0, 1
    
    b   loop1

end1:
    li		$v0, 0
    jr		$ra
    

    .data
flag:
    .byte   '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
    .byte   '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
    .byte   '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
    .byte   '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
    .byte   '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
    .byte   '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'