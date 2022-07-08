@react.component
let make = (~playing, ~rotateValue) => {
  let className = "roulette " ++ (playing ? "rotate-roulette" : "")
  <div className="roulette-container">
    <img className src="/images/roulette.png" /> <Ball playing rotateValue />
  </div>
}
