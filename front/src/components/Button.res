@react.component
let make = (
  ~handleClick,
  ~betToken,
  ~playerRecordAmount,
  ~casinoRecordAmount,
  ~spin,
  ~readyToPlay,
  ~bet,
) => {
  let disabled =
    !readyToPlay ||
    spin ||
    bet == -1 ||
    Belt.Float.toInt(betToken) * 39 > playerRecordAmount ||
    Belt.Float.toInt(betToken) * 39 > casinoRecordAmount
  <button
    className={`spin ${disabled ? "disabled" : ""} ${spin ? "spinning" : ""}`}
    onClick=handleClick
    disabled>
    {spin ? <img src="/images/loading.svg" /> : React.string("Spin")}
  </button>
}
