import { Router } from "express"

import { getManyDeliveriesQuerySchema } from "./validation"

import { Validator } from "@/middlewares/validation"

import { getManyDeliveries } from "@/logic/deliveries"

const deliveriesController = Router()

deliveriesController.get(
	"/",
	Validator(getManyDeliveriesQuerySchema, "query"),
	getManyDeliveries
)

export { deliveriesController }
