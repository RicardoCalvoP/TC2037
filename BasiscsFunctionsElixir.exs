# Simple functions in Elixir
#
# Ricardo Calvo
# 27/02/2024

# Functions MOST be WRITTEN in LOWERCASE

defmodule Basiscs do

    def suma(a,b) do
        a + b
    end

    def farh_cel(f) do
        (f-32)*(5/9)
    end

    def cel_farh(c) do
        (c*9/5)+32
    end

end

IO.puts(Basiscs.suma(4,2))
IO.puts(Basiscs.farh_cel(122))
IO.puts(Basiscs.cel_farh(50))

IO.puts(Basiscs.farh_cel(Basiscs.cel_farh(36.4)))

# Pipe operator
# Take the previos result as the first argument of a functions

83.12
|> Basiscs.farh_cel()
|> Basiscs.cel_farh()
|> IO.puts

# Lists

defmodule TecList do

    def size(list), do: do_size(list, 0)
    defp do_size([], len), do: len
    defp do_size(list, len), do: do_size(tl(list), len + 1)

    def sum(list), do: sum_list(list,0)
    
    defp sum_list([], res), do: res
    defp sum_list(list, res), do: sum_list(tl(list), res + hd(list))

    def make_nums(n), do: do_make_nums(n,[])

    defp do_make_nums(0,res), do: res
    defp do_make_nums(n,res), do: do_make_nums(n-1, [n | res])
end
