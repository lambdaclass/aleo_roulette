@react.component
let make = (~win, ~transactions: array<Transaction.t>) => {
  let content = Belt.Array.map(transactions, transaction => {
    <div className="transaction">
      <div key=transaction.address id=transaction.address>
        <p> {React.string("Transaction ID: ")} </p> <p> {React.string(transaction.address)} </p>
      </div>
      <div key={transaction.token} id={transaction.token}>
        <p> {React.string("Token: ")} </p> <p> {React.string(transaction.token)} </p>
      </div>
    </div>
  })

  <div className="transaction-container"> {React.array(content)} </div>
}
