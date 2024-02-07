import { Router } from "express";
import { Validator } from "@/middlewares/validation";

import { getManyTours } from "@/logic/tours";

import { getManyToursQuerySchema } from "./validation";
import { headerSchema } from "../validation";

const toursController = Router();

toursController.get(
    "/",
    Validator(headerSchema, "headers"),
    Validator(getManyToursQuerySchema, "query"),
    getManyTours
);

export { toursController };