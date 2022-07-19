defmodule AleoRouletteApiWeb.BetView do
  use AleoRouletteApiWeb, :view

  def render("make_bet.json", %{
        casino_token_record: casino_token_record,
        player_token_record: player_token_record
      }) do
    %{
      casino_token_record: casino_token_record,
      player_token_record: player_token_record
    }
  end
end
