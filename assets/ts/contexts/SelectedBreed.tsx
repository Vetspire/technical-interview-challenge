import { createContext } from "react";

import Breed from "../models/Breed";

type MaybeId = Breed["id"] | null;

export type SelectedContext = MaybeId;

export type DispatchContext = (id: MaybeId) => void;

export const SelectedBreedContext = createContext<SelectedContext>(null);

export const BreedDispatchContext = createContext<DispatchContext>(() => {
  throw new Error("BreedDispatchContext is not dispatching");
});
