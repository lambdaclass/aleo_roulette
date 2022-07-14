@react.component
let make = (~active, ~handleBet, ~bettable) => {
  let onClick = _evt => {
    handleBet(bettable)
  }
  let className = active ? "selected" : ""
  <div className onClick> {React.string(Belt.Int.toString(bettable))} </div>
}
