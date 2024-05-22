# Reading and writing into files with Elixir
# Also using regular expressions
#
# Gilberto Echeverria
# 2024-04-30

defmodule Tfile do

  @doc """
  Function to extract all the emails found in a text file.
  Will scan every line individually.
  Arguments:
  - in_filename : the name of the file to read
  - out_filename : the name of a new file where emails will be stores, one in each line
  Returns:
  - :ok
  - As a side effect, a new file is created
  """
  @spec get_emails(String.t(), String.t()) :: :ok
  def get_emails(in_filename, out_filename) do

    # Prepare the file to write the results
    {:ok, out_fd} = File.open(out_filename, [:write])

    # Start with the filename
    in_filename
    # Open the file to read it line by line
    |> File.stream!()
    # Scan each line to find email addresses
    #|> Enum.map(&Regex.scan(~r/\w+@\w+\.\w{2,4}/, &1))
    # Another syntax for the anonymous function to the map
    #|> Enum.map(fn line -> Regex.scan(~r/\w+@\w+\.\w{2,4}/, line) end)
    # Using a named function instead
    |> Enum.map(&find_email(&1))
    |> IO.inspect(label: "After scan")
    # Eliminate lines without an email
    |> Enum.filter(&(&1 != []))
    |> IO.inspect(label: "After filter")
    # Remove the lists containing the emails
    |> Enum.map(&hd/1)
    |> Enum.map(&hd/1)
    |> IO.inspect(label: "After getting the heads of the lists")
    # Write each line to the file
    |> Enum.map(&IO.puts(out_fd, &1))

    File.close(out_fd)
  end

  @doc """
  Function to look for an email address inside a string
  Arguments:
  - line : a string
  Returns:
  - A list, either empty if no matches were found, or containing lists of matches
  """
  @spec find_email(String.t()) :: List
  def find_email(line) do
    IO.inspect(line, label: "Processing line")
    Regex.scan(~r/\w+@\w+\.\w{2,4}/, line)
  end

end

# Code to read a single command line argument
[in_filename] = System.argv()
# Create the name of the output file
# Add the string "-emails" before the file extension
out_filename = String.replace(in_filename, ~r/(\.\w+$)/, "-emails\\1")
# Call the function to find emails
Tfile.get_emails(in_filename, out_filename)

# Now the program can be called as:
# elixir 07_file_io.exs loren_emails.txt
