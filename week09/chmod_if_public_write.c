#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Wrong number of arguments\n");
    }

    for (int i = 1; i < argc; i++) {
        struct stat s;
        if (stat(argv[i], &s) != 0) {
            perror(argv[i]);
            return 1;
        }

        mode_t mode = s.st_mode;
        if (mode & S_IWOTH) {
            mode_t newmode = mode & ~S_IWOTH;
            if (chmod(argv[i], newmode) != 0) {
                perror(argv[i]);
                return 1;
            }

            print("removing public write from %s\n", argv[i]);
        } else {
            printf("%s is not publically writeable\n", argv[i]);
        }
    }

    return 0;
}
