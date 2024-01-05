import { Router } from "express";

import { Validator } from "@/middlewares/validation";

import { getManyClients } from "@/logic/clients";

import { getManyClientsQuerySchema } from "./validation";

const clientsController = Router();

clientsController.get(
    "/",
    Validator(getManyClientsQuerySchema, "query"),
    getManyClients
);

export { clientsController };