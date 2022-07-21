@react.component
let make = (~handleClick, ~spin, ~readyToPlay, ~bet) => {
  let disabled = !readyToPlay || spin || bet == -1
  <button className={`spin ${disabled ? "disabled" : ""}`} onClick=handleClick disabled>
    {React.string(spin ? "Spinning" : "Spin")}
  </button>
}
