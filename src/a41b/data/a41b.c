// a41b.c
#include <stdio.h>

int main()
{
    int m = 2;
    int a[5]; // note: uninitialized array

    for (int k = 0; k < 5; k++)
    {
        m = m + k; // increment m by index value 
        a[k] = 1;  // populate array at index k with constant value '1'
    }

    printf(" > m: [ %d ]\n", m);
    printf(" > a[5]: [ %d, %d, %d, %d, %d ]\n", a[0], a[1], a[2], a[3], a[4]);

    return 0;
}
