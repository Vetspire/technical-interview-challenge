import Link from "next/link";

import pathTo from "utils/pathTo";

type Props = {
  breed: string;
  imageUrl: string;
};

const PetCard = (props: Props) => {
  const { breed, imageUrl } = props;
  const href = `${pathTo.dogs}/${encodeURI(breed)}`;

  return (
    <Link href={href}>
      <a>
        <div className="h-full border-solid border border-slate-600 rounded-md">
          <img
            className="p-0 object-cover h-[100px] w-[100px] rounded rounded-b-none"
            src={imageUrl}
            alt=""
            width="100"
            height="100"
          />
          <p className="w-[100px] text-sm px-2 py-2 word-break capitalize">
            {breed}
          </p>
        </div>
      </a>
    </Link>
  );
};

export default PetCard;
