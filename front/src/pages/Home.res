@react.component
let make = () => {
  <div className="screen">
    <div className="headings">
      <h1> {"ALEO ROULETTE"->React.string} </h1> <h2> {"Network: Aleo Testnet3"->React.string} </h2>
    </div>
    <RouletteGame />
  </div>
}
