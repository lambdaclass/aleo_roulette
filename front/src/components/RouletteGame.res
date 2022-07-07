@val external setTimeout: (unit => unit, int) => unit = "setTimeout"

@react.component
let make = () => {
  let (rotateValue, setRotateValue) = React.useState(_ => 352)
  let (playing, setPlay) = React.useState(_ => false)
  let (bet, setBet) = React.useState(_ => 0)
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
  let onClick = evt => {
    let randomNumber = 9
    let degreeSelected = degreesArray[randomNumber]
    let circleMove = Js.Math.random_int(3, 6)

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
  <div className="roulette-container">
    <Roulette playing />
    <Ball playing rotateValue />
    <RouletteNumber rouletteNumber />
    <Win playing win />
    <Table setBet playing />
    <Button onClick playing />
  </div>
}
