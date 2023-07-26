import Celd from './Celd';

import styles from './Table.module.css';

const formatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD',
  minimumFractionDigits: 2,
  maximumFractionDigits: 2
});

export default function Table(props) {
  return (
    <table className={styles.result}>
      <thead>
        <tr>
          <th>Year</th>
          <th>Total Savings</th>
          <th>Interest (Year)</th>
          <th>Total Interest</th>
          <th>Invested Capital</th>
        </tr>
      </thead>
      <tbody>
        {props.data.map((yearData)=> (
          <tr key={yearData.year}>
            <Celd text={yearData.year} />
            <Celd text={formatter.format(yearData.savingsEndOfYear)} />
            <Celd text={formatter.format(yearData.yearlyInterest)} />
            <Celd text=
              {formatter.format(
                yearData.savingsEndOfYear -
                props.initialInvestment -
                yearData.yearlyContribution * yearData.year
              )}
            />
            <Celd text=
              {formatter.format(
                props.initialInvestment +
                yearData.yearlyContribution * yearData.year
              )}
            />
          </tr>
        ))}
      </tbody>
    </table>
  );
}