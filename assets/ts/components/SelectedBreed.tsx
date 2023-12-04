import { FC, useContext, useMemo } from "react";

import { SelectedBreedContext } from "../contexts/SelectedBreed";
import useBreedsQuery from "../hooks/useBreedsQuery";

const SelectedBreed: FC = () => {
  const selectedBreedId = useContext(SelectedBreedContext);
  const { data } = useBreedsQuery();

  const breed = useMemo(() => {
    return data && selectedBreedId ? data.breeds.get(selectedBreedId) : null;
  }, [selectedBreedId, data]);

  const image = useMemo(() => {
    return data && breed ? data.images.get(breed.image_id) : null;
  }, [breed, data]);

  if (!breed) return null;
  if (!image)
    throw new Error("unable to find image for breed!", {
      cause: { data, breed },
    });

  return (
    <div>
      <img
        src={
          image.asset_url.startsWith("/")
            ? image.asset_url
            : "/" + image.asset_url
        }
      />
    </div>
  );
};

export default SelectedBreed;
