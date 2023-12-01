import "@testing-library/jest-dom";
import { beforeAll, beforeEach, afterAll } from "@jest/globals";

import server from "./ts/test/msw";

beforeAll(() => server.listen());
beforeEach(() => server.resetHandlers());
afterAll(() => server.close());
