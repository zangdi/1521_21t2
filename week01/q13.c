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

// passing in pointer to struct pet so we can edit it in place
void age_fluffy(struct pet *my_pet) {
    double old_age = my_pet->age;
    my_pet->age++;
    double weightMultiplier = my_pet->age / old_age;
    my_pet->weight = my_pet->weight * weightMultiplier;
    // my_pet->weight *= weightMultiplier; // equivalent to the line above
}

int main(void) {
    struct pet my_pet;

    strcpy(my_pet.name, "Fluffy");
    strcpy(my_pet.breed, "axolotl");
    my_pet.age = 7;
    my_pet.weight = 300;

    age_fluffy(&my_pet);
    printf("%d, %d\n", my_pet.age, my_pet.weight);

    return 0;
}
