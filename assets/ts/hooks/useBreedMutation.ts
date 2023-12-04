import { useMutation, useQueryClient } from "@tanstack/react-query";

import * as Breeds from "../services/breeds";

interface Props {
  type?: "dog";
}

const useBreedsMutation = ({ type = "dog" }: Props) => {
  const queryClient = useQueryClient();

  return useMutation<Breeds.SuccessResponse, Error, Breeds.PostProps>({
    mutationFn: Breeds.post,
    mutationKey: ["breeds", type],
    onSuccess: (data) => queryClient.setQueryData(["breeds", type], data),
  });
};

export default useBreedsMutation;
