@react.component
let make = (~rouletteNumber) => {
  <p className="win-txt">
    {React.string(
      rouletteNumber == -1 ? "" : "Lucky number: " ++ Belt.Int.toString(rouletteNumber),
    )}
  </p>
}
