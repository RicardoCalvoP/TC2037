defmodule Read do
  def find_emails(file) do
    big_String = read_file(file)

    emails = Regex.scan(~r/\w+@+\w+\.+\w{2,4}/, big_String)
    write_file(emails)
  end

  def read_file(file), do: File.read!(file)

  defp write_file(emails) do
    File.write!("list_of_mails.txt", Enum.join(emails, "\n"))
    read_file("list_of_mails.txt")
  end
end
