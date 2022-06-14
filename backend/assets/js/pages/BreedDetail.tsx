import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

import { Breed, MaybeBreed } from "../models/breed.model";
import { getBreed } from "../services/breed-service";

type BreedDetailParams = {
  breedId: string;
}



function BreedDetail(): JSX.Element {
  const { breedId } = useParams<BreedDetailParams>();
  const [breed, setBreed] = useState<MaybeBreed>(null);

  useEffect(() => {
    getBreed(breedId || "1").then(setBreed);
  }, [breedId])

  if (breed == null) {
    return (
      <div>
        {/* Show nothing while loading. This is a quick fix to avoid flashing error text */}
      </div>
    );
  }

  if (breed instanceof Error) {
    return (
      <p>{breed.message}</p>
    );
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
  );
}

export default BreedDetail;