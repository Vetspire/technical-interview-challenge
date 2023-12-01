import { FC, ReactEventHandler, useCallback, useContext } from "react";

import {
  BreedDispatchContext,
  SelectedBreedContext,
} from "../contexts/SelectedBreed";
import useBreedsQuery from "../hooks/useBreedsQuery";

const Dropdown: FC = () => {
  const query = useBreedsQuery();
  const selectedBreed = useContext(SelectedBreedContext);
  const dispatch = useContext(BreedDispatchContext);
  const onSelect = useCallback<ReactEventHandler<HTMLSelectElement>>(
    (e) => {
      const value = e.currentTarget.value
        ? parseInt(e.currentTarget.value, 10)
        : null;
      dispatch(value);
    },
    [dispatch],
  );
  return query.data ? (
    <div>
      <select value={selectedBreed ?? undefined} onChange={onSelect}>
        <option>Select a breed:</option>
        {query.data.map(({ id, name }) => (
          <option value={id} key={id}>
            {name}
          </option>
        ))}
      </select>
    </div>
  ) : null;
};

export default Dropdown;
