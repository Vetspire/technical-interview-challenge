import { FC } from "react";

import AppProvider from "../components/AppProvider";
import Dropdown from "../components/Dropdown";
import SelectedBreed from "../components/SelectedBreed";

const App: FC = () => {
  return (
    <AppProvider>
      <div>
        <Dropdown />
        <SelectedBreed />
      </div>
    </AppProvider>
  );
};

export default App;
