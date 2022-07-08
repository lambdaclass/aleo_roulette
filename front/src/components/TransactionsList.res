@react.component
let make = (~win, ~transactions: array<Transaction.t>) => {
  let content = Belt.Array.map(transactions, transaction => {
    <div className="transaction">
      <p key=transaction.address id=transaction.address>
        {React.string("Transaction ID: " ++ transaction.address)}
      </p>
      <p key={transaction.token} id={transaction.token}>
        {React.string("Token: " ++ transaction.token)}
      </p>
    </div>
  })

  <div className="transaction-container">
    <p className="win-txt" style={ReactDOM.Style.make(~display=win ? "initial" : "none", ())}>
      {React.string(win ? "te pagan" : "pagaste")}
    </p>
    {React.array(content)}
  </div>
}
