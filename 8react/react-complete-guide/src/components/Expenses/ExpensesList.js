import ExpenseItem from "./ExpenseItem";
import './ExpensesList.css'

export default function ExpensesList(props) {
  return (
    props.items.length === 0 ?
    (
      <h2 className="expenses-list__fallback">No expenses found.</h2>
    ) : (
      <ul className="expenses-list">
        {props.items.map((expense) =>
          <ExpenseItem
            key={expense.id}
            title={expense.title}
            amount={expense.amount}
            date={expense.date}
          />
        )}
      </ul>
    )
  )
}