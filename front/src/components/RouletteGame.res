@val external setTimeout: (unit => unit, int) => unit = "setTimeout"

@react.component
let make = () => {
  let (rotateValue, setRotateValue) = React.useState(_ => 352)
  let (playing, setPlay) = React.useState(_ => false)
  let (bet, setBet) = React.useState(_ => -1)
  let (betToken, setBetToken) = React.useState(() => "")
  let (rouletteNumber, setRouletteNumber) = React.useState(_ => -1)
  let (win, setWin) = React.useState(_ => false)
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
    setBetToken(_ => value)
  }

  let handleBet = betValue => {
    setBet(_prev => betValue)
  }
  let handleSpin = _evt => {
    let randomNumber = Js.Math.random_int(0, 37)
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
  }
  <div className="roulette-table">
    <Win playing win />
    <Roulette playing rotateValue rouletteNumber />
    <Table bet handleBet playing />
    <div className="action-panel">
      <div className="transaction-label">
        {React.string("Transactions")}
        <img src="/images/arrow.svg" />
        <TransactionsList win transactions />
      </div>
      <div className="token-button-container">
        <Token handleInputChange betToken /> <Button handleClick=handleSpin playing />
      </div>
    </div>
  </div>
}
