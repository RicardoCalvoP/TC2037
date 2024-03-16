# Module with functions to define languages recursively

# Ricardo Calvo
# 03/2024

defmodule Hw.Langs.Rec do
  def generate(iters, base, rules), do: do_generate(iters, rules, [base])

  defp do_generate(0, _, result), do: Enum.reverse(result)

  defp do_generate(iters, rules, [strings | rest]),
    do: do_generate(iters - 1, rules, [iterate_strings(strings, rules), strings | rest])

  def iterate_strings(strings, rules), do: do_iterate_strings(strings, rules, [])

  defp do_iterate_strings([], _, result), do: List.flatten(result)

  defp do_iterate_strings([string | rest], rules, result),
    do: do_iterate_strings(rest, rules, [apply_rules(string, rules) | result])

  def apply_rules(string, rules), do: do_apply_rules(string, rules, [])

  defp do_apply_rules(_, [], result), do: result

  defp do_apply_rules(string, [rule | rest], result),
    do: do_apply_rules(string, rest, [apply_rule(string, rule) | result])

  def apply_rule(string, rule), do: String.replace(rule, "u", string)
end
