@react.component
let make = (~playing, ~rouletteNumber) => {
  <div className="win-txt">
    {React.string(rouletteNumber == -1 || playing ? "" : Belt.Int.toString(rouletteNumber))}
  </div>
}
