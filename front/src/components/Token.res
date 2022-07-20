@react.component
let make = (~handleInputChange, ~betToken) => {
  <input
    type_="text"
    placeholder="Place your bet"
    value={betToken->Belt.Float.toString}
    onChange=handleInputChange
  />
}
