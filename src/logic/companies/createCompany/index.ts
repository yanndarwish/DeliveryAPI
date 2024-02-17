import { CreateCompanyRequest, CreateCompanyResponse } from "@/api/interfaces"
import { queryAsync } from "@/lib/database"

import { createCompanyBodyMapper } from "./mapper"
import { createCompanyQuery } from "./query"

export const createCompany = async (
	req: CreateCompanyRequest,
	res: CreateCompanyResponse
) => {
	await queryAsync(createCompanyQuery, createCompanyBodyMapper(req.body))

	res.status(201).send({ message: "Société créée avec succès" })
}
