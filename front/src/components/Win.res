@react.component
let make = (~playing, ~win) => {
  let className = "win-txt " ++ (win ? "show" : "")
  <div className> <p> {React.string(!playing && win ? "YOU WIN! " : "")} </p> </div>
}
