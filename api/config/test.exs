import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :aleo_roulette_api, AleoRouletteApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "J7NhIYfjgyW2ijwdjtcL6TBOhi3AGKUgacwQpjIDg0fKjw1Nx3qhtbhVzq9/2sCT",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
