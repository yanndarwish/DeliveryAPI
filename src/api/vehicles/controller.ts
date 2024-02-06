import { Router } from "express"
import { Validator } from "@/middlewares/validation"

import { getManyVehicles, createVehicle } from "@/logic/vehicles"

import {
	getManyVehiclesQuerySchema,
	createVehicleBodySchema,
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

export { vehiclesController }
