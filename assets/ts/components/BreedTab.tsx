import { FC, memo, useContext } from "react";

import { BreedDispatchContext } from "../contexts/SelectedBreed";
import Breed from "../models/Breed";

interface Props extends Breed {
  isSelected: boolean;
}

const BreedTab: FC<Props> = ({ id, isSelected, name }) => {
  const dispatch = useContext(BreedDispatchContext);
  return (
    <div
      id={`tab-${id}`}
      role="tab"
      aria-selected={isSelected}
      key={id}
      onClick={() => dispatch(id)}
      style={{
        background: isSelected ? "orange" : undefined,
        cursor: "pointer",
      }}
    >
      {name}
    </div>
  );
};

// memoized to prevent unnecessary renders
export default memo(BreedTab);
