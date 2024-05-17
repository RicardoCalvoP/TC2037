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
    write_html_start("testing.html")

    read_file(file, html_file)

    # Write closure tags and close file
    write_html_end("testing.html")
    # File.close(html_file)
  end

  # -----------------------
  # File functions
  # -----------------------

  # Function yo call to read the calling file line by line
  def read_file(file, html_file) do
    lines = File.stream!(file)

    Enum.map(lines, &find_coincidences(&1))
    # Check elements for future results
    # Save results in list of tuples
    # write_results(html_file, results)
  end

  # Main function to put together  all of the html doc with results
  def write_results(html_file, results) do
    results = Enum.reverse(results)

    formatted_results =
      Enum.reduce(results, "", fn [token, value], acc ->
        if token == "space" do
          acc <> " "
        else
          acc <> "<span id=\"#{token}\">#{value}</span>"
        end
      end)

    results_string = "\n" <> formatted_results

    File.write!(html_file, results_string, [:append])
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
    results = []
    is_reserved_word(line, results)
  end

  # -----------------------
  # Defining rule Functions
  # -----------------------

  # variable "coincidence" is going to be equal to the function Regex.run()
  # this function only searches for the first element that matches with the
  # regular expression, in case of matching is going to be storage in
  # a list like this ["coincidence"]

  # in case of no having a match coincidence value is going to be nil

  # if there is coincidences with the regular expression
  # we save a list of two instances [:token, coincidence]
  # this list is going to be saved in a list of lists called results

  # else if the string (line) is empty, is going to print the results
  # in the html file

  # else if there si no coincidences, it is going to skip to the next category

  # --------------------------------------------------------------------------------------------
  # Reserved word Function
  # --------------------------------------------------------------------------------------------

  def is_reserved_word(string, results) do
    coincidence = Regex.run(~r/^(defmodule|def|defp|do|end|false|true|cond|case)/, string)

    cond do
      coincidence ->
        results = [["reserved_word", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_func(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Function Function
  # --------------------------------------------------------------------------------------------

  def is_func(string, results) do
    coincidence = Regex.run(~r/^[a-z]\w*(\!+)?(?=\()/, string)

    cond do
      coincidence ->
        results = [["function", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_variable(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Variable Function
  # --------------------------------------------------------------------------------------------

  def is_variable(string, results) do
    coincidence = Regex.run(~r/^[a-z]\w*/, string)

    cond do
      coincidence ->
        results = [["variable", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_comment(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Comment Function
  # --------------------------------------------------------------------------------------------

  def is_comment(string, results) do
    coincidence = Regex.run(~r/^\#.*/, string)

    cond do
      coincidence ->
        results = [["comment", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_module(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Module Function
  # --------------------------------------------------------------------------------------------

  def is_module(string, results) do
    coincidence = Regex.run(~r/^[A-Z]\w*/, string)

    cond do
      coincidence ->
        results = [["module", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_string(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # String Function
  # --------------------------------------------------------------------------------------------

  def is_string(string, results) do
    coincidence = Regex.run(~r/^\".*\"/, string)

    cond do
      coincidence ->
        results = [["string", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_number(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Number Function
  # --------------------------------------------------------------------------------------------

  def is_number(string, results) do
    coincidence = Regex.run(~r/^\d+(\.\d+)?/, string)

    cond do
      coincidence ->
        results = [["number", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_operator(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Operator Function
  # --------------------------------------------------------------------------------------------

  def is_operator(string, results) do
    coincidence = Regex.run(~r/^(\+|\-|\*|\/|\=|\==|\===|\!=|\.|\,|\|>|\->|\&|\<|\>|\<>)/, string)

    cond do
      coincidence ->
        results = [["operator", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_atoms(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Atom Function
  # --------------------------------------------------------------------------------------------

  def is_atoms(string, results) do
    coincidence = Regex.run(~r/^\:\w+/, string)

    cond do
      coincidence ->
        results = [["atom", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_container(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Container  Function
  # --------------------------------------------------------------------------------------------

  def is_container(string, results) do
    coincidence = Regex.run(~r/^[\(\)\{\}\[\]]/, string)

    cond do
      coincidence ->
        results = [["container", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_regular_expression(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Regular Expression Function
  # --------------------------------------------------------------------------------------------

  def is_regular_expression(string, results) do
    coincidence = Regex.run(~r/^\~r.+\//, string)

    cond do
      coincidence ->
        results = [["regular_expression", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        is_space(string, results)
    end
  end

  # --------------------------------------------------------------------------------------------
  # Space Function
  # --------------------------------------------------------------------------------------------
  def is_space(string, results) do
    coincidence = Regex.run(~r/^\s/, string)

    cond do
      coincidence ->
        results = [["space", hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        is_reserved_word(elem(new_string, 1), results)

      string == "" ->
        write_results("testing.html", results)

      true ->
        new_string = String.split_at(string, 1)
        is_reserved_word(elem(new_string, 1), results)
    end
  end
end
