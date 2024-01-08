import { Router } from "express"

import { Validator } from "@/middlewares/validation"

import {
	getManyRelays,
	createRelay,
	getOneRelayById,
	updateRelay,
	deleteOneRelayById,
} from "@/logic/relays"

import {
	getManyRelaysQuerySchema,
	createRelayBodySchema,
	getOneRelayParamsSchema,
	updateOneRelayParamsSchema,
	updateOneRelayBodySchema,
	deleteOneRelayParamsSchema,
} from "./validation"

import { headerSchema } from "../validation"

const relaysController = Router()

relaysController.get(
	"/",
	Validator(headerSchema, "headers"),
	Validator(getManyRelaysQuerySchema, "query"),
	getManyRelays
)

relaysController.post(
	"/",
	Validator(headerSchema, "headers"),
	Validator(createRelayBodySchema, "body"),
	createRelay
)

relaysController.get(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(getOneRelayParamsSchema, "params"),
	getOneRelayById
)

relaysController.put(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(updateOneRelayParamsSchema, "params"),
	Validator(updateOneRelayBodySchema, "body"),
	updateRelay
)

relaysController.delete(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(deleteOneRelayParamsSchema, "params"),
	deleteOneRelayById
)

export { relaysController }
