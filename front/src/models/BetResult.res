type t = {
  casino_token_record: TokenRecord.t,
  player_token_record: TokenRecord.t,
  spin_result: int,
}

let decode = json => {
  open Json.Decode
  {
    casino_token_record: json |> field("casino_token_record", TokenRecord.decode),
    player_token_record: json |> field("player_token_record", TokenRecord.decode),
    spin_result: json |> field("spin_result", int),
  }
}

let default = {
  casino_token_record: TokenRecord.default,
  player_token_record: TokenRecord.default,
  spin_result: -1,
}
