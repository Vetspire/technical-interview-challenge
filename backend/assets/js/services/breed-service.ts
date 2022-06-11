import { Breed, MaybeBreed } from "../models/breed.model"

export async function getBreedList(): Promise<Breed[]> {
  const response = await fetch("/api/breeds")
  if (response.ok) {
    return response.json().then(data => data.data)
  }
  throw response
}

export async function getBreed(id: string): Promise<MaybeBreed> {
  const response = await fetch(`/api/breeds/${id}`)
  if (response.ok) {
    return response.json().then(data => data.data)
  }
  return handleError(response)
}

function handleError(response: Response) {
  switch (response.status) {
    case 404:
      return new Error("Breed not found.")
    default:
      return new Error("Problem loading breed.")
  }
}