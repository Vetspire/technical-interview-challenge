import { FC, useContext, useMemo } from "react";

import { SelectedBreedContext } from "../contexts/SelectedBreed";
import useBreedsQuery from "../hooks/useBreedsQuery";

const SelectedBreed: FC = () => {
  const query = useBreedsQuery();
  const selectedBreedId = useContext(SelectedBreedContext);
  const breed = useMemo(() => {
    return query.data && selectedBreedId
      ? query.data.breeds.get(selectedBreedId)
      : null;
  }, [selectedBreedId, query.data]);

  const image = useMemo(() => {
    return query.data && breed ? query.data.images.get(breed.image_id) : null;
  }, [breed, query.data]);

  if (!breed) return null;
  if (!image)
    throw new Error("unable to find image for breed", {
      cause: {
        data: query.data,
        breed,
      },
    });
  return (
    <div>
      <img src={image.asset_url} />
    </div>
  );
};

export default SelectedBreed;
