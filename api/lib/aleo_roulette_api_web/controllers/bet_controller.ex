defmodule AleoRouletteApiWeb.BetController do
  use AleoRouletteApiWeb, :controller
  alias AleoRouletteApi.Bets
  alias AleoRouletteApi.Bets.IO

  def make(conn, %{"bet_number" => bet_number, "credits" => credits, "spin_number" => spin_number}) do
    bet_make = Bets.Make.new(bet_number, credits)

    File.write!("../circuits/poseidon/inputs/poseidon.in",
      IO.leo_poseidon_input_string(spin_number)
    )

    :os.cmd(:"cd ../circuits/poseidon && leo clean && leo run")
    IO.wait_for_leo_poseidon()
    poseidon_result = IO.read_poseidon_output()

    poseidon_bit_decomposition =
      String.to_integer(poseidon_result)
      |> Integer.to_string(2)

    IO.generate_roulette_leo_input(bet_number,credits,spin_number,poseidon_bit_decomposition)
    :os.cmd(:"ls && cd ../circuits/bets && leo clean && leo run")

    {credits_int, _} = Integer.parse(credits)
    {poseidon_int, _} = Integer.parse(poseidon_result)
    {bet_number_int, _} = Integer.parse(bet_number)
    spin_result = rem(poseidon_int, 38)
    new_balance = if spin_result == bet_number_int, do:  credits_int*36, else: -credits_int

    IO.wait_for_leo_roulette()

    conn
    |> render("make.json", spin_result: spin_result, new_balance: new_balance)
  end


end
