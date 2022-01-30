import { request, gql } from 'graphql-request'

import Breed from "../models/breed";

const query = gql`
  {
    breeds {
        name,
        filename
    }
  }
`

export default class BreedInfoService {
    public static async getAllBreeds(): Promise<{breeds: Breed[]}> {
        const response = await request('/graphql', query);
        return response;
    }
}