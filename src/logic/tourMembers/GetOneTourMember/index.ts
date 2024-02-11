import {
	GetOneTourMemberRequest,
	GetOneTourMemberResponse,
} from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { getOneTourMemberResponseMapper } from "./mapper"
import { getOneTourMemberQuery } from "./query"

export const getOneTourMember = async (
	req: GetOneTourMemberRequest,
	res: GetOneTourMemberResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { tourId, id } = req.params

	const result = await queryAsync(getOneTourMemberQuery, [
		id,
		Number(tourId),
		Number(companyId),
	])
	const response = result[0]?.[0]

	if (!response) {
		throw new NotFoundError(
			`Aucun membre de la tournée ${tourId} n'a été trouvé avec l'identifiant: ${id}`
		)
	}

	res.send(getOneTourMemberResponseMapper(response))
}
