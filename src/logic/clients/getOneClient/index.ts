import { GetOneClientRequest, GetOneClientResponse } from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { getOneClientResponseMapper } from "./mapper"
import { getOneClientByIdQuery } from "./query"

export const getOneClientById = async (
	req: GetOneClientRequest,
	res: GetOneClientResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { id } = req.params

	const result = await queryAsync(getOneClientByIdQuery, [
		id,
		Number(companyId),
	])
	const response = result[0]?.[0]

	if (!response) {
		throw new NotFoundError(
			`Aucun client n'a été trouvé avec l'identifiant: ${id}`
		)
	}

	res.send(getOneClientResponseMapper(response))
}
