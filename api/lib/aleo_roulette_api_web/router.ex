defmodule AleoRouletteApiWeb.Router do
  use AleoRouletteApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", AleoRouletteApiWeb do
    pipe_through(:api)

    scope "/records" do
      scope "/token" do
        post("/casino", RecordController, :mint_casino_token_record)
      end
    end

    scope "/bets" do
      post("/make", BetController, :make_bet)
    end
  end
end
