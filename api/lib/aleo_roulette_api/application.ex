defmodule AleoRouletteApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AleoRouletteApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AleoRouletteApi.PubSub},
      # Start the Endpoint (http/https)
      AleoRouletteApiWeb.Endpoint,
      AleoRouletteApi.Roulette.SpinCounter
      # Start a worker by calling: AleoRouletteApi.Worker.start_link(arg)
      # {AleoRouletteApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AleoRouletteApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AleoRouletteApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
