@react.component
let make = (~mode, ~transformValue) => {
  let className = "ball " ++ (mode ? "stop-rotation" : "rotate")
  <div
    className
    style={ReactDOM.Style.make(
      ~transform="translate(-50%) rotate(" ++ Belt.Int.toString(transformValue) ++ "deg)",
      ~transition=mode ? "0s" : "5s all ease",
      (),
    )}
  />
}
