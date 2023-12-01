import Breed from "../models/Breed";

import * as Api from "./api";

export const PATH = "/api/v1/breeds";

export const get = () => Api.get<Breed[]>(PATH);

export const post = (breed: FormData) => Api.post<FormData, Breed>(PATH, breed);
