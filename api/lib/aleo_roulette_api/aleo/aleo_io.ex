defmodule AleoRouletteApi.Aleo.IO do
  alias AleoRouletteApi.Aleo.OutputParser

  @aleo_path "../../aleo/target/release/aleo"
  @poseidon_circuit_path "../circuits/poseidon"
  @bets_circuit_path "../circuits/bets"

  def gen_poseidon_hash(seed) do
    {output, _exit_code} = run_poseidon_circuit(:psd_hash, %{seed: "#{seed}u32"})

    output
    |> IO.puts()

    output
    |> OutputParser.get_pds_hash()
  end

  def gen_casino_token(address, amount) do
    {output, _exit_code} =
      run_bets_circuit(
        :mint_casino_token_record,
        %{address: address, amount: "#{amount}u64"}
      )

    output
    |> IO.puts()

    output
    |> OutputParser.get_mint_casino_token_record()
  end

  defp run_poseidon_circuit(
         :psd_hash,
         %{seed: seed} = params
       ) do
    System.cmd("sh", [
      "-c",
      "cd #{@poseidon_circuit_path} && #{@aleo_path} run psd_hash #{seed}"
    ])
  end

  defp run_bets_circuit(
         :mint_casino_token_record,
         %{address: address, amount: amount} = params
       ) do
    System.cmd("sh", [
      "-c",
      "cd #{@bets_circuit_path} && #{@aleo_path} run mint_casino_token_record #{address} #{amount}"
    ])
  end
end
