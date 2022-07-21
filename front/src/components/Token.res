@react.component
let make = (~handleInputChange, ~betToken, ~spin, ~readyToPlay, ~bet) => {
  let disabled = !readyToPlay || spin || bet == -1

  <div className="bet-input">
    <label> {React.string("Tokens to bet")} </label>
    <input
      type_="number"
      min="1"
      value={betToken->Belt.Float.toString}
      onChange=handleInputChange
      disabled
      className={disabled ? "disabled" : ""}
    />
  </div>
}
