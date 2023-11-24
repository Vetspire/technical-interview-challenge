import React from "react";
import * as ReactDOM from "react-dom/client";
import { ApolloClient, InMemoryCache, ApolloProvider } from "@apollo/client";
import BreedList from "./BreedList";

const client = new ApolloClient({
  /* Using the same host as server; obviously may be different in a "real"
   * environment.
   */
  uri: "/api",
  cache: new InMemoryCache(),
});

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <ApolloProvider client={client}>
    <BreedList />
  </ApolloProvider>,
);
