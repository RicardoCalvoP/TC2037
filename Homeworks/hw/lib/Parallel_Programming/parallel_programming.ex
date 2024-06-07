defmodule Hw.Primes do
  def sum_primes(lim) when lim < 2, do: :error

  def sum_primes(lim), do: do_prime(0, 2, lim)

  defp do_prime(res, prime, lim) when prime > lim, do: res

  # defp do_prime()
end
