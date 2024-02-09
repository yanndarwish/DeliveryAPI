import { Router } from "express"
import { Validator } from "@/middlewares/validation"

import { getManyTours, createTour, getOneTour } from "@/logic/tours"

import {
	getManyToursQuerySchema,
	createTourBodySchema,
	getOneTourParamsSchema,
} from "./validation"
import { headerSchema } from "../validation"

const toursController = Router()

toursController.get(
	"/",
	Validator(headerSchema, "headers"),
	Validator(getManyToursQuerySchema, "query"),
	getManyTours
)

toursController.post(
	"/",
	Validator(headerSchema, "headers"),
	Validator(createTourBodySchema, "body"),
	createTour
)

toursController.get(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(getOneTourParamsSchema, "params"),
	getOneTour
)

export { toursController }
