@react.component
let make = (~spin, ~playing, ~rotateValue, ~rouletteNumber) => {
  <div className="roulette-number-container">
    <div
      className="roulette-container"
      style={ReactDOM.Style.make(
        ~transform=spin ? "rotate(-" ++ Belt.Int.toString(360 * 3) ++ "deg)" : "rotate(0deg)",
        ~transition=spin ? "20s all ease" : "0s",
        (),
      )}>
      <img className="roulette" src="/images/roulette.svg" /> <Ball playing rotateValue />
    </div>
    <RouletteNumber playing rouletteNumber />
  </div>
}
