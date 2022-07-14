defmodule AleoRouletteApi.Roulette.Model do

  @spec run_roulette_game(integer, integer, integer) :: {integer, number}
  def run_roulette_game(rand, bet_number, credits) do
    spin_result = rem(rand, 38)
    new_balance = if spin_result == bet_number, do:  credits*36, else: -credits
    {spin_result, new_balance}
  end

end
