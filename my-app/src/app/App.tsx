import 'reflect-metadata';
import { Routes, Route } from "react-router-dom";

import Home from "../pages/home/home";

import './App.css';

function App() {
  return (
    <div className="App">
      <h1>Vetspire Dogs Page</h1>
      <Routes>
        <Route path="/" element={<Home />} />
      </Routes>
    </div>
  );
}

export default App;
