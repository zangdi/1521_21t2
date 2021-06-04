#include <stdio.h>

void print_array(int nums[], int length, int index) {
    if (index >= length) {
        return;
    }

    printf("%d\n", nums[index]);
    
    print_array(nums, length, index + 1);
}


int main(void) {
    int nums[] = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3};
    print_array(nums, 10, 0);
    return 0;
}
