defmodule AleoRouletteApi.Aleo.IO do
  alias AleoRouletteApi.Aleo.OutputParser

  @aleo_path "../../aleo/target/release/aleo"
  @bets_circuit_path "../circuits/bets"

  def gen_poseidon_hash(seed) do
    {output, _exit_code} = run_bets_circuit(:psd_hash, %{seed: "#{seed}u32"})

    output
    |> IO.inspect()
    |> OutputParser.get_pds_hash()
  end

  def gen_casino_token(address, amount) do
    {output, _exit_code} =
      run_bets_circuit(
        :mint_casino_token_record,
        %{address: address, amount: "#{amount}u64"}
      )

    output
    |> IO.inspect()
    |> OutputParser.get_mint_casino_token_record()
  end

  def gen_make_bet(
        casino_token_record,
        player_address,
        roulette_random_result,
        player_bet_number,
        player_bet_amount,
        player_amount_of_available_tokens
      ) do
    {output, _exit_code} =
      run_bets_circuit(
        :make_bet,
        %{
          casino_token_record: %{
            owner: "#{casino_token_record.owner}.private",
            gates: "#{casino_token_record.gates}u64.private",
            amount: "#{casino_token_record.amount}u64.private"
          },
          player_address: player_address,
          roulette_random_result: "#{roulette_random_result}u8",
          player_bet_number: "#{player_bet_number}u8",
          player_bet_amount: "#{player_bet_amount}u64",
          player_amount_of_available_tokens: "#{player_amount_of_available_tokens}u64"
        }
      )

    output
    |> IO.inspect()
    |> OutputParser.get_make_bet()
  end

  defp run_bets_circuit(
         :psd_hash,
         %{seed: seed} = _params
       ) do
    System.cmd("sh", [
      "-c",
      "cd #{@bets_circuit_path} && #{@aleo_path} run psd_hash #{seed}"
    ])
  end

  defp run_bets_circuit(
         :mint_casino_token_record,
         %{address: address, amount: amount} = _params
       ) do
    System.cmd("sh", [
      "-c",
      "cd #{@bets_circuit_path} && #{@aleo_path} run mint_casino_token_record #{address} #{amount}"
    ])
  end

  defp run_bets_circuit(
         :make_bet,
         %{
           casino_token_record: %{
             owner: casino_token_owner,
             gates: casino_token_gates,
             amount: casino_token_amount
           },
           player_address: player_address,
           roulette_random_result: roulette_random_result,
           player_bet_number: player_bet_number,
           player_bet_amount: player_bet_amount,
           player_amount_of_available_tokens: player_amount_of_available_tokens
         } = _params
       ) do
    System.cmd("sh", [
      "-c",
      "cd #{@bets_circuit_path} && #{@aleo_path} run make_bet \"{owner: #{casino_token_owner}, gates: #{casino_token_gates}, amount: #{casino_token_amount} }\" #{player_address} #{roulette_random_result} #{player_bet_number} #{player_bet_amount} #{player_amount_of_available_tokens}"
    ])
  end
end
