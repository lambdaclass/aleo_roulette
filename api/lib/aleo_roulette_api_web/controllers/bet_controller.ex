defmodule AleoRouletteApiWeb.BetController do
  use AleoRouletteApiWeb, :controller
  alias AleoRouletteApi.Bets

  def make(conn, %{"bet_number" => bet_number, "credits" => credits, "spin_number" => spin_number}) do
    bet_make = Bets.Make.new(bet_number, credits)


    File.write!("../circuits/poseidon/inputs/poseidon.in",
      leo_poseidon_input_string(spin_number)
    )

    :os.cmd(:"cd ../circuits/poseidon && leo clean && leo run")

    wait_for_leo_poseidon()

    poseidon_result = File.read!("../circuits/poseidon/outputs/poseidon.out")
      |> String.split("= ")
      |> List.last()
      |> String.split(";")
      |> List.first()

    poseidon_bit_decomposition =
      String.to_integer(poseidon_result)
      |> Integer.to_string(2)
    # Format bit list to Leo Input
    IO.inspect(bit_list_to_leo_input(poseidon_bit_decomposition))

    generate_roulette_leo_input(bet_number,credits,spin_number,poseidon_bit_decomposition)
    :os.cmd(:"cd ../circuits/bets && leo clean && leo run")

    wait_for_leo_poseidon()

    conn
    |> render("make.json", bet_make: poseidon_result)
  end

  def leo_poseidon_input_string(random_seed) do
    "[main]\nfe: field = #{random_seed};\n\n[registers]\nr0: field = 0;\n"
  end

  def bit_list_to_leo_input(bit_list) do
    padded_string = String.pad_leading(bit_list, 254, "0")
    padded_string = Regex.replace(~r/1/,padded_string,"1,")
    padded_string = Regex.replace(~r/0/,padded_string,"0,")
    padded_string = String.slice(padded_string, 0..-2)
    "[" <> padded_string <> "]"
  end

  def bets_to_leo_input(bet_number, credits) do
    bet_number = String.to_integer(bet_number)
    base_string = "[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]"
    String.slice(base_string,0..((bet_number - 1) * 3)) <> credits <>  String.slice(base_string,bet_number * 3 + 1 + String.length(credits)..-1)
  end

  def wait_for_leo_poseidon() do
    :timer.sleep(500)
    case File.stat("../circuits/poseidon/outputs/poseidon.sum") do
      {:enoent, _} -> wait_for_leo_poseidon()
      _ -> ""
    end
  end

  def generate_roulette_leo_input(bet_number, credits, seed, bit_field) do
    file_str = "[main]
bets: [i16; 38] = #{bets_to_leo_input(bet_number,credits)};
rand_bit_field: [field; 254] = #{bit_list_to_leo_input(bit_field)};
rand_seed: field = #{seed};

[registers]
user_earnt_or_lost_credits: i16 = 0;\n"

  File.write!("../circuits/bets/inputs/bets.in",
    file_str
  )
  end
end
