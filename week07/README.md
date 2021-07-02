# Week 7 Tute

## 2D Arrays

flag[6][12]

flag2[72]

flag[i][j]

flag[i * 12 + j]

___

### 4. Translate this C program to MIPS assembler.
``` C
#include <stdio.h>

char flag[6][12] = {
    {'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'},
    {'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'},
    {'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'},
    {'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'},
    {'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'},
    {'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'}
};

int main(void) {
    for (int row = 0; row < 6; row++) {
        for (int col = 0; col < 12; col++)
            printf ("%c", flag[row][col]);
        printf ("\n");
    }

}
```

MIPS:
```
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
```

___
## MIPS Functions
$a0, $a1, $a2, $a3 - argument registers

$v0, $v1 - return registers

$s0 -> $s8 - save registers, saved between argument calls

$sp - stack pointer

Save onto the stack any of the save registers you use in your function, as well as $ra if you call another function!

___
### 5. Translate this C program to MIPS assembler using normal function calling conventions.
### `sum2` is a very simple function but don't rely on this when implementing `sum4`.
``` C
// sum 4 numbers using function calls

#include <stdio.h>

int sum4(int a, int b, int c, int d);
int sum2(int x, int y);

int main(void) {
    int z = sum4(11, 13, 17, 19);
    printf("%d\n", z);
    return 0;
}

int sum4(int a, int b, int c, int d) {
    int e = sum2(a, b);
    int f = sum2(c, d);
    return sum2(e, f);
}

int sum2(int x, int y) {
    return x + y;
}
```

MIPS:
```
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
    
```
