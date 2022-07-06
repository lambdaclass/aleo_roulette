@val external setTimeout: (unit => unit, int) => unit = "setTimeout"

module Control = {
  @react.component
  let make = (~setting, ~transformValue, ~doTransformValue, ~dontSpin, ~newDontSpin) => {
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
      147,
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
      ReactEvent.Mouse.preventDefault(evt)
      setting(prev => !prev)

      let randomNumber = Js.Math.random_int(0, 36)
      let circleMove = Js.Math.random_int(3, 6)
      let degreeSelected = degreesArray[randomNumber]

      doTransformValue(_prev => transformValue - 360 * circleMove)
      setTimeout(() => {
        setting(prev => !prev)
        doTransformValue(_prev => degreeSelected + 360 * circleMove)
      }, 1)

      if !dontSpin {
        newDontSpin(prev => !prev)
        setTimeout(() => {
          newDontSpin(prev => !prev)
        }, 5000)
      }
    }
    <Button onClick dontSpin />
  }
}

@react.component
let make = () => {
  let (transformValue, doTransformValue) = React.useState(_ => 352)
  let (dontSpin, newDontSpin) = React.useState(_ => false)
  let (mode, setting) = React.useState(_ => false)

  <div className="roulette-container">
    <Roulette />
    <Ball mode transformValue />
    <Control setting transformValue doTransformValue dontSpin newDontSpin />
  </div>
}
