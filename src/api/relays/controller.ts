import { Router } from "express";

import { Validator } from "@/middlewares/validation";

import { getManyRelays, createRelay } from "@/logic/relays";

import { getManyRelaysQuerySchema, createRelayBodySchema } from "./validation";

import { headerSchema } from "../validation";

const relaysController = Router();

relaysController.get(
    "/",
    Validator(headerSchema, "headers"),
    Validator(getManyRelaysQuerySchema, "query"),
    getManyRelays
);

relaysController.post(
    "/",
    Validator(headerSchema, "headers"),
    Validator(createRelayBodySchema, "body"),
    createRelay
);

export { relaysController };