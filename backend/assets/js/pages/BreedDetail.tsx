import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

import { Breed, MaybeBreed } from "../models/breed.model";
import { getBreed } from "../services/breed-service";

type BreedDetailParams = {
  breedId: string;
}



function BreedDetail() {
  const { breedId } = useParams<BreedDetailParams>();
  const [breed, setBreed] = useState<MaybeBreed>(null);

  useEffect(() => {
    // Will just set the breed to null in case of a 404
    // or any other error.
    // Not the most robust error handling but should be
    // sufficient for this app
    getBreed(breedId || "1").then(setBreed);
  }, [breedId])

  if (breed == null) {
    return (
      <h2>Breed not found.</h2>
    )
  }

  return (
    <div className="flex justify-center">
      <div className="rounded-lg shadow-lg bg-white max-w-sm">
        <img className="rounded-t-lg" src={breed['image']} alt={breed['name']} />
        <div className="p-6">
          <h5 className="text-gray-900 text-xl font-medium mb-2">{breed['name']}</h5>
          <p className="text-gray-700 text-base mb-4">
            {breed['description']}
          </p>
        </div>
      </div>
    </div>
  )
}

export default BreedDetail;