import { useQuery } from "@tanstack/react-query";

import * as Breeds from "../services/breeds";

const useBreedsQuery = (type: string = "dog") => {
  return useQuery({
    queryFn: Breeds.get,
    queryKey: ["breeds", type],
  });
};

export default useBreedsQuery;
