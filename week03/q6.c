#include <stdio.h>
#include <stdint.h>

uint32_t six_middle_bits(uint32_t num) {
    uint32_t mask = 0x3F;
    int shift = 13;
    return (num >> shift) & mask;
}