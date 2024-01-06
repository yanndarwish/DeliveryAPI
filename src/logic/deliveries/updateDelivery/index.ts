import {
	UpdateOneDeliveryRequest,
	UpdateOneDeliveryResponse,
} from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { updateDeliveryQuery } from "./query"
import { updateDeliveryBodyMapper } from "./mapper"
import { getOneDeliveryByIdQuery } from "../getOneDelivery/query"

export const updateDelivery = async (
	req: UpdateOneDeliveryRequest,
	res: UpdateOneDeliveryResponse
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

	const body = { ...req.body, id: Number(id) }

	await queryAsync(
		updateDeliveryQuery,
		updateDeliveryBodyMapper(body, companyId)
	)

	res
		.status(200)
		.send({ message: "La livraison a été mise à jour avec succès" })
}
