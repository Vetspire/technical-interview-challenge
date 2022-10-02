import Head from "next/head";
import type { NextPage, GetServerSideProps } from "next";
import Link from "next/link";

import client from "clients/graphql/graphqlClient";
import DOGS_QUERY from "clients/graphql/queries/dogsQuery";
import PetCard from "components/PetCard";
import type { Props as Dog } from "pages/dogs/[breed]";
import pathTo from "utils/pathTo";

export const getServerSideProps: GetServerSideProps = async () => {
  try {
    const { dogs } = await client.request(DOGS_QUERY);

    return {
      props: { dogs },
    };
  } catch (error) {
    console.error("failed to fetch dogs");
    return {
      props: { dogs: [], error: "failed to fetch dogs" },
    };
  }
};

type Props = {
  dogs: Dog[];
  error?: string;
};

const HomePage: NextPage<Props> = (props) => {
  const { dogs, error = null } = props;

  return (
    <div className="flex w-screen h-screen flex-col items-center">
      <Head>
        <title>Pets</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className="flex flex-col items-center">
        <h1 className="text-6xl font-bold mb-2">Welcome to Pets website!</h1>
        <section className="flex flex-col">
          <div className="text-xl mb-2">
            <h2 className="inline-block after:content-['-'] after:mx-2">
              Dogs Breeds
            </h2>
            <Link href={`${pathTo.dogs}/create`}>
              <span className="underline text-blue-500 cursor-pointer">
                Create new breed
              </span>
            </Link>
          </div>
          {error ? (
            <p>{error}</p>
          ) : (
            <ul className="grid grid-cols-6 gap-4 auto-rows-fr">
              {dogs.map((dog) => (
                <li key={dog.uid}>
                  <PetCard {...dog} />
                </li>
              ))}
            </ul>
          )}
        </section>
      </main>
    </div>
  );
};

export default HomePage;
