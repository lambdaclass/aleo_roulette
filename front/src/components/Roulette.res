@react.component
let make = (~playing) => {
  let className = "roulette " ++ (playing ? "rotate-roulette" : "")
  <img className src="/images/roulette.png" />
}
