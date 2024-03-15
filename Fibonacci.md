
def Fibonacci(n):
    if n == 0 or n ==  1:
        return n
    return Fibonacci(n-1) + Fibonacci(n - 2)

def Factorial(n):
    if n == 0:
        return 1
    return n * Factorial(n - 1)


print(Fibonacci(8))
print(Factorial(10))