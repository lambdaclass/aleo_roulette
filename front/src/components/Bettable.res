@react.component
let make = (~handleBet, ~bettable) => {
  let (selected, setSelection) = React.useState(_ => false)
  let onClick = _evt => {
    setSelection(prev => !prev)
    handleBet(bettable)
  }
  let className = selected ? "selected" : ""
  <div className onClick> {React.string(Belt.Int.toString(bettable))} </div>
}
