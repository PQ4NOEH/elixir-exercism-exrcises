defmodule Username do
  @moduledoc """
  sanitized aliases for all email accounts
  """
  @moduledoc since: "1.0.0"

  @allowed_characters 'abcdefghijklmnopqrstuvwxyz_ßäöü'

  @doc"""
  Sanitize email address
  """
  @spec sanitize(CharList.t()) :: String.t()
  def sanitize(username) do
    Enum.reduce( username, '', fn c, acc ->
      acc ++ case c do
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
        c when c not in @allowed_characters -> ''
        _ -> [c]
      end
    end )
  end
end
