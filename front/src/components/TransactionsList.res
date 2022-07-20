@react.component
let make = (~win, ~transactions: array<Transaction.t>) => {
  let content = Belt.Array.map(transactions, transaction => {
    <div className="transaction">
      <div key=transaction.address id=transaction.address>
        <p> {React.string("Transaction ID: ")} </p>
        <p> {React.string(transaction.address)} </p>
      </div>
      <div key={transaction.token->Belt.Float.toString} id={transaction.token->Belt.Float.toString}>
        <p> {React.string("Token: ")} </p>
        <p> {React.float(transaction.token)} </p>
      </div>
    </div>
  })

  <div className="transaction-container"> {React.array(content)} </div>
}
