import React from "react";
import { useState } from "react";
import { useQuery, gql } from "@apollo/client";
import BreedImage from "./BreedImage";
import "./breeds.css";

const FETCH_BREEDS = gql`
  query FetchBreeds {
    breeds {
      id
      name
    }
  }
`;

export default function BreedList() {
  const { loading, error, data } = useQuery(FETCH_BREEDS);
  const [shownImageIds, setShowImageIds] = useState([]);

  const toggleShown = (id) => {
    if (shownImageIds.includes(id)) {
      setShowImageIds(shownImageIds.filter((shownId) => shownId != id));
    } else {
      setShowImageIds(shownImageIds.concat([id]));
    }
  };

  if (loading) return <p>Loading...</p>;
  if (error) return <p className="error">Error! Could not load breeds list!</p>;

  console.log(typeof shownImageIds);

  const breedBoxes = data.breeds.map(({ id, name }) => (
    <div className="breed-box" key={id}>
      <h3 className="breed-title">{name}</h3>
      {shownImageIds.includes(id) ? (
        <BreedImage id={id} />
      ) : (
        <button onClick={() => toggleShown(id)} className="breed-image-show">
          Show Image
        </button>
      )}
    </div>
  ));

  return <div className="breeds">{breedBoxes}</div>;
}
