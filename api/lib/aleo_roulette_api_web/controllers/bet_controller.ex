defmodule AleoRouletteApiWeb.BetController do
  use AleoRouletteApiWeb, :controller
  alias AleoRouletteApi.Roulette.Game

  def make_bet(conn, %{
        "casino_token_record" => %{
          "owner" => casino_address,
          "gates" => casino_gates,
          "amount" => casino_amount
        },
        "player_token_record" => %{
          "owner" => player_address,
          "gates" => _player_gates,
          "amount" => player_amount_of_available_tokens
        },
        "player_bet_number" => player_bet_number,
        "player_bet_amount" => player_bet_amount
      }) do
    bet_result =
      Game.make_bet(
        %{
          owner: casino_address,
          gates: casino_gates,
          amount: casino_amount
        },
        player_address,
        player_bet_number,
        player_bet_amount,
        player_amount_of_available_tokens
      )

    case bet_result do
      {:ok, casino_token_record, player_token_record, spin_result} ->
        conn
        |> render("make_bet.json",
          casino_token_record: casino_token_record,
          player_token_record: player_token_record,
          spin_result: spin_result
        )

      {:error, error_message} ->
        conn |> send_resp(409, error_message)
    end
  end
end
