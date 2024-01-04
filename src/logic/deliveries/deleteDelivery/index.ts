import {
	DeleteOneDeliveryRequest,
	DeleteOneDeliveryResponse,
} from "@/api/interfaces"
import { queryAsync } from "@/lib/database"
import { NotFoundError } from "@/lib/errors/notFoundError"

import { deleteOneDeliveryQuery } from "./query"

export const deleteOneDeliveryById = async (
	req: DeleteOneDeliveryRequest,
	res: DeleteOneDeliveryResponse
) => {
	const { id } = req.params

	const result = await queryAsync(deleteOneDeliveryQuery, [id])

	if (result.affectedRows === 0) {
		throw new NotFoundError(
			`Aucune livraison n'a été trouvée avec l'identifiant: ${id}`
		)
	}

	res.send({
		message: `La livraison avec l'identifiant ${id} a bien été supprimée`,
	})
}
