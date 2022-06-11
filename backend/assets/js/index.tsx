import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter, Route, Routes } from "react-router-dom";

import App from "./App";
import BreedDetail from "./pages/BreedDetail";
import BreedList from "./pages/BreedList";
import Default from "./pages/Default";

const root = ReactDOM.createRoot(
  document.getElementById('app') as HTMLElement
);
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<App />}>
          <Route index element={<Default />} />
          <Route path="breeds/:breedId" element={<BreedDetail />} />
          <Route path="breeds" element={<BreedList />} />
        </Route>
      </Routes>
    </BrowserRouter>
  </React.StrictMode>
)