defmodule AleoRouletteApiWeb.BetView do
  use AleoRouletteApiWeb, :view
  alias AleoRouletteApi.Bets

  def render("make.json", %{bet_make: bet_make}) do
    bet_make
  end
end
