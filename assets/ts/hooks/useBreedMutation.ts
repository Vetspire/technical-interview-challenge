import { useMutation } from "@tanstack/react-query";

import * as Breeds from "../services/breeds";

interface Props {
  type?: "dog";
}

const useBreedsMutation = ({ type = "dog" }: Props) => {
  return useMutation<Breeds.SuccessResponse, Error, Breeds.PostProps>({
    mutationFn: Breeds.post,
    mutationKey: ["breeds", type, name],
  });
};

export default useBreedsMutation;
