type number = int
@react.component
let make = (~handleBet, ~playing) => {
  let numbersList = Belt.Array.range(0, 36)
  let content = Belt.Array.map(numbersList, number => {
    <div key={Belt.Int.toString(number)} id={Belt.Int.toString(number)}>
      <Bettable bettable=number handleBet />
    </div>
  })
  <div
    className="table" style={ReactDOM.Style.make(~pointerEvents=playing ? "none" : "initial", ())}>
    {React.array(content)}
  </div>
}