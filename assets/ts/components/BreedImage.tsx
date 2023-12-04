import { FC, memo } from "react";

import Image from "../models/Image";

interface Props extends Image {
  isHidden: boolean;
}

const BreedImage: FC<Props> = ({ asset_url, breed_id, isHidden }) => {
  return (
    <div
      id={`panel-${breed_id}`}
      key={`breed-image-${breed_id}`}
      role="tabpanel"
      aria-labelledby={`tab-${breed_id}`}
      hidden={isHidden}
    >
      <img src={asset_url} />
    </div>
  );
};

// memoized to prevent unnecessary re-renders
export default memo(BreedImage);
