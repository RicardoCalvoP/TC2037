# Activity 3.2 Programming a DFA

# Ricardo Calvo
# 04/2024

defmodule Hw.TokenList do
  def arithmetic_lexer(string) do
    string
    |> String.graphemes()
    |> eval_dfa(
      {&Hw.TokenList.delta_valid_number/2, [:int, :float, :exp, :var, :close_par], :start},
      []
    )
  end

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

  # Automaton Function

  def delta_valid_number(state, char) do
    case state do
      :start ->
        cond do
          is_var(char) -> [:var, false]
          is_sign(char) -> [:sign, false]
          is_digit(char) -> [:int, false]
          char === "(" -> [:open, false]
          true -> [:fail, false]
        end

      :var ->
        cond do
          is_var(char) -> [:var, false]
          is_digit(char) -> [:var, false]
          is_operator(char) -> [:op, :var]
          char === "=" -> [:asign, :var]
          true -> [:fail, false]
        end

      :asign ->
        cond do
          is_var(char) -> [:var, :asign]
          is_digit(char) -> [:int, :asign]
          is_sign(char) -> [:sign, :asign]
          true -> [:fail, false]
        end

      :sign ->
        cond do
          is_digit(char) -> [:int, false]
          true -> [:fail, false]
        end

      :op ->
        cond do
          is_var(char) -> [:var, :op]
          is_digit(char) -> [:int, :op]
          is_sign(char) -> [:sign, :op]
          char === "(" -> [:open, :op]
          true -> [:fail, false]
        end

      :int ->
        cond do
          is_digit(char) -> [:int, false]
          is_power(char) -> [:pow, false]
          is_operator(char) -> [:op, :int]
          char === ")" -> [:close_par, :int]
          char === "." -> [:dot, false]
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
          is_power(char) -> [:pow, false]
          char === ")" -> [:close_par, false]
          true -> [:fail, false]
        end

      :pow ->
        cond do
          is_digit(char) -> [:exp, false]
          is_sign(char) -> [:pow_sign, false]
          true -> [:fail, false]
        end

      :pow_sign ->
        cond do
          is_digit(char) -> [:exp, false]
          true -> [:fail, false]
        end

      :exp ->
        cond do
          is_digit(char) -> [:exp, false]
          is_operator(char) -> [:op, :exp]
          char === ")" -> [:close_par, :exp]
          true -> [:fail, false]
        end

      :open ->
        cond do
          is_digit(char) -> [:int, :open_par]
          is_var(char) -> [:var, :open_par]
          is_sign(char) -> [:sign, :open_par]
          true -> [:fail, false]
        end

      :close_par ->
        cond do
          is_operator(char) -> [:op, :close_par]
          true -> [:fail, false]
        end

      :fail ->
        [:fail, false]
    end
  end

  # -----------------------
  # Defining rule Functions
  # -----------------------

  def is_var(char) do
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz"
    |> String.graphemes()
    |> Enum.member?(char)
  end

  def is_digit(char) do
    "0123456789"
    |> String.graphemes()
    |> Enum.member?(char)
  end

  def is_sign(char) do
    Enum.member?(["+", "-"], char)
  end

  def is_operator(char) do
    "+-*/%"
    |> String.graphemes()
    |> Enum.member?(char)
  end

  def is_power(char) do
    Enum.member?(["E", "e"], char)
  end
end
