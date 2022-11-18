defmodule FileSniffer do
  @moduledoc """
  verify files matches its media types
  """

  @doc """
  Match file extension to media mime type

  ## EXAMPLES
      iex> FileSniffer.type_from_extension("png")
      "image/png"
  """
  @spec type_from_extension(String.t()) :: String.t()
  def type_from_extension("exe"),  do: "application/octet-stream"
  def type_from_extension("bmp"),  do: "image/bmp"
  def type_from_extension("png"),  do: "image/png"
  def type_from_extension("jpg"),  do: "image/jpg"
  def type_from_extension("gif"),  do: "image/gif"
  def type_from_extension(_),  do: nil

  @doc """
  Match file binary to media mime type

  ## EXAMPLES

      iex> FileSniffer.type_from_binary(<<>>)
      nil

      iex> FileSniffer.type_from_binary(<<0x42, 0x4D, 0x0D>>)
      "image/bmp"
  """
  @spec type_from_binary(bitstring()) :: String.t()
  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _ :: bitstring>>), do: type_from_extension("exe")
  def type_from_binary(<<0x42, 0x4D, _ :: bitstring>>), do: type_from_extension("bmp")
  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _ :: bitstring>>), do: type_from_extension("png")
  def type_from_binary(<<0xFF, 0xD8, 0xFF, _ :: bitstring>>), do: type_from_extension("jpg")
  def type_from_binary(<<0x47, 0x49, 0x46, _ :: bitstring>>), do: type_from_extension("gif")
  def type_from_binary(_), do: type_from_extension("");

  @doc """
  Takes a file (binary) and extension (string) and return an :ok or :error tuple

  ## EXAMPLES

      iex> FileSniffer.type_from_binary(<<0x42, 0x4D, 0x0D>>, "gif")
      {:error, "Warning, file format and file extension do not match."}

      iex> FileSniffer.type_from_binary(<<0x42, 0x4D, 0x0D>>, "bmp")
      {:ok, "image/bmp"}
  """
  @spec verify(bitstring(), String.t()) :: {atom(), String.t()}
  def verify(file_binary, extension) do
    expected_mime_media = type_from_extension(extension)
    case type_from_binary(file_binary) do
      ^expected_mime_media -> {:ok, expected_mime_media}
      _ -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end
