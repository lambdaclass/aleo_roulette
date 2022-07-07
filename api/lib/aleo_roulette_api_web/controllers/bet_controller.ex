defmodule AleoRouletteApiWeb.BetController do
  use AleoRouletteApiWeb, :controller
  alias AleoRouletteApi.Bets

  def make(conn, %{"bet_number" => bet_number, "credits" => credits}) do
    bet_make = Bets.Make.new(bet_number, credits)

    conn
    |> render("make.json", bet_make: bet_make)
  end
end
