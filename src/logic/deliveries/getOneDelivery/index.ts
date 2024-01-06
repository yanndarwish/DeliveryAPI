import { GetOneDeliveryRequest, GetOneDeliveryResponse } from "@/api/interfaces"
import { NotFoundError } from "@/lib/errors/notFoundError"
import { queryAsync } from "@/lib/database"

import { getOneDeliveryResponseMapper } from "./mapper"
import { getOneDeliveryByIdQuery } from "./query"

export const getOneDeliveryById = async (
	req: GetOneDeliveryRequest,
	res: GetOneDeliveryResponse
) => {
	const companyId = req.headers["company-id"] as string
	const { id } = req.params

	const result = await queryAsync(getOneDeliveryByIdQuery, [id, Number(companyId)])
	const response = result[0]?.[0]

	if (!response) {
		throw new NotFoundError(
			`Aucune livraison n'a été trouvée avec l'identifiant: ${id}`
		)
	}

	res.send(getOneDeliveryResponseMapper(response))
}
