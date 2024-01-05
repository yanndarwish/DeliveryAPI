import { Router } from "express";

import { Validator } from "@/middlewares/validation";

import { getManyClients } from "@/logic/clients";

import { getManyClientsQuerySchema } from "./validation";

import { headerSchema } from "../validation"

const clientsController = Router();

clientsController.get(
    "/",
    Validator(headerSchema, "headers"),
    Validator(getManyClientsQuerySchema, "query"),
    getManyClients
);

export { clientsController };