import { NextFunction, Request, Response } from "express"

import { getOneCompanyQuery } from "@/logic/companies/getOneCompany/query"

import { NotFoundError } from "@/lib/errors/notFoundError"
import { ValidationError } from "@/lib/errors"
import { queryAsync } from "@/lib/database"

export const Validator =
	(schema: any, property: "body" | "query" | "params" | "headers") =>
	async (req: Request, res: Response, next: NextFunction) => {
		const validate = schema.safeParse(req[property])

		if (property === "headers") {
			const companyId = req.headers["company-id"] as string

			const isValidCompany = await checkValidCompany(companyId)

			if (!isValidCompany) {
				throw new NotFoundError(
					`company-id : Aucune entreprise ne correspond à l'identifiant : ${companyId}`
				)
			}
		}

		if (!validate.success) {
			throw new ValidationError(validate.error.message)
		}

		next()
	}

const checkValidCompany = async (companyId: string): Promise<boolean> => {
	const result = await queryAsync(getOneCompanyQuery, [companyId])
	const response = result[0]?.[0]

	return !!response
}
