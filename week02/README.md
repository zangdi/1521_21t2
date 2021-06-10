# Week 2 Tute

### 1. When should the types in stdint.h be used:
``` C
#include <stdint.h>

                 // range of values for type
                 //             minimum               maximum
    int8_t   i1; //                 -128                  127
    uint8_t  i2; //                    0                  255
    int16_t  i3; //               -32768                32767
    uint16_t i4; //                    0                65535
    int32_t  i5; //          -2147483648           2147483647
    uint32_t i6; //                    0           4294967295
    int64_t  i7; // -9223372036854775808  9223372036854775807
    uint64_t i8; //                    0 18446744073709551615
```


___
## Converting between decimal and binary


## Converting between binary and octal / hexadecimal

___
### 2. Show what the following decimal values look like in 8-bit binary, 3-digit octal, and 2-digit hexadecimal:

| part | decimal | binary | octal | hexadecimal |
|:---:|:---:|:---:|:---:|:---:|
| a | 1 |
| b | 8 |
| c | 10 |
| d | 15 |
| e | 16 |
| f | 100 |
| g | 127 |
| h | 200 |


___
## Bitwise Operations
| symbol | name | what it does |
|:---:|:---:|---|

___
### 3. Assume that we have the following 16-bit variables defined and initialised:
``` C
uint16_t a = 0x5555, b = 0xAAAA, c = 0x0001;
```
### What are the values of the following expressions:
### Give your answer in hexadecimal, but you might find it easier to convert to binary to work out the solution.
| part | expression | binary | hexadecimal |
|:---:|:---:|:---:|:---:|
| a | a \| b |
| b | a & b |
| c | a ^ b |
| d | a & ~b |
| e | c << 6 |
| f | a >> 4 |
| g | a & (b << 1) |
| h | b \| c |
| i | a & ~c |


___
### 4. Consider a scenario where we have the following flags controlling access to a device.
```C
#define READING   0x01
#define WRITING   0x02
#define AS_BYTES  0x04
#define AS_BLOCKS 0x08
#define LOCKED    0x10
```
### The flags are contained in an 8-bit register, defined as:
```C
unsigned char device;
```
### Write C expressions to implement each of the following:

### a. mark the device as locked for reading bytes
### b. mark the device as locked for writing blocks
### c. set the device as locked, leaving other flags unchanged
### d. remove the lock on a device, leaving other flags unchanged
### e. switch a device from reading to writing, leaving other flags unchanged
### f. swap a device between reading and writing, leaving other flags unchanged


___
### 5. Discuss the starting code for sixteen_out, one of this week's lab exercises. In particular, what does this code (from the provided main) do?
``` C
    long l = strtol(argv[arg], NULL, 0);
    assert(l >= INT16_MIN && l <= INT16_MAX);
    int16_t value = l;

    char *bits = sixteen_out(value);
    printf("%s\n", bits);

    free(bits);
```


___
### 6. Given the following type definition
```C
typedef unsigned int Word;
```
### Write a function
```C
Word reverseBits(Word w);
```
### which reverses the order of the bits in the variable w.
### For example: If `w == 0x01234567`, the underlying bit string looks like:
``` C
0000 0001 0010 0011 0100 0101 0110 0111
```
### which, when reversed, looks like:
```C
1110 0110 1010 0010 1100 0100 1000 0000
```
### which is `0xE6A2C480` in hexadecimal.


___
## 16 in and 16 out

___
## BCD

