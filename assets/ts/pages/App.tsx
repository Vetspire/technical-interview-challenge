import { FC } from "react";

import AppProvider from "../components/AppProvider";
import BreedList from "../components/BreedList";
import SelectedBreed from "../components/SelectedBreed";
import UploadImage from "../components/UploadImage";

const App: FC = () => {
  return (
    <AppProvider>
      <div style={{ width: "75%", margin: "50px auto" }}>
        <div style={{ display: "flex" }}>
          <BreedList />
          <SelectedBreed />
        </div>
        <UploadImage />
      </div>
    </AppProvider>
  );
};

export default App;
