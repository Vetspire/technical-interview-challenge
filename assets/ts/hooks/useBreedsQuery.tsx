import { useQuery } from "@tanstack/react-query";

import * as Breeds from "../services/breeds";

const useBreedsQuery = () => {
  return useQuery({
    queryFn: Breeds.get,
    queryKey: ["breeds"],
  });
};

export default useBreedsQuery;
