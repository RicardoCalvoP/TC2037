#include <stdio.h>
#include <stdlib.h>

unsigned long factorial_recursive(int n)
{
    if (n == 1)
    {
        return n;
    }
    else
    {
        return n * factorial_recursive(n - 1);
    }
}

int main(int argc, char *argv[])
{
    int n;
    unsigned long result;
    printf("Hello, I am %s\n", argv[0]);

    if (argc == 2)
    {
        n = atoi(argv[1]);
    }
    else
    {
        printf("Enter the number to compute: ");
        scanf("%d", &n);
    }

    result = factorial_recursive(n);
    printf("The factorial of %d is %lu\n", n, result);
    return 0;
}