# Week 3 Tute

### 1. On a machine with 16-bit ints, the C expression `(30000 + 30000)` yields a negative result.
### Why the negative result? How can you make it produce the correct result?

2^15 - 1 = 32767

30000 + 30000 = 60000 > 32767

`uint32_t` 32 bits 

`uint16_t` 16 bits, max is 2^16 - 1 

___
## Twos-complement

___
### 2. Assume that the following hexadecimal values are 16-bit twos-complement. Convert each to the corresponding decimal value.

| part | hexadecimal | twos complement | flipped | decimal |
|:---:|:---:|:---:|:---:|:---:|
| i | 0x0013 | 0000 0000 0001 0011 | |  19 |
| ii | 0x0444 |
| iii | 0x1234 |
| iv | 0xffff | 1111 1111 1111 1111 | 0000 0000 0000 0000 | -1 |
| v | 0x8000 | 1000 0000 0000 0000 | 0111 1111 1111 1111 | -2^16

___
### 3. Give a representation for each of the following decimal values in 16-bit twos-complement bit-strings. Show the value in binary, octal and hexadecimal.
| part | decimal | binary | octal | hexadecimal |
|:---:|:---:|:---:|:---:|:---:|
| i | 1 | 
| ii | 100 | 
| iii | 1000 | 
| iv | 10000 | 0010 0111 0001 0000 | 023420 | 0x2710 |
| v | 100000 | too big
| vi | -5 | 1111 1111 1111 1011 | 0177773 | 0xFFFB |
| vii | -100 | 1111 1111 1001 1100 | 0177634 | 0xFF9C |

___
## Floating Point Representation

___
### 4. What decimal numbers do the following single-precision IEEE 754-encoded bit-strings represent?
### Each of the following are a single 32-bit bit-string, but partitioned to show the sign, exponent and fraction parts.
| part | string | decimal |
|:---:|:---:|:---:|
| a | 0 00000000 00000000000000000000000 | 
| b | 1 00000000 00000000000000000000000 | 
| c | 0 01111111 10000000000000000000000 | 
| d | 0 01111110 00000000000000000000000 | 
| e | 0 01111110 11111111111111111111111 | 
| f | 0 10000000 01100000000000000000000 | 
| g | 0 10010100 10000000000000000000000 | 
| h | 0 01101110 10100000101000001010000 | 

___
### 5. Convert the following decimal numbers into IEEE 754-encoded bit-strings:
| part | decimal | string |
|:---:|:---:|:---:|
| a | 2.5 | 
| b | 0.375 | 
| c | 27.0 | 
| d | 100.0 | 

___
### 6. Write a C function, `six_middle_bits`, which, given a `uint32_t`, extracts and returns the middle six bits.



___
### 7. Draw diagrams to show the difference between the following two data structures:
``` C
struct {
    int a;
    float b;
} x1;
union {
    int a;
    float b;
} x2;
```
### If `x1` was located at `&x1 == 0x1000` and `x2` was located at `&x2 == 0x2000`, what would be the values of `&x1.a`, `&x1.b`, `&x2.a`, and `&x2.b`?

sizeof(struct) = sum(sizeof(component)) = 8 (in this case)

sizeof(union) = max(sizeof(component)) = 4 (in this case)

`&x1.a = 0x1000`

`&x1.b  = 0x1004`

`&x2.a = 0x2000`

`&x2.b = 0x2000`

___
### 8. How large (#bytes) is each of the following C unions?
### You may assume `sizeof(char) == 1`, `sizeof(short) == 2`, `sizeof(int) == 4`.
### a. 
``` C
union { int a; int b; } u1;
```
4

### b.
``` C
union { unsigned short a; char b; } u2;
```
2

### c. 
``` C
union { int a; char b[12]; } u3;
```
12

### d.
``` C
union { int a; char b[14]; } u4;
``` 
16 (b is of size 14, but padding at the end so that int will align with 4 byte)

### e.
``` C
union { unsigned int a; int b; struct { int x; int y; } c; } u5;
```
8

### 9. Consider the following C union
``` C
union _all {
   int   ival;
   char cval;
   char  sval[4];
   float fval;
   unsigned int uval;
};
```
### If we define a variable `union _all var`; and assign the following value `var.uval = 0x00313233;`, then what will each of the following `printf`s produce:
### You can assume that bytes are arranged from right-to-left in increasing address order.
### a. 
``` C
printf("%x\n", var.uval);
```


### b. 
``` C
printf("%d\n", var.ival);
```


### c.
``` C
printf("%c\n", var.cval);
```


### d.
``` C
printf("%s\n", var.sval);
```


### e.
``` C
printf("%f\n", var.fval);
```


### f.
``` C
printf("%e\n", var.fval);
```
