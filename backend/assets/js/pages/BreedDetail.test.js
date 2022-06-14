import React from "react";
import ReactDOM from 'react-dom/client'
import { render, unmountComponentAtNode } from "react-dom";
import { act } from "react-dom/test-utils";

import BreedDetail from "./BreedDetail"

// Quick fix to deal with providing the path param in test
// Better fix would be to separate the functional component
// from the data dependent component and pass breedId down
// as a prop
jest.mock('react-router-dom', () => ({
  ...jest.requireActual('react-router-dom'),
  useParams: () => ({
    breedId: 1
  })
}))

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

it("renders breed data", async () => {
  const fakeBreed = {
    id: 1,
    name: "Cerberus",
    description: "Three heads are better than one",
    image: "/uploads/cerberus.jpg"
  }

  global.fetch = jest.fn().mockImplementation(() =>
    Promise.resolve({
      ok: true,
      status: 200,
      json: () => Promise.resolve({data: fakeBreed})
    })
  )

  await act(async () => {
    const root = ReactDOM.createRoot(container)
    root.render(<BreedDetail />)
  })

  global.fetch.mockClear()
  delete global.fetch

  expect(container.textContent).toContain(fakeBreed.name)
  expect(container.textContent).toContain(fakeBreed.description)
})

it("renders an error when a 500 status returned", async () => {
  global.fetch = jest.fn().mockImplementation(() =>
    Promise.resolve({
      ok: false,
      status: 500,
    })
  )

  await act(async () => {
    const root = ReactDOM.createRoot(container)
    root.render(<BreedDetail />)
  })

  global.fetch.mockClear()
  delete global.fetch

  expect(container.textContent).toContain("Problem loading breed")
})

it("renders a not found message when a 404 is returned", async () => {
  global.fetch = jest.fn().mockImplementation(() =>
    Promise.resolve({
      ok: false,
      status: 404,
    })
  )

  await act(async () => {
    const root = ReactDOM.createRoot(container)
    root.render(<BreedDetail />)
  })

  global.fetch.mockClear()
  delete global.fetch

  expect(container.textContent).toContain("Breed not found")
})