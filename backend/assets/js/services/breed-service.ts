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
  } else {
    return null
  }
}