import { Breed } from "../models/breed.model"

export async function getBreedList(): Promise<Breed[]> {
  const response = await fetch("/api/breeds")
  if (response.ok) {
    return response.json().then(data => data.data)
  }
  throw response
}