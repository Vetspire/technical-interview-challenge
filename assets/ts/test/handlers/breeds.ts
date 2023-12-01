import { HttpResponse, http } from "msw";

import Breed from "../../models/Breed";
import { PATH } from "../../services/breeds";

export const MOCK_BREEDS: Breed[] = [
  "German Shepherd",
  "Border Collie",
  "Great Dane",
].map((name, i) => ({
  id: i + 1,
  name,
  image_path: `/images/dogs/${name.toLowerCase().replace(" ", "_")}.jpg`,
}));

export const success = http.get(PATH, () => HttpResponse.json(MOCK_BREEDS));

export const error = http.get(PATH, () =>
  HttpResponse.json("Unknown Error", { status: 500 }),
);
