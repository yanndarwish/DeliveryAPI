import { CreateRelayBody } from "@/api/interfaces"

export const createRelayBodyMapper = (
	body: CreateRelayBody,
	companyId: string
) => {
	return [
		body.name,
		body.streetNumber ?? null,
		body.street,
		body.city,
		body.postalCode ?? null,
		body.country,
		body.comment ?? null,
		body.active,
		Number(companyId),
	]
}
