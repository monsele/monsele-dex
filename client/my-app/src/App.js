import './App.css';
import TokenSwap from './pages/TokenSwap'
import { BrowserRouter, Routes, Route } from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
    <Routes>
      <Route path="/swap" element={ <TokenSwap/> }/>
    </Routes>
    </BrowserRouter>
  );
}

export default App;
