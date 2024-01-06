import { Router } from "express";

import { Validator } from "@/middlewares/validation";

import { getManyRelays } from "@/logic/relays";

import { getManyRelaysQuerySchema } from "./validation";

import { headerSchema } from "../validation";

const relaysController = Router();

relaysController.get(
    "/",
    Validator(headerSchema, "headers"),
    Validator(getManyRelaysQuerySchema, "query"),
    getManyRelays
);

export { relaysController };