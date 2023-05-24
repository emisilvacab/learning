// import logo from './logo.svg';
// import './App.css';

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

// export default App;
import React from "react";

import './App.css';
import IdeaButton from "./components/IdeaButton/IdeaButton";
import Copyright from "./components/Copyright/Copyright";

function logIdea() {
    console.log('Someone had an idea!');
}

export default function App() {
    return (
        <div className="App">
            <div className="App-header">
                <IdeaButton
                    message="I have an idea!"
                    handleClick={logIdea}
                />
            </div>
            <footer>
                <Copyright />
                <IdeaButton
                    message="Footer idea!"
                    handleClick={logIdea}
                />
            </footer>
        </div>
    );
}