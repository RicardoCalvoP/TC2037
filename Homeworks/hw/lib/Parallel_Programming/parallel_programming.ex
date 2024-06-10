# Ricardo Calvo
# A01028889
# 06/2024

defmodule Hw.Primes do
  # Function to calculate the sum of prime numbers up to a given limit
  def sum_primes(limit) when limit < 2, do: :error

  def sum_primes(limit) do
    # Generate an infinite stream of numbers starting from 2
    Stream.iterate(2, &(&1 + 1))
    # Filter out non-prime numbers and take numbers up to the given limit
    |> Stream.filter(&prime?(&1, 3))
    |> Stream.take_while(&(&1 <= limit))
    # Sum the prime numbers
    |> Enum.sum()
  end

  # Helper function to check if a number is prime
  defp prime?(2, _), do: true
  defp prime?(3, _), do: true
  defp prime?(n, _) when rem(n, 2) == 0, do: false

  defp prime?(n, from \\ 3) do
    limit = [2, round(:math.sqrt(n))] |> Enum.max()

    # Generate a stream of odd numbers starting from input
    Stream.iterate(from, &(&1 + 2))
    # Take numbers up to the square root of 'n'
    |> Stream.take_while(fn x -> x <= limit end)
    # Filter out divisors of the current number
    |> Stream.filter(fn x -> rem(n, x) == 0 end)
    # Check if the stream is empty to determine if n is prime
    |> Enum.empty?()
  end

  # Function to calculate the sum of prime numbers up to a given limit using parallel processing
  def sum_primes_parallel(limit, num_threads \\ 8) do
    chunk_size = div(limit, num_threads)

    # Divide the range of numbers into chunks for parallel processing
    ranges =
      Enum.map(0..(num_threads - 1), fn i ->
        start = 2 + i * chunk_size
        finish = if i == num_threads - 1, do: limit, else: 2 + (i + 1) * chunk_size - 1
        {start, finish}
      end)

    # Execute the sum_primes_in_range function concurrently for each chunk
    tasks =
      Enum.map(ranges, fn {start, finish} ->
        Task.async(fn -> sum_primes_in_range(start, finish) end)
      end)

    # Wait for all tasks to complete and sum their results
    results = Enum.map(tasks, &Task.await/1)
    Enum.sum(results)
  end

  # Helper function to calculate the sum of prime numbers in a given range from chunks
  defp sum_primes_in_range(start, finish) do
    # Generate a stream of numbers within the specified range
    Stream.iterate(start, &(&1 + 1))
    # Take numbers within the range
    |> Stream.take_while(&(&1 <= finish))
    # Filter out non-prime numbers
    |> Stream.filter(&prime?(&1, 3))
    # Sum the prime numbers
    |> Enum.sum()
  end

  # Function to measure the execution time of a given function with the provided arguments
  def calc_time(function, args) do
    {time, function} = :timer.tc(function, args)
    # Convert time from microseconds to seconds
    time / 1_000_000
  end
end
