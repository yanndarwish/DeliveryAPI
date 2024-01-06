import { CreateClientRequest, CreateClientResponse } from "@/api/interfaces"

import { queryAsync } from "@/lib/database"

import { createClientBodyMapper } from "./mapper"
import { createClientQuery } from "./query"

export const createClient = async (
	req: CreateClientRequest,
	res: CreateClientResponse
) => {
	const companyId = req.headers["company-id"] as string

	await queryAsync(createClientQuery, createClientBodyMapper(req.body, companyId))

	res.status(201).send({ message: "Client créé avec succès" })
}
