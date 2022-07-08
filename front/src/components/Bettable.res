@react.component
let make = (~handleBet, ~bettable) => {
  let onClick = _evt => {
    handleBet(bettable)
  }
  <div onClick> {React.string(Belt.Int.toString(bettable))} </div>
}
