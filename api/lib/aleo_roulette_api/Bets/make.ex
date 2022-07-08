defmodule AleoRouletteApi.Bets.Make do
  @derive Jason.Encoder
  defstruct [
    :bet_number,
    :credits
  ]

  def new(bet_number \\ 0, credits \\ 0) do
    %__MODULE__{
      bet_number: bet_number,
      credits: credits
    }
  end
end
