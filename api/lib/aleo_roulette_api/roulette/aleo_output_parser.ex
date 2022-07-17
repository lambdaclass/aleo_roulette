defmodule AleoRouletteApi.Roulette.AleoOutputParser do
  import NimbleParsec

  @output_start_prefix "➡️  Output"
  @output_param_prefix "• "

  aleo_output_section =
    eventually(string(@output_start_prefix))
    |> ignore()
    |> eventually(string(@output_param_prefix))
    |> ignore()

  aleo_psd_hash_output =
    aleo_output_section
    |> integer(min: 1, max: 100)

  defparsec(:parsec_psd_hash, aleo_psd_hash_output)

  def get_hash(aleo_output) do
    {:ok, [hash], _, _, _, _} =
      aleo_output
      |> parsec_psd_hash()

    hash
  end
end
