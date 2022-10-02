import type { NextPage, GetStaticProps } from "next";
import Link from "next/link";

import client from "clients/graphql/graphqlClient";
import DOG_QUERY from "clients/graphql/queries/dogQuery";
import DOGS_QUERY from "clients/graphql/queries/dogsQuery";
import pathTo from "utils/pathTo";

export type Props = {
  uid: string;
  breed: string;
  description: string;
  imageUrl: string;
};

export const getStaticPaths = async () => {
  const { dogs } = (await client.request(DOGS_QUERY)) as { dogs: Props[] };

  const paths = dogs.map((dog) => ({
    params: { breed: dog.breed },
  }));

  return {
    paths,
    fallback: true,
  };
};

export const getStaticProps: GetStaticProps = async (context) => {
  const { params = {} } = context;

  try {
    const variables = { breed: params.breed };
    const { dog } = await client.request(DOG_QUERY, variables);

    return {
      props: { ...dog },
    };
  } catch {
    console.error("failed to fetch dog");
    return {
      props: {},
    };
  }
};

const DogPage: NextPage<Props> = (props) => {
  const { imageUrl = "", breed = "", description = "" } = props;

  return (
    <div className="m-auto w-1/2 mt-4 text-xl">
      <Link href={pathTo.home}>
        <span className="underline cursor-pointer">Back</span>
      </Link>
      <img
        className="h-[300px] rounded my-4"
        src={imageUrl}
        alt={`picture of ${breed} dog`}
      />
      <h1 className="font-bold capitalize">Breed: {breed}</h1>
      <div>
        <h2 className="font-bold">About</h2>
        <p>{description}</p>
      </div>
    </div>
  );
};

export default DogPage;
