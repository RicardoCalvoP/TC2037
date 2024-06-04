# Project.convert_file("main.ex")
# Project.convert_folder("ToReadElxirFiles")

defmodule Project do
  # Converts a single file into a new HTML file
  def convert_file(input_file) do
    html_address = "HTML_Results/"
    File.mkdir_p!(html_address)

    html_file_name = String.replace(input_file, ~r/\.\w+$/, ".html")
    html_file = Path.join(html_address, html_file_name)
    write_html_start(html_file, html_file_name)

    input_file_folder = "ToReadElxirFiles/"
    file = Path.join(input_file_folder, input_file)

    read_file(file, html_file)
    write_html_end(html_file)
  end

  # Converts all Elixir files in a folder into different HTML files
  def convert_folder(folder) do
    case File.ls(folder) do
      {:ok, files} ->
        files
        |> Enum.map(&Task.async(fn -> do_convert_file(&1, folder) end))
        |> Enum.map(&Task.await(&1))

      {:error, reason} ->
        IO.puts("Error reading folder: #{reason}")
    end
  end

  defp do_convert_file(folder_file, folder) do
    # Folder where HTML results will be saved
    html_address = "HTML_Results/"
    # Ensure HTML results folder exists
    File.mkdir_p!(html_address)

    # Create a new name based on the called file but changed extensions from .ex to .html
    html_file_name = String.replace(folder_file, ~r/\.\w+$/, ".html")
    # Full path for the output HTML file
    html_file = Path.join(html_address, html_file_name)
    # Create & write top HTML file
    write_html_start(html_file, html_file_name)

    # Full path to the input file
    file = Path.join(folder, folder_file)

    read_file(file, html_file)

    # Write closure tags and close file
    write_html_end(html_file)
  end

  # Reads the input file line by line
  def read_file(file, html_file) do
    lines = File.stream!(file)

    token_list = [
      {"reserved_word",
       ~r/^(defmodule|defp|def|do|end|false|true|cond|case|when|if|else|for|fn|nil)(?=\s)/},
      {"function", ~r/^[a-z]\w*(\!+|\?+)?(?=\()/},
      {"unused_variable", ~r/^\_[a-z]\w*(\d)*?(\:+)?/},
      {"variable", ~r/^[a-z]\w*(\d)*?(\:+)?/},
      {"comment", ~r/^\#.*/},
      {"module", ~r/^[A-Z]\w*(\d)*?/},
      {"attribute", ~r/^\@\w*/},
      {"string", ~r/^\".*\"/},
      {"number", ~r/^\d+(\.\d+)?/},
      {"operator", ~r/^(\+|\-|\*|\/|\=|==|===|!=|\.|\,|\||\|>|\->|\&|\<>|\<|\>|\::)/},
      {"atom", ~r/^\:\w+(\d)*?/},
      {"container", ~r/^[\(\)\{\}\[\]]/},
      {"regular_expression", ~r/^\~r.+\//},
      {"space", ~r/^\s/},
      {"unknown", ~r/^[^\s]+/}
    ]

    Enum.each(lines, &find_coincidences(token_list, token_list, [], html_file, &1))
  end

  def write_results(html_file, results) do
    results = Enum.reverse(results)

    formatted_results =
      Enum.reduce(results, "", fn [token, value], acc ->
        if token == "space" do
          acc <> " "
        else
          acc <> "<span class=\"#{token}\">#{value}</span>"
        end
      end)

    results_string = formatted_results <> " \n"
    File.write!(html_file, results_string, [:append])
  end

  def write_html_start(html_file, name) do
    File.write!(html_file, """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" href="CSS/style.css">
      <title>#{name}</title>
    </head>
    <body>
    <pre>
    """)
  end

  def write_html_end(html_file) do
    File.write!(
      html_file,
      """
      </pre>
      </body>
      </html>
      """,
      [:append]
    )
  end

  def find_coincidences(
        [{token, regex} | tail],
        token_list,
        results,
        html_file,
        string
      ) do
    coincidence = Regex.run(regex, string)

    cond do
      coincidence ->
        cond do
          token == "operator" ->
            coincidence =
              case hd(coincidence) do
                "<" -> "&lt;"
                ">" -> "&gt;"
                "&" -> "&amp;"
                other -> other
              end

          true ->
            nil
        end

        results = [[token, hd(coincidence)] | results]
        new_string = String.split_at(string, String.length(hd(coincidence)))
        find_coincidences(token_list, token_list, results, html_file, elem(new_string, 1))

      string == "" ->
        write_results(html_file, results)

      true ->
        find_coincidences(tail, token_list, results, html_file, string)
    end
  end
end
