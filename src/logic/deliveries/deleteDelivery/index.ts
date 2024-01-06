import {
	DeleteOneDeliveryRequest,
	DeleteOneDeliveryResponse,
} from "@/api/interfaces"
import { queryAsync } from "@/lib/database"
import { NotFoundError } from "@/lib/errors/notFoundError"

import { deleteOneDeliveryQuery } from "./query"
import { getOneDeliveryByIdQuery } from "../getOneDelivery/query"

export const deleteOneDeliveryById = async (
	req: DeleteOneDeliveryRequest,
	res: DeleteOneDeliveryResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { id } = req.params

	// check that delivery exists
	const delivery = await queryAsync(getOneDeliveryByIdQuery, [
		id,
		Number(companyId),
	])

	if (!delivery[0]?.[0]) {
		throw new NotFoundError(
			`Aucune livraison n'a été trouvée avec l'identifiant: ${id}`
		)
	}

	await queryAsync(deleteOneDeliveryQuery, [id, Number(companyId)])

	res.send({
		message: `La livraison avec l'identifiant ${id} a bien été supprimée`,
	})
}
