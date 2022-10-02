import { GraphQLClient } from "graphql-request";

const endpoint = process.env.NEXT_PUBLIC_GRAPHQL_CLIENT_ENDPOINT as string;
const client = new GraphQLClient(endpoint);

export default client;
