import {
	DeleteOneDriverRequest,
	DeleteOneDriverResponse,
} from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { deleteOneDriverQuery } from "./query"
import { getOneDriverByIdQuery } from "../getOneDriver/query"

export const deleteOneDriverById = async (
	req: DeleteOneDriverRequest,
	res: DeleteOneDriverResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { id } = req.params

	// check that driver exists
	const driver = await queryAsync(getOneDriverByIdQuery, [
		id,
		Number(companyId),
	])

	if (!driver[0]?.[0]) {
		throw new NotFoundError(
			`Aucun chauffeur n'a été trouvé avec l'identifiant: ${id}`
		)
	}

	await queryAsync(deleteOneDriverQuery, [id])

	res.send({
		message: `Le chauffeur avec l'identifiant ${id} a été supprimé avec succès`,
	})
}
