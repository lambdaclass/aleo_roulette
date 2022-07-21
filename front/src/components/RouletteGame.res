@val external setTimeout: (unit => unit, int) => unit = "setTimeout"

@react.component
let make = () => {
  let (rotateValue, setRotateValue) = React.useState(_ => 356)
  let (playing, setPlay) = React.useState(_ => false)
  let (spin, setSpin) = React.useState(_ => false)
  let (bet, setBet) = React.useState(_ => -1)
  let (betToken, setBetToken) = React.useState(() => 1.)
  let (win, setWin) = React.useState(_ => false)

  // api integration
  let (casinoRecord, setCasinoRecord) = React.useState(_ => TokenRecord.default)
  let (playerRecord, setPlayerRecord) = React.useState(_ => TokenRecord.player_default)
  let (spinResult, setSpinResult) = React.useState(_ => 0)
  let (readyToPlay, setReadyToPlay) = React.useState(_ => false)

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
      ->Promise.then(casino_token_record => {
        setCasinoRecord(_prev => casino_token_record)
        setPlay(_ => false) // FIXME: why?
        setReadyToPlay(_ => true)
        Promise.resolve()
      })

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
    308,
    288,
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

  let handleSpin = _evt => {
    setSpin(_prev => true)
    setRotateValue(_prev => 356)
    setWin(_prev => false)

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
    if spin {
      let degreeSelected = degreesArray[spinResult]
      let circleMove = Js.Math.random_int(3, 6)

      let randomTransactionId =
        "aleo1y90yg3yzs4g7q25f9nn8khuu00m8ysynxmcw8aca2d0phdx8dgpq4vw" ++
        Belt.Int.toString(Js.Math.random_int(100, 5000))
      let item: Transaction.t = {token: betToken, address: randomTransactionId}
      let _pushedValue = Js.Array2.push(transactions, item)

      setRotateValue(_prev => degreeSelected + 360 * circleMove)
      setPlay(_prev => true)
    }

    None
  }, [spinResult])

  React.useEffect1(() => {
    Js.Console.log(`betToken: ${betToken->Belt.Float.toString}`)
    None
  }, [betToken])

  React.useEffect1(() => {
    if playing {
      setTimeout(() => {
        setSpin(_prev => false)
        setPlay(_prev => false)

        if spinResult == bet {
          setWin(_prev => true)
        }
      }, 7000)
    }
    None
  }, [playing])

  let handleCloseWin = _ => {
    setWin(_prev => false)
  }

  <div className="roulette-table">
    <Win win handleCloseWin />
    <Roulette spin playing rotateValue spinResult />
    <Table bet handleBet playing />
    // This should be changed to conditional rendering
    <div
      className="action-panel loading"
      style={ReactDOM.Style.make(~opacity=readyToPlay ? "0" : "1", ())}>
      <img src="/images/loading.svg" /> {React.string("Loading Casino")}
    </div>
    <div
      className="action-panel loaded"
      style={ReactDOM.Style.make(~opacity=readyToPlay ? "1" : "0", ())}>
      <div className="action-info-panels">
        <div className="dropdown">
          {React.string("Transactions")}
          <img src="/images/arrow.svg" />
          <TransactionsList transactions />
        </div>
        <div className="dropdown">
          {React.string("Your account")}
          <img src="/images/arrow.svg" />
          <div className="info-container">
            <div>
              <div className="title"> {React.string("Address: ")} </div>
              <span> {playerRecord.owner->React.string} </span>
            </div>
            <div>
              <div className="title"> {React.string("Tokens: ")} </div>
              <span> {playerRecord.amount->React.int} </span>
            </div>
          </div>
        </div>
        <div className="dropdown">
          {React.string("Casino's account")}
          <img src="/images/arrow.svg" />
          <div className="info-container">
            <div>
              <div className="title"> {React.string("Address: ")} </div>
              <span> {casinoRecord.owner->React.string} </span>
            </div>
            <div>
              <div className="title"> {React.string("Tokens: ")} </div>
              <span> {casinoRecord.amount->React.int} </span>
            </div>
          </div>
        </div>
      </div>
      <div className="token-button-container">
        <div className="wrapper">
          <Token handleInputChange betToken spin readyToPlay bet />
          <Button handleClick=handleSpin spin readyToPlay bet />
        </div>
      </div>
      <div className="network"> {"Network: Aleo Testnet3"->React.string} </div>
    </div>
  </div>
}
