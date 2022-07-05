@val external setTimeout: (unit => unit, int) => unit = "setTimeout"

module Control = {
  @react.component
  let make = (~setting, ~transformValue, ~doTransformValue, ~dontClick, ~newDontClick) => {
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
      if !dontClick {
        newDontClick(prev => !prev)
        setTimeout(() => {
          newDontClick(prev => !prev)
        }, 5000)
      }
    }
    <button
      className="spin"
      onClick
      style={ReactDOM.Style.make(
        ~pointerEvents=dontClick ? "none" : "initial",
        ~opacity=dontClick ? "0" : "100%",
        (),
      )}>
      {React.string("SPIN")}
    </button>
  }
}

@react.component
let make = () => {
  let (transformValue, doTransformValue) = React.useState(_ => 352)
  let (dontClick, newDontClick) = React.useState(_ => false)
  let (mode, setting) = React.useState(_ => false)
  let className = "ball " ++ (mode ? "stop-rotation" : "rotate")

  <div className="roulette-container">
    <img className="roulette" src="/images/roulette.png" />
    <div
      className
      style={ReactDOM.Style.make(
        ~transform="translate(-50%) rotate(" ++ Belt.Int.toString(transformValue) ++ "deg)",
        ~transition=mode ? "0s" : "5s all ease",
        (),
      )}
    />
    <Control setting transformValue doTransformValue dontClick newDontClick />
  </div>
}
