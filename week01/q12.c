#include <stdio.h>
#include <string.h>

#define MAX_NAME_LENGTH 256
#define MAX_BREED_LENGTH 64

struct pet {
    char name[MAX_NAME_LENGTH];
    char breed[MAX_BREED_LENGTH];
    int age;
    int weight;
};

int main(void) {
    struct pet my_pet;

    strcpy(my_pet.name, "Fluffy");
    strcpy(my_pet.breed, "axolotl");
    my_pet.age = 7;
    my_pet.weight = 300;

    return 0;
}
