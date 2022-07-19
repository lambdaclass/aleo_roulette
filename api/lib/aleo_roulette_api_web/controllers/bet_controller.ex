defmodule AleoRouletteApiWeb.BetController do
  use AleoRouletteApiWeb, :controller
  alias AleoRouletteApi.Roulette.Game

  def make_bet(conn, %{
        "casino_token_record" => %{
          "owner" => casino_address,
          "gates" => _casino_gates,
          "amount" => casino_amount
        },
        "player_token_record" => %{
          "owner" => player_address,
          "gates" => _player_gates,
          "amount" => player_amount_of_available_tokens
        },
        "seed" => seed,
        "player_bet_number" => player_bet_number,
        "player_bet_amount" => player_bet_amount
      }) do
    {casino_token_record, player_token_record} =
      Game.make_bet(
        %{
          owner: casino_address,
          gates: _casino_gates,
          amount: casino_amount
        },
        seed,
        player_address,
        player_bet_number,
        player_bet_amount,
        player_amount_of_available_tokens
      )

    conn
    |> render("make_bet.json",
      casino_token_record: casino_token_record,
      player_token_record: player_token_record
    )
  end
end
