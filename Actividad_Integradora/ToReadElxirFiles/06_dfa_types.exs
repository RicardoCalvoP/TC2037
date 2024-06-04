# Basic implementation of Finite Automatons
# Returns a list of the types of tokens identified
#
# An Automaton is defined as:
# M = (Q, \Sigma, \delta, F, q_0)
#
# Gilberto Echeverria
# 2024-04-23

defmodule DFA do
  @doc """
  Entry frunction to evaluate a string with a given automata
  The automata argument is expressed as:
  {delta, accept, q0}
  """
  def arithmetic_lexer(string) do
    # Hardcode the automata to use for parsing
    # The list of accept states must be updates when the delta function changes
    automata = {&DFA.delta_arithmetic/2, [:int, :float], :start}

    string
    # Split the string into a list of characters
    |> String.graphemes()
    |> eval_dfa(automata, [])
  end

  @doc """
  Recursive function to follow the state transitions for each of the characters in the list
  If the final state is in the accept state list, the string is accepted
  """
  def eval_dfa([], {_delta, accept, state}, tokens) do
    # binding() |> IO.inspect()
    cond do
      Enum.member?(accept, state) -> Enum.reverse([state | tokens])
      true -> false
    end
  end

  def eval_dfa([char | tail], {delta, accept, state}, tokens) do
    # binding() |> IO.inspect()
    [new_state, found] = delta.(state, char)

    cond do
      found -> eval_dfa(tail, {delta, accept, new_state}, [found | tokens])
      true -> eval_dfa(tail, {delta, accept, new_state}, tokens)
    end
  end

  @doc """
  Transition function to recognize valid arithmetic expressions
  Valid states are:
  - :int
  - :float
  """
  def delta_arithmetic(state, char) do
    case state do
      :start ->
        cond do
          is_sign(char) -> [:sign, false]
          is_digit(char) -> [:int, false]
          true -> [:fail, false]
        end

      :int ->
        cond do
          is_digit(char) -> [:int, false]
          is_operator(char) -> [:op, :int]
          char == "." -> [:dot, false]
          true -> [:fail, false]
        end

      :dot ->
        cond do
          is_digit(char) -> [:float, false]
          true -> [:fail, false]
        end

      :float ->
        cond do
          is_digit(char) -> [:float, false]
          is_operator(char) -> [:op, :float]
          true -> [:fail, false]
        end

      :op ->
        cond do
          is_sign(char) -> [:sign, :op]
          is_digit(char) -> [:int, :op]
          true -> [:fail, false]
        end

      :sign ->
        cond do
          is_digit(char) -> [:int, false]
          true -> [:fail, false]
        end

      :fail ->
        [:fail, false]
    end
  end

  @doc """
  Helper function to identify characters that represent digits
  """
  def is_digit(char) do
    "0123456789"
    |> String.graphemes()
    |> Enum.member?(char)
  end

  def is_alpha(char) do
    lowercase = ?a..?z |> Enum.map(&<<&1::utf8>>)
    uppercase = ?A..?Z |> Enum.map(&<<&1::utf8>>)
    Enum.member?(lowercase ++ uppercase, char)
  end

  @doc """
  Helper function to identify characters that represent positive or negative signs for numbers
  """
  def is_sign(char) do
    Enum.member?(["+", "-"], char)
  end

  @doc """
  Helper function to identify characters that represent arithmetic operators
  """
  def is_operator(char) do
    Enum.member?(["+", "-", "*", "/", "%", "^", "="], char)
  end
end
