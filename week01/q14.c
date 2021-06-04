#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_NAME_LENGTH 256
#define MAX_BREED_LENGTH 64

struct pet {
    char name[MAX_NAME_LENGTH];
    char breed[MAX_BREED_LENGTH];
    int age;
    int weight;
};

// *argv[] or **argv or argv[][] are all equivalent
// argc is the number of command line arguments given
// argv[0] - contains name of the program
int main(int argc, char *argv[]) {
    // we need 4 arguments, but argc also includes program name as an argument
    if (argc != 5) {
        printf("Usage: %s [pet_name] [pet_breed] [age] [weight]\n", argv[0]);
        return 1;
    }
    
    struct pet my_pet;

    strcpy(my_pet.name, argv[1]);
    strcpy(my_pet.breed, argv[2]);
    my_pet.age = strtol(argv[3], NULL, 10);
    my_pet.weight = strtol(argv[4], NULL, 10);

    return 0;
}
