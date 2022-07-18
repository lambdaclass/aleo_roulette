defmodule AleoRouletteApi.Aleo.OutputParser do
  import NimbleParsec

  @output_start_prefix "➡️  Output"
  @param_prefix "• "
  @owner_prefix "owner: "
  @gates_prefix "gates: "
  @amount_prefix "amount: "
  @alphanumeric_range [?a..?z, ?A..?Z, ?0..?9]

  aleo_output_section =
    eventually(string(@output_start_prefix))
    |> ignore()

  aleo_psd_hash_output =
    aleo_output_section
    |> ignore(eventually(string(@param_prefix)))
    |> integer(min: 1, max: 100)

  aleo_mint_casino_token_record_output =
    aleo_output_section
    |> ignore(eventually(string(@param_prefix)))
    |> ignore(eventually(string(@owner_prefix)))
    |> ascii_string(@alphanumeric_range, min: 1)
    |> ignore(eventually(string(@gates_prefix)))
    |> integer(min: 1, max: 21)
    |> ignore(eventually(string(@amount_prefix)))
    |> integer(min: 1, max: 21)

  aleo_make_bet_output =
    aleo_output_section
    |> ignore(eventually(string(@param_prefix)))
    |> ignore(eventually(string(@owner_prefix)))
    |> ascii_string(@alphanumeric_range, min: 1)
    |> ignore(eventually(string(@gates_prefix)))
    |> integer(min: 1, max: 21)
    |> ignore(eventually(string(@amount_prefix)))
    |> integer(min: 1, max: 21)
    |> ignore(eventually(string(@param_prefix)))
    |> ignore(eventually(string(@owner_prefix)))
    |> ascii_string(@alphanumeric_range, min: 1)
    |> ignore(eventually(string(@gates_prefix)))
    |> integer(min: 1, max: 21)
    |> ignore(eventually(string(@amount_prefix)))
    |> integer(min: 1, max: 21)

  defparsec(:parsec_psd_hash, aleo_psd_hash_output)
  defparsec(:parsec_mint_casino_token_record, aleo_mint_casino_token_record_output)
  defparsec(:parsec_make_bet, aleo_make_bet_output)

  def get_pds_hash(aleo_output) do
    {:ok, [hash], _, _, _, _} =
      aleo_output
      |> parsec_psd_hash()

    hash
  end

  def get_mint_casino_token_record(aleo_output) do
    {:ok, [casino_owner, casino_gates, casino_amount], _, _, _, _} =
      aleo_output
      |> parsec_mint_casino_token_record()

    %{
      owner: casino_owner,
      gates: casino_gates,
      amount: casino_amount
    }
  end

  def get_make_bet(aleo_output) do
    {:ok, [casino_owner, casino_gates, casino_amount, player_owner, player_gates, player_amount],
     _, _, _,
     _} =
      aleo_output
      |> parsec_make_bet()

    {
      %{
        owner: casino_owner,
        gates: casino_gates,
        amount: casino_amount
      },
      %{
        owner: player_owner,
        gates: player_gates,
        amount: player_amount
      }
    }
  end
end
