#include <stdio.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Incorrect number of arguments\n");
        return 1;
    }

    FILE *stream = fopen(argv[1], "w");
    if (stream == NULL) {
        perror(argv[1]);
        return 1;
    }

    int c;
    while ((c = getchar()) != EOF) {
        fputc(c, stream);
        if (c == '\n') {
            break;
        }
    }

    fclose(stream);
    return 0;
}
