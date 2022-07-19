defmodule AleoRouletteApiWeb.BetView do
  use AleoRouletteApiWeb, :view

  def render("make_bet.json", %{
        casino_token_record: casino_token_record,
        player_token_record: player_token_record,
        spin_result: spin_result
      }) do
    %{
      casino_token_record: casino_token_record,
      player_token_record: player_token_record,
      spin_result: spin_result
    }
  end
end
