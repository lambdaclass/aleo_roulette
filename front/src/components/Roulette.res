@react.component
let make = (~spin, ~playing, ~rotateValue, ~spinResult) => {
  let rouletteSpinCount = "31"
  <div className="roulette-number-container">
    <div
      className="roulette-container"
      style={ReactDOM.Style.make(
        ~transform=spin ? "rotate(-" ++ Belt.Int.toString(360 * 7) ++ "deg)" : "rotate(0deg)",
        ~transition=spin ? `${rouletteSpinCount}s all ease-out` : "0s",
        (),
      )}>
      <img className="roulette" src="/images/roulette.svg" /> <Ball playing rotateValue spin />
    </div>
    <RouletteNumber spin spinResult />
  </div>
}
