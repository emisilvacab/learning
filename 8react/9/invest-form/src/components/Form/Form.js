import { useState } from "react";

import Input from "./Input";
import Button from "./Button";

import styles from './Form.module.css';

export default function Form(props) {
  const initialUserInput = {
    'current-savings': 10000,
    'yearly-contribution': 1200,
    'expected-return': 7,
    duration: 10
  }
  const [userInput, setUserInput] = useState(initialUserInput);

  const submitHandler = (event) => {
    event.preventDefault();

    props.onCalculate(userInput);
  };

  const resetHandler = () => {
    setUserInput(initialUserInput);
  };

  const inputChangeHandler = (input, value) => {
    setUserInput((prevInput) => {
      return {
        ...prevInput,
        [input]: value,
      };
    });
  };

  return (
    <form onSubmit={submitHandler} className={styles.form}>
      <div className={styles['input-group']}>
        <Input
          label="Current Savings ($)"
          id="current-savings"
          value={userInput['current-savings']}
          onChange={(event) =>
            inputChangeHandler('current-savings', event.target.value)
          }
        />
        <Input
          label="Yearly Contribution ($)"
          id="yearly-contribution"
          value={userInput['yearly-contribution']}
          onChange={(event) =>
            inputChangeHandler('yearly-contribution', event.target.value)
          }
        />
      </div>
      <div className={styles['input-group']}>
        <Input
          label="Expected Interest (%, per year)"
          id="expected-return"
          value={userInput['expected-return']}
          onChange={(event) =>
            inputChangeHandler('expected-return', event.target.value)
          }
        />
        <Input
          label="Investment Duration(years)"
          id="duration"
          value={userInput['duration']}
          onChange={(event) =>
            inputChangeHandler('duration', event.target.value)
          }
        />
      </div>
      <p className={styles.actions}>
        <Button
          type="reset"
          className="buttonAlt"
          text="Reset"
          onClick={resetHandler}
        />
        <Button
          type="submit"
          className="button"
          text="Calculate"
        />
      </p>
    </form>
  );
}