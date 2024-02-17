import { Router } from "express"

import { Validator } from "@/middlewares/validation"

import { getManyCompanies, createCompany } from "@/logic/companies"

import {
	getManyCompaniesQuerySchema,
	createCompanyBodySchema,
} from "./validation"

const companiesController = Router()

companiesController.get(
	"/",
	Validator(getManyCompaniesQuerySchema, "query"),
	getManyCompanies
)

companiesController.post(
	"/",
	Validator(createCompanyBodySchema, "body"),
	createCompany
)

export { companiesController }
