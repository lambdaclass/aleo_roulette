defmodule AleoRouletteApi.Roulette.AleoIO do
  @aleo_path "../../aleo/target/release/aleo"
  @poseidon_circuit_path "../circuits/poseidon_aleo"
  @bets_circuit_path "../circuits/poseidon_aleo"
  @aleo_output_prefix " • "

  def gen_poseidon_hash(seed) do
    {output, _exit_code} = run_poseidon_circuit(seed)

    output
    |> String.split("\n")
    |> Enum.at(7)
    |> get_aleo_output_value("field")
    |> Integer.parse()
    |> Tuple.to_list()
    |> Enum.at(0)
  end

  def gen_bet_result(seed) do
    {output, _exit_code} = run_poseidon_circuit(seed)

    output
    |> String.split("\n")
    |> Enum.at(7)
    |> get_aleo_output_value("field")
    |> Integer.parse()
    |> Tuple.to_list()
    |> Enum.at(0)
  end

  defp run_poseidon_circuit(seed) do
    System.cmd("sh", [
      "-c",
      "cd #{@poseidon_circuit_path} && #{@aleo_path} run psd_hash #{seed}u32"
    ])
  end

  defp get_aleo_output_value(output, type) do
    output
    |> String.replace_prefix(@aleo_output_prefix, <<>>)
    |> String.replace_suffix(type, <<>>)
  end
end
