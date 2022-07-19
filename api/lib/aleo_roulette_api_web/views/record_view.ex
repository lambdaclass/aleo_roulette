defmodule AleoRouletteApiWeb.RecordView do
  use AleoRouletteApiWeb, :view
  alias AleoRouletteApi.Bets

  def render("casino_token_record.json", %{token_record: token_record}) do
    token_record
  end
end
