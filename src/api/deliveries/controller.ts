import { Router } from "express"

import { Validator } from "@/middlewares/validation"

import {
	getManyDeliveries,
	createDelivery,
	getOneDeliveryById,
} from "@/logic/deliveries"

import {
	getManyDeliveriesQuerySchema,
	createDeliveryBodySchema,
	getOneDeliveryParamsSchema,
} from "./validation"

const deliveriesController = Router()

deliveriesController.get(
	"/",
	Validator(getManyDeliveriesQuerySchema, "query"),
	getManyDeliveries
)

deliveriesController.post(
	"/",
	Validator(createDeliveryBodySchema, "body"),
	createDelivery
)

deliveriesController.get(
	"/:id",
	Validator(getOneDeliveryParamsSchema, "params"),
	getOneDeliveryById
)

export { deliveriesController }
