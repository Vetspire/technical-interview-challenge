import { HttpResponse, http } from "msw";

import * as Breeds from "../../services/breeds";

const BREED_NAMES = ["German Shepherd", "Border Collie", "Great Dane"];

const MOCK_BREEDS: Breeds.ApiSuccessResponse["breeds"] = Object.fromEntries(
  BREED_NAMES.map((name, i) => {
    const id = i + 1;
    return [
      id.toString(),
      {
        id,
        name,
        image_id: id,
      },
    ];
  }),
);

const MOCK_IMAGES: Breeds.ApiSuccessResponse["images"] = Object.fromEntries(
  BREED_NAMES.map((name, i) => {
    const id = i + 1;
    return [
      id.toString(),
      {
        id,
        asset_url: `/images/dogs/${name.toLowerCase().replace(" ", "_")}.jpg`,
        breed_id: id,
      },
    ];
  }),
);

export const MOCK_RESPONSE: Breeds.ApiSuccessResponse = {
  breeds: MOCK_BREEDS,
  images: MOCK_IMAGES,
};

export const success = http.get(Breeds.path("dog"), () =>
  HttpResponse.json(MOCK_RESPONSE),
);

export const error = http.get(Breeds.path("dog"), () =>
  HttpResponse.json("Unknown Error", { status: 500 }),
);
