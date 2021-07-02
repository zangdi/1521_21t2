# Week 5 Tute

___
## Assignment 1
Reminder that [assignment 1](https://cgi.cse.unsw.edu.au/~cs1521/21T2/assignments/ass1/index.html) is out!

Take a look at the README file in week07 for some examples of 2D arrays and functions in MIPS.


### 1. Often when writing large MIPS programs, you will make accidental errors that cause your program to misbehave.
### Discuss what tools are available to help debug broken MIPS code.

QtSPIM can be used to debug SPIM. [Here's lecture of JAS demonstrating QtSPIM.](https://www.youtube.com/watch?v=-bOpoJXvPY0)

You can also use `spim` without `-f` to use it as a debugger. The `help` command will give you a list of instructions. I will note that I personally found it a bit finnicky to use but you may have better luck with it.

___
### 2. Translate the following do-while loop to MIPS assembly.
``` C
#include <stdio.h>

int main(void) {
	int i = 0;

	do {
		i++;

		printf("%d", i);
		printf("\n");
	} while (i < 10);

	return 0;
}
```

MIPS:
```
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
```

___
### 3. If the data segment of a particular MIPS program starts at the address 0x10000020, then what addresses are the following labels associated with, and what value is stored in each 4-byte memory cell?
``` assembly
    .data
a:  .word   42
b:  .space  4
c:  .asciiz "abcde"
    .align  2
d:  .byte   1, 2, 3, 4
e:  .word   1, 2, 3, 4
f:  .space  1
```


| Label | Address | Contents |
|:---:|:---:|:---:|
| a | 0x10000020 | 42 |
| b | 0x10000024 | ???? |
| c | 0x10000028 | "abcd" |
|   | 0x1000002C | "e"??? |
| d | 0x10000030 | '1' '2' '3' '4' |
| e | 0x10000034 | 1 |
|   | 0x10000038 | 2 |
|   | 0x1000003C | 3 |
|   | 0x10000040 | 4 |
| f | 0x10000044 | ???? |

___
### 4. Give MIPS directives to represent the following variables:
### Assume that we are placing the variables in memory, at an appropriately-aligned address, and with a label which is the same as the C variable name.
| part | C | MIPS |
|:---:|:---|:---|
| a | `int u;` | `u: .space 4` |
| b | `int v = 42;` | `v: .word 42` |
| c | `char w;` | `w: .space 1` |
| d | `char x = 'a';` | `x: .byte 'a'` |
| e | `double y;` | `y: .space 8` |
| f | `int z[20];` | `z: .space 80`

___

```
la  $t0, print_statement
lb  $t1, ($t0)          # grab print_statement[0]
lb  $t2, 1($t0)         # grab print_statement[1]

la  $t0, z
lw  $t1, ($t0)          # grab z[0]
lw  $t2, 4($t0)         # grab z[1]
lw  $t2, z+4            # grab z[1]
li  $t2, 4
sw  $t2, 8($t0)         # store the number 4 into z[2]
```

### 5. Consider the following memory state:
```
Address       Data Definition
0x10010000    aa:  .word 42
0x10010004    bb:  .word 666
0x10010008    cc:  .word 1
0x1001000C         .word 3
0x10010010         .word 5
0x10010014         .word 7
```
### What address will be calculated, and what value will be loaded into register $t0, after each of the following statements (or pairs of statements)?


#### a)
```
la   $t0, aa
```
$t0 = 0x10010000


#### b)
```
lw   $t0, bb
```
$t0 = 666

#### c)
```
lb   $t0, bb
```
0x12345678, $t0 = 0x12 or $t0 = 0x78

#### d)
```
lw   $t0, aa+4
```
$t0 = 666

#### e)
```
la   $t1, cc
lw   $t0, ($t1)
```
$t1 = 0x10010008

$t0 = 1

#### f)
```
la   $t1, cc
lw   $t0, 8($t1)
```
$t1 = 0x10010008

$t0 = 5

#### g)
```
li   $t1, 8
lw   $t0, cc($t1)
```

$t1 = 8

$t0 = 5

#### h)
```
la   $t1, cc
lw   $t0, 2($t1)
```

$t1 = 0x10010008

error

___
### 7. Translate this C program to MIPS assembler
``` C
#include <stdio.h>

int main(void) {
    int i;
    int numbers[10] = {0};

    i = 0;
    while (i < 10) {
        scanf("%d", &numbers[i]);
        i++;
    }

    i = 9;
    while (i >= 0) {
        printf("%d", numbers[i]);
        printf("\n");
        i--;
    }
}
```

MIPS:
```
    .text
main:
    # store i in $t0
    li		$t0, 0
    
loop1:
    bge		$t0, 10, end1
    
    li  $v0, 5
    syscall

# method 1 of storing something at &numbers[i]
# calculate the address, &numbers[i] and store it into register $t4
# then access the address by using ($t4)
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
# calculate the distance between &numbers[i] and &numbers[0] and store in register $t3
# then access $t3 higher than &numbers[0] but using numbers($t3)
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
```
