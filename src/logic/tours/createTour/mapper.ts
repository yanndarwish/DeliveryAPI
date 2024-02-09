import { CreateTourBody } from "@/api/interfaces"

export const createTourBodyMapper = (
	body: CreateTourBody,
	companyId: string
) => {
	return [body.name, body.active, companyId, JSON.stringify(body.clientIds)]
}
