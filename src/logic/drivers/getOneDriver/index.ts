import { GetOneDriverRequest, GetOneDriverResponse } from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { getOneDriverResponseMapper } from "./mapper"
import { getOneDriverByIdQuery } from "./query"

export const getOneDriverById = async (
	req: GetOneDriverRequest,
	res: GetOneDriverResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { id } = req.params

	const result = await queryAsync(getOneDriverByIdQuery, [
		id,
		Number(companyId),
	])
	const response = result[0]?.[0]

	if (!response) {
		throw new NotFoundError(
			`Aucun chauffeur n'a été trouvé avec l'identifiant: ${id}`
		)
	}

	res.send(getOneDriverResponseMapper(response))
}
