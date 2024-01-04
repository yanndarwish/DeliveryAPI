import { CreateDeliveryRequest, CreateDeliveryResponse } from "@/api/interfaces"

import { queryAsync } from "@/lib/database"

import { createDeliveryQuery } from "./query"
import { createDeliveryBodyMapper } from "./mapper"

export const createDelivery = async (
	req: CreateDeliveryRequest,
	res: CreateDeliveryResponse
) => {
	await queryAsync(createDeliveryQuery, createDeliveryBodyMapper(req.body))

	res.status(201).send({ message: "Livraison créée avec succès"})
}
