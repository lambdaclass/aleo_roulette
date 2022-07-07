@react.component
let make = (~onClick, ~dontSpin) => {
  <button
    className="spin"
    onClick
    style={ReactDOM.Style.make(
      ~pointerEvents=dontSpin ? "none" : "initial",
      ~opacity=dontSpin ? "0" : "100%",
      (),
    )}>
    {React.string("SPIN")}
  </button>
}
