# Ricardo Calvo
## Parallel Programming
---

## _Summary_

In this code, we wanted to calculate the sum of prime numbers up to a specified limit efficiently. We implemented two main functions: sum_primes/1 and sum_primes_parallel/2.

The sum_primes/1 function sequentially computes the sum of prime numbers using a stream-based approach, filtering out non-prime numbers lazily and summing the prime numbers up to the given limit.

To further optimize performance, we introduced the sum_primes_parallel/2 function, which parallelizes the computation by distributing the workload among multiple threads. This parallel approach significantly improves execution time, particularly for larger computation tasks, by leveraging Elixir's task-based concurrency model.

Additionally, we provided a utility function, calc_time/2, to measure the execution time of the prime summation functions, allowing for performance analysis and comparison between sequential and parallel execution.

## _Code Reasoning_ 

`sum_primes/1` Function: This function goes through numbers one by one, checking if each is a prime number. Once it finds a prime number, it adds it to the total sum of prime numbers up to the given limit.

`sum_primes_parallel/2` Function: This function speeds up the calculation by splitting the work among different threads. Each thread handles a portion of the numbers, checking if they are prime and adding them to the total sum. It takes advantage of Elixir's ability to run tasks concurrently on multiple CPU cores, which makes the computation faster by using the available resources effectively.

## _Speedup Analysis_

Parallel processing demonstrates significant speedup compared to sequential execution, especially for larger computation tasks. For instance, when summing primes up to 20, parallel execution with 8 threads reduces execution time from 0.005427 seconds to 0.003686 seconds. Similarly, for a larger task, such as summing primes up to 2000, the speedup is even more pronounced, with execution time decreasing from 0.000921 seconds to 0.000512 seconds. This highlights the effectiveness of parallel processing in optimizing performance, particularly for computationally intensive tasks.