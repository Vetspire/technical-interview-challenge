import React from "react";
import ReactDOM from "react-dom/client";
import { unmountComponentAtNode } from "react-dom";
import { act } from "react-dom/test-utils";

import BreedList from './BreedList'
import { MemoryRouter } from "react-router-dom";

let container = null;
beforeEach(() => {
  container = document.createElement("div");
  document.body.appendChild(container)
});

afterEach(() => {
  unmountComponentAtNode(container);
  container.remove();
  container = null;
})

it("renders a list of breeds", async () => {
  const fakeBreeds = [
    {
      id: 1,
      name: "Cerberus",
      description: "Three heads are better than one",
      image: "/uploads/cerberus.jpg"
    },
    {
      id: 2,
      name: "Werewolf",
      description: "Is it a wolf or is it a man?",
      image: "/uploads/werewolf.jpg"
    }
  ]
  const [breed1, breed2] = fakeBreeds;

  global.fetch = jest.fn().mockImplementation(() =>
    Promise.resolve({
      ok: true,
      status: 200,
      json: () => Promise.resolve({data: fakeBreeds})
    })
  )

  await act(async () => {
    const root = ReactDOM.createRoot(container)
    root.render(
      <MemoryRouter>
        <BreedList />
      </MemoryRouter>
    )
  })

  global.fetch.mockClear()
  delete global.fetch

  expect(container.textContent).toContain(breed1.name)
  expect(container.textContent).toContain(breed2.name)
  expect(container.textContent).toContain(breed1.description)
  expect(container.textContent).toContain(breed1.description)
})