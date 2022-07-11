@react.component
let make = (~playing, ~win) => {
  <div className="win-txt" style={ReactDOM.Style.make(~opacity=win ? "100" : "0", ())}>
    <p> {React.string(!playing && win ? "YOU WIN! " : "")} </p>
  </div>
}
