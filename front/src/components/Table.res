type number = int
@react.component
let make = (~bet, ~handleBet, ~playing) => {
  let numbersList = Belt.Array.range(0, 36)
  let content = Belt.Array.map(numbersList, number => {
    <div key={Belt.Int.toString(number)} id={Belt.Int.toString(number)}>
      <Bettable bettable=number active={bet == number} handleBet />
    </div>
  })
  <div className="table-wrapper">
    // This should be changed to conditional rendering
    <div className="current-bet" style={ReactDOM.Style.make(~display=bet == -1 ? "none" : "", ())}>
      {"Current bet: "->React.string} <span> {bet->React.int} </span>
    </div>
    <div
      className="table"
      style={ReactDOM.Style.make(~pointerEvents=playing ? "none" : "initial", ())}>
      {React.array(content)}
    </div>
  </div>
}
