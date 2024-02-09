import { GetOneTourRequest, GetOneTourResponse } from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { getOneTourResponseMapper } from "./mapper"
import { getOneTourQuery } from "./query"

export const getOneTour = async (
	req: GetOneTourRequest,
	res: GetOneTourResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { id } = req.params

	const result = await queryAsync(getOneTourQuery, [id, Number(companyId)])
	const response = result[0]?.[0]

	if (!response) {
		throw new NotFoundError(
			`Aucune tournée n'a été trouvée avec l'identifiant: ${id}`
		)
	}

	res.send(getOneTourResponseMapper(response))
}
