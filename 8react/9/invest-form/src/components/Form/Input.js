import './Input.css';

export default function Input(props) {
  return (
    <p>
      <label htmlFor={props.id}>{props.label}</label>
      <input
        type="number"
        id={props.id}
        onChange={props.onChange}
        value={props.value}
      />
    </p>
  );
}