defmodule AleoRouletteApi.Roulette.Game do
  alias AleoRouletteApi.Aleo.IO, as: AleoIO

  @roulette_posible_results 37

  def mint_casino_token_record(initial_token_amount) do
    casino_address = Application.get_env(:aleo_roulette_api, :casino_address)
    AleoIO.gen_casino_token(casino_address, initial_token_amount)
  end

  def make_bet(
        casino_token_record,
        seed,
        player_address,
        player_bet_number,
        player_bet_amount,
        player_amount_of_available_tokens
      ) do
    aleo_hash = AleoIO.gen_poseidon_hash(seed)

    roulette_random_result = aleo_hash |> mod_of_last_6_bits()

    mod_probe =
      AleoIO.gen_psd_mod_verification({
        aleo_hash |> get_last_6_bits_input_for_aleo(),
        roulette_random_result
      })

    {casino_token_record, player_token_records} =
      AleoIO.gen_make_bet(
        casino_token_record,
        player_address,
        roulette_random_result,
        player_bet_number,
        player_bet_amount,
        player_amount_of_available_tokens
      )

    case mod_probe do
      true -> {:ok, casino_token_record, player_token_records, roulette_random_result}
      false -> {:error, "The spinning result verification failed"}
    end
  end

  defp get_last_6_bits_input_for_aleo(hash) do
    hash
    |> Integer.to_string(2)
    |> String.graphemes()
    |> Enum.take(-6)
    |> Enum.map(fn x ->
      case x do
        "1" -> true
        "0" -> false
      end
    end)
  end

  defp mod_of_last_6_bits(hash) do
    hash
    |> Integer.to_string(2)
    |> String.slice(-6, 6)
    |> String.to_integer(2)
    |> Integer.mod(@roulette_posible_results)
  end
end
