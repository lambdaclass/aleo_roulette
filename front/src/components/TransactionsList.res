@react.component
let make = (~transactions: array<Transaction.t>) => {
  let content = Belt.Array.map(transactions, transaction => {
    <div key=transaction.address className="transaction">
      <div id=transaction.address>
        <p> {React.string("Transaction ID: ")} </p> <p> {React.string(transaction.address)} </p>
      </div>
      <div key={transaction.token->Belt.Float.toString} id={transaction.token->Belt.Float.toString}>
        <p> {React.string("Token: ")} </p> <p> {React.float(transaction.token)} </p>
      </div>
    </div>
  })

  <div className="transaction-container">
    <div className="title"> {React.string("Transactions")} </div>
    <div className="list"> {React.array(content)} </div>
  </div>
}
