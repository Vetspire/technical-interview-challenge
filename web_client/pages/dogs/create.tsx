import { useRef, useState } from "react";
import classNames from "classnames";
import type { ChangeEvent } from "react";
import type { NextPage } from "next";
import { useRouter } from "next/router";
import Link from "next/link";

import client from "clients/graphql/graphqlClient";
import CREATE_DOG_MUTATION from "clients/graphql/mutations/createDog";
import S3_PRESIGNED_URL_QUERY from "clients/graphql/queries/s3PresignedUrlQuery";
import pathTo from "utils/pathTo";

const CreateDogPage: NextPage = () => {
  const [isSubmitting, setIsSubmitting] = useState<boolean>(false);
  const inputBreedEl = useRef<HTMLInputElement | null>(null);
  const inputDescriptionEl = useRef<HTMLTextAreaElement | null>(null);
  const inputimageFileEl = useRef<HTMLInputElement | null>(null);
  const router = useRouter();

  const buttonClass = classNames("mt-4 bg-blue-500 text-white py-2 rounded", {
    "opacity-50": isSubmitting,
    "cursor-not-allowed": isSubmitting,
  });

  const handleSubmit = async (event: ChangeEvent<HTMLFormElement>) => {
    event.preventDefault();

    const breed = inputBreedEl?.current?.value as string;
    const description = inputDescriptionEl?.current?.value as string;
    const imageFile = inputimageFileEl?.current?.files?.[0] as File;

    const imageFileExtension = imageFile.name.split(".").pop();
    const filename = breed.replace(" ", "_") + "." + imageFileExtension;

    setIsSubmitting(true);

    try {
      const {
        s3PresignedUrl: { url, fields },
      } = await client.request(S3_PRESIGNED_URL_QUERY, { filename });

      const formData = new FormData();
      for (const field of fields) {
        formData.append(field.key, field.value);
      }
      formData.append("file", imageFile, filename);

      await fetch(url, {
        method: "POST",
        mode: "no-cors",
        body: formData,
      });

      const variables = {
        breed,
        description,
        filename,
      };

      const { createDog } = await client.request(
        CREATE_DOG_MUTATION,
        variables
      );

      router.push({
        pathname: `${pathTo.dogs}/[breed]`,
        query: { breed: createDog.breed },
      });
    } catch (error) {
      alert(`failed to create dog error: ${error}`);

      setIsSubmitting(false);
    }
  };

  return (
    <main className="flex flex-col max-w-sm mx-auto my-4">
      <Link href={pathTo.home}>
        <span className="underline cursor-pointer">Back</span>
      </Link>
      <h3 className="text-2xl mb-2">Create new dog breed</h3>
      <form className="flex flex-col" onSubmit={handleSubmit}>
        <label className="my-2" htmlFor="breed">
          Breed:
        </label>
        <input
          ref={inputBreedEl}
          autoComplete="off"
          className="border border-zinc-500 border-solid rounded px-2"
          type="text"
          id="breed"
          name="breed"
          required
          autoFocus
        />
        <label className="my-2" htmlFor="description">
          Description:
        </label>
        <textarea
          ref={inputDescriptionEl}
          autoComplete="off"
          className="border border-zinc-500 border-solid rounded px-2"
          id="description"
          name="description"
          required
        />
        <label className="my-2" htmlFor="imageFile">
          Image File:
        </label>
        <input
          ref={inputimageFileEl}
          type="file"
          accept="image/*"
          id="imageFile"
          name="imageFile"
          required
        />
        <button type="submit" className={buttonClass} disabled={isSubmitting}>
          {isSubmitting ? "Saving..." : "Submit"}
        </button>
      </form>
    </main>
  );
};

export default CreateDogPage;
