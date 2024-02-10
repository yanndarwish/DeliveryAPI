import { Router } from "express"
import { Validator } from "@/middlewares/validation"

import {
	getManyTours,
	createTour,
	getOneTour,
	updateTour,
	deleteTour,
} from "@/logic/tours"

import {
	getManyToursQuerySchema,
	createTourBodySchema,
	getOneTourParamsSchema,
	updateTourParamsSchema,
	updateTourBodySchema,
	deleteTourParamsSchema,
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

toursController.put(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(updateTourParamsSchema, "params"),
	Validator(updateTourBodySchema, "body"),
	updateTour
)

toursController.delete(
	"/:id",
	Validator(headerSchema, "headers"),
	Validator(deleteTourParamsSchema, "params"),
	deleteTour
)

export { toursController }
