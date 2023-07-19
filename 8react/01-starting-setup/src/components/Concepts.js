import Concept from "./Concept";
import "./Concepts.css"

function Concepts({ concepts }) {
  return (
    <ul id="concepts">
      <Concept
        title={concepts[0].title}
        image={concepts[0].image}
        description={concepts[0].description}
      />
      <Concept
        title={concepts[1].title}
        image={concepts[1].image}
        description={concepts[1].description}
      />
      <Concept
        title={concepts[2].title}
        image={concepts[2].image}
        description={concepts[2].description}
      />
    </ul>
  );
}

export default Concepts;