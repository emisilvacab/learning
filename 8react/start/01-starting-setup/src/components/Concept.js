import './Concept.css'

function Concept({ title, image, description}) {
  return (
    <li className="concept">
      <img src={image} alt="TODO: TITLE" />
      <h2>{title}</h2>
      <p>{description}</p>
    </li>
  );
}

export default Concept;