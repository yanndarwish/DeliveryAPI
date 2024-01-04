import { Router } from "express"

import { Validator } from "@/middlewares/validation"

import {
	getManyDeliveries,
	createDelivery,
	getOneDeliveryById,
	deleteOneDeliveryById,
} from "@/logic/deliveries"

import {
	getManyDeliveriesQuerySchema,
	createDeliveryBodySchema,
	getOneDeliveryParamsSchema,
	deleteOneDeliveryParamsSchema,
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

deliveriesController.delete(
	"/:id",
	Validator(deleteOneDeliveryParamsSchema, "params"),
	deleteOneDeliveryById
)

export { deliveriesController }
