import { createContext } from "react";

import Breed from "../models/Breed";

type MaybeId = Breed["id"] | null;

export type SelectedContext = MaybeId;

export type DispatchContext = (id: MaybeId) => void;

/**
 * I broke these into separate contexts to limit unnecessary
 * re-renders, because there are some components that only need
 * the state, and others that only need the dispatch.
 */
export const SelectedBreedContext = createContext<SelectedContext>(null);

export const BreedDispatchContext = createContext<DispatchContext>(() => {
  throw new Error("BreedDispatchContext is not dispatching");
});
