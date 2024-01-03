import { Router } from "express"

import {
	getManyDeliveriesQuerySchema,
	createDeliveryBodySchema,
} from "./validation"

import { Validator } from "@/middlewares/validation"

import { getManyDeliveries, createDelivery } from "@/logic/deliveries"

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

export { deliveriesController }
