import { FC, useContext } from "react";

import { SelectedBreedContext } from "../contexts/SelectedBreed";
import useBreedsQuery from "../hooks/useBreedsQuery";

import BreedTab from "./BreedTab";

/**
 * As currently implemented, this simply renders all of the data that
 * is received from the server at once. If we were dealing with
 * a large number of items, I would want to look into using some kind
 * of virtualized list in order to limit the number of items that
 * are being rendered.
 */
const BreedList: FC = () => {
  const query = useBreedsQuery();
  const selectedBreed = useContext(SelectedBreedContext);
  return query.data ? (
    <div style={{ paddingRight: "1rem" }} role="tablist">
      {Array.from(query.data.breeds.values()).map((breed) => (
        <BreedTab
          {...breed}
          isSelected={breed.id === selectedBreed}
          key={breed.id}
        />
      ))}
    </div>
  ) : null;
};

export default BreedList;
