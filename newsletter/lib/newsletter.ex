defmodule Newsletter do
  @moduledoc """
  You're a big model train enthusiast and have decided to share your passion with the world by starting a newsletter.
  You'll start by sending the first issue of your newsletter to your friends and acquaintances that share your hobby.
  You have a text file with a list of their email addresses.
  """

  @doc """
  Reads the given file and returns the emails
  """
  @spec read_emails(String.t()) :: list(String.t())
  def read_emails(path) do
    {:ok, text} = File.read(path);
    String.split(text, "\n", trim: true)
  end

  @doc """
  Takes a file path, open the file for writing, and return the PID of the process that handles the file
  """
  @spec open_log(String.t()) :: pid()
  def open_log(path), do: File.open!(path, [:write])

  @doc """
  Takes a PID of the process that handles the file and a string with the email address.
  It writes the email address to the file, followed by a newline
  """
  @spec log_sent_email(pid(), String.t()) :: atom()
  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  @doc """
  takes a PID of the process that handles the file and close the file.
  """
  @spec close_log(pid()) :: atom()
  def close_log(pid), do: File.close(pid)

  @doc """
  Takes a:

  1. Path of the file with email addresses
  2. Path of a log file
  3. An anonymous function that sends an email to a given email address.

  It reads all the email addresses from the given file and attempt to send an email to every one of them.
  If the anonymous function that sends the email returns :ok then writes the email address to the log file, followed by a new line.
  """
  @spec send_newsletter(String.t(), String.t(), fun(String.t())) :: atom()
  def send_newsletter(emails_path, log_path, send_fun) do
    log_file = open_log(log_path);

    emails_path
    |> read_emails()
    |> Enum.each(fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(log_file, email)
        _ -> :ok
      end
    end)

    close_log(log_file)
  end
end
