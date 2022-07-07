defmodule AleoRouletteApiWeb.Router do
  use AleoRouletteApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AleoRouletteApiWeb do
    pipe_through :api

    scope "/bets" do
      post "/make", BetController, :make
    end

  end
end
