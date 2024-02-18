import { GetOneCompanyRequest, GetOneCompanyResponse } from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { getOneCompanyResponseMapper } from "./mapper"
import { getOneCompanyQuery } from "./query"

export const getOneCompany = async (
	req: GetOneCompanyRequest,
	res: GetOneCompanyResponse
) => {
	const { id } = req.params

	const result = await queryAsync(getOneCompanyQuery, [id])
	const response = result[0]?.[0]

	if (!response) {
		throw new NotFoundError(
			`Aucune entreprise n'a été trouvée avec l'identifiant: ${id}`
		)
	}

	res.send(getOneCompanyResponseMapper(response))
}
