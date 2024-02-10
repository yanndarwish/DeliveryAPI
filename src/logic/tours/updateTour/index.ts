import { UpdateOneTourRequest, UpdateOneTourResponse } from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { updateTourQuery } from "./query"
import { updateTourBodyMapper } from "./mapper"
import { getOneTourQuery } from "../getOneTour/query"

export const updateTour = async (
	req: UpdateOneTourRequest,
	res: UpdateOneTourResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { id } = req.params

	// check that tour exists
	const tour = await queryAsync(getOneTourQuery, [id, Number(companyId)])

	if (!tour[0]?.[0]) {
		throw new NotFoundError(
			`Aucune tournée n'a été trouvée avec l'identifiant: ${id}`
		)
	}

	const body = { ...req.body, id: Number(id) }

	await queryAsync(updateTourQuery, updateTourBodyMapper(body, companyId))

	res.status(200).send({ message: "La tournée a été mise à jour avec succès" })
}
