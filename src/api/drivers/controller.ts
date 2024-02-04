import { Router } from "express"

import { Validator } from "@/middlewares/validation"

import {
	getManyDrivers,
	createDriver,
	getOneDriverById,
	updateDriver,
	deleteOneDriverById,
} from "@/logic/drivers"

import {
	getManyDriversQuerySchema,
	createDriverBodySchema,
	getOneDriverParamsSchema,
	updateOneDriverParamsSchema,
	updateOneDriverBodySchema,
	deleteOneDriverParamsSchema,
} from "./validation"

import { headerSchema } from "../validation"

const driversController = Router()

driversController.get(
	"/",
	Validator(headerSchema, "headers"),
	Validator(getManyDriversQuerySchema, "query"),
	getManyDrivers
)

driversController.post(
	"/",
	Validator(headerSchema, "headers"),
	Validator(createDriverBodySchema, "body"),
	createDriver
)

driversController.get(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(getOneDriverParamsSchema, "params"),
	getOneDriverById
)

driversController.put(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(updateOneDriverParamsSchema, "params"),
	Validator(updateOneDriverBodySchema, "body"),
	updateDriver
)

driversController.delete(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(deleteOneDriverParamsSchema, "params"),
	deleteOneDriverById
)

export { driversController }
