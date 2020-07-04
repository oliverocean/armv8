// a42.c
#include <stdio.h>

int f3 (int a, int *b)
{
    int c;
    c = a >> 2;  // 7 = 31 >> 2
    *b = a + *b; // 159 = 31 + 128

    if (a < 2 || c < 0)
    {
        return c; //  c < 0: false (c = 7, statement never reached) 
    }
    else
    {
        return c | a; // 31 = 7 | 31 (bitwise OR operator)
    }
}

int main()
{
    int c = 31;
    int p = 128;

    printf(" > f3(c, &p): [ %d ]\n", f3(c, &p)); // f3() = '31'

    return 0;
}
