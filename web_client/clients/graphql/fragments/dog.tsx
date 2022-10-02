import { gql } from "graphql-request";

export const DOG_FIELDS = gql`
  fragment DogFields on Dog {
    uid
    breed
    description
    imageUrl
  }
`;
