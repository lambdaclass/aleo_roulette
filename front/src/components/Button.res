@react.component
let make = (~handleClick, ~playing) => {
  <button
    className="spin"
    onClick=handleClick
    style={ReactDOM.Style.make(
      ~pointerEvents=playing ? "none" : "initial",
      ~opacity=playing ? "0" : "100%",
      (),
    )}>
    {React.string("Spin")}
  </button>
}
