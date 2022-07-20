@react.component
let make = (~playing, ~rotateValue) => {
  let className = "ball " ++ (playing ? "show" : "")
  <div
    className
    style={ReactDOM.Style.make(
      ~transform="translate(-50%) rotate(" ++ Belt.Int.toString(rotateValue) ++ "deg)",
      ~transition=playing ? "5s all ease" : "0s",
      (),
    )}
  />
}
