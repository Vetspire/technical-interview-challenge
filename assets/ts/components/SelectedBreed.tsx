import { FC, useContext, useMemo } from "react";

import { SelectedBreedContext } from "../contexts/SelectedBreed";
import useBreedsQuery from "../hooks/useBreedsQuery";

const SelectedBreed: FC = () => {
  const breeds = useBreedsQuery();
  const selectedBreedId = useContext(SelectedBreedContext);
  const breed = useMemo(() => {
    return breeds.data
      ? breeds.data.find(({ id }) => id === selectedBreedId)
      : null;
  }, [selectedBreedId, breeds]);

  if (!breed) return null;
  return (
    <div>
      <img src={breed.image_path} />
    </div>
  );
};

export default SelectedBreed;
