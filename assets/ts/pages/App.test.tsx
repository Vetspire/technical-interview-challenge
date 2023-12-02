import { describe, test } from "@jest/globals";
import { fireEvent, render, screen, waitFor } from "@testing-library/react";

import * as Api from "../services/api";
import * as BreedHandlers from "../test/handlers/breeds";

import App from "./App";

describe("<App />", () => {
  test("renders", async () => {
    jest
      .spyOn(Api, "get")
      .mockImplementationOnce(() =>
        Promise.resolve(BreedHandlers.MOCK_RESPONSE),
      );
    render(<App />);
    await waitFor(() =>
      expect(
        screen.getByRole("option", { name: "Select a breed:", selected: true }),
      ).toBeVisible(),
    );

    expect(screen.queryByRole("img")).not.toBeInTheDocument();

    fireEvent.change(screen.getByRole("combobox"), { target: { value: 1 } });
    expect(screen.getByRole("img")).toBeInTheDocument();
  });
});
