@val external setTimeout: (unit => unit, int) => unit = "setTimeout"

@react.component
let make = () => {
  let (rotateValue, setRotateValue) = React.useState(_ => 356)
  let (playing, setPlay) = React.useState(_ => false)
  let (bet, setBet) = React.useState(_ => -1)
  let (betToken, setBetToken) = React.useState(() => 0.)
  let (rouletteNumber, setRouletteNumber) = React.useState(_ => -1)
  let (win, setWin) = React.useState(_ => false)

  // api integration
  let (casinoRecord, setCasinoRecord) = React.useState(_ => TokenRecord.default)
  let (playerRecord, setPlayerRecord) = React.useState(_ => TokenRecord.player_default)
  let (spinResult, setSpinResult) = React.useState(_ => 0)

  // POST CASINO INIT
  React.useEffect0(() => {
    let payload = Js.Dict.fromArray([("amount", Js.Json.number(1000.))])

    let _ =
      Fetch.fetchWithInit(
        "http://localhost:5000/api/records/token/casino",
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=payload->Js.Json.object_->Js.Json.stringify->Fetch.BodyInit.make,
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )
      ->Promise.then(Fetch.Response.json)
      ->Promise.then(json => TokenRecord.decode(json)->Promise.resolve)
      ->Promise.then(casino_token_record =>
        setCasinoRecord(_prev => casino_token_record)->Promise.resolve
      )
    None
  })

  let degreesArray = [
    356,
    220,
    56,
    337,
    36,
    182,
    95,
    298,
    153,
    259,
    172,
    133,
    317,
    114,
    240,
    17,
    201,
    75,
    278,
    26,
    230,
    46,
    269,
    162,
    192,
    65,
    346,
    104,
    288,
    284,
    143,
    249,
    6,
    211,
    85,
    327,
    124,
  ]

  let (transactions, _setTransactions) = React.useState(_ => [])
  let handleInputChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setBetToken(_ =>
      switch value->Belt.Float.fromString {
      | Some(amount) => amount
      | None => 0.
      }
    )
  }

  let handleBet = betValue => {
    setBet(_prev => betValue)
  }

  React.useEffect1(() => {
    Js.Console.log(bet)
    None
  }, [bet])

  let handleSpin = _evt => {
    let payload = Js.Dict.fromArray([
      (
        "casino_token_record",
        Js.Dict.fromArray([
          ("owner", Js.Json.string(casinoRecord.owner)),
          ("gates", Js.Json.number(casinoRecord.gates->Belt.Float.fromInt)),
          ("amount", Js.Json.number(casinoRecord.amount->Belt.Float.fromInt)),
        ])->Js.Json.object_,
      ),
      (
        "player_token_record",
        Js.Dict.fromArray([
          ("owner", Js.Json.string(playerRecord.owner)),
          ("gates", Js.Json.number(playerRecord.gates->Belt.Float.fromInt)),
          ("amount", Js.Json.number(playerRecord.amount->Belt.Float.fromInt)),
        ])->Js.Json.object_,
      ),
      ("seed", Js.Json.number(Js.Math.random_int(0, 37)->Belt.Float.fromInt)),
      ("player_bet_number", Js.Json.number(bet->Belt.Float.fromInt)),
      ("player_bet_amount", Js.Json.number(betToken)),
    ])

    let _ =
      Fetch.fetchWithInit(
        "http://localhost:5000/api/bets/make",
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=payload->Js.Json.object_->Js.Json.stringify->Fetch.BodyInit.make,
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )
      ->Promise.then(Fetch.Response.json)
      ->Promise.then(json => BetResult.decode(json)->Promise.resolve)
      ->Promise.then(bet_result => {
        setCasinoRecord(_prev => bet_result.casino_token_record)
        setPlayerRecord(_prev => bet_result.player_token_record)
        setSpinResult(_prev => bet_result.spin_result)
        Promise.resolve()
      })
  }

  React.useEffect1(() => {
    let randomNumber = spinResult
    let degreeSelected = degreesArray[randomNumber]
    let circleMove = Js.Math.random_int(3, 6)

    let randomTransactionId =
      "aleo1y90yg3yzs4g7q25f9nn8khuu00m8ysynxmcw8aca2d0phdx8dgpq4vw" ++
      Belt.Int.toString(Js.Math.random_int(100, 5000))
    let item: Transaction.t = {token: betToken, address: randomTransactionId}
    let pushedValue = Js.Array2.push(transactions, item)

    setRotateValue(_prev => rotateValue - 360 * circleMove)
    setPlay(prev => !prev)
    setTimeout(() => {
      setPlay(prev => !prev)
      setRotateValue(_prev => degreeSelected + 360 * circleMove)
    }, 1)

    if !playing {
      setPlay(prev => !prev)
      setTimeout(() => {
        setPlay(prev => !prev)
        setRouletteNumber(_prev => randomNumber)
        if randomNumber == bet * 1 {
          setWin(_prev => true)
        } else {
          setWin(_prev => false)
        }
      }, 5000)
    }
    None
  }, [spinResult])

  React.useEffect1(() => {
    Js.Console.log(playing)
    None
  }, [playing])

  React.useEffect1(() => {
    Js.Console.log(`bet: ${bet->Belt.Int.toString}`)
    None
  }, [bet])

  React.useEffect1(() => {
    Js.Console.log(`betToken: ${betToken->Belt.Float.toString}`)
    None
  }, [betToken])

  <div className="roulette-table">
    <Win playing win />
    <Roulette playing rotateValue rouletteNumber />
    <Table bet handleBet playing />
    <div className="action-panel">
      <div className="dropdown">
        {React.string("Transactions")}
        <img src="/images/arrow.svg" />
        <TransactionsList win transactions />
      </div>
      <div className="dropdown">
        {React.string("Your account")}
        <img src="/images/arrow.svg" />
        <div className="info-container">
          <div>
            <span> {React.string("Address: ")} </span>
            {playerRecord.owner->React.string}
          </div>
          <div>
            <span> {React.string("Tokens: ")} </span>
            {playerRecord.amount->React.int}
          </div>
        </div>
      </div>
      <div className="dropdown">
        {React.string("Casino's account")}
        <img src="/images/arrow.svg" />
        <div className="info-container">
          <div>
            <span> {React.string("Address: ")} </span>
            {casinoRecord.owner->React.string}
          </div>
          <div>
            <span> {React.string("Tokens: ")} </span>
            {casinoRecord.amount->React.int}
          </div>
        </div>
      </div>
      <div className="token-button-container">
        <Token handleInputChange betToken />
        <Button handleClick=handleSpin playing />
      </div>
    </div>
  </div>
}
