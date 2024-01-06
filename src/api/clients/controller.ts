import { Router } from "express"

import { Validator } from "@/middlewares/validation"

import { getManyClients, createClient, getOneClientById, updateClient } from "@/logic/clients"

import {
	getManyClientsQuerySchema,
	createClientBodySchema,
	getOneClientParamsSchema,
	updateOneClientParamsSchema,
	updateOneClientBodySchema,
} from "./validation"

import { headerSchema } from "../validation"

const clientsController = Router()

clientsController.get(
	"/",
	Validator(headerSchema, "headers"),
	Validator(getManyClientsQuerySchema, "query"),
	getManyClients
)

clientsController.post(
	"/",
	Validator(headerSchema, "headers"),
	Validator(createClientBodySchema, "body"),
	createClient
)

clientsController.get(
    "/:id",
    Validator(headerSchema, "headers"),
    Validator(getOneClientParamsSchema, "params"),
    getOneClientById
)

clientsController.put(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(updateOneClientParamsSchema, "params"),
	Validator(updateOneClientBodySchema, "body"),
	updateClient
)

export { clientsController }
