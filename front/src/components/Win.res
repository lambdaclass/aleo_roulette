@react.component
let make = (~playing, ~win) => {
  <p className="win-txt"> {React.string(!playing && win ? "You win! " : "")} </p>
}
