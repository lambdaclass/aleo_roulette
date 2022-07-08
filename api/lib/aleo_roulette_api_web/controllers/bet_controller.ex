defmodule AleoRouletteApiWeb.BetController do
  use AleoRouletteApiWeb, :controller
  alias AleoRouletteApi.Bets

  def make(conn, %{"bet_number" => bet_number, "credits" => credits}) do
    bet_make = Bets.Make.new(bet_number, credits)


    File.write!("../circuits/poseidon/inputs/poseidon.in",
      leo_poseidon_input_string(bet_number)
    )

    :os.cmd(:"cd ../circuits/poseidon && leo clean && leo run")

    wait_for_leo_poseidon()

    result = File.read!("../circuits/poseidon/outputs/poseidon.out")
      |> String.split("= ")
      |> List.last()
      |> String.split(";")
      |> List.first()

    conn
    |> render("make.json", bet_make: result)
  end

  def leo_poseidon_input_string(random_seed) do
    "[main]\nfe: field = #{random_seed};\n\n[registers]\nr0: field = 0;\n"
  end

  def wait_for_leo_poseidon() do
    :timer.sleep(500)
    case File.stat("../circuits/poseidon/outputs/poseidon.sum") do
      {:enoent, _} -> wait_for_leo_poseidon()
      _ -> ""
    end
  end
end
