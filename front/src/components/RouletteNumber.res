@react.component
let make = (~spin, ~spinResult) => {
  <div className="winner-number">
    {React.string(spinResult == -1 || spin ? "" : Belt.Int.toString(spinResult))}
  </div>
}
