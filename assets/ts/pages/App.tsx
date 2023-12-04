import { FC } from "react";

import AppProvider from "../components/AppProvider";
import Dropdown from "../components/Dropdown";
import SelectedBreed from "../components/SelectedBreed";
import UploadImage from "../components/UploadImage";

const App: FC = () => {
  return (
    <AppProvider>
      <div>
        <Dropdown />
        <SelectedBreed />
        <UploadImage />
      </div>
    </AppProvider>
  );
};

export default App;
