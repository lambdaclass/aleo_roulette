@react.component
let make = (~onClick, ~playing) => {
  <button
    className="spin"
    onClick
    style={ReactDOM.Style.make(
      ~pointerEvents=playing ? "none" : "initial",
      ~opacity=playing ? "0" : "100%",
      (),
    )}>
    {React.string("SPIN")}
  </button>
}
