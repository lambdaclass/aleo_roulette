@val external setTimeout: (unit => unit, int) => unit = "setTimeout"

@react.component
let make = () => {
  let (rotateValue, setRotateValue) = React.useState(_ => 352)
  let (playing, setPlay) = React.useState(_ => false)
  let (bet, setBet) = React.useState(_ => 0)
  let (betToken, setBetToken) = React.useState(() => "")
  let (rouletteNumber, setRouletteNumber) = React.useState(_ => -1)
  let (win, setWin) = React.useState(_ => false)
  let degreesArray = [
    352,
    216,
    50,
    332,
    31,
    177,
    89,
    293,
    148,
    255,
    167,
    128,
    313,
    110,
    235,
    12,
    196,
    70,
    274,
    21,
    225,
    41,
    264,
    158,
    187,
    60,
    342,
    99,
    303,
    284,
    138,
    245,
    2,
    206,
    80,
    323,
    119,
  ]
  let (transactions, setTransactions) = React.useState(_ => [])
  let handleInputChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setBetToken(_ => value)
  }
  let handleBet = betValue => {
    setBet(prev => betValue)
  }
  let handleSpin = evt => {
    let randomNumber = Js.Math.random_int(0, 36)
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
        setRouletteNumber(prev => randomNumber)
        if randomNumber == bet * 1 {
          setWin(prev => true)
        } else {
          setWin(prev => false)
        }
      }, 5000)
    }
  }
  <div className="roulette-table">
    <Win playing win />
    <Roulette playing rotateValue />
    <Table handleBet playing />
    <div className="action-panel">
      <TransactionsList win transactions />
      <RouletteNumber playing rouletteNumber />
      <div className="token-button-container">
        <Token handleInputChange betToken /> <Button handleClick=handleSpin playing />
      </div>
    </div>
  </div>
}
