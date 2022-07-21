@react.component
let make = (~playing, ~rotateValue, ~spin) => {
  let className = "ball " ++ (playing || (!playing && !spin) ? "show" : "")
  <div
    className
    style={ReactDOM.Style.make(
      ~transform="translate(-50%) rotate(" ++ Belt.Int.toString(rotateValue) ++ "deg)",
      ~transition=playing ? "6s all ease" : "0s",
      (),
    )}
  />
}
