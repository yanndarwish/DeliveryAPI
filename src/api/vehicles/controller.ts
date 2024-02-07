import { Router } from "express"
import { Validator } from "@/middlewares/validation"

import {
	getManyVehicles,
	createVehicle,
	getOneVehicleById,
} from "@/logic/vehicles"

import {
	getManyVehiclesQuerySchema,
	createVehicleBodySchema,
	getOneVehicleParamsSchema,
} from "./validation"
import { headerSchema } from "../validation"

const vehiclesController = Router()

vehiclesController.get(
	"/",
	Validator(headerSchema, "headers"),
	Validator(getManyVehiclesQuerySchema, "query"),
	getManyVehicles
)

vehiclesController.post(
	"/",
	Validator(headerSchema, "headers"),
	Validator(createVehicleBodySchema, "body"),
	createVehicle
)

vehiclesController.get(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(getOneVehicleParamsSchema, "params"),
	getOneVehicleById
)

export { vehiclesController }
