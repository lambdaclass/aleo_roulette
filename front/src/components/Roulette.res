@react.component
let make = (~spin, ~playing, ~rotateValue, ~spinResult) => {
  <div className="roulette-number-container">
    <div className={`roulette-container rotate-roulette ${spin ? "" : "pause-animation"}`}>
      <img className="roulette" src="/images/roulette.svg" /> <Ball playing rotateValue spin />
    </div>
    <RouletteNumber spin spinResult />
  </div>
}
