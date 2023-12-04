import { type ChangeEventHandler, type FC } from "react";

import useBreedsMutation from "../hooks/useBreedMutation";

const UploadImage: FC = () => {
  const breedMutation = useBreedsMutation({});

  const onSubmit: ChangeEventHandler<HTMLFormElement> = (e) => {
    e.stopPropagation();
    e.preventDefault();
    breedMutation
      .mutateAsync({ form: new FormData(e.currentTarget) })
      .then(() => {});
  };

  return (
    <div
      style={{ border: "1px solid black", padding: "1rem", maxWidth: "20rem" }}
    >
      <h2 style={{ fontSize: "1.5rem" }}>Add a new breed:</h2>

      {breedMutation.isPending ? (
        <p>Loading...</p>
      ) : (
        <form
          id="breed_form"
          name="breed"
          onSubmit={onSubmit}
          style={{
            display: "flex",
            flexDirection: "column",
            gap: "1rem",
          }}
        >
          <div>
            <label htmlFor="breed_name">Breed name:</label>
            <input id="breed_name" type="text" name="breed_name"></input>
          </div>
          <div>
            <label htmlFor="image_file">Upload File:</label>
            <input
              type="file"
              id="image_file"
              name="image_file"
              accept="image/*"
            />
          </div>
          <button
            type="submit"
            style={{
              display: "block",
              borderRadius: ".5rem",
              background: "orange",
              padding: ".5rem",
            }}
          >
            Create
          </button>
        </form>
      )}
    </div>
  );
};

export default UploadImage;
