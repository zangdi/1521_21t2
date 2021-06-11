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
### 2. Show what the following decimal values look like in 8-bit binary, 3-digit octal, and 2-digit hexadecimal:

| part | decimal | binary | octal | hexadecimal |
|:---:|:---:|:---:|:---:|:---:|
| a | 1 | 00000001 | 001 | 01 |
| b | 8 | 00001000 | 010 | 08 |
| c | 10 | 00001010 | 012 | 0A |
| d | 15 | 00001111 | 017 | 0F |
| e | 16 | 00010000 | 020 | 10 |
| f | 100 | 01100100 | 144 | 64 |
| g | 127 | 01111111 | 177 | 7F |
| h | 200 | 1100 1000 | 310 | C8 |

___
## Bitwise Operations
| symbol | name | what it does |
|:---:|:---:|---|
| & | and | a & b => sets all bits that are set in both a and b 
| \| | or | a \| b => sets all bits that are set in either a or b
| ^ | xor | a ^ b => sets all bits that are set in exactly one of a or b
| ~ | not | ~a => flips all the bits
| << | left shift | a << c => shifts all the bits of a up by c, 0101 << 1 = 1010
| >> | right shift | a >> c => shifts all the bits of a down by c, 0101 >> 1 = 0010

(i = a & b)

i += 1 (i = i + 1)

i &= 1 (i = i & 1)

or -> useful if you want to set a particular bits

and -> useful if you want to extract a bit

bitmask -> 00001111

___
### 3. Assume that we have the following 16-bit variables defined and initialised:
``` C
uint16_t a = 0x5555, b = 0xAAAA, c = 0x0001;
```
### What are the values of the following expressions:
### Give your answer in hexadecimal, but you might find it easier to convert to binary to work out the solution.
a = 0101010101010101

b = 1010101010101010

b << 1 = 0101010101010100
    
c = 0000000000000001

~c = 1111 1111 1111 1110

| part | expression | binary | hexadecimal |
|:---:|:---:|:---:|:---:|
| a | a \| b | 1111 1111 1111 1111 | FFFF |
| b | a & b | 0000 0000 0000 0000 | 0000 |
| c | a ^ b | 1111 1111 1111 1111 | FFFF |
| d | a & ~b | 0101 0101 0101 0101 | 5555 |
| e | c << 6 | 0000 0000 0100 0000 | 0040 |
| f | a >> 4 | 0000 0101 0101 0101 | 0555 |
| g | a & (b << 1) | 0101 0101 0101 0100 | 5554 |
| h | b \| c | 1010 1010 1010 1011 | AAAB |
| i | a & ~c | 0101 0101 0101 0100 | 5554 |

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

``` C
#include <stdio.h>

typedef unsigned int Word;
// assume that integer has 32 bits

Word reverseBits(Word w) {
    // extract a certain bit -> & (with a bitmask)
    // set a certain bit -> |
    Word result = 0;
    for (int i = 0; i < 32; i++) {
        // find out if the ith bit of w is set or not
        // set (31 - i)th bit of result
        Word isSet = w & (1 << i);
        if (isSet != 0) {
            result = result | (1 << (31 - i));
        }
    }

    return result;
}

int main(void) {
    Word w = 0x01234567;
    printf("%x reversed is %x\n", w, reverseBits(w));

    return 0;
}
```
