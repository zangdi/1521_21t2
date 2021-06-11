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