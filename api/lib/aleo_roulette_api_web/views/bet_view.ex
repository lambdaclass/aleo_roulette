defmodule AleoRouletteApiWeb.BetView do
  use AleoRouletteApiWeb, :view
  alias AleoRouletteApi.Bets

  def render("token_record.json", %{record: record}) do
    record
  end
end
