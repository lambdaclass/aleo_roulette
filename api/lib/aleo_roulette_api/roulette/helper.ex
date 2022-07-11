defmodule AleoRouletteApi.Roulette.Helper do

  def poseidon_hash_to_bit_string(poseidon_hash) do
    String.to_integer(poseidon_hash)
    |> Integer.to_string(2)
  end

end
