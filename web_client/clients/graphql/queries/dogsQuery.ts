import { gql } from "graphql-request";

import { DOG_FIELDS } from "../fragments/dog";

export default gql`
  query DOGS_QUERY {
    dogs {
      ...DogFields
    }
  }
  ${DOG_FIELDS}
`;
