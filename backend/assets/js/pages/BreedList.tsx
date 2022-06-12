import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";

import { Breed } from "../models/breed.model";
import {getBreedList} from '../services/breed-service'

function BreedList() {
  const [breeds, setBreeds] = useState<Breed[]>([]);

  useEffect(() => {
      getBreedList().then(setBreeds)
  }, [])

  return (
    <div>
      <div className="text-center">
        <h1 className="text-3xl text-gray-800 font-semibold">
          Dog Breeds
        </h1>
        <p className="mt-3 text-gray-500">
          All your favorite dogs, now in one place.
        </p>
        <Link to="new">
          <button type="button" className="py-2.5 px-7 my-2 text-sm font-medium text-gray-900 bg-white rounded-lg border border-gray-300 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-200">
            Add a Breed
          </button>
        </Link>
      </div>
      <div className="mt-12 grid gap-2 sm:grid-cols-2 lg:grid-cols-3">
        {breeds.map(BreedCard)}
      </div>
    </div>
  )
}

function BreedCard(breed: Breed): JSX.Element {
  return (
    <article className="max-w-md mx-auto mt-4 shadow-lg border rounded-md duration-300 hover:shadow-sm" key={breed.id.toString()}>
      <Link to={`/breeds/${breed.id.toString()}`} state={{ breedName: breed.name}}>
        <img src={breed.image} alt={breed.name} loading="lazy" className="w-full h-48 rounded-t-md" />
        <div className="pt-3 ml-4 mr-2 mb-3">
          <h3 className="text-xl text-gray-900">
            {breed.name}
          </h3>
          <p className="text-gray-400 text-sm-mt-1">
            {breed.description}
          </p>
        </div>
      </Link>
    </article>
  )
}

export default BreedList;