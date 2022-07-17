defmodule AleoRouletteApi.Roulette.AleoIO do
  alias AleoRouletteApi.Roulette.AleoOutputParser

  @aleo_path "../../aleo/target/release/aleo"
  @poseidon_circuit_path "../circuits/poseidon"
  @bets_circuit_path "../circuits/bets"

  def gen_poseidon_hash(seed) do
    {output, _exit_code} = run_poseidon_circuit(seed)

    output
    |> IO.inspect()

    output
    |> AleoOutputParser.get_hash()
  end

  def gen_casino_record(seed) do
    {output, _exit_code} = run_poseidon_circuit(seed)
  end

  defp run_poseidon_circuit(seed) do
    System.cmd("sh", [
      "-c",
      "cd #{@poseidon_circuit_path} && #{@aleo_path} run psd_hash #{seed}u32"
    ])
  end

  defp run_casino_token_mint_circuit(seed) do
    System.cmd("sh", [
      "-c",
      "cd #{@bets_circuit_path} && #{@aleo_path} run psd_hash #{seed}u32"
    ])
  end
end
