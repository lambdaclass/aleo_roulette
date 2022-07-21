@react.component
let make = (~handleClick, ~spin, ~readyToPlay) => {
  <button
    className="spin"
    onClick=handleClick
    style={ReactDOM.Style.make(
      ~pointerEvents=!readyToPlay || spin ? "none" : "initial",
      ~opacity=!readyToPlay || spin ? "0" : "100%",
      (),
    )}>
    {React.string("Spin")}
  </button>
}
