    .text
main:
    la  $a0, prompt
    li  $v0, 4
    syscall             # printf("Enter a number: ")

    li  $v0, 5
    syscall
    # x is stored in t0
    move    $t0, $v0    # scanf("%d",&x);

    ble	$t0, 46340, square  # if (x <= 46340) goto squre;

    la  $a0, error_msg
    li	$v0, 4
    syscall             # printf("square too big for 32 bits\n");
    
    b	end             # goto end;

square:
    # y is stored in t1
    mul $t1, $t0, $t0   # y = x * x

    move    $a0, $t1
    li	$v0, 1
    syscall             # printf("%d", y);

    li	$v0, 11
    li  $a0, '\n'
    syscall             # printf("\n");

end:
    li  $v0, 0
    jr  $ra             # return 0;

    .data
prompt:
    .asciiz "Enter a number: "
error_msg:
    .asciiz "square too big for 32 bits\n"