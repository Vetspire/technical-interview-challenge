import { RequestHandler } from "msw";
import { setupServer } from "msw/node";

const handlers: RequestHandler[] = [];

const server = setupServer(...handlers);

export default server;
