import { ChangeEventHandler, FC, useCallback } from "react";

import useBreedsMutation from "../hooks/useBreedMutation";

const UploadImage: FC = () => {
  const breedMutation = useBreedsMutation({});

  const onSubmit = useCallback<ChangeEventHandler<HTMLFormElement>>(
    (e) => {
      e.preventDefault();
      breedMutation.mutateAsync({ form: new FormData(e.currentTarget) });
    },
    [breedMutation],
  );

  return (
    <div>
      <p>Add a new breed:</p>

      {breedMutation.isPending ? (
        <p>Loading...</p>
      ) : (
        <form id="breed_form" name="breed" onSubmit={onSubmit}>
          <div>
            <label htmlFor="breed_name">Breed name:</label>
            <input id="breed_name" type="text" name="breed_name"></input>
          </div>
          <label htmlFor="image_file">Upload File:</label>
          <input
            type="file"
            id="image_file"
            name="image_file"
            accept="image/*"
          />
          <button type="submit">Create</button>
        </form>
      )}
    </div>
  );
};

export default UploadImage;
