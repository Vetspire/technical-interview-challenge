import { describe, test } from "@jest/globals";
import { render, screen } from "@testing-library/react";

import App from "./App";

describe("<App />", () => {
  test("renders", () => {
    render(<App />);
    expect(screen.getByText("App")).toBeInTheDocument();
  });
});
