import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { type FC, type PropsWithChildren } from "react";

import SelectedBreedProvider from "./SelectedBreedProvider";

const client = new QueryClient();

const AppProvider: FC<PropsWithChildren> = ({ children }) => {
  return (
    <>
      <QueryClientProvider client={client}>
        <SelectedBreedProvider>{children}</SelectedBreedProvider>
      </QueryClientProvider>
    </>
  );
};

export default AppProvider;
