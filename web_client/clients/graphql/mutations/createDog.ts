import { gql } from "graphql-request";

import { DOG_FIELDS } from "../fragments/dog";

export default gql`
  mutation CREATE_DOG_MUTATION($breed: String!, $description: String!, $filename: String!) {
    createDog(breed: $breed, description: $description, filename: $filename) {
      ...DogFields
    }
  }
  ${DOG_FIELDS}
`;
