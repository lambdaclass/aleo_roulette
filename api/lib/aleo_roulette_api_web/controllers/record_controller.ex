defmodule AleoRouletteApiWeb.RecordController do
  use AleoRouletteApiWeb, :controller
  alias AleoRouletteApi.Roulette.Game

  def mint_casino_token_record(conn, %{
        "amount" => amount
      }) do
    casino_token_record = Game.casino_initial_token_record(amount)

    conn
    |> render("casino_token_record.json", %{token_record: casino_token_record})
  end
end
