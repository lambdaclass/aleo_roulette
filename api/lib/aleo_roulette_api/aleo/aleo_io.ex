defmodule AleoRouletteApi.Aleo.IO do
  alias AleoRouletteApi.Aleo.OutputParser

  @aleo_path "../../aleo/target/release/aleo"
  @poseidon_circuit_path "../circuits/poseidon"
  @bets_circuit_path "../circuits/bets"

  def gen_poseidon_hash(seed) do
    {output, _exit_code} = run_poseidon_circuit("psd_hash", %{seed: "#{seed}u32"})

    output
    |> IO.puts()

    output
    |> OutputParser.get_hash()
  end

  defp run_poseidon_circuit(
         function_name,
         %{seed: seed} = params
       ) do
    System.cmd("sh", [
      "-c",
      "cd #{@poseidon_circuit_path} && #{@aleo_path} run #{function_name} #{seed}"
    ])
  end

  defp run_bets_circuit(seed) do
    System.cmd("sh", [
      "-c",
      "cd #{@bets_circuit_path} && #{@aleo_path} run psd_hash #{seed}u32"
    ])
  end
end
