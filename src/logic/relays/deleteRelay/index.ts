import { DeleteOneRelayRequest, DeleteOneRelayResponse } from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { deleteOneRelayQuery } from "./query"
import { getOneRelayByIdQuery } from "../getOneRelay/query"

export const deleteOneRelayById = async (
	req: DeleteOneRelayRequest,
	res: DeleteOneRelayResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { id } = req.params

	// check that relay exists
	const relay = await queryAsync(getOneRelayByIdQuery, [id, Number(companyId)])

	if (!relay[0]?.[0]) {
		throw new NotFoundError(
			`Aucun relais n'a été trouvé avec l'identifiant: ${id}`
		)
	}

	await queryAsync(deleteOneRelayQuery, [id])

	res.send({
		message: `Le relais avec l'identifiant ${id} a été supprimé avec succès`,
	})
}
