// a42.c
#include <stdio.h>

int f3 (int a, int *b)
{
    int c;
    c = a >> 2;
    *b = a + *b;

    if (a < 2 || c < 0)
    {
        return c;
    }
    else
    {
        return c | a; // bitwise OR operator
    }
}

int main()
{
    int c = 31;
    int p = 128;

    printf(" > f3(c, &p): [ %d ]\n", f3(c, &p));

    return 0;
}
