import { CreateDriverRequest, CreateDriverResponse } from "@/api/interfaces"

import { queryAsync } from "@/lib/database"

import { createDriverBodyMapper } from "./mapper"
import { createDriverQuery } from "./query"

export const createDriver = async (
	req: CreateDriverRequest,
	res: CreateDriverResponse
) => {
	const companyId = req.headers["company-id"] as string

	await queryAsync(
		createDriverQuery,
		createDriverBodyMapper(req.body, companyId)
	)

	res.status(201).send({ message: "Chauffeur créé avec succès" })
}
