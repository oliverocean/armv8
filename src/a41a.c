// a41a.c
#include <stdio.h>

int main()
{
    int i = 10;
    int j = 5;
    int g = 1;
    int f = 0;

    while (i != j)
    {
        f = g + j;
        j++;
    }

    printf(" > results: [ %d ] (f_value)\n", f);

    return 0;
}
