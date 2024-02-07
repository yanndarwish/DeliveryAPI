import { Router } from "express"
import { Validator } from "@/middlewares/validation"

import {
	getManyVehicles,
	createVehicle,
	getOneVehicleById,
	updateVehicle,
	deleteOneVehicleById,
} from "@/logic/vehicles"

import {
	getManyVehiclesQuerySchema,
	createVehicleBodySchema,
	getOneVehicleParamsSchema,
	updateVehicleParamsSchema,
	updateVehicleBodySchema,
	deleteVehicleParamsSchema,
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

vehiclesController.put(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(updateVehicleParamsSchema, "params"),
	Validator(updateVehicleBodySchema, "body"),
	updateVehicle
)

vehiclesController.delete(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(deleteVehicleParamsSchema, "params"),
	deleteOneVehicleById
)

export { vehiclesController }
