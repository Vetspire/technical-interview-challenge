import { gql } from "graphql-request";

export default gql`
  query S3_PRESIGNED_URL_QUERY($filename: String!) {
    s3PresignedUrl(filename: $filename) {
      url
      fields {
        key
        value
      }
    }
  }
`;
