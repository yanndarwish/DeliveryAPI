import { CreateDeliveryRequest, CreateDeliveryResponse } from "@/api/interfaces"

import { queryAsync } from "@/lib/database"

import { createDeliveryQuery } from "./query"
import { createDeliveryBodyMapper } from "./mapper"

export const createDelivery = async (
	req: CreateDeliveryRequest,
	res: CreateDeliveryResponse
) => {
	const companyId = req.headers["company-id"]

	const body = { ...req.body, companyId }

	await queryAsync(createDeliveryQuery, createDeliveryBodyMapper(body))

	res.status(201).send({ message: "Livraison créée avec succès"})
}
