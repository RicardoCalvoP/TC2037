# Activity 3.2 Programming a DFA

# Ricardo Calvo
# 04/2024

defmodule Hw.TokenList do
  def arithmetic_lexer(string) do
    string
    |> String.graphemes()
    |> eval_dfa(
      {&Hw.TokenList.delta_valid_number/2, [:int, :float, :exp, :var, :close_par], :start},
      [],
      []
    )
  end

  def eval_dfa([], {_delta, accept, state}, tokens, entity) do
    # binding() |> IO.inspect()

    cond do
      Enum.member?(accept, state) ->
        rev_entyty = Enum.reverse(entity)

        string_entity = Enum.join(rev_entyty)
        Enum.reverse([{state, string_entity} | tokens])

      true ->
        false
    end
  end

  def eval_dfa([char | tail], {delta, accept, state}, tokens, entity) do
    # binding() |> IO.inspect()
    [new_state, found] = delta.(state, char)

    cond do
      found ->
        rev_entyty = Enum.reverse(entity)

        string_entity = Enum.join(rev_entyty)
        eval_dfa(tail, {delta, accept, new_state}, [{found, string_entity} | tokens], [char])

      char == " " ->
        eval_dfa(tail, {delta, accept, new_state}, tokens, entity)

      true ->
        eval_dfa(tail, {delta, accept, new_state}, tokens, [char | entity])
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
          is_space(char) -> [:start, false]
          char === "(" -> [:open, false]
          true -> [:fail, false]
        end

      :var ->
        cond do
          is_var(char) -> [:var, false]
          is_digit(char) -> [:var, false]
          is_operator(char) -> [:op, :var]
          is_space(char) -> [:space, :var]
          char === "=" -> [:asign, :var]
          true -> [:fail, false]
        end

      :asign ->
        cond do
          is_var(char) -> [:var, :asign]
          is_digit(char) -> [:int, :asign]
          is_sign(char) -> [:sign, :asign]
          is_space(char) -> [:asign, false]
          true -> [:fail, false]
        end

      :sign ->
        cond do
          is_digit(char) -> [:int, false]
          is_space(char) -> [:sign, false]
          true -> [:fail, false]
        end

      :op ->
        cond do
          is_var(char) -> [:var, :op]
          is_digit(char) -> [:int, :op]
          is_sign(char) -> [:sign, :op]
          is_space(char) -> [:space_op, :op]
          char === "(" -> [:open, :op]
          true -> [:fail, false]
        end

      :int ->
        cond do
          is_digit(char) -> [:int, false]
          is_power(char) -> [:pow, false]
          is_operator(char) -> [:op, :int]
          is_space(char) -> [:space, :int]
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
          is_space(char) -> [:space, :float]
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
          is_space(char) -> [:space, :exp]
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

      :space ->
        cond do
          is_operator(char) -> [:op, false]
          true -> [:fail, false]
        end

      :space_op ->
        cond do
          is_var(char) -> [:var, false]
          is_digit(char) -> [:int, false]
          is_sign(char) -> [:sign, false]
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

  def is_space(char) do
    Enum.member?([" "], char)
  end
end
