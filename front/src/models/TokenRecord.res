type t = {
  owner: string,
  gates: int,
  amount: int,
}

let decode = json => {
  open Json.Decode
  {
    owner: json |> field("owner", string),
    gates: json |> field("gates", int),
    amount: json |> field("amount", int),
  }
}

let default = {
  owner: "",
  gates: 0,
  amount: 0,
}

let player_default = {
  owner: "",
  gates: 0,
  amount: 50,
}
