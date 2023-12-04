import { describe, test } from "@jest/globals";
import { fireEvent, render, screen, waitFor } from "@testing-library/react";

import * as Api from "../services/api";
import * as BreedHandlers from "../test/handlers/breeds";

import App from "./App";

const selectedTab = () => screen.getByRole("tab", { selected: true });

describe("<App />", () => {
  test("renders", async () => {
    jest
      .spyOn(Api, "get")
      .mockImplementationOnce(() =>
        Promise.resolve(BreedHandlers.MOCK_RESPONSE),
      );
    render(<App />);
    await waitFor(() => expect(selectedTab()).toBeVisible());
    expect(selectedTab().textContent).toBe("German Shepherd");

    // this will throw if more than one tab is visible
    const panel1 = screen.getByRole("tabpanel");

    expect(selectedTab().id).toEqual("tab-1");
    expect(panel1.getAttribute("aria-labelledby")).toEqual("tab-1");

    const nextTab = screen.getAllByRole("tab", { selected: false }).at(0);
    expect(nextTab).toBeDefined();
    expect(nextTab!.id).toEqual("tab-2");
    fireEvent.click(nextTab!);

    const panel2 = screen.getByRole("tabpanel");
    expect(panel2.getAttribute("aria-labelledby")).toEqual("tab-2");
  });
});
