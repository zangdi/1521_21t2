    .text
main:
    # store i in t0
    li  $t0, 1          # int i = 1;

loop0:
    bgt $t0, 10, end0   # if (i > 10) goto end0;

    # store i in t0
    # store j in t1
    li  $t1, 0          # int j = 0; 

loop1:
    bge $t1, $t0, end1  # if (j >= i) goto end1;

    li  $a0, '*'
    li  $v0, 11
    syscall             # printf("*");

    addi    $t1, $t1, 1 # j = j + 1

    j   loop1           # goto loop1

end1:
    li  $a0, '\n'
    li  $v0, 11
    syscall             # printf("\n");

    addi    $t0, $t0, 1 # i = i + 1;

    b	loop0           # goto loop1;
    

end0:
    li  $v0, 0
    jr  $ra             # return 0;