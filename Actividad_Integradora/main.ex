# Project.convert_file("main.ex")
# Project.convert_folder("ToReadElxirFiles")
# Project.convert_folder_parallel("ToReadElxirFiles")

defmodule Project do
  # Converts all Elixir files in a folder into different HTML files

  # Using threads
  def convert_folder_parallel(folder, threads \\ 8) do
    File.ls!(folder)
    |> Enum.map(&Task.async(fn -> convert_file(&1, folder) end))
    |> Enum.map(&Task.await(&1, :infinity))
  end

  # Not using threads
  def convert_folder(folder) do
    File.ls!(folder)
    |> Enum.map(&convert_file(&1, folder))
  end

  # Checking time

  def calc_time(function, args) do
    {time, function} = :timer.tc(function, args)
    time / 1_000_000
  end

  # Converts a single file into a new HTML file
  def convert_file(folder_file, folder \\ "ToReadElxirFiles/") do
    # Folder where HTML results will be saved
    # IO.inspect("Proccesing file: #{folder_file}")
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

    results = Enum.map(lines, &find_coincidences(token_list, token_list, [], &1))
    {:ok, out_fd} = File.open(html_file, [:write, :append])

    separate_results(out_fd, results)
    File.close(out_fd)
  end

  def separate_results(out_fd, [head | tail]) do
    write_results(out_fd, head)
    separate_results(out_fd, tail)
  end

  def separate_results(out_fd, []), do: :ok

  def write_results(out_fd, results) do
    results = Enum.reverse(results)

    formatted_results =
      Enum.reduce(results, "", fn [token, value], acc ->
        if token == "space" do
          acc <> " "
        else
          acc <> "<span class=\"#{token}\">#{value}</span>"
        end
      end)

    IO.puts(out_fd, formatted_results)
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
        find_coincidences(token_list, token_list, results, elem(new_string, 1))

      string == "" ->
        results

      true ->
        find_coincidences(tail, token_list, results, string)
    end
  end
end
