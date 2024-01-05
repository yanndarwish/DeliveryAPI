import { Router } from "express"

import { Validator } from "@/middlewares/validation"

import {
	getManyDeliveries,
	createDelivery,
	getOneDeliveryById,
	updateDelivery,
	deleteOneDeliveryById,
} from "@/logic/deliveries"

import {
	getManyDeliveriesQuerySchema,
	createDeliveryBodySchema,
	getOneDeliveryParamsSchema,
	updateOneDeliveryParamsSchema,
	updateOneDeliveryBodySchema,
	deleteOneDeliveryParamsSchema,
} from "./validation"

import { headerSchema } from "../validation"

const deliveriesController = Router()

deliveriesController.get(
	"/",
	Validator(headerSchema, "headers"),
	Validator(getManyDeliveriesQuerySchema, "query"),
	getManyDeliveries
)

deliveriesController.post(
	"/",
	Validator(headerSchema, "headers"),
	Validator(createDeliveryBodySchema, "body"),
	createDelivery
)

deliveriesController.get(
	"/:id",
	Validator(getOneDeliveryParamsSchema, "params"),
	getOneDeliveryById
)

deliveriesController.put(
	"/:id",
	Validator(updateOneDeliveryParamsSchema, "params"),
	Validator(updateOneDeliveryBodySchema, "body"),
	updateDelivery
)

deliveriesController.delete(
	"/:id",
	Validator(deleteOneDeliveryParamsSchema, "params"),
	deleteOneDeliveryById
)

export { deliveriesController }
