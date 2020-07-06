// sort-debug.c
#include <stdio.h>


void swap(long long int v[], size_t j)
{
    printf("    > pre  [ %d, %d, %d, %d, %d ]\n", v[0], v[1], v[2], v[3], v[4]);
    printf("    > swap [ %d ] and [ %d ]\n", v[j], v[j + 1]);
    long long int temp;
    temp = v[j];
    v[j] = v[j + 1];
    v[j + 1] = temp;
    printf("    > post [ %d, %d, %d, %d, %d ]\n", v[0], v[1], v[2], v[3], v[4]);
}

void sort(long long int v[], size_t v_size)
{
    for (int i = 0; i < v_size; i++)
    {
        printf("\n-------\n> i: [ %d ]\n", i);
	// j = i - 1        starts further to right over time (i increases in outer loop)
	// j >= 0           continue until v[0] is reached (or less, ie: -1 at loop 1)
	// v[j] > v[j + 1]  otherwise compare j to next value, if its bigger, invoke loop body: swap()
	// j--              this loop moves backwards (to left!)
	for (int j = i - 1;  j >= 0 && v[j] > v[j + 1]; j--)
	{
            printf("  > j: [ %d ]\n", j);
	    swap(v, j);
	}
    }
}

void print(long long int v[], size_t k)
{
    printf("\n> [ ");
    for (int p = 0; p < k; p++)
    {
	printf("%d, ", v[p]);
    }
    printf("]\n");

}

int main()
{
    long long int v[] = { 5, 4, 3, 2, 1 };

    print(v, 5);
    sort(v, 5);
    print(v, 5);
    return 0;
}
