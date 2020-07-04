// l41.c
#include <stdio.h>

int getMax(int a, int b, int c)
{
    int result = a;

    if (b > result)
    {
	if (c > b) 
	{ 
	    result = c;
	}
	else
	{
	    result = b;
	}
    }		
    else if (c > result)
    {
	result = c; 
    }
    
    return result;
}

void printMax(int m)
{
    printf(" > The maximum number is: [ %d ]\n", m);
}    

int main(void)
{
    int max;
    max = getMax(4, 3, 7);
    printMax(max);

    return 0;
}
