export interface Breed {
  id: Number,
  name: string,
  image: string,
  description: string
}

export type MaybeBreed = Breed | null