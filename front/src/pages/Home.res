@react.component
let make = () => {
  <div className="screen">
    <div className="headings">
      <h1>
        <img
          src="https://assets-global.website-files.com/5e990b3bae81cf4a03433c58/5f347d008da2e477a3c61fca_Aleo-logo-white-p-500.png"
        />
        {"Roulette"->React.string}
      </h1>
    </div>
    <RouletteGame />
  </div>
}
