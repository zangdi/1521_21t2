# Week 4 Tute

### 1. The MIPS processor has 32 general purpose 32-bit registers, referenced as $0 .. $31. Some of these registers are intended to be used in particular ways by programmers and by the system. For each of the registers below, give their symbolic name and describe their intended use:

Look at the [SPIM Guide](https://cgi.cse.unsw.edu.au/~cs1521/21T2/resources/spim-guide.html). You can use it during weekly tests as well.
___
### 2. Translate this C program to MIPS assembler
```C
// print the square of a number
#include <stdio.h>

int main(void) {
    int x, y;
    printf("Enter a number: ");
    scanf("%d", &x);
    y = x * x;
    printf("%d\n", y);
    return 0;
}
```
### Store variable x in register $t0 and store variable y in register $t1.

``` assembly
    .text
main:
    la  $a0, prompt
    li  $v0, 4
    syscall             # printf("Enter a number: ")

    li  $v0, 5
    syscall
    move    $t0, $v0    # scanf("%d",&x);

    # x is stored in t0
    # y is stored in t1

    mul $t1, $t0, $t0   # y = x * x

    move    $a0, $t1
    li	$v0, 1
    syscall             # printf("%d", y);

    li	$v0, 11
    li  $a0, '\n'
    syscall             # printf("\n");

    li  $v0, 0
    jr  $ra             # return 0;

    .data
prompt:
    .asciiz "Enter a number: "
```

___
### 3. Translate this C program so it uses goto rather than if/else.
### Then translate it to MIPS assembler.
``` C
#include <stdio.h>

int main(void) {
    int x, y;
    printf("Enter a number: ");
    scanf("%d", &x);

    if (x > 46340) {
        printf("square too big for 32 bits\n");
    } else {
        y = x * x;
        printf("%d\n", y);
    }

    return 0;
}
```

Translated program:
``` C
#include <stdio.h>

int main(void) {
    int x, y;
    printf("Enter a number: ");
    scanf("%d", &x);

    if (x <= 46340) goto square;
    printf("square too big for 32 bits\n");
    goto end;

    square:
    y = x * x;
    printf("%d", y);
    printf("\n");

    end:
    return 0;
}
```

MIPS:
``` assembly
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
```

___
### 5. Translate this C program so it uses goto rather than if/else.
### Then translate it to MIPS assembler.
``` C
#include <stdio.h>

int main(void) {
    for (int x = 24; x < 42; x += 3) {
        printf("%d\n",x);
    }
}
```

Translated C
``` C
#include <stdio.h>

int main(void) {
    int x = 24;
    loop:
    if (x >= 42) goto end;
    printf("%d", x);
    printf("\n");
    x = x + 3;
    goto loop;

    end:
    return 0;
}
```

MIPS:
``` assembly
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
```

___
### 6. Translate this C program so it uses goto rather than if/else.
### Then translate it to MIPS assembler.
``` C
// print a triangle
#include <stdio.h>

int main (void) {
    for (int i = 1; i <= 10; i++) {
        for (int j = 0; j < i; j++) {
            printf("*");
        }
        printf("\n");
    };
    return 0;
}
```

Translated C
``` C
#include <stdio.h>

int main (void) {
    int i = 1;
    loop0:
    if (i > 10) goto end0;
    int j = 0;

    loop1:
    if (j >= i) goto end1;
    printf("*");
    j = j + 1;
    goto loop1;

    end1:
    printf("\n");
    i = i + 1;
    goto loop0;

    end0:
    return 0;
}
```

MIPS:
``` assembly
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
```
