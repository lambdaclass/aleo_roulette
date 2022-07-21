@react.component
let make = (~handleClick, ~spin, ~readyToPlay, ~bet) => {
  let disabled = !readyToPlay || spin || bet == -1
  <button
    className={`spin ${disabled ? "disabled" : ""} ${spin ? "spinning" : ""}`}
    onClick=handleClick
    disabled>
    {spin ? <img src="/images/loading.svg" /> : React.string("Spin")}
  </button>
}
