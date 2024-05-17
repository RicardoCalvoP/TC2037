# Ricardo Calvo Perez
# 05/2024

# This code is for elixir

defmodule Project do
  # -----------------------
  # Main Function
  # -----------------------

  def convert_file(file) do
    # Create a new name based on the called file but changed extensions from .ex to .html
    html_file = String.replace(file, ~r/\.\w+$/, ".html")
    # Create & Write top html file
    write_html_start(html_file)

    # read_file(file)

    # Write closure tags and close file
    write_html_end(html_file)
    File.close(html_file)
  end

  # -----------------------
  # File functions
  # -----------------------

  # Function yo call to read the calling file line by line
  def read_file(file, html_file) do
    lines = File.stream!(file)
    #
    # Results are going to be list of tuples [{token, result}]
    # Enum.map(lines, &find_coincidences(&1, []))
    # Check elements for future results
    # Save results in list of tuples
    # write_results(html_file, results)
  end

  # Main function to put together  all of the html doc with results
  def write_results(html_file, results) do
    File.write!(html_file, results, [:append])
  end

  # Function to write the beginning of html structure
  def write_html_start(file) do
    File.write!(file, """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Resultados</title>
    </head>
    <body>
    """)
  end

  # Function to write closure tags of html structure
  def write_html_end(file_name) do
    File.write!(
      file_name,
      """
      </body>
      </html>
      """,
      [:append]
    )
  end

  # --------------------------------
  # Finding coincidences  Functions
  # --------------------------------

  def find_coincidences(line) do
    result = []
    is_reserved_word(line, result)
    # is_variable(line)
    # is_comment(line)
    # is_string(line)
    # is_operator(line)
  end

  # -----------------------
  # Defining rule Functions
  # -----------------------

  def is_reserved_word(string, result) do
    coincidence = Regex.run(~r/^(defmodule|def|defp|do|end|false|true|cond|case)/, string)

    cond do
      coincidence ->
        result = [[:reserved_word, hd(coincidence)] | result]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), result)

      string == "" ->
        result

      true ->
        is_func(string, result)
    end
  end

  def is_func(string, result) do
    coincidence = Regex.run(~r/^[a-z]\w*\((\w*(\,\s(\w*|\d*))*?)*?\)/, string)

    cond do
      coincidence ->
        result = [[:function, hd(coincidence)] | result]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), result)

      string == "" ->
        result

      true ->
        is_variable(string, result)
    end
  end

  def is_variable(string, result) do
    coincidence = Regex.run(~r/^[a-z]\w*/, string)

    cond do
      coincidence ->
        result = [[:variable, hd(coincidence)] | result]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), result)

      string == "" ->
        result

      true ->
        new_string = String.split_at(string, 1)
        is_space(string, result)
    end
  end

  # def is_comment(string), do: Regex.scan(~r/s?\#.*/, string)

  # def is_string(string), do: Enum.map(&Regex.scan(~r/\".*\"/, &1))

  # def is_operator(string),
  # do: Enum.map(&Regex.scan(~r/\+|\-|\*|\/|\=|\==|\===|\!=|\.|\,|\|>|\->|\&/, &1))

  # def is_module(string), do: Enum.map(&Regex.scan(~r/s?\:\w+/, &1))

  # def is_container(string), do: Enum.map(&Regex.scan(~r/\(|\)|\{|\}|\[|\]/, &1))

  # def is_regular_expression(string), do: Enum.map(&Regex.scan(~r/\~r.*\//, &1))

  def is_space(string, result) do
    coincidence = Regex.run(~r/^\s/, string)

    cond do
      coincidence ->
        result = [[:space, hd(coincidence)] | result]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), result)

      string == "" ->
        result

      true ->
        new_string = String.split_at(string, 1)
        is_reserved_word(elem(new_string, 1), result)
    end
  end
end
