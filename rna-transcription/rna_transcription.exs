defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    map = dna_rna_map();
    [dna]
    |> Enum.map(&(map[&1]) )
    |> Enum.join("")
    |> to_char_list
  end
  defp dna_rna_map(), do:  %{'A' => 'U', 'C' => 'G', 'T' => 'A', 'G' => 'C'}
end
