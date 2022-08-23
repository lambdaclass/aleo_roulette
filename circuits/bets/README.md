# bets.aleo


### Mint casino token record
params : [casino_program_address: address] [casino_tokens_amount: u64]
```
aleo run mint_casino_token_record aleo1ljfzdypkggkzuvweyzat535r4kczzguyfmctwd67fm3vn6n9ggyqcx8tc7 100u64
```

### Make winning bet
params : [casino_token_record: token.record] [player_address: address] [roulette_random_result: u8] [player_bet_number: u8] [player_bet_amount: u64] [player_amount_of_available_tokens: u64]
```
aleo run make_bet "{
  owner: aleo1ljfzdypkggkzuvweyzat535r4kczzguyfmctwd67fm3vn6n9ggyqcx8tc7.private,
  gates: 0u64.private,
  amount: 100u64.private
}" aleo10a2kkktd6zgm5kyy53aj7hxyk2rkulkntexg0qwxhywjqvu4cqxs29ggqs 32u8 32u8 1u64 50u64
```

### Make a losing bet
params : [casino_token_record: token.record] [player_address: address] [roulette_random_result: u8] [player_bet_number: u8] [player_bet_amount: u64] [player_amount_of_available_tokens: u64]
```
aleo run make_bet "{
  owner: aleo1ljfzdypkggkzuvweyzat535r4kczzguyfmctwd67fm3vn6n9ggyqcx8tc7.private,
  gates: 0u64.private,
  amount: 100u64.private
}" aleo10a2kkktd6zgm5kyy53aj7hxyk2rkulkntexg0qwxhywjqvu4cqxs29ggqs 32u8 31u8 1u64 50u64
```
