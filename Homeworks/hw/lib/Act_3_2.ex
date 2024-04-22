# Activity 3.2 Programming a DFA

# Ricardo Calvo
# 04/2024

defmodule TokenList do
  def arithmetic_lexer(string) do
    string
    |> String.graphemes()
    |> eval_dfa(automata)
  end

  def eval_dfa([], {_delta, accept, state}) do
    binding() |> IO.inspect()
    Enum.member?(accept, state)
  end

  def eval_dfa([char | tail], {delta, accept, state}) do
    binding() |> IO.inspect()
    new_state = delta.(state, char)
    eval_dfa(tail, {delta, accept, new_state})
  end

  # Automaton Function

  def delta_valid_number(state, char) do
    case state do
    end
  end
end
