import { Router } from "express"

import { Validator } from "@/middlewares/validation"

import {
	getManyCompanies,
	createCompany,
	getOneCompany,
} from "@/logic/companies"

import {
	getManyCompaniesQuerySchema,
	createCompanyBodySchema,
	getOneCompanyParamsSchema,
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

companiesController.get(
	"/:id",
	Validator(getOneCompanyParamsSchema, "params"),
	getOneCompany
)

export { companiesController }
