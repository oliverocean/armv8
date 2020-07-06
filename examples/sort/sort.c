// sort.c
#include <stdio.h>


void swap(long long int v[], size_t j)
{
    long long int temp;
    temp = v[j];
    v[j] = v[j + 1];
    v[j + 1] = temp;
}

void sort(long long int v[], size_t v_size)
{
    for (int i = 0; i < v_size; i++)
    {
	for (int j = i - 1;  j >= 0 && v[j] > v[j + 1]; j--)
	{
	    swap(v, j);
	}
    }
}

void print(long long int v[], size_t k)
{
    printf(" > [ ");
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
