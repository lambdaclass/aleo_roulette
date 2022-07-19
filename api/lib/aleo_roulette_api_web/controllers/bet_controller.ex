defmodule AleoRouletteApiWeb.BetController do
  use AleoRouletteApiWeb, :controller
  alias AleoRouletteApi.Roulette.AleoIO
  alias AleoRouletteApi.Roulette.LeoIO
  alias AleoRouletteApi.Roulette.Model
  alias AleoRouletteApi.Roulette.Helper

  def make_with_aleo(conn, %{
        "bet_number" => bet_number,
        "credits" => credits,
        "spin_number" => spin_number
      }) do
    psd_hash = AleoIO.gen_poseidon_hash(5)
    IO.inspect(psd_hash)

    conn
    |> render("make.json", spin_result: "", new_balance: "")
  end

  def make_with_leo(conn, %{
        "bet_number" => bet_number,
        "credits" => credits,
        "spin_number" => spin_number
      }) do
    LeoIO.generate_poseidon_leo_input(spin_number)
    :os.cmd(:"cd ../circuits/poseidon_leo && leo clean && leo run")
    LeoIO.wait_for_leo_poseidon()

    poseidon_result = LeoIO.read_poseidon_output()
    poseidon_bit_decomposition = Helper.poseidon_hash_to_bit_string(poseidon_result)

    LeoIO.generate_roulette_leo_input(
      bet_number,
      credits,
      spin_number,
      poseidon_bit_decomposition
    )

    :os.cmd(:"ls && cd ../circuits/bets_leo && leo clean && leo run")

    {credits_int, _} = Integer.parse(credits)
    {poseidon_int, _} = Integer.parse(poseidon_result)
    {bet_number_int, _} = Integer.parse(bet_number)

    {spin_result, new_balance} =
      Model.run_roulette_game(poseidon_int, bet_number_int, credits_int)

    LeoIO.wait_for_leo_roulette()

    conn
    |> render("make.json", spin_result: spin_result, new_balance: new_balance)
  end
end
