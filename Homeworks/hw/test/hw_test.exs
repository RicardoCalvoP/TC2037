#    Tests for the set of problems by Ariel Ortiz
#    Use of functions, conditions, recursion and lists
#
#    Gilberto Echeverria
#    2022-03-04

defmodule Hw.Ariel1Test do
  use ExUnit.Case
  alias Hw.Ariel1

  # Functions

  describe "fahrenheit_to_celsius:" do
    test "212 F -> 100 C",
      do: assert(Ariel1.fahrenheit_to_celsius(212.0) == 100.0)

    test "32 F -> 0 C",
      do: assert(Ariel1.fahrenheit_to_celsius(32) == 0)

    test "-40 F -> -40 C",
      do: assert(Ariel1.fahrenheit_to_celsius(-40) == -40)
  end

  describe "roots:" do
    test "roots(2, 4, 2)",
      do: assert(Ariel1.roots(2, 4, 2) == -1)

    test "roots(1, 0, 0)",
      do: assert(Ariel1.roots(1, 0, 0) == 0)

    test "roots(4, 5, 1)",
      do: assert(Ariel1.roots(4, 5, 1) == -1 / 4)
  end

  # Conditionals

  describe "sign:" do
    test "negative number",
      do: assert(Ariel1.sign(-5) == -1)

    test "positive number",
      do: assert(Ariel1.sign(5) == 1)

    test "zero",
      do: assert(Ariel1.sign(0) == 0)
  end

  describe "bmi:" do
    test "underweight",
      do: assert(Ariel1.bmi(47, 1.7) == :underweight)

    test "normal",
      do: assert(Ariel1.bmi(55, 1.5) == :normal)

    test "obese1",
      do: assert(Ariel1.bmi(76, 1.7) == :obese1)

    test "obese2",
      do: assert(Ariel1.bmi(81, 1.6) == :obese2)

    test "obese3",
      do: assert(Ariel1.bmi(120, 1.6) == :obese3)
  end

  # Recursion

  describe "factorial:" do
    test "factorial(0)",
      do: assert(Ariel1.factorial(0) == 1)

    test "factorial(5)",
      do: assert(Ariel1.factorial(5) == 120)

    test "factorial(120)",
      do:
        assert(
          Ariel1.factorial(40) == 815_915_283_247_897_734_345_611_269_596_115_894_272_000_000_000
        )
  end

  describe "pow:" do
    test "5⁰",
      do: assert(Ariel1.pow(5, 0) == 1)

    test "-5³",
      do: assert(Ariel1.pow(-5, 3) == -125)

    test "15¹²",
      do: assert(Ariel1.pow(15, 12) == 129_746_337_890_625)
  end

  describe "fib:" do
    test "6",
      do: assert(Ariel1.fib(6) == 8)

    test "sequence 0 - 10",
      do:
        assert(
          Enum.map(Enum.to_list(0..10), &Ariel1.fib/1) == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
        )

    test "42",
      do: assert(Ariel1.fib(42) == 267_914_296)
  end

  # Lists

  describe "duplicate:" do
    test "empty list",
      do: assert(Ariel1.duplicate([]) == [])

    test "number list",
      do: assert(Ariel1.duplicate([1, 2, 3, 4, 5]) == [1, 1, 2, 2, 3, 3, 4, 4, 5, 5])

    test "atom list",
      do:
        assert(
          Ariel1.duplicate([:a, :b, :c, :d, :e, :f, :g, :h]) == [
            :a,
            :a,
            :b,
            :b,
            :c,
            :c,
            :d,
            :d,
            :e,
            :e,
            :f,
            :f,
            :g,
            :g,
            :h,
            :h
          ]
        )
  end

  describe "enlist:" do
    test "empty list",
      do: assert(Ariel1.enlist([]) == [])

    test "atom list",
      do: assert(Ariel1.enlist([:a, :b, :c]) == [[:a], [:b], [:c]])

    test "nested lists",
      do: assert(Ariel1.enlist([[1, 2, 3], 4, [5], 7, 8]) == [[[1, 2, 3]], [4], [[5]], [7], [8]])
  end

  describe "positives:" do
    test "empty list",
      do: assert(Ariel1.positives([]) == [])

    test "mixed list",
      do: assert(Ariel1.positives([12, -4, 3, -1, -10, -13, 6, -5]) == [12, 3, 6])

    test "only negatives list",
      do: assert(Ariel1.positives([-4, -1, -10, -13, -5]) == [])

    test "only positives list",
      do: assert(Ariel1.positives([6, 2, 9, 13]) == [6, 2, 9, 13])
  end

  describe "add_list:" do
    test "empty list",
      do: assert(Ariel1.add_list([]) == 0)

    test "small list",
      do: assert(Ariel1.add_list([2, 4, 1, 3]) == 10)

    test "larger list",
      do: assert(Ariel1.add_list([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == 55)
  end

  describe "invert_pairs:" do
    test "empty list",
      do: assert(Ariel1.invert_pairs([]) == [])

    test "single pair list",
      do: assert(Ariel1.invert_pairs([{1, 2}]) == [{2, 1}])

    test "mixed list",
      do:
        assert(
          Ariel1.invert_pairs([{1, 2}, {:a, :b}, {"Monday", "Tuesday"}]) ==
            [{2, 1}, {:b, :a}, {"Tuesday", "Monday"}]
        )

    test "atom-number list",
      do:
        assert(
          Ariel1.invert_pairs([{:a, 1}, {:a, 2}, {:b, 1}, {:b, 2}]) ==
            [{1, :a}, {2, :a}, {1, :b}, {2, :b}]
        )

    test "month-number list",
      do:
        assert(
          Ariel1.invert_pairs([{:January, 1}, {:February, 2}, {:March, 3}]) ==
            [{1, :January}, {2, :February}, {3, :March}]
        )
  end

  describe "is_atom_list:" do
    test "empty list",
      do: assert(Ariel1.is_atom_list([]) == true)

    test "only atoms list",
      do: assert(Ariel1.is_atom_list([:a, :b, :c, :d, :e]) == true)

    test "mixed list",
      do: assert(Ariel1.is_atom_list([:a, :b, :c, :d, 42, :e]) == false)
  end

  describe "swapper:" do
    test "empty list",
      do: assert(Ariel1.swapper([], :a, :b) == [])

    test "no swaps",
      do: assert(Ariel1.swapper([:x, :y, :z], :a, :b) == [:x, :y, :z])

    test "atom list",
      do: assert(Ariel1.swapper([:a, :b, :c, :b, :d], :a, :b) == [:b, :a, :c, :a, :d])

    test "number list",
      do:
        assert(
          Ariel1.swapper([4, 4, 5, 2, 4, 8, 2, 5, 6, 4, 5, 1, 9, 5, 9, 9, 1, 2, 2, 4], 1, 2) == [
            4,
            4,
            5,
            1,
            4,
            8,
            1,
            5,
            6,
            4,
            5,
            2,
            9,
            5,
            9,
            9,
            2,
            1,
            1,
            4
          ]
        )

    test "number list without swaps",
      do:
        assert(
          Ariel1.swapper([4, 3, 4, 9, 9, 3, 3, 3, 9, 9, 7, 9, 3, 7, 8, 7, 8, 4, 5, 6], 1, 2) == [
            4,
            3,
            4,
            9,
            9,
            3,
            3,
            3,
            9,
            9,
            7,
            9,
            3,
            7,
            8,
            7,
            8,
            4,
            5,
            6
          ]
        )

    test "big bang list",
      do:
        assert(
          Ariel1.swapper(
            [
              :soft,
              :kitty,
              :warm,
              :kitty,
              :little,
              :ball,
              :of,
              :fur,
              :happy,
              :kitty,
              :sleepy,
              :kitty,
              :purr,
              :purr,
              :purr
            ],
            :purr,
            :kitty
          ) == [
            :soft,
            :purr,
            :warm,
            :purr,
            :little,
            :ball,
            :of,
            :fur,
            :happy,
            :purr,
            :sleepy,
            :purr,
            :kitty,
            :kitty,
            :kitty
          ]
        )
  end

  describe "dot_product:" do
    test "empty list",
      do: assert(Ariel1.dot_product([], []) == 0)

    test "integer list",
      do: assert(Ariel1.dot_product([1, 2, 3], [4, 5, 6]) == 32)

    test "float list",
      do:
        assert(
          Ariel1.dot_product([1.3, 3.4, 5.7, 9.5, 10.4], [-4.5, 3.0, 1.5, 0.9, 0.0]) == 21.45
        )
  end

  describe "average:" do
    test "empty list",
      do: assert(Ariel1.average([]) == 0)

    test "single item list",
      do: assert(Ariel1.average([4]) == 4)

    test "integer list",
      do: assert(Ariel1.average([5, 6, 1, 6, 0, 1, 2]) == 3)

    test "float list",
      do: assert(Ariel1.average([1.7, 4.5, 0, 2.0, 3.4, 5, 2.5, 2.2, 1.2]) == 2.5)
  end

  describe "std_dev:" do
    test "empty list",
      do: assert(Ariel1.std_dev([]) == 0)

    test "list 1",
      do: assert(Ariel1.std_dev([4, 8, 15, 16, 23, 42]) == 12.315302134607444)

    test "list 2",
      do: assert(Ariel1.std_dev([110, 105, 90, 100, 95]) == 7.0710678118654755)

    test "list 3",
      do:
        assert(
          Ariel1.std_dev([9, 2, 5, 4, 12, 7, 8, 11, 9, 3, 7, 4, 12, 5, 4, 10, 9, 6, 9, 4]) ==
            2.9832867780352594
        )
  end

  describe "replic:" do
    test "empty list",
      do: assert(Ariel1.replic(7, []) == [])

    test "repeat 0 times",
      do: assert(Ariel1.replic(0, [:a, :b, :c]) == [])

    test "repeat 3 single item",
      do: assert(Ariel1.replic(3, [:a]) == [:a, :a, :a])

    test "repeat 4 list",
      do:
        assert(Ariel1.replic(4, [1, 2, 3, 4]) == [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4])
  end

  describe "expand:" do
    test "empty list",
      do: assert(Ariel1.expand([]) == [])

    test "single item",
      do: assert(Ariel1.expand([:a]) == [:a])

    test "integer list",
      do: assert(Ariel1.expand([1, 2, 3, 4]) == [1, 2, 2, 3, 3, 3, 4, 4, 4, 4])

    test "atom list",
      do:
        assert(
          Ariel1.expand([:a, :b, :c, :d, :e]) == [
            :a,
            :b,
            :b,
            :c,
            :c,
            :c,
            :d,
            :d,
            :d,
            :d,
            :e,
            :e,
            :e,
            :e,
            :e
          ]
        )
  end

  describe "binary:" do
    test "zero",
      do: assert(Ariel1.binary(0) == [])

    test "30",
      do: assert(Ariel1.binary(30) == [1, 1, 1, 1, 0])

    test "45123",
      do: assert(Ariel1.binary(45123) == [1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1])
  end
end
