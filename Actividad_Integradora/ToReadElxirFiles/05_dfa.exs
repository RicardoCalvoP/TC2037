# Basic implementation of Finite Automatons
#
# An Automaton is defined as:
# M = (Q, \Sigma, \delta, F, q_0)
#
# Gilberto Echeverria
# 2024-04-16

defmodule DFA do

  # The automatas can be defined as variables in IEX
  # auto_exam = {&DFA.delta_contains_db/2, [:q2, :q4], :q0}
  # auto_arithmetic = {&DFA.delta_arithmetic/2, [:int, :float], :start}

  @doc """
  Entry frunction to evaluate a string with a given automata
  The automata argument is expressed as:
  {delta, accept, q0}
  """
  def evaluate_1(string, automata) do
    string
    # Split the string into a list of characters
    |> String.graphemes()
    |> eval_dfa(automata)
  end

  @doc """
  Recursive function to follow the state transitions for each of the characters in the list
  If the final state is in the accept state list, the string is accepted
  """
  def eval_dfa([], {_delta, accept, state}) do
    #binding() |> IO.inspect()
    Enum.member?(accept, state)
  end
  def eval_dfa([char | tail], {delta, accept, state}) do
    #binding() |> IO.inspect()
    new_state = delta.(state, char)
    eval_dfa(tail, {delta, accept, new_state})
  end


  @doc """
  Transition function to recognize strings that contain "db" and where "ad" is invalid
  Valid states are:
  - :q2
  - :q4
  """
  def delta_contains_db(state, char) do
    case state do
      :q0 -> case char do
        "a" -> :q3
        "b" -> :q0
        "c" -> :q0
        "d" -> :q1
      end
      :q1 -> case char do
        "a" -> :q3
        "b" -> :q2
        "c" -> :q0
        "d" -> :q1
      end
      :q2 -> case char do
        "a" -> :q4
        "b" -> :q2
        "c" -> :q2
        "d" -> :q2
      end
      :q3 -> case char do
        "a" -> :q3
        "b" -> :q0
        "c" -> :q0
        "d" -> :q5
      end
      :q4 -> case char do
        "a" -> :q4
        "b" -> :q2
        "c" -> :q2
        "d" -> :q5
      end
      :q5 -> :q5
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
      :start -> cond do
        is_sign(char) -> :sign
        is_digit(char) -> :int
        true -> :fail
      end
      :int -> cond do
        is_digit(char) -> :int
        is_operator(char) -> :op
        char == "." -> :dot
        true -> :fail
      end
      :dot -> cond do
        is_digit(char) -> :float
        true -> :fail
      end
      :float -> cond do
        is_digit(char) -> :float
        is_operator(char) -> :op
        true -> :fail
      end
      :op -> cond do
        is_sign(char) -> :sign
        is_digit(char) -> :int
        true -> :fail
      end
      :sign -> cond do
        is_digit(char) -> :int
        true -> :fail
      end
      :fail -> :fail
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
