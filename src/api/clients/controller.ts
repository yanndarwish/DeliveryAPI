import { Router } from "express";

import { Validator } from "@/middlewares/validation";

import { getManyClients, createClient } from "@/logic/clients";

import { getManyClientsQuerySchema, createClientBodySchema } from "./validation";

import { headerSchema } from "../validation"

const clientsController = Router();

clientsController.get(
    "/",
    Validator(headerSchema, "headers"),
    Validator(getManyClientsQuerySchema, "query"),
    getManyClients
);

clientsController.post(
    "/",
    Validator(headerSchema, "headers"),
    Validator(createClientBodySchema, "body"),
    createClient
);

export { clientsController };