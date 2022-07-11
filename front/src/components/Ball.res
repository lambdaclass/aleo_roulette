@react.component
let make = (~playing, ~rotateValue) => {
  <div
    className="ball"
    style={ReactDOM.Style.make(
      ~transform="translate(-50%) rotate(" ++ Belt.Int.toString(rotateValue) ++ "deg)",
      ~transition=playing ? "5s all ease" : "0s",
      (),
    )}
  />
}
