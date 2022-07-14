defmodule AleoRouletteApiWeb.BetView do
  use AleoRouletteApiWeb, :view
  alias AleoRouletteApi.Bets

  def render("make.json", %{spin_result: spin_result, new_balance: new_balance}) do
    %{spin_result: spin_result, has_won: new_balance > 0, new_balance: new_balance}
  end
end
