@react.component
let make = (~playing, ~win) => {
  <p className="win-txt" style={ReactDOM.Style.make(~display=win ? "initial" : "none", ())}>
    {React.string(!playing && win ? "You win! " : "")}
  </p>
}
