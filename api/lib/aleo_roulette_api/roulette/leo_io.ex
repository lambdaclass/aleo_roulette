defmodule AleoRouletteApi.Roulette.LeoIO do
  def bit_list_to_leo_input(bit_list) do
    padded_string = String.pad_leading(bit_list, 254, "0")
    padded_string = Regex.replace(~r/1/, padded_string, "1,")
    padded_string = Regex.replace(~r/0/, padded_string, "0,")
    padded_string = String.slice(padded_string, 0..-2)
    "[" <> padded_string <> "]"
  end

  def bets_to_leo_input(bet_number, credits) do
    bet_number = String.to_integer(bet_number)

    base_string =
      "[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]"

    String.slice(base_string, 0..((bet_number - 1) * 3)) <>
      credits <> String.slice(base_string, (bet_number * 3 + 1 + String.length(credits))..-1)
  end

  def wait_for_leo_poseidon() do
    :timer.sleep(500)

    case File.stat("../circuits/poseidon_leo/outputs/poseidon.sum") do
      {:error, _} -> wait_for_leo_poseidon()
      _ -> ""
    end
  end

  @spec wait_for_leo_roulette :: <<>>
  def wait_for_leo_roulette() do
    :timer.sleep(500)

    case File.stat("../circuits/bets_leo/outputs/bets.sum") do
      {:error, _} -> wait_for_leo_roulette()
      _ -> ""
    end
  end

  def generate_roulette_leo_input(bet_number, credits, seed, bit_field) do
    file_str = "[main]
  bets: [i16; 37] = #{bets_to_leo_input(bet_number, credits)};
  rand_bit_field: [field; 254] = #{bit_list_to_leo_input(bit_field)};
  rand_seed: field = #{seed};

  [registers]
  user_earnt_or_lost_credits: i16 = 0;\n"

    File.write!(
      "../circuits/bets_leo/inputs/bets.in",
      file_str
    )
  end

  def generate_poseidon_leo_input(random_seed) do
    File.write!(
      "../circuits/poseidon_leo/inputs/poseidon.in",
      "[main]\nfe: field = #{random_seed};\n\n[registers]\nr0: field = 0;\n"
    )
  end

  def read_poseidon_output() do
    File.read!("../circuits/poseidon_leo/outputs/poseidon.out")
    |> String.split("= ")
    |> List.last()
    |> String.split(";")
    |> List.first()
  end
end
