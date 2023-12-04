import {
  type FC,
  type PropsWithChildren,
  useEffect,
  useRef,
  useState,
} from "react";

import {
  SelectedBreedContext,
  BreedDispatchContext,
  type SelectedContext,
} from "../contexts/SelectedBreed";
import useBreedsQuery from "../hooks/useBreedsQuery";

const SelectedBreedProvider: FC<PropsWithChildren> = ({ children }) => {
  const [state, setState] = useState<SelectedContext>(null);
  const query = useBreedsQuery();

  // I decided to use a ref instead of state to track this value, because this
  // is a simple boolean that is only meant to change once (when the data is first
  // loaded) - it seemed like overkill to track this as state alongside the
  // selected breed.
  const firstLoadRef = useRef<boolean>(true);

  useEffect(() => {
    // select the first image when the page is first loaded
    if (firstLoadRef.current === false) return;
    if (query.data) {
      firstLoadRef.current = false;
      setState(Array.from(query.data.breeds.keys())[0]);
    }
  }, [query.data]);

  return (
    <SelectedBreedContext.Provider value={state}>
      <BreedDispatchContext.Provider value={setState}>
        {children}
      </BreedDispatchContext.Provider>
    </SelectedBreedContext.Provider>
  );
};

export default SelectedBreedProvider;
