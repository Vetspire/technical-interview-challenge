import React from "react";
import { useQuery, gql } from "@apollo/client";

const FETCH_BREED_IMAGE = gql`
  query FetchBreedImage($id: ID!) {
    breed(id: $id) {
      imageUrl
    }
  }
`;

export default function BreedImage({ id }) {
  const { loading, error, data } = useQuery(FETCH_BREED_IMAGE, {
    variables: { id },
  });

  if (loading) return null;
  if (error) return "Error loading image";

  return <img className="breed-image" src={data.breed.imageUrl} />;
}
