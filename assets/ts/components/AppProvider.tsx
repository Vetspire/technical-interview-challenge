import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { FC, PropsWithChildren, useState } from "react";

import {
  BreedDispatchContext,
  SelectedBreedContext,
  SelectedContext,
} from "../contexts/SelectedBreed";

const client = new QueryClient();

const AppProvider: FC<PropsWithChildren> = ({ children }) => {
  const [state, setState] = useState<SelectedContext>(null);
  return (
    <>
      <QueryClientProvider client={client}>
        <SelectedBreedContext.Provider value={state}>
          <BreedDispatchContext.Provider value={setState}>
            {children}
          </BreedDispatchContext.Provider>
        </SelectedBreedContext.Provider>
      </QueryClientProvider>
    </>
  );
};

export default AppProvider;
