import React, { useCallback, useState } from 'react';

import Button from './components/UI/Button/Button';
import './App.css';
import DemoOutput from './components/Demo/DemoOutput';
import DemoList from './components/Demo/DemoList';

function App() {
  const [showParagraph, setShowParagraph] = useState(false);
  const [allowToggle, setAllowToggle] = useState(false);
  const [listTitle, setListTitle] = useState('My List');

  console.log('APP RUNNING');

  const toggleParagraphHandler = useCallback(() => {
    if (allowToggle)
      setShowParagraph((prevShowParagraph) => !prevShowParagraph)
  }, [allowToggle]);

  const allowToggleHandler = () => {
    setAllowToggle(true);
  };

  const changeTitleHandler = useCallback(() => {
    setListTitle('New Title');
  }, []);

  return (
    <div className="app">
      <h1>Hi there!</h1>
      <DemoList title={listTitle} items={[5, 3, 1, 10, 9]} />
      <Button onClick={changeTitleHandler}>Change List Title</Button>
      <DemoOutput show={showParagraph} />
      {/* <Button onClick={allowToggleHandler}>Allow Toggling!</Button> */}
      {/* <Button onClick={toggleParagraphHandler}>Toggle Paragraph!</Button> */}
    </div>
  );
}

export default App;
