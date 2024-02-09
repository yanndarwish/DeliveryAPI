import { Router } from "express"
import { Validator } from "@/middlewares/validation"

import { getManyTours, createTour } from "@/logic/tours"

import { getManyToursQuerySchema, createTourBodySchema } from "./validation"
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

export { toursController }
