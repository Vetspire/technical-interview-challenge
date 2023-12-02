import Breed from "./Breed";

export default interface Image {
  id: number;
  asset_url: string;
  breed_id: Breed["id"];
}
