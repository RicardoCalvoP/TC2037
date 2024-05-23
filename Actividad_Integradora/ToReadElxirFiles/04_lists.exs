# Basic functions with lists
#
# Gilberto Echeverria
# 2024-03-01

defmodule TecLists do

  # Function to count the elements in a list
  def size(list), do: do_size(list, 0)

  # Using the hd() and tl() functions to split the list
  defp do_size([], len), do: len
  defp do_size(list, len), do: do_size(tl(list), len + 1)

  def sum(list), do: do_sum(list, 0)

  defp do_sum([], res), do: res
  defp do_sum(list, res), do: do_sum(tl(list), res + hd(list))

  # Create a list with the integers from 1 to n
  def make_nums(n), do: do_make_nums_2(n, [])

  # Using ++ to append new elements into the list
  defp do_make_nums_1(0, res), do: res
  defp do_make_nums_1(n, res) do
    IO.inspect binding()
    do_make_nums_1(n - 1, [n] ++ res)
  end

  # Using the [head | tail] construct to add elements to a list
  defp do_make_nums_2(0, res), do: res
  defp do_make_nums_2(n, res) do
    # Show the arguments received by the function
    IO.inspect binding()
    do_make_nums_1(n - 1, [n | res])
  end

  # Reverse the order of the elments in a list
  def invert(list), do: do_invert(list, [])

  defp do_invert([], res), do: res
  defp do_invert([head | tail], res), do: do_invert(tail, [head | res])

  # Put every element in a list into a list of its own
  def enlist(list), do: do_enlist(list, [])

  defp do_enlist([], res), do: invert(res)
  defp do_enlist([head | tail], res), do: do_enlist(tail, [[head] | res])

end
