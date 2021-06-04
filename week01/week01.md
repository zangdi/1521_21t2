# Week 1 Tute

The class website can be found [here](https://cgi.cse.unsw.edu.au/~cs1521/21T2/).
It contains links to all the information you need, including course outline, lectures, lecture slides, tute questions, lab questions, etc.

The course forum can be found [here](https://discourse.cse.unsw.edu.au/21t2/comp1521/).
If you have any questions about the content or any tute questions and lab exercises, please ask there.

### 2. Consider the following C program skeleton:
``` C
int  a;
char b[100];

int fun1() {
    int c, d;
    ...
}

double e;

int fun2() {
    int f;
    static int ff;
    ...
    fun1();
    ...
}

int g;

int main(void) {
    char h[10];
    int i;
    ...
    fun2()
    ...
}
```
### Now consider what happens during the execution of this program and answer the following:

### a. Which variables are accessible from within `main()`?
`a, b, e, g` are global variables which are above `main`

`h, i` are local variables

### b. Which variables are accessible from within `fun2()`?
`a, b, e` are global variables which are above `fun2`

`f, ff` are local variables

Note that `g` is a global variable but cannot be accessed as it is below `fun2`

### c. Which variables are accessible from within `fun1()`?
`a, b` are global variables which are above `fun1`

`c, d` are local variables

Note that `e, g` are global variables but cannot be accessed as they are below `fun1`

### d. Which variables are removed when `fun1()` returns?
`c, d`

### e. Which variables are removed when `fun2()` returns?
`f`

Sidenote: `static` variables in a function are like global variables but can only be accessed in the function which they are declared.
The first time a function is called, `static` variables will be initialised to 0 if there is not assignment in the same line as the declaration or whatever value it is assigned to be.
In further calls to the function, the variable will be updated and maintain the value it was between function calls.

### f. How long does the variable `f` exist during program execution?
It will exist whenever `fun2` exists.

When `fun2` calls `fun1`, `fun2` still exists on the stack under `fun1`'s stack so `f` will still exist.
However, when the program returns from `fun2`, `f` will no longer exist.

### g. How long does the variable `g` exist during program execution?
Since `g` is a global variable, it will exist for the entire duration of program execution.

### 3.Explain the differences between the properties of the variables s1 and s2 in the following program fragment:
``` C
#include <stdio.h>

char *s1 = "abc";

int main(void) {
    char *s2 = "def";
    // ...
}
```

### Where is each variable located in memory? Where are the strings located?

Memory is structured like this diagram

![0x0000\[ Code | Data | Heap ->         <- Stack ] 0xFFFF>\]](week01.png)

+ Code contains the code which is being executed.
+ Data contains global variables and string literals
+ Heap contains variables which have been dynamically allocated and grows upwards
+ Stack contains information for the functions, including local variables and grows downwards

Since `s1` is a global variables, it is stored in the data segment.

Since `s2` is a local variable, it is stored in the stack.

The string literals are stored in the data segment.


### 4. C's `sizeof` operator is a prefix unary operator (precedes its 1 operand) - what are examples of other C unary operators?
A unary operator is an operator that takes in 1 argument.

operator | name | example | notes
---|---|---|---
\- | unary minus | `int a = -5` | negative number
\+ | unary plus | `int b = +5` | positive number
-- | decrement | `int c = --a` | can be prefix (--x) or postfix (x--)
++ | increment | `int d = b++` | can be prefix (++x) or postfix (x++)
! | logical negation | `if (true == ! false)` | for conditions
~ | bitwise negation | `int e = ~0` | for bit operations
& | address of | `int *f = &e` | gets the address of a variable
\* | indirection | `int g = *f` | gets the value stored at an address

Note: for increment and decrement, prefix and postfix do different things.
The following is an example that shows the difference.
``` C
#include <stdio.h>

int main(void) {
    int arr[] = {1, 2, 3, 4, 5};

    // incrementing prefix
    int i = 2;
    printf("%d\n", arr[++i]); // prints 4, which is at the 3rd index of arr
    printf("%d\n", i); // prints 3, since i has now been incremented

    // incrementing postfix
    int j = 2;
    printf("%d\n", arr[j++]); // prints 3, which is at the 2nd index of arr
    printf("%d\n", j); // prints 3, since j has now been incremented

    return 0;
}
```

### 5. Why is C's `sizeof` operator different to other C unary & binary operators?
`sizeof` can take variable, value or type as an argument. E.g.
``` C
#include <stdio.h>

int main(void) {
    char x;
    printf("%ld\n", sizeof x); // prints 1 as x is of type char and chars are 1 byte
    printf("%ld\n", sizeof(char)); // prints 1 as chars are 1 byte
    printf("%ld\n", sizeof "sandwich"); // prints 9 as 9 chars (including null terminator)

    return 0;
}
```
To use `sizeof` with types, you will need to put brackets around the type.

`sizeof` is a compile time operator.

### 6. Discuss errors in this code:
``` C
struct node *a, *b, *c, *d;
a = NULL:
b = malloc(sizeof b);
c = malloc(sizeof struct node);
d = malloc(8);
c = a;
d.data = 42;
c->data = 42;
```
Since `b` is of type `struct node *`, `*b` is of type `struct node`.
Therefore we should have
``` C
b = malloc(sizeof *b);
```
While 
``` C
d = malloc(8);
```
could be correct, it is not portable as `struct node` could be of different sizes on different systems, e.g. 8 bytes on a 32-bit OS but 16 bytes on a 64-bit OS.

`d.data` is not correct as `d` is a pointer to a struct. We should have
``` C
d->data = 42;
```

`c->data` is illegal as `c` will be `NULL` when it is executed.

### 7. What is a pointer? How do pointers relate to other variables?
A pointer is a variable that points to another variable.

In C, they store the memory address of the variable they refer to.

Given a pointer, you can access the variable it points to and assign to it.

### 8. Consider the following small C program.
### Assume the variable `n` has address `0x7fff00000000`.
### Assume `sizeof (int) == 4`.
### What does the program print?
``` C
#include <stdio.h>

int main(void) {
    int n[4] = { 42, 23, 11, 7 };
    int *p;

    p = &n[0];
    printf("%p\n", p); // prints 0x7fff00000000
    printf("%lu\n", sizeof (int)); // prints 4

    n[0]++; // increments the first element of n, so 42 becomes 43
    printf("%d\n", *p); // prints 32
    p++; // increments p, since p is a pointer to an int, p is increased by sizeof(int) which is 4
    printf("%p\n", p); // prints 0x7fff00000004
    printf("%d\n", *p); // prints 23 since p now points to index 1 of n

    return 0;
}
```

Note: When you add or subtract `a` from a pointer, they change by `a * sizeof(*pointer)`.

So for `int *x = 1000`, assuming 4 bytes in an int, `x += 4` will result in `x = 1016`.

### 9. Consider the following pair of variables
``` C
int  x;  // a variable located at address 1000 with initial value 0
int *p;  // a variable located at address 2000 with initial value 0
```

### If each of the following statements is executed in turn, starting from the above state, show the value of both variables after each statement:

### If any of the statements would trigger an error, state what the error would be.

### a.
``` C
p = &x;
```
Set `p` to the address of `x` which is 1000.

`p = 1000, x = 0`

### b.
```C
x = 5;
```
Set `x` to 5.

`p = 1000, x = 5`

### c.
``` C
*p = 3;
```
Set the variable at the address pointed to by `p` to 3.
Since `p` points to `x`, set `x` to 3.

`p = 1000, x = 3`

### d.
``` C
x = (int)p;
```
`(int) p` means casting the variable `p` to an int, so treating `p` as if it were an int.

Set `x` to the `p` casted as an int.

`p = 1000, x = 1000`

### e.
``` C
x = (int)&p;
```
Set `x` to the address of `p` casted as an int.
The address of `p` is 2000.

`p = 1000, x = 2000`

### f.
``` C
p = NULL;
```
Set `p` to `NULL`.

`p = NULL, x = 2000`

### g.
``` C
*p = 1;
```
Set the address pointed to by `p` to 1.

Since `p` points to `NULL` and `NULL` cannot be accessed, we will get an error for dereferencing a `NULL` pointer

### 10. Consider the following C program:
``` C
#include <stdio.h>

int main(void)
{
    int nums[] = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3};
    for (int i = 0; i < 10; i++) {
        printf("%d\n", nums[i]);
    }
    return 0;
}
```
### This program uses a `for` loop to print each element in the array
### Rewrite this program using a [recursive function](https://en.wikipedia.org/wiki/Recursion_(computer_science))

A recursive function is a function that calls itself.

Any iterative loop (`for` or `while` loop) can be written as a recursive function.

The key elements of a recursive function are:
+ a base step (where the recursion stops)
+ actions which are taken at each specific stage of the recurstion
+ a recursive call (where the function calls itself)

``` C
#include <stdio.h>

void print_array(int nums[], int length, int index) {
    // base step
    if (index >= length) {
        return;
    }

    // action for each stage of the recursion
    printf("%d\n", nums[index]);

    // recursive call
    print_array(nums, length, index + 1);
}

int main(void) {
    int nums[] = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3};
    print_array(nums, 10, 0);
    return 0;
}
```

### 11. What is a struct? What are the differences between structs and arrays?
Arrays and structs are both made up of other data types.

Arrays are:
+ made of the same data type
+ accessed with integer indexes (`arr[0]`)

Structs:
+ can be made of different data types.
+ are accessed by field names (`node.field`)

### 12. Define a struct that might store information about a pet.
### The information should include the pet's name, type of animal, age and weight.
### Create a variable of this type and assign information to it to represent an axolotl named "Fluffy" of age 7 that weighs 300grams.
``` C
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
```

### 13. Write a function that increases the age of fluffy by one and then increases its weight by the fraction of its age that has increased. The function is defined like this:
### `void age_fluffy(struct pet *my_pet);`
### e.g.: If fluffy goes from age 7 to age 8, it should end up weighing 8/7 times the amount it weighed before. You can store the weight as an int and ignore any fractions.
### Show how this function can be called by passing the address of a struct variable to the function.

``` C
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
```

### 14. Write a main function that takes command line input that fills out the fields of the pet struct. Remember that command line arguments are given to our main function as an array of strings, which means we'll need something to convert strings to numbers.
``` C
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
```

### 15. Consider the following C program:
``` C
#include <stdio.h>

int main(void) {
    char str[10];
    str[0] = 'H';
    str[1] = 'i';
    printf("%s", str);
    return 0;
}
```
### What will happen when the above program is compiled and executed?

`printf` expects strings to be terminated with a null-terminator (`'\0'`).

Since `str[2]` and beyond are uninitialised, `str[2]` probably won't be a null-terminator.

If the code is compiled with `dcc`, it will stop with an error because `str[2]` is uninitialised.

However, if the code is compiled with `gcc`, it will keep printing junk until it reaches a `'\0'` byte or the operating system kills it because of an illegal memory access.

### 16. How do you correct the program?
``` C
#include <stdio.h>

int main(void) {
    char str[10];
    str[0] = 'H';
    str[1] = 'i';
    str[2] = '\0';
    printf("%s", str);
    return 0;
}
```
