import React from "react";
import ReactDOM from "react-dom/client";

import Greeter from "./greeter";

const root = ReactDOM.createRoot(
  document.getElementById('app') as HTMLElement
);
root.render(
  <React.StrictMode>
    <Greeter name="Jake" />
  </React.StrictMode>
)