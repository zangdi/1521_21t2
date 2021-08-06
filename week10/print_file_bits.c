#include <stdio.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *stream = fopen(argv[1], "r");
    if (stream == NULL) {
        perror(argv[1]);
        return 1;
    }

    int num;
    while (fscanf(stream, "%d", &num) == 1) {
        int last_bytes = num & 0xFF;
        if (last_bytes & (1 << 7)) {
            last_bytes = last_bytes | 0xFFFFFF00;
        }

        printf("%d\n", last_bytes);
    }

    return 0;
}