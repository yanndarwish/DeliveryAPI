import {
	UpdateOneTourMemberRequest,
	UpdateOneTourResponse,
} from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { getOneTourMemberQuery } from "../GetOneTourMember/query"
import { updateTourMemberStatusQuery } from "./query"
import { updateTourMemberBodyMapper } from "./mapper"

export const updateTourMember = async (
	req: UpdateOneTourMemberRequest,
	res: UpdateOneTourResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { id, tourId } = req.params

	// check that tour exists
	const tourMember = await queryAsync(getOneTourMemberQuery, [
		id,
		tourId,
		Number(companyId),
	])

	if (!tourMember[0]?.[0]) {
		throw new NotFoundError(
			`Aucun membre de la tournée ${tourId} n'a été trouvé avec l'identifiant: ${id}`
		)
	}

	const body = { ...req.body, id: Number(id), tourId: Number(tourId) }

	await queryAsync(
		updateTourMemberStatusQuery,
		updateTourMemberBodyMapper(body)
	)

	res
		.status(200)
		.send({ message: "Le membre de tournée a été mis à jour avec succès" })
}
