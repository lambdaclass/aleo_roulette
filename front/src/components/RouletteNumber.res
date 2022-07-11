@react.component
let make = (~playing, ~rouletteNumber) => {
  <div className="winner-number">
    {React.string(rouletteNumber == -1 || playing ? "" : Belt.Int.toString(rouletteNumber))}
  </div>
}
