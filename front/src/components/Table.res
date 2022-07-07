type post = int
module TextTable = {
  @react.component
  let make = (~setBet, ~playing, ~numbersList: array<post>) => {
    let onClick = _evt => {
      setBet(ReactEvent.Mouse.target(_evt)["id"])
    }
    let content = Belt.Array.map(numbersList, post => {
      <p onClick id={Belt.Int.toString(post)}> {React.string(Belt.Int.toString(post))} </p>
    })
    <div
      className="table"
      style={ReactDOM.Style.make(~pointerEvents=playing ? "none" : "initial", ())}>
      {React.array(content)}
    </div>
  }
}
@react.component
let make = (~setBet, ~playing) => {
  let numbersList = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
  ]
  <TextTable setBet playing numbersList />
}
