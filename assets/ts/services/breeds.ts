import { QueryFunction } from "@tanstack/react-query";

import Breed from "../models/Breed";
import Image from "../models/Image";

import * as Api from "./api";

export interface ApiSuccessResponse {
  breeds: Record<string, Breed>;
  images: Record<string, Image>;
}

export interface SuccessResponse {
  breeds: Map<Breed["id"], Breed>;
  images: Map<Image["id"], Image>;
}

const PATH = "/api/v1/breeds";

const assetMap = <key extends keyof SuccessResponse>(
  record: ApiSuccessResponse[key],
): SuccessResponse[key] =>
  new Map(Object.entries(record).map(([id, asset]) => [parseInt(id), asset]));

const parseResponse = ({
  breeds,
  images,
}: ApiSuccessResponse): SuccessResponse => ({
  breeds: assetMap<"breeds">(breeds),
  images: assetMap<"images">(images),
});

export const path = (type: string) => `${PATH}/${type}`;

export const get: QueryFunction<SuccessResponse, ["breeds", string]> = ({
  queryKey: [, type],
}) => Api.get<ApiSuccessResponse>(path(type)).then(parseResponse);

export const post = (breed: FormData) => Api.post<FormData, Breed>(PATH, breed);
