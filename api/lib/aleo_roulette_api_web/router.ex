defmodule AleoRouletteApiWeb.Router do
  use AleoRouletteApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", AleoRouletteApiWeb do
    pipe_through(:api)

    scope "/bets" do
      post("/make/leo", BetController, :make_with_leo)
      post("/make/aleo", BetController, :make_with_aleo)
    end
  end
end
