import { Router } from "express"
import { Validator } from "@/middlewares/validation"

import { getManyVehicles } from "@/logic/vehicles"

import { getManyVehiclesQuerySchema } from "./validation"
import { headerSchema } from "../validation"

const vehiclesController = Router()

vehiclesController.get(
    "/",
    Validator(headerSchema, "headers"),
    Validator(getManyVehiclesQuerySchema, "query"),
    getManyVehicles
)

export { vehiclesController }


