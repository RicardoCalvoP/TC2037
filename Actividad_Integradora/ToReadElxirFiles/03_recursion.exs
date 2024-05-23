# Functions with recursion in Elixir
#
# Gilberto Echeverria
# 2024-03-01

defmodule Recur do

  def fact_1(n) do
    if n > 0 do
      if n == 0 do
        1
      else
        n * fact_1(n - 1)
      end
    else
      :error
    end
  end

  def fact_2(n) do
    cond do
      n < 0 -> :error
      n == 0 -> 1
      true -> n * fact_2(n - 1)
    end
  end

  # Using pattern matching and guards
  # to create different versions of the function
  def fact_3(n) when n < 0, do: :error
  def fact_3(0), do: 1
  def fact_3(n), do: n * fact_3(n - 1)

  # Public function that calls the tail recursion version
  def fact_4(n), do: fact_4(n, 1)

  # Private functions to use tail recursion
  defp fact_4(n, _a) when n < 0, do: :error
  defp fact_4(0, a), do: a
  defp fact_4(n, a), do: fact_4(n - 1, a * n)

end
