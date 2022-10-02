import { gql } from "graphql-request";

import { DOG_FIELDS } from "../fragments/dog";

export default gql`
  query DOG_QUERY($breed: String!) {
    dog(breed: $breed) {
      ...DogFields
    }
  }
  ${DOG_FIELDS}
`;
