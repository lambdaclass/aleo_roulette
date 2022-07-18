defmodule AleoRouletteApi.Roulette.Game do
  alias AleoRouletteApi.Aleo.IO

  @roulette_posible_results 37

  def casino_initial_token_record(initial_token_amount) do
    casino_address = Application.get_env(:aleo_roulette_api, :casino_address)
    IO.gen_casino_token(casino_address, initial_token_amount)
  end

  def make_bet(
        casino_token_record,
        seed,
        player_address,
        player_bet_number,
        player_bet_amount,
        player_amount_of_available_tokens
      ) do
    aleo_hash = IO.gen_poseidon_hash(seed)

    roulette_random_result = Integer.mod(aleo_hash, @roulette_posible_results)

    IO.gen_make_bet(
      casino_token_record,
      player_address,
      roulette_random_result,
      player_bet_number,
      player_bet_amount,
      player_amount_of_available_tokens
    )
  end
end