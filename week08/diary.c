#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(void) {
    char *home = getenv("HOME");
    printf("%s\n", home);

    int len = strlen(home) + 8;
    char *path = malloc(sizeof(char) * len);
    snprintf(path, len, "%s/.diary", home);
    printf("%s\n", path);

    FILE *diary = fopen(path, "r");
    if (diary == NULL) {
        perror(path);
        return 1;
    }

    int byte;
    while ((byte = fgetc(diary)) != EOF) {
        putchar(byte);
    }

    fclose(diary);

    return 0;
}
